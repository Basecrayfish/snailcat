# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Reactive Extensions for the JVM"
HOMEPAGE="http://reactivex.io/"

MY_PN="RxJava"
MY_P="${MY_PN}-${PV}"

SRC_URI="https://github.com/ReactiveX/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/reactive-streams-jvm:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${MY_P}"
JAVA_SRC_DIR="src/main/java"
