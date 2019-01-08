# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION=""
HOMEPAGE=""
EGIT_REPO_URI="https://github.com/Basecrayfish/Proton"
EGIT_SUBMODULES=( openvr fonts/liberation-fonts )

LICENSE="ValveProtonLicense"
SLOT="0"
KEYWORDS=""
IUSE=""

COMMON_DEPEND="
	app-emulation/wine-proton[faudio]
	app-emulation/dxvk
"

DEPEND="${COMMON_DEPEND}
	dev-util/cmake
"

RDEPEND="${COMMON_DEPEND}"
BDEPEND=""

src_configure() {
	./configure.sh --no-steam-runtime
}

src_install() {
	emake
	emake dist
}
