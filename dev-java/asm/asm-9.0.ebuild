# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PV="ASM_9_0"
MY_P="${PN}-${MY_PV}"
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Bytecode manipulation framework for Java"
HOMEPAGE="http://asm.ow2.org"
SRC_URI="https://gitlab.ow2.org/asm/${PN}/-/archive/${MY_PV}/${MY_P}.tar.bz2"
LICENSE="BSD"
SLOT="9"
IUSE=""
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

# Needs dependencies we don't have yet.
RESTRICT="test"

S="${WORKDIR}/${MY_P}"
JAVA_SRC_DIR="${PN}/src/main/java"
