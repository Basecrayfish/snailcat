# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A collection of Google's core Java libraries"
HOMEPAGE="https://github.com/google/guava"

PARENT_PN="guava"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/google/${PARENT_PN}/archive/v${PV}.tar.gz -> ${PARENT_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="${PV%.*}"
KEYWORDS="~amd64"

CP_DEPEND="
	dev-java/${PARENT_PN}:${SLOT}
	dev-java/animal-sniffer-annotations:0
	dev-java/checker-framework-checker-qual:0
	dev-java/error-prone-annotations:0
	dev-java/jsr305:0
	dev-java/junit:4
"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
	dev-java/j2objc-annotations:0"

S="${WORKDIR}/${PARENT_P}/${PN}"
JAVA_SRC_DIR="src"

src_configure() {
	JAVA_GENTOO_CLASSPATH_EXTRA=$(java-pkg_getjars --build-only j2objc-annotations)
}
