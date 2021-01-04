# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

if [[ ${PV} != *9999* ]]; then
	SRC_URI="https://gitlab.gnome.org/GNOME/evolution-etesync/-/archive/v${PV}/${PN}-v${PV}.tar.gz /v${PV}.tar.gz  -> ${P}.tar.gz"
	KEYWORDS="~amd64"
else
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.gnome.org/jadahl/libdecoration.git"
	EGIT_BRANCH="wip/api-versions"
fi

DESCRIPTION="Helps Wayland clients handle window decorations"
HOMEPAGE="https://gitlab.gnome.org/jadahl/libdecoration"
LICENSE="MIT"
SLOT="0"

DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	>=sys-apps/dbus-1.0
"
RDEPEND="${DEPEND}"
BDEPEND=""
