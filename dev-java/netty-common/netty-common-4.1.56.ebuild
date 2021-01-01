# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

MY_PN="netty"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Async event-driven framework for high performance network applications"
HOMEPAGE="https://netty.io/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${MY_P}.Final.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test"

CP_DEPEND="dev-java/commons-logging:0
	dev-java/log4j-api:2
	dev-java/log4j-core:2
	dev-java/jctools-core:0
	dev-java/slf4j-api:0
	dev-java/substratevm:0
	dev-java/blockhound:0"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

S="${WORKDIR}/${MY_PN}-${MY_P}.Final/${PN/${MY_PN}-}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	# Needs Mockito 1.10.
	rm -v src/test/java/io/netty/util/concurrent/PromiseCombinerTest.java || die
	java-pkg-2_src_prepare
}
