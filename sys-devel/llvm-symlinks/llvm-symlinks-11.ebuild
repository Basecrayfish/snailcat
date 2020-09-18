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
	ewarn "Usage of ESYSROOT is probably incorrect"
	ewarn "ONLY USE THIS PACKAGE TO TEST FAULTY EBUILDS LOOKING FOR cc AND FRIENDS DIRECTLY"
}

src_unpack() {
	mkdir -p ${S} || die
}

src_install() {
	LLVMDIR="${ESYSROOT}/usr/lib/llvm/11/bin"
	# LLVM Core symlinks
	ln -s "${LLVMDIR}"/llvm-as as || die
	ln -s "${LLVMDIR}"/llvm-as "${CHOST}"-as || die
	ln -s "${LLVMDIR}"/llvm-ar ar || die
	ln -s "${LLVMDIR}"/llvm-ar "${CHOST}"-ar || die
	ln -s "${LLVMDIR}"/llvm-nm nm || die
	ln -s "${LLVMDIR}"/llvm-nm "${CHOST}"-nm || die
	ln -s "${LLVMDIR}"/llvm-ranlib ranlib || die
	ln -s "${LLVMDIR}"/llvm-ranlib "${CHOST}"-ranlib || die
	ln -s "${LLVMDIR}"/llvm-readelf readelf || die
	ln -s "${LLVMDIR}"/llvm-readelf "${CHOST}"-readelf || die
	ln -s "${LLVMDIR}"/llvm-readobj readobj || die
	ln -s "${LLVMDIR}"/llvm-readobj "${CHOST}"-readobj || die
	ln -s "${LLVMDIR}"/llvm-strip strip || die
	ln -s "${LLVMDIR}"/llvm-strip "${CHOST}"-strip || die
	ln -s "${LLVMDIR}"/llvm-objdump objdump || die
	ln -s "${LLVMDIR}"/llvm-objdump "${CHOST}"-objdump || die
	ln -s "${LLVMDIR}"/llvm-dlltool dlltool || die
	ln -s "${LLVMDIR}"/llvm-dlltool "${CHOST}-"dlltool || die
	ln -s "${LLVMDIR}"/llvm-mt mt || die
	ln -s "${LLVMDIR}"/llvm-mt "${CHOST}"-mt || die
	ln -s "${LLVMDIR}"/llvm-strings strings || die
	ln -s "${LLVMDIR}"/llvm-strings "${CHOST}"-strings || die
	# Clang symlinks
	ln -s "${LLVMDIR}"/"${CHOST}"-clang++-11 c++ || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang++-11 clang++ || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang++-11 clang++-11 || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang++-11 "${CHOST}"-clang++-11 || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-11 cc || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-11 clang || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-11 clang-11 || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-11 "${CHOST}"-clang-11 || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-cpp-11 cpp || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-cpp-11 clang-cpp || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-cpp-11 clang-cpp-11 || die
	ln -s "${LLVMDIR}"/"${CHOST}"-clang-cpp-11 "${CHOST}"-clang-cpp-11 || die
	# LLVM Config symlinks
	ln -s "${LLVMDIR}"/"${CHOST}"-llvm-config llvm-config || die
	ln -s "${LLVMDIR}"/"${CHOST}"-llvm-config "${CHOST}"-llvm-config || die
	# Linker symlink (Doesn't really belong here)
	if use lld; then
		ln -s "${ESYSROOT}"/usr/bin/lld ld || die
	fi

	mkdir -p "${ED}"/usr/bin || die
	cp -d * "${ED}"/usr/bin || die
}
