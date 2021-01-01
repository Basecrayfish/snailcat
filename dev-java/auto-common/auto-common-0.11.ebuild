# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A set of common utilities for Auto to help ease use of the annotation processing environment"
HOMEPAGE="https://github.com/google/auto"
SRC_URI="https://github.com/google/auto/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

CP_DEPEND="dev-java/guava:26
	dev-java/javapoet:0"

DEPEND=">=virtual/jdk-1.8
	${CP_DEPEND}"
RDEPEND=">=virtual/jre-1.8
	${CP_DEPEND}"

# Needs dependencies we don't have yet.
RESTRICT="test"

S="${WORKDIR}/auto-${P}"
JAVA_SRC_DIR="common/src/main/java"
