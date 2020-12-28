# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Dependancy for old mockito"

PARENT_PN="mockito"

HOMEPAGE="https://github.com/mockito/mockito"
SRC_URI="https://github.com/mockito/${PARENT_PN}/archive/v${PV}.tar.gz -> ${PARENT_PN}-${PV}.tar.gz"

LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/ant-core:0"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"
DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

JAVA_SRC_DIR="${PARENT_PN}-${PV}/cglib-and-asm/src"

src_prepare() {
	java-pkg_clean
	java-pkg-2_src_prepare
}
