# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A Java API for generating .java source files"
HOMEPAGE="https://github.com/square/javapoet"
SRC_URI="https://github.com/square/${PN}/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

# Needs dependencies we don't have yet.
RESTRICT="test"

S="${WORKDIR}/${PN}-${P}"
JAVA_SRC_DIR="src/main/java"
