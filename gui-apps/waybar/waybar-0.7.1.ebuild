# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Highly customizable Wayland bar for Sway and Wlroots based compositors."
HOMEPAGE="https://github.com/Alexays/Waybar"
SRC_URI="https://github.com/Alexays/Waybar/archive/${PV}.tar.gz -> ${P}.tar.gz"
S=${WORKDIR}/Waybar-${PV}

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+netlink mpd pulseaudio +tray +udev"

RDEPEND="
	sys-libs/libcap
	>=dev-libs/libfmt-5.3.0
	>=dev-libs/spdlog-1.3.1
	dev-libs/libappindicator
	dev-libs/libinput
	dev-libs/wayland
	dev-cpp/gtkmm:3.0
	gui-libs/wlroots
	tray? ( dev-libs/libdbusmenu[gtk3] )
	dev-libs/jsoncpp
	dev-libs/libsigc++
	netlink? ( dev-libs/libnl )
	pulseaudio? ( media-sound/pulseaudio )
	udev? ( virtual/udev )
	mpd? ( media-libs/libmpdclient )
"

DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"

src_configure() {
	local emesonargs=(
		$(meson_feature netlink libnl)
		$(meson_feature udev libudev)
		$(meson_feature pulseaudio)
		$(meson_feature tray dbusmenu-gtk)
		$(meson_feature mpd)
	)
	meson_src_configure
}
