# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 toolchain-funcs

DESCRIPTION="User-space application to modify the EFI boot manager"
HOMEPAGE="https://github.com/rhinstaller/efibootmgr"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
EGIT_REPO_URI="https://github.com/rhinstaller/efibootmgr"
EGIT_COMMIT="edc8b9b6ec1c7751ccb9a483405c99141ba237fc"

RDEPEND="sys-apps/pciutils
	>=sys-libs/efivar-25:="
DEPEND="${RDEPEND}"

src_prepare() {
	default
	sed -i -e 's/-Werror //' Make.defaults || die
}

src_configure() {
	tc-export CC
	export EFIDIR="Gentoo"
}

src_compile() {
	emake PKG_CONFIG="$(tc-getPKG_CONFIG)"
}
