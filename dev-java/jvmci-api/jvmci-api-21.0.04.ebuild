# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

# FIXME: Package should have a virtual that is satified by JDK9+
DESCRIPTION="JVM Compiler Instrumentation components backported to Hotspot for JDK8"
HOMEPAGE="https://github.com/graalvm/graal-jvmci-8"

PARENT_PN="jvmci"
MY_PV="21.0-b04"
PARENT_P="${PARENT_PN}-${MY_PV}"

SRC_URI="https://github.com/graalvm/graal-jvmci-8/archive/${PARENT_P}.tar.gz"

LICENSE="GPL-2-with-classpath-exception GPL-2"
SLOT="0"
KEYWORDS="~amd64"


RDEPEND=">=virtual/jre-1.8"

DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/graal-jvmci-8-${PARENT_P}/${PARENT_PN}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	mkdir -p ${JAVA_SRC_DIR} || die
	# FIXME: Only building stubbed api
	# FIXME: amd64 only
	cp -r jdk.vm.ci.{code,services,common,meta,runtime,amd64}/src/* ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
