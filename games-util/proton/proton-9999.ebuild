# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-multilib

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/Basecrayfish/Proton"
EGIT_SUBMODULES="openvr"

LICENSE="ValveProtonLicense"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	app-emulation/wine-proton
	app-emulation/dxvk
"

DEPEND="${COMMON_DEPEND}
	dev-util/cmake
"

RDEPEND="${COMMON_DEPEND}"
BDEPEND=""

src_configure() {
	cmake-multilib_src_configure
}

src_compile() {
	make
}

src_install() {
	ewarn WIP Manual installation required
	die
}
