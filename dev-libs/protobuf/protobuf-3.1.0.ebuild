# Copyright 2008-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools elisp-common flag-o-matic multilib-minimal toolchain-funcs

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3

	EGIT_REPO_URI="https://github.com/protocolbuffers/protobuf"
	EGIT_SUBMODULES=()
fi

DESCRIPTION="Google's Protocol Buffers - Extensible mechanism for serializing structured data"
HOMEPAGE="https://developers.google.com/protocol-buffers/ https://github.com/protocolbuffers/protobuf"
if [[ "${PV}" == "9999" ]]; then
	SRC_URI=""
else
	SRC_URI="https://github.com/protocolbuffers/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="BSD"
SLOT="3.1.0"
KEYWORDS="~amd64"
IUSE="static-libs test zlib"
# Hacky ebuild so no tests for you
RESTRICT="test"

DEPEND="test? ( >=dev-cpp/gtest-1.9[${MULTILIB_USEDEP}] )
	zlib? ( sys-libs/zlib[${MULTILIB_USEDEP}] )"
RDEPEND="zlib? ( sys-libs/zlib[${MULTILIB_USEDEP}] )"

PATCHES=(
	"${FILESDIR}/${PN}-2.6.1-protoc-cmdline.patch"
	"${FILESDIR}/${PN}-3.0.2-disable-local-gmock.patch"
)

DOCS=(CHANGES.txt CONTRIBUTORS.txt README.md)

src_prepare() {
	default

	# https://github.com/protocolbuffers/protobuf/issues/7413
	sed -e "/^AC_PROG_CXX_FOR_BUILD$/d" -i configure.ac || die

	eautoreconf
}

src_configure() {
	append-cppflags -DGOOGLE_PROTOBUF_NO_RTTI

	if tc-ld-is-gold; then
		# https://sourceware.org/bugzilla/show_bug.cgi?id=24527
		tc-ld-disable-gold
	fi

	multilib-minimal_src_configure
}

# FIXME: Ignores /lib64 etc...
# FIXME: Ignores EPREFIX
# FIXME: WONTFIX: Throwaway ebuild used to test ancient rev-deps
multilib_src_configure() {
	local options=(
		$(use_enable static-libs static)
		$(use_with zlib)
		--prefix=/usr/lib/protobuf-${PV}
		--exec-prefix=/usr/lib/protobuf-${PV}
	)

	if tc-is-cross-compiler; then
		# Build system uses protoc when building, so protoc copy runnable on host is needed.
		mkdir -p "${WORKDIR}/build" || die
		pushd "${WORKDIR}/build" > /dev/null || die
		ECONF_SOURCE="${S}" econf_build "${options[@]}"
		options+=(--with-protoc="$(pwd)/src/protoc")
		popd > /dev/null || die
	fi

	ECONF_SOURCE="${S}" econf "${options[@]}"
}

src_compile() {
	multilib-minimal_src_compile
}

multilib_src_compile() {
	if tc-is-cross-compiler; then
		emake -C "${WORKDIR}/build/src" protoc
	fi

	default
}

multilib_src_test() {
	emake check
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
