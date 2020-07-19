# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="!!DO NOT MERGE!! Test package adding depricated cc symlinks from gcc for clang"
HOMEPAGE="https://replicantprocess.com"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+lld"

DEPEND="
	sys-devel/llvm:10
	lld? ( sys-devel/lld )
	!sys-devel/binutils"
RDEPEND="${DEPEND}"

pkg_pretend() {
	ewarn "This package is a complete hack"
	ewarn "Probably will not work with prefix"
	ewarn "x86_64-gentoo-linux-musl is hardcoded"
	ewarn "Usage of ESYSROOT is probably incorrect"
	ewarn "ONLY USE THIS PACKAGE TO TEST FAULTY EBUILDS LOOKING FOR cc AND FRIENDS DIRECTLY"
}

src_unpack() {
	mkdir -p ${S} || die
}

src_install() {
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-ar ar || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-nm nm || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-ranlib ranlib || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-readelf readelf || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-readobj readobj || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/llvm-strip strip || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/x86_64-gentoo-linux-musl-clang++-10 c++ || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/x86_64-gentoo-linux-musl-clang-10 cc || die
	ln -s "${ESYSROOT}"/usr/lib/llvm/10/bin/x86_64-gentoo-linux-musl-clang-cpp-10 cpp || die
	if use lld; then
		ln -s "${ESYSROOT}"/usr/bin/lld ld || die
	fi

	mkdir -p "${ED}"/usr/bin || die
	cp --no-dereference ar nm ranlib readelf readobj strip c++ cc cpp "${ED}"/usr/bin || die
}
