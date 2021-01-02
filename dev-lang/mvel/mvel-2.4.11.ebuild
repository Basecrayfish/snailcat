# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="MVEL (MVFLEX Expression Language)"
HOMEPAGE="http://mvel.documentnode.com/"

MY_PN="mvel2"
MY_PV="${PV}.Final"
MY_P="${MY_PN}-${MY_PV}"

SRC_URI="https://github.com/mvel/${PN}/archive/${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

CP_DEPEND="dev-java/asm:9"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${PN}-${MY_P}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	java-pkg_clean
	rm -r ${JAVA_SRC_DIR}/org/mvel2/asm || die
	sed -e "s/org.mvel2.asm/org.objectweb.asm/g" \
		-i "${JAVA_SRC_DIR}/org/mvel2/optimizers/impl/asm/ProducesBytecode.java" \
		-i "${JAVA_SRC_DIR}/org/mvel2/optimizers/OptimizerFactory.java" \
		-i "${JAVA_SRC_DIR}/org/mvel2/optimizers/impl/asm/ASMAccessorOptimizer.java" \
		|| die "sed failed"
	java-pkg-2_src_prepare
}
