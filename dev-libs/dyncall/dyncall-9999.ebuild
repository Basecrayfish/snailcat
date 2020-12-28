# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake mercurial multilib

DESCRIPTION="A Generic Dynamic FFI package"
HOMEPAGE="https://www.dyncall.org"
EHG_REPO_URI="https://dyncall.org/pub/dyncall/dyncall"

# Closest appoximation
LICENSE="BSD-1"
SLOT="0"
KEYWORDS=""

src_install() {
	cmake_src_install

	sed -e "s@%LIB%@$(get_libdir)@g" -e "s@%PREFIX%@${EPREFIX}/usr@g" \
		"${FILESDIR}/dyncall.pc" > "${T}/dyncall.pc" \
		|| die "sed failed"
	insinto "/usr/$(get_libdir)/pkgconfig"
	doins "${T}/dyncall.pc"
}
