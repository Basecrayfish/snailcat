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
	sys-devel/llvm:11
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
	LLVMDIR="${ESYSROOT}/usr/lib/llvm/11/bin"
	ln -s "${LLVMDIR}"/llvm-ar ar || die
	ln -s "${LLVMDIR}"/llvm-nm nm || die
	ln -s "${LLVMDIR}"/llvm-ranlib ranlib || die
	ln -s "${LLVMDIR}"/llvm-readelf readelf || die
	ln -s "${LLVMDIR}"/llvm-readobj readobj || die
	ln -s "${LLVMDIR}"/llvm-strip strip || die
	ln -s "${LLVMDIR}"/llvm-objdump objdump || die
	ln -s "${LLVMDIR}"/llvm-dlltool dlltool || die
	ln -s "${LLVMDIR}"/llvm-mt mt || die
	ln -s "${LLVMDIR}"/llvm-strings strings || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang++-11 c++ || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang++-11 clang++ || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang++-11 clang++-11 || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang++-11 x86_64-gentoo-linux-musl-clang++-11 || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-11 cc || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-11 clang || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-11 clang-11 || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-11 x86_64-gentoo-linux-musl-clang-11 || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-cpp-11 cpp || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-cpp-11 clang-cpp || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-cpp-11 clang-cpp-11 || die
	ln -s "${LLVMDIR}"/x86_64-gentoo-linux-musl-clang-cpp-11 x86_64-gentoo-linux-musl-clang-cpp-11 || die
	if use lld; then
		ln -s "${ESYSROOT}"/usr/bin/lld ld || die
	fi

	mkdir -p "${ED}"/usr/bin || die
	cp -d ar nm ranlib readelf readobj strip objdump dlltool mt strings cc clang clang-11 x86_64-gentoo-linux-musl-clang-11 c++ clang++ clang++-11 x86_64-gentoo-linux-musl-clang++-11 cpp clang-cpp clang-cpp-11 x86_64-gentoo-linux-musl-clang-cpp-11 "${ED}"/usr/bin || die
	if use lld; then
		cp -d ld "${ED}"/usr/bin || die
	fi
}
