# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The GraalVM SDK is a collection of APIs for the components of GraalVM"
HOMEPAGE="https://www.graalvm.org/"

PARENT_PN="graal-vm"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/oracle/graal/archive/vm-${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="GPL-2-with-classpath-exception GPL-2"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND=">=virtual/jre-1.8"

DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${PARENT_P}/sdk"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	mkdir -p ${JAVA_SRC_DIR} || die
	# FIXME: Check packages in actual release jar
	cp -r src/org.graalvm.{collections,home,nativeimage,options,polyglot,word}/src/* ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
