# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="YAML 1.2 parser and emitter for Java 8"
HOMEPAGE="https://bitbucket.org/asomov/snakeyaml-engine"

COMMIT_HASH="6dccee472c70"
REPO_AUTHOR="asomov"

SRC_URI="https://bitbucket.org/${REPO_AUTHOR}/${PN}/get/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="test"

RDEPEND=">=virtual/jre-1.8"
DEPEND=">=virtual/jdk-1.8"

S="${WORKDIR}/${REPO_AUTHOR}-${PN}-${COMMIT_HASH}"
JAVA_SRC_DIR="src/main/java"
