# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A Java math library for OpenGL rendering calculations"
HOMEPAGE="https://joml-ci.github.io/JOML/"

MY_PN="JOML"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/JOML-CI/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

JAVA_SRC_DIR="src"
JAVA_GENTOO_CLASSPATH="gwt-2.8"

S="${WORKDIR}/${MY_P}"

PATCHES=( "${FILESDIR}/${PN}-1.9.16-gwt-preprocess.patch" )

src_prepare() {
	default
	rm -v pom.xml || die
}

src_install() {
	einstalldocs
	java-pkg-simple_src_install
}
