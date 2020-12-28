# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source"

inherit java-pkg-2 java-pkg-simple

PARENT_PN="checker-framework"

DESCRIPTION="Pluggable type-checking for Java"
HOMEPAGE="https://checkerframework.org/"
SRC_URI="https://github.com/typetools/${PARENT_PN}/archive/${PARENT_PN}-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

S="${WORKDIR}/${PARENT_PN}-${PARENT_PN}-${PV}"

JAVA_SRC_DIR="${S}/${PN}/src/main/java"

src_prepare() {
	mkdir -p ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/formatter/FormatUtil.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/nullness/NullnessUtil.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/regex/RegexUtil.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/units/UnitsTools.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/signedness/SignednessUtil.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/i18nformatter/I18nFormatUtil.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/*/qual/*.java ${JAVA_SRC_DIR} || die
	cp ${S}/dataflow/src/main/java/org/checkerframework/dataflow/qual/*.java ${JAVA_SRC_DIR} || die
	cp ${S}/framework/src/main/java/org/checkerframework/common/*/qual/*.java ${JAVA_SRC_DIR} || die
	cp ${S}/framework/src/main/java/org/checkerframework/framework/qual/*.java ${JAVA_SRC_DIR} || die
	cp ${S}/checker/src/main/java/org/checkerframework/checker/nullness/Opt.java ${JAVA_SRC_DIR} || die
	cp ${S}/framework/src/main/java/org/checkerframework/framework/util/PurityUnqualified.java ${JAVA_SRC_DIR} || die
	java-pkg-2_src_prepare
}
