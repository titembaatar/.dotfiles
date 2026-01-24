#!/usr/bin/env bash

packages=(
	"ollama|https://ollama.com/install.sh"
	"opencode|https://opencode.ai/install"
)

models=(
	"ministral-3:8b"
	"ministral-3:14b"
	"qwen2.5-coder:7b"
	"qwen3-coder:30b"
)

ollama_config="$HOME/.dotfiles/env/.config/ollama"

install_packages() {
	for package in "${packages[@]}"; do
		name=${package%|*}
		url=${package#*|}

		if ! command -v "$name" &>/dev/null; then
			curl -fsSL "$url" | bash
		fi
	done
}

install_models() {
	for model in "${models[@]}"; do
		ollama pull "$model"
	done
}

create_modelfile() {
	local model=$1 path=$2
	printf 'FROM %s\nPARAMETER num_ctx 16384' "$model" > "$path"
}

expand_context() {
	local modelfiles_dir="$ollama_config/modelfiles"

	for model in "${models[@]}"; do
		local modelfile="$modelfiles_dir/Modelfile_$model"
		mkdir -p "$modelfiles_dir"
		[[ ! -f $modelfile ]] && create_modelfile "$model" "$modelfile"
		ollama create "$model"-16k -f "$modelfiles_dir/Modelfile_$model"
	done
}

clean_originals_models() {
	for model in "${models[@]}"; do
		ollama rm "$model"
	done
}

main() {
	install_packages
	install_models
	expand_context
	clean_originals_models

	stow -d "$HOME/.dotfiles" -t "$HOME" env
}

main
