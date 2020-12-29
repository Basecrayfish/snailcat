# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="OSHI is a free JNA-based (native) Operating System and Hardware Information library for Java"
HOMEPAGE="https://github.com/oshi/oshi"

PARENT_PN="oshi"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/oshi/${PARENT_PN}/archive/${P}.tar.gz"

LICENSE="EPL-1.0"
SLOT="1"
KEYWORDS="~amd64"

PATCHES=( "${FILESDIR}/${P}-remove-jna-fix.patch" )

CP_DEPEND="dev-java/jna:4
	dev-java/slf4j-simple:0"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

S="${WORKDIR}/${PARENT_PN}-${P}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	default
	java-pkg-2_src_prepare
}
