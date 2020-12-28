# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2

DESCRIPTION="Java stubs for minecraft text2speech library"
HOMEPAGE="https://minecraft.net"

MY_PN="text2speech"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://libraries.minecraft.net/com/mojang/${MY_PN}/${PV}/${MY_P}.jar
	install-natives? ( https://libraries.minecraft.net/com/mojang/${MY_PN}/${PV}/${MY_P}-natives-linux.jar )"

LICENSE="Mojang"
SLOT="0"
KEYWORDS="~amd64"

IUSE="install-natives"

RDEPEND=">=virtual/jre-1.8"

RESTRICT="bindist mirror"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${MY_P}.jar" "${WORKDIR}" || die
	if use install-natives; then
		cp "${DISTDIR}/${MY_P}-natives-linux.jar" "${WORKDIR}" || die
	fi
}

src_compile() {
	:;
}

src_install() {
	java-pkg_jarinto "/opt/${P}"
	java-pkg_newjar ${MY_P}.jar ${MY_PN}.jar
	use install-natives && java-pkg_newjar ${MY_P}-natives-linux.jar ${MY_PN}-natives-linux.jar
}
