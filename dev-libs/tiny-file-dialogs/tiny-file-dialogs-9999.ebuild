# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 toolchain-funcs

DESCRIPTION="Highly portable and cross-platform dialogs for native inputbox, passwordbox and colorpicker"
HOMEPAGE="https://sourceforge.net/projects/tinyfiledialogs/"
EGIT_REPO_URI="https://git.code.sf.net/p/tinyfiledialogs/code"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_compile() {
	$(tc-getCC) ${CFLAGS} -c -I. -o tinyfd.o tinyfiledialogs.c || die
	$(tc-getAR) rcs libtinyfd.a tinyfd.o || die
}

src_install() {
	dolib.a ${S}/libtinyfd.a
	doheader ${S}/tinyfiledialogs.h
}
