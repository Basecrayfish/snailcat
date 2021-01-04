# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 multilib

DESCRIPTION="Realtime CPU/GPU Profiler with Remote Web Viewer"
HOMEPAGE="https://github.com/Celtoys/Remotery"
EGIT_REPO_URI="https://github.com/Celtoys/Remotery.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+opengl"

DEPEND="opengl? ( virtual/opengl )"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-musl-fd_set.patch" )

src_prepare() {
	if use opengl; then
		sed -e "s/#define RMT_USE_OPENGL 0/#define RMT_USE_OPENGL 1/g" \
			-i ${S}/lib/Remotery.h || die "sed failed"
	fi
	default
}

src_compile() {
	$(tc-getCC) ${CFLAGS} -c -Ilib -o Remotery.o lib/Remotery.c || die
	$(tc-getAR) rcs libremotery.a Remotery.o || die
}

src_install() {
	dolib.a ${S}/libremotery.a
	doheader ${S}/lib/Remotery.h
	sed -e "s@%LIB%@$(get_libdir)@g" -e "s@%PREFIX%@${EPREFIX}/usr@g" \
		"${FILESDIR}/remotery.pc" > "${T}/remotery.pc" \
		|| die "sed failed"
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${T}/remotery.pc"
}
