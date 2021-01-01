# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
MY_PV="1.0-rc7"
MY_P="${PN}-${MY_PV}"
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A configuration/metadata generator for java.util.ServiceLoader-style service providers"
HOMEPAGE="https://github.com/google/auto"
SRC_URI="https://github.com/google/auto/archive/${MY_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

CP_DEPEND="dev-java/auto-service-annotations:${SLOT}
	dev-java/auto-common:0"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"
RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

# Needs dependencies we don't have yet.
RESTRICT="test"

S="${WORKDIR}/auto-${MY_P}"
JAVA_SRC_DIR="service/processor/src/main/java"
