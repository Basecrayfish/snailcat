# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A mocking framework for Java"
HOMEPAGE="https://github.com/mockito/mockito"
SRC_URI="https://github.com/mockito/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/junit:4
	dev-java/objenesis:2
	dev-java/hamcrest-core:0
	dev-java/ant-core:0
	dev-java/mockito-cglib:1.8.5"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"
DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

JAVA_SRC_DIR="${P}/src"

src_prepare() {
	java-pkg_clean
	java-pkg-2_src_prepare
}
