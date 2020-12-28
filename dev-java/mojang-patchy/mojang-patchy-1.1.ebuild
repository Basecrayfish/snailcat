# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2

DESCRIPTION="Library used for Minecraft"
HOMEPAGE="https://minecraft.net"

MY_PN="patchy"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://libraries.minecraft.net/com/mojang/${MY_PN}/${PV}/${MY_P}.jar"

LICENSE="Mojang"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8"

RESTRICT="bindist mirror"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/${A}" "${WORKDIR}" || die
}

src_compile() {
	:;
}

src_install() {
	java-pkg_jarinto "/opt/${P}"
	java-pkg_newjar ${MY_P}.jar ${MY_PN}.jar
}
