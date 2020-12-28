# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Brigadier is a command parser & dispatcher, designed and developed for Minecraft: Java Edition"
HOMEPAGE="https://github.com/Mojang/brigadier"
SRC_URI="https://github.com/Mojang/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="MIT"
SLOT="0"

KEYWORDS="~amd64"

CP_DEPEND="dev-java/guava:26
	dev-java/junit:4
	dev-java/hamcrest-library:1.3
	dev-java/mockito:0
	dev-java/guava-testlib:26
	dev-java/jmh-core:0
	dev-java/jmh-generator-annprocess:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

JAVA_SRC_DIR="${P}/src/main/java"

src_install() {
	einstalldocs
	java-pkg-simple_src_install
}
