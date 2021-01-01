# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PARENT_PN="asm"
PARENT_PV="ASM_9_0"
PARENT_P="${PARENT_PN}-${PARENT_PV}"
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Bytecode manipulation framework for Java"
HOMEPAGE="http://asm.ow2.org"
SRC_URI="https://gitlab.ow2.org/asm/asm/-/archive/${PARENT_PV}/${PARENT_P}.tar.bz2"
LICENSE="BSD"
SLOT="9"
IUSE=""
KEYWORDS="~amd64"

CP_DEPEND="dev-java/asm:${SLOT}
	dev-java/asm-tree:${SLOT}"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"
RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

# Needs dependencies we don't have yet.
RESTRICT="test"

S="${WORKDIR}/${PARENT_P}"
JAVA_SRC_DIR="${PN}/src/main/java"
