# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Provides fontconfig's fonts.dtd file"
HOMEPAGE="https://fontconfig.org/"
# TODO: Fetching full source tarball is wasteful.
SRC_URI="https://fontconfig.org/release/fontconfig-${PV}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/fontconfig-${PV}"

src_configure() {
	einfo "Skipping fontconfig's configuration"
}

src_compile() {
	einfo "Skipping fontconfig's compilation"
}

src_install() {
	insinto /etc/fonts
	doins fonts.dtd
}
