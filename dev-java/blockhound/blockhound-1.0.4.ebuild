# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Java agent to detect blocking calls from non-blocking threads"
HOMEPAGE="https://github.com/reactor/BlockHound"

MY_PN="BlockHound"
MY_PV="${PV}.RELEASE"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="https://github.com/reactor/${MY_PN}/archive/${MY_PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CP_DEPEND="dev-java/byte-buddy:0
	dev-java/byte-buddy-agent:0
	dev-java/asm:9
	dev-java/asm-commons:9
	dev-java/auto-service:0
	dev-java/rxjava:2"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${MY_P}/agent"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	# Reverse byte-buddy asm class relocations
	sed -e "s/net.bytebuddy.jar.asm/org.objectweb.asm/g" \
		-i "${JAVA_SRC_DIR}/reactor/blockhound/NativeWrappingClassFileTransformer.java" \
		-i "${JAVA_SRC_DIR}/reactor/blockhound/BlockingMethod.java" \
		-i "${JAVA_SRC_DIR}/reactor/blockhound/InstrumentationUtils.java" || die
	# FIXME: Cyclical dependancy should be added via use flag
	rm ${JAVA_SRC_DIR}/reactor/blockhound/integration/ReactorIntegration.java || die
	java-pkg-2_src_prepare
}
