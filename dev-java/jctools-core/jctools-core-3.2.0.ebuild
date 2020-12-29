# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java Concurrency Tools for the JVM"
HOMEPAGE="https://jctools.github.io/JCTools/"

PARENT_PN="JCTools"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/JCTools/${PARENT_PN}/archive/v${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8"

DEPEND=">=virtual/jdk-1.8"

JAVA_SRC_DIR="${PARENT_P}/${PN}/src/main/java"
