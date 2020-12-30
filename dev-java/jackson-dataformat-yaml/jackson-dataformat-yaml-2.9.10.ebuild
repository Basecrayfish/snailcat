# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="Jackson extension component for reading and writing XML encoded data"
HOMEPAGE="https://github.com/FasterXML/jackson-dataformat-xml"

PARENT_PN="jackson-dataformats-text"
PARENT_P="${PARENT_PN}-${PV}"
MY_PN="yaml"

SRC_URI="https://github.com/FasterXML/${PARENT_PN}/archive/${PARENT_P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="!test? ( test )"

# FIXME: JAXB API Missing in JDK9
CP_DEPEND="dev-java/jackson:${SLOT}
	dev-java/jackson-annotations:${SLOT}
	dev-java/jackson-databind:${SLOT}
	dev-java/snakeyaml:0"

RDEPEND=">=virtual/jre-1.7
	${CP_DEPEND}"

DEPEND=">=virtual/jdk-1.7
	${CP_DEPEND}
	test? ( dev-java/junit:4 )"

S="${WORKDIR}/${PARENT_PN}-${PARENT_P}/${MY_PN}"
JAVA_SRC_DIR="src/main/java"

src_prepare() {
	default

	sed -e 's:@package@:com.fasterxml.jackson.dataformat.yaml:g' \
		-e "s:@projectversion@:${PV}:g" \
		-e 's:@projectgroupid@:com.fasterxml.jackson.dataformat:g' \
		-e 's:@projectartifactid@:jackson-dataformat-yaml:g' \
		"${JAVA_SRC_DIR}/com/fasterxml/jackson/dataformat/yaml/PackageVersion.java.in" \
		> "${JAVA_SRC_DIR}/com/fasterxml/jackson/dataformat/yaml/PackageVersion.java" || die

	java-pkg-2_src_prepare
}

src_install() {
	java-pkg-simple_src_install
	dodoc README.md ../release-notes/VERSION-2.x
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
