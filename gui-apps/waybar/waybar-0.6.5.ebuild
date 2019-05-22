# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Highly customizable Wayland Polybar like bar"
HOMEPAGE="https://github.com/Alexays/Waybar"
SRC_URI="https://github.com/Alexays/Waybar/archive/${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+netlink mpd pulseaudio +tray"

RDEPEND="sys-libs/libcap
	>=dev-libs/libfmt-5.3.0
	>=dev-libs/spdlog-1.3.1
	dev-libs/libinput
	dev-libs/wayland
	dev-cpp/gtkmm:3.0
	gui-libs/wlroots
	tray? ( dev-libs/libdbusmenu[gtk3] )
	dev-libs/jsoncpp
	dev-libs/libsigc++
	netlink? ( dev-libs/libnl )
	pulseaudio? ( media-sound/pulseaudio )
	mpd? ( media-libs/libmpdclient )
"
DEPEND="${RDEPEND}
	dev-libs/wayland-protocols
"

src_unpack() {
	unpack ${PV}.tar.gz
	mv Waybar-${PV} ${P}
}

src_configure() {
	local emesonargs=(
		-Dlibnl=$(usex netlink enabled disabled)
		-Dpulseaudio=$(usex pulseaudio enabled disabled)
		-Ddbusmenu-gtk=$(usex tray enabled disabled)
		-Dmpd=$(usex mpd enabled disabled)
	)
	meson_src_configure
}
