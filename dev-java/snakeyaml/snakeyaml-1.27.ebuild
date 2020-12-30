# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A YAML 1.1 parser and emitter for Java"
HOMEPAGE="https://bitbucket.org/asomov/snakeyaml"

REPO_COMMIT="29e2699b80fc"
REPO_AUTHOR="asomov"

SRC_URI="https://bitbucket.org/${REPO_AUTHOR}/${PN}/get/${P}.tar.bz2"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

DEPEND=">=virtual/jdk-1.8
	test? (
		dev-java/joda-time:0
		dev-java/junit:4 )"

RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${REPO_AUTHOR}-${PN}-${REPO_COMMIT}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	# Remove some tests with tricky dependencies.
	rm -rv src/test/java/org/yaml/snakeyaml/emitter/template/VelocityTest.java || die
	java-pkg-2_src_prepare
}

src_install() {
	java-pkg-simple_src_install
	dodoc README.md src/etc/announcement.msg
}

src_test() {
	local DIR="src/test/java"
	local CP="${DIR}/../resources:${DIR}:${PN}.jar:$(java-pkg_getjars joda-time,junit-4)"

	local TESTS=$(find "${DIR}" -name "*Test.java" ! -name AbstractTest.java ! -name PyImportTest.java)
	TESTS="${TESTS//src\/test\/java\/}"
	TESTS="${TESTS//.java}"
	TESTS="${TESTS//\//.}"

	ejavac -cp "${CP}" -d "${DIR}" $(find "${DIR}" -name "*.java")
	ejunit4 -classpath "${CP}" ${TESTS}
}
