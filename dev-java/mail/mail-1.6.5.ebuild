# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-ant-2

DESCRIPTION="Implementation of the Jakarta Mail API"
HOMEPAGE="https://github.com/eclipse-ee4j/mail"
SRC_URI="https://github.com/eclipse-ee4j/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="EPL-2.0"
SLOT="1"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="test"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${P}"

PATCHES=( "${FILESDIR}/${P}-remove-maven-tasks.patch" )

JAVA_PKG_STRICT="true"
JAVA_ANT_REWRITE_CLASSPATH="true"

src_prepare() {
	default
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg_dojar ${S}/target/release/${PN}.jar || die "Installing JAR"
	default
}
