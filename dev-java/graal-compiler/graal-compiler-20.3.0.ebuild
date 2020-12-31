# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The GraalVM compiler is a dynamic compiler written in Java that integrates with the HotSpot JVM"
HOMEPAGE="https://www.graalvm.org/"

PARENT_PN="graal-vm"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/oracle/graal/archive/vm-${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="GPL-2-with-classpath-exception GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/graal-sdk:0
	dev-java/truffle:0
	dev-java/jvmci-api:0"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"


S="${WORKDIR}/${PARENT_P}/compiler"
JAVA_SRC_DIR="src/main/java"

PATCHES=( "${FILESDIR}/${PN}-20.3.0-stub-truffle-polyglot-options.patch" )

src_prepare() {
	default
	mkdir -p ${JAVA_SRC_DIR} || die
	# FIXME: Only building a stubbed api
	cp -r src/org.graalvm.{graphio,libgraal,libgraal.jdk8,util}/src/* ${JAVA_SRC_DIR} || die
	cp -r src/org.graalvm.compiler.{bytecode,code,core,core.amd64,core.aarch64,core.sparc,core.common,debug,graph,java,lir,lir.amd64,lir.aarch64,lir.sparc,loop,loop.phases,phases,phases.common,printer,asm,asm.amd64,asm.aarch64,asm.sparc,nodes,nodeinfo,options,serviceprovider,serviceprovider.jdk8,api.directives,api.runtime,api.replacements,word,virtual,replacements,replacements.amd64,replacements.aarch64,replacements.sparc,hotspot,hotspot.jdk8,runtime,truffle.common,truffle.compiler,truffle.options}/src/* ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
