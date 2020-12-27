# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Hash of tag, download not available via ${PV}
PARENT_PV="f25ae8584db1"
PARENT_PN="jmh"
PARENT_PKG_NAME="jmh-core"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="JMH benchmark generator, based on annotation processors."
HOMEPAGE="https://openjdk.java.net/projects/code-tools/jmh"
SRC_URI="https://hg.openjdk.java.net/code-tools/${PARENT_PN}/archive/${PARENT_PV}.tar.gz -> ${PARENT_PKG_NAME}-${PV}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

# jopt *must* be 4.6, see https://mail.openjdk.java.net/pipermail/jmh-dev/2016-October/002395.html
CP_DEPEND="
	dev-java/asm:4
	dev-java/junit:4
	dev-java/commons-math:3
	dev-java/jopt-simple:4.6
	dev-java/jmh-core:0"

DEPEND=">=virtual/jdk-1.7
	${CP_DEPEND}"

RDEPEND=">=virtual/jre-1.7
	${CP_DEPEND}"

S="${WORKDIR}/${PARENT_PN}-${PARENT_PV}/${PN}"
