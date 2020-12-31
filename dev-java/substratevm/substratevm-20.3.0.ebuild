# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Substrate VM is the name for the runtime components required for a graal native image"
HOMEPAGE="https://www.graalvm.org/"

PARENT_PN="graal-vm"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/oracle/graal/archive/vm-${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="GPL-2-with-classpath-exception GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/graal-sdk:0
	dev-java/truffle:0
	dev-java/jvmci-api:0
	dev-java/graal-compiler:0"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${PARENT_P}/${PN}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	mkdir -p ${JAVA_SRC_DIR} || die
	cp -r src/com.oracle.{graal.pointsto,objectfile}/src/* ${JAVA_SRC_DIR} || die
	cp -r src/com.oracle.svm.{util,core,core.jdk8,core.posix,graal,core.graal.amd64,core.graal.aarch64,hosted,reflect}/src/* ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
