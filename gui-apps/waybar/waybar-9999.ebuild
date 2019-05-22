# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Highly customizable Wayland Polybar like bar"
HOMEPAGE="https://github.com/Alexays/Waybar"
EGIT_REPO_URI="https://github.com/Alexays/Waybar.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="+netlink mpd pulseaudio +tray"

RDEPEND="sys-libs/libcap
	>=dev-libs/libfmt-5.3.0
	dev-libs/spdlog
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

src_configure() {
	local emesonargs=(
		-Dlibnl=$(usex netlink enabled disabled)
		-Dpulseaudio=$(usex pulseaudio enabled disabled)
		-Ddbusmenu-gtk=$(usex tray enabled disabled)
		-Dmpd=$(usex mpd enabled disabled)
	)
	meson_src_configure
}