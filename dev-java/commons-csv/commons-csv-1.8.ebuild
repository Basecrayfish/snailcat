# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple eutils

DESCRIPTION="Commons CSV reads and writes files in variations of the Comma Separated Value (CSV) format"
HOMEPAGE="http://commons.apache.org/csv/"
SRC_URI="https://github.com/apache/${PN}/archive/rel/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="1"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="test"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${PN}-rel-${P}"
JAVA_SRC_DIR="src/main/java"
