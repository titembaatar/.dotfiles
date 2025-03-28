#!/bin/bash
# Workspace Manager - No external dependencies required
# Sets up Sway workspaces based on a simple configuration format

log_debug() {
    if [[ -n "$WORKSPACE_SETUP_DEBUG" ]]; then
        echo "[DEBUG]: $*" >&2
    fi
}

log_info() {
    echo "[INFO ]: $*" >&2
}

log_error() {
    echo "[ERROR]: $*" >&2
}

wait_for_window() {
    local window_pattern="$1"
    local timeout="${2:-10}"
    local counter=0

    log_debug "Waiting for window matching: $window_pattern"
    while [ $counter -lt "$timeout" ]; do
        if swaymsg -t get_tree | grep -q "$window_pattern"; then
            log_debug "Window found: $window_pattern"
            return 0
        fi
        sleep 0.5
        counter=$((counter + 1))
    done

    log_debug "Timeout waiting for window: $window_pattern"
    return 1
}

read_config() {
    local file="$1"
    local section="$2"
    local in_section=0

    while IFS= read -r line; do
        # Skip comments and empty lines
        [[ "$line" =~ ^[[:space:]]*# ]] && continue
        [[ "$line" =~ ^[[:space:]]*$ ]] && continue

        # Check for section header
        if [[ "$line" =~ ^\[([^]]+)\]$ ]]; then
            if [[ "${BASH_REMATCH[1]}" == "$section" ]]; then
                in_section=1
            else
                in_section=0
            fi
            continue
        fi

        # Output lines only when in the requested section
        if [[ $in_section -eq 1 ]]; then
            echo "$line"
        fi
    done < "$file"
}

# Function to parse key-value pairs
parse_config() {
    local line="$1"
    local key="$2"

    if [[ "$line" =~ ^[[:space:]]*"$key"[[:space:]]*=[[:space:]]*(.+)$ ]]; then
        echo "${BASH_REMATCH[1]}"
    fi
}

# Function to setup a specific workspace
setup_workspace() {
    local config_file="$1"
    local workspace_num="$2"

    # Read the workspace section
    local section="workspace_${workspace_num}"
    local workspace_config

    workspace_config=$(read_config "$config_file" "$section")

    if [[ -z "$workspace_config" ]]; then
        log_error "No configuration found for workspace $workspace_num"
        return 1
    fi

    # Parse the layout
    local layout=""
    while IFS= read -r line; do
        if tmp=$(parse_config "$line" "layout"); then
            layout="$tmp"
            break
        fi
    done <<< "$workspace_config"

    # Switch to the workspace
    log_info "Setting up workspace $workspace_num"
    swaymsg "workspace $workspace_num"

    # Set the layout if specified
    if [[ -n "$layout" ]]; then
        log_debug "Setting layout: $layout"
        swaymsg "layout $layout"
    fi

    # Process each window definition
    local window_index=1
    while true; do
        local window_section="window_${window_index}"
        local window_config
        window_config=$(read_config "$config_file" "${section}_${window_section}")

        if [[ -z "$window_config" ]]; then
            # No more windows for this workspace
            break
        fi

        # Parse window properties
        local command=""
        local match=""
        local mark=""
        local position=""
        local focus=""
        local post_command=""

        while IFS= read -r line; do
            if tmp=$(parse_config "$line" "command"); then
                command="$tmp"
            elif tmp=$(parse_config "$line" "match"); then
                match="$tmp"
            elif tmp=$(parse_config "$line" "mark"); then
                mark="$tmp"
            elif tmp=$(parse_config "$line" "position"); then
                position="$tmp"
            elif tmp=$(parse_config "$line" "focus"); then
                focus="$tmp"
            elif tmp=$(parse_config "$line" "post_command"); then
                post_command="$tmp"
            fi
        done <<< "$window_config"

        # Verify required properties
        if [[ -z "$command" || -z "$match" ]]; then
            log_error "Window $window_index in workspace $workspace_num is missing required properties"
            window_index=$((window_index + 1))
            continue
        fi

        # Launch application
        log_debug "Launching: $command"
        eval "$command" &

        # Wait for window to appear
        if ! wait_for_window "$match" 10; then
            log_error "Failed to detect window: $match"
            window_index=$((window_index + 1))
            continue
        fi

        # Mark window if specified
        if [[ -n "$mark" ]]; then
            log_debug "Marking window $match as $mark"
            swaymsg "[$match] mark \"$mark\""
        fi

        # Position window if specified
        if [[ -n "$position" ]]; then
            log_debug "Positioning window [$match]: $position"
            swaymsg "[$match] $position"
        fi

        # Focus window if specified
        if [[ "$focus" == "true" ]]; then
            log_debug "Focusing window: [$match]"
            swaymsg "[$match] focus"

            # Execute post command if specified
            if [[ -n "$post_command" ]]; then
                log_debug "Executing post command: $post_command"
                if [[ "$match" == *"kitty"* && "$post_command" == "send_text="* ]]; then
                    # Special handling for kitty send_text
                    local text="${post_command#send_text=}"
                    kitty @ send-text "$text"
                else
                    # Generic command execution
                    eval "$post_command"
                fi
            fi
        fi

        window_index=$((window_index + 1))
    done

    return 0
}

# Main function
main() {
    local config_file="${1:-"$HOME/.config/workspace-manager/config"}"
    shift
    local workspaces=("$@")

    if [ ! -f "$config_file" ]; then
        log_error "Configuration file not found: $config_file"
        exit 1
    fi

    # If no workspaces specified, find all defined workspaces
    if [ ${#workspaces[@]} -eq 0 ]; then
        while IFS= read -r line; do
            if [[ "$line" =~ ^\[workspace_([0-9]+)\]$ ]]; then
                workspaces+=("${BASH_REMATCH[1]}")
            fi
        done < "$config_file"
    fi

    # Set up each workspace
    for workspace in "${workspaces[@]}"; do
        setup_workspace "$config_file" "$workspace"
    done
}

# Run the main function
main "$@"
