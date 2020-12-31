# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Truffle is an Open Source library for building programming language implementations as interpreters for self-modifying Abstract Syntax Trees"
HOMEPAGE="https://www.graalvm.org/"

PARENT_PN="graal-vm"
PARENT_P="${PARENT_PN}-${PV}"

SRC_URI="https://github.com/oracle/graal/archive/vm-${PV}.tar.gz -> ${PARENT_P}.tar.gz"

LICENSE="GPL-2-with-classpath-exception GPL-2"
SLOT="0"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/graal-sdk:0"

RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"

S="${WORKDIR}/${PARENT_P}/${PN}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	mkdir -p ${JAVA_SRC_DIR} || die
	# FIXME: Only building a stubbed api
	cp -r src/com.oracle.truffle.{api,api.jdk8,api.utilities,api.library,api.dsl,api.interop,api.exception,api.instrumentation,api.object,api.object.dsl,api.profiles}/src/* ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
