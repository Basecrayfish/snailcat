# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-ant-2

DESCRIPTION="LZ4 compression for Java"
HOMEPAGE="https://github.com/lz4/lz4-java"

SRC_URI="https://github.com/lz4/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="pure-java"

# FIXME: pure java toggle does nothing
CDEPEND="
	!pure-java? (
		app-arch/lz4
		dev-libs/xxhash
	)"
CP_DEPEND="dev-java/cpptasks:0
	dev-lang/mvel:2.3"

# FIXME: Missing OSGi Support
RDEPEND=">=virtual/jre-1.7
	${CDEPEND}"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.7
	${CDEPEND}"

JAVA_PKG_STRICT="true"
EANT_BUILD_TARGET="jar"

PATCHES=( "${FILESDIR}/${P}-build-xml.patch" )

src_prepare() {
	default
	# TODO: patch in/out pure-java
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar ${S}/dist/lz4.jar
}
