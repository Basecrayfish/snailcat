# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bsdmk multilib-minimal toolchain-funcs

DESCRIPTION="Libraries/utilities to handle ELF objects (BSD drop in replacement for libelf)"
HOMEPAGE="https://wiki.freebsd.org/LibElf"
SRC_URI="https://pubfiles.replicantprocess.com/${P}.tar.bz2"

LICENSE="BSD-2 "
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~riscv ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="static-libs toolchain-progs"

RDEPEND=">=sys-libs/zlib-1.2.8-r1[${MULTILIB_USEDEP}]
	app-arch/libarchive
	app-arch/sharutils
	dev-libs/expat
	!dev-libs/libelf
	!dev-libs/elfutils
	!sys-devel/binutils"

DEPEND="${RDEPEND}
	virtual/yacc
	sys-apps/lsb-release
	elibc_musl? (
		sys-libs/argp-standalone
		sys-libs/fts-standalone
		sys-libs/obstack-standalone
	)"

src_prepare() {
	cd ${S}
	if ! use toolchain-progs; then
		PATCHES+=( "${FILESDIR}"/${PN}-0.7.1-disable-progs.patch )
	fi
	default
	rm -rf test || die
	rm -rf documentation || die
	rm libelf/os.Linux.mk
}

multilib_src_compile() {
	cd ${S}
	bsdmk_src_compile
}


multilib_src_install() {
	cd ${S}
	mymakeopts="NO_WERROR=1"
	bsdmk_src_install
	if use toolchain-progs; then
		mv ${D}/usr/bin/ld ${D}/usr/bin/ld.elf || die
	fi
	einstalldocs
}
