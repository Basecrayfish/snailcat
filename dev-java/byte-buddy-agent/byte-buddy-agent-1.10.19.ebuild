# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Runtime code generation for the Java virtual machine"
HOMEPAGE="https://bytebuddy.net/"

PARENT_PN="byte-buddy"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/raphw/${PARENT_PN}/archive/${PARENT_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

# FIXME: Not using native code
CP_DEPEND="dev-java/jna:4
	dev-java/spotbugs-annotations:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${PARENT_PN}-${PARENT_P}/${PN}"
JAVA_SRC_DIR="src/main/java"
