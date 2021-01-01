# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="High-performance, streaming/chunking Java LZF codec"
HOMEPAGE="https://github.com/ning/compress"

SRC_URI="https://github.com/ning/compress/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8"

DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/compress-${P}"
JAVA_SRC_DIR="src/main/java"
