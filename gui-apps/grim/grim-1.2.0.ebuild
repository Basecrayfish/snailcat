# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Grab images from a Wayland compositor"
HOMEPAGE="https://wayland.emersion.fr/grim"
SRC_URI="https://github.com/emersion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="man jpeg"

DEPEND="
	x11-libs/cairo
	dev-libs/wayland
	jpeg? ( virtual/jpeg )
"

RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature jpeg)
		$(meson_feature man man-pages)
	)
	meson_src_configure
}
