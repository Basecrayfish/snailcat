# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="SpotBugs is FindBugs' successor. A tool for static analysis to look for bugs in Java code"
HOMEPAGE="https://spotbugs.github.io/"

PARENT_PN="spotbugs"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/spotbugs/${PARENT_PN}/archive/${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/jsr305:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${PARENT_P}/${PN}"
JAVA_SRC_DIR="src/main/java"
