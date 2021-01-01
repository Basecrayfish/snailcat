# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION=""
HOMEPAGE="http://reactivex.io/"

SRC_URI="https://github.com/reactive-streams/reactive-streams-jvm/archive/v${PV}.tar.gz -> ${P}.tar.gz"

# FIXME: Real license is MIT No Attribution aka MIT-0
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND=""

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${P}"
JAVA_SRC_DIR="api/src/main/java"
