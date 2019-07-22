# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Select a region in a Wayland compositor"
HOMEPAGE="https://wayland.emersion.fr/slurp"
SRC_URI="https://github.com/emersion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man"

RDEPEND="
	dev-libs/wayland
	x11-libs/cairo
"

DEPEND="${RDEPEND}
	>=dev-libs/wayland-protocols-1.14
	man? ( app-text/scdoc )
"

src_configure() {
	local emesonargs=(
		$(meson_feature man man-pages)
	)
	meson_src_configure
}
