# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 java-pkg-2 java-pkg-simple

DESCRIPTION="A set of utilities designed for incremental building, merging and optimization of data transformations"
HOMEPAGE="https://github.com/Mojang/DataFixerUpper"
EGIT_REPO_URI="https://github.com/Mojang/DataFixerUpper.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""

CP_DEPEND="
	dev-java/gson:2.8
	dev-java/guava:21
	dev-java/commons-lang:3.6
	dev-java/fastutil:0
	dev-java/log4j-api:2
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"
RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

JAVA_SRC_DIR="${P}/src/main/java"
