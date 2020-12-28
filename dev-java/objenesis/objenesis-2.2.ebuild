# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="source doc"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A small Java library with one purpose: To instantiate a new object of a class"
HOMEPAGE="https://objenesis.googlecode.com/"
SRC_URI="https://github.com/easymock/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="main/src/main/java"
