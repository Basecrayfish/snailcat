# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Command line parsing framework for Java"
HOMEPAGE="https://github.com/cbeust/jcommander"
SRC_URI="https://github.com/cbeust/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

RESTRICT="test"

JAVA_SRC_DIR="${P}/src/main/java"

src_prepare() {
	rm -rf src/test || die
	default
}
