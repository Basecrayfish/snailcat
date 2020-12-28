# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A low-overhead robust logging package for Java"
HOMEPAGE="https://logging.apache.org/log4j/2.x/index.html"

PARENT_PN="log4j"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/apache/logging-log4j2/archive/${PARENT_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/osgi-core-api:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

MY_P="logging-log4j2-${P}"
S="${WORKDIR}/logging-log4j2-${PARENT_P}"

JAVA_SRC_DIR="${PN}/src/main/java"

src_prepare() {
	default
	java-pkg_clean
}

src_install() {
	java-pkg_dojar ${S}/${PN}.jar
}
