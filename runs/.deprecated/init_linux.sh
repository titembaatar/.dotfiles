#!/usr/bin/env bash

hostname=$1
set_hostname() {
	while [[ -z $hostname ]]; do
		read -rp "Choose hostname: " a
		hostname=$a
	done

	sudo hostnamectl set-hostname "$hostname"
}

set_sudoer() {
    sudo usermod -aG wheel "$USER"
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    printf '%%wheel\tALL=(ALL)\tNOPASSWD: ALL\n' > "$tmp"
    sudo install -m 0440 -o root -g root "$tmp" /etc/sudoers.d/wheel_grp
}

mount_shares() {
	if ! rpm -q nfs-utils &> /dev/null; then
		sudo dnf install -qy nfs-utils
	fi

	local shares=(
		# ip:dataset:mount
		"10.0.0.10:vault:data"
		"10.0.0.10:vault:files"
		"10.0.0.10:flash:docker"
		"10.0.0.19:volume1:backup"
	)
	local share_opts="nfs rw,defaults,soft,_netdev,noatime,nodiratime 0 0"
	local mnt_dirs=()
	while IFS=: read -r ip dataset mount; do
		mnt_dirs+=("$mount")
		printf "%s:/%s/%s\t/mnt/%s\t%s\n" \
			"$ip" "$dataset" "$mount" "$mount" "$share_opts" \
			| sudo tee -a /etc/fstab &>/dev/null
	done < <(printf '%s\n' "${shares[@]}")

	for mount in "${mnt_dirs[@]}"; do
		sudo mkdir -p /mnt/"$mount"
	done

	sudo systemctl daemon-reload
	sudo mount -a
}

setup_ssh() {
	local ssh_dir="$HOME/.ssh"
	local ssh_config="$ssh_dir/config"
	local key="$ssh_dir/$hostname"

	mkdir -m 0700 "$ssh_dir"
	if [[ ! -f $key ]]; then
		ssh-keygen -t ed25519 -f "$key" -N ""
	fi

	local devices=(
		"nas:10.0.0.10:titem"
		"worker1:10.0.0.11:titem"
		"worker2:10.0.0.12:titem"
		"worker3:10.0.0.13:titem"
		"backup:10.0.0.19:titem"
	)

	if [[ ! -f $ssh_config ]]; then
		touch "$ssh_config"
	fi

	chmod 600 "$ssh_config"

	while IFS=: read -r host ip user; do
		ssh-copy-id -o StrictHostKeyChecking=no -i "$key.pub" "$user@$ip"
		printf 'Host %s\n
			\tHostName\t%s\n
			\tUser\t%s\n
			\tIdentityFile\t%s\n\n' \
			"$host" "$ip" "$user" "$key" \
			>> "$ssh_config"
	done < <(printf '%s\n' "${devices[@]}")
}

set_hostname
set_sudoer
mount_shares
setup_ssh
