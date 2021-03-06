# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A Java library for parsing command line options"
HOMEPAGE="https://pholser.github.com/jopt-simple"
SRC_URI="https://github.com/jopt-simple/${PN}/archive/${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${PN}-${P}"

JAVA_SRC_DIR="src/main/java"

src_prepare() {
	default
	rm -v pom.xml || die
}

src_install() {
	einstalldocs
	java-pkg-simple_src_install
}
