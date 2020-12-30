# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="The gold standard Stax XML API implementation"
HOMEPAGE="https://github.com/FasterXML/woodstox"

MY_PN="woodstox"

SRC_URI="https://github.com/FasterXML/${MY_PN}/archive/${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="6"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# FIXME: JAXB API Missing in JDK9
CP_DEPEND="dev-java/osgi-core-api:0
	dev-java/stax2-api:0
	dev-java/msv:0
	dev-java/relaxng-datatype-java:0
	dev-java/xsdlib:0"

RDEPEND=">=virtual/jre-1.7
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.7
	${CP_DEPEND}
	test? ( dev-java/junit:4 )"

S="${WORKDIR}/${MY_PN}-${P}"
JAVA_SRC_DIR="src/main/java"

src_install() {
	java-pkg-simple_src_install
	dodoc README.md release-notes/VERSION
}

src_compile() {
	java-pkg-simple_src_compile
	java-pkg_addres ${PN}.jar src/main/resources
}

src_test() {
	cd src/test/java || die

	local CP=".:${S}/${PN}.jar:$(java-pkg_getjars junit-4)"
	local TESTS=$(find * -name "*Test.java")
	TESTS="${TESTS//.java}"
	TESTS="${TESTS//\//.}"

	ejavac -cp "${CP}" -d . $(find * -name "*.java")
	ejunit4 -classpath "${CP}" ${TESTS}
}
