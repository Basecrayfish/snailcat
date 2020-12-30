# Copyright Gentoo Authors 2020
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The relaxng datatype library for java"
HOMEPAGE="https://github.com/java-schema-utilities/relaxng-datatype-java"

MY_PN="relaxngDatatype"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/java-schema-utilities/${PN}/archive/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="test"

RDEPEND=">=virtual/jre-1.7"
DEPEND=">=virtual/jdk-1.7"

S="${WORKDIR}/${PN}-${MY_P}"
JAVA_SRC_DIR="src/main/java"
