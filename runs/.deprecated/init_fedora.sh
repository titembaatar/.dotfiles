#!/usr/bin/env bash

gpu=$1

rpm_install() {
	sudo dnf install -y \
		https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-"$(rpm -E %fedora)".noarch.rpm \
		https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-"$(rpm -E %fedora)".noarch.rpm
	sudo dnf group upgrade core -y
	sudo dnf check-update
}

flathub_install() {
	flatpak remote-delete fedora
	flatpak remote-add --if-not-exists --subset=verified \
		flathub https://flathub.org/repo/flathub.flatpakrepo
}

video_codecs() {
	sudo dnf swap -y ffmpeg-free ffmpeg --allowerasing
	sudo dnf install -y gstreamer1-plugins-{bad-\*,good-\*,base} \
		gstreamer1-plugin-openh264 gstreamer1-libav lame\* \
		--exclude=gstreamer1-plugins-bad-free-devel
	sudo dnf group install -y multimedia
	sudo dnf group install -y sound-and-video
}

hw_acceleration() {
	sudo dnf install -y ffmpeg-libs libva libva-utils
	if [[ $gpu == "nvidia" ]]; then
		sudo dnf install -y libva-nvidia-driver
	fi
}

firefox_video() {
	sudo dnf install -y openh264 gstreamer1-plugin-openh264 mozilla-openh264
	sudo dnf config-manager --set-enabled fedora-cisco-openh264
	sudo dnf update -y
}

nvidia_drivers() {
	sudo dnf install -y kernel-devel kernel-headers gcc make dkms acpid \
		libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig
	sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda

	# TODO: test this shit one day
	# loader=(- / \| \\)
	# date_minus_1h=$(date -d "1 hour ago" +"%F %T")
	# is_finished=$(sudo journalctl -S "$date_minus_1h" -u akmods | \
	# 	grep -qi 'finished')
	# while $is_finished; do
	# 	for load in "${loader[@]}"; do
	# 		printf "[%s] Building NVIDIA driver\r" "$load"
	# 		sleep 0.25
	# 	done
	# done
}

amd_drivers() {
	sudo dnf install -y mesa-dri-drivers mesa-vulkan-drivers \
		vulkan-loader mesa-libGLU
}

firmware_update() {
	sudo fwupdmgr get-devices
	sudo fwupdmgr refresh --force
	sudo fwupdmgr get-updates
	sudo fwupdmgr update
}

rpm_install
sudo dnf update -y
video_codecs
firefox_video

while true; do
	if [[ -z $gpu ]]; then
		read -rp "What GPU are you using ? [nvidia/amd] " a
		gpu=${a,,}
	fi

	if [[ "$gpu" == "nvidia" ]] || [[ "$gpu" == "amd" ]]; then
		break
	fi
done

hw_acceleration

if [[ $gpu == "nvidia" ]]; then
	nvidia_drivers
elif [[ $gpu == "amd" ]]; then
	amd_drivers
fi

firmware_update
