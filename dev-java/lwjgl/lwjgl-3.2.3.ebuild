# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source test"

inherit eutils flag-o-matic java-pkg-2 java-ant-2 toolchain-funcs

DESCRIPTION="The Lightweight Java Game Library (LWJGL)"
HOMEPAGE="https://www.lwjgl.org"
SRC_URI="https://github.com/LWJGL/lwjgl3/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="3.2"
KEYWORDS=""
IUSE=""

MY_PN="lwjgl3"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

#GWT provides some javax annotations until i figure out how to use the real ones
CP_DEPEND="
	dev-java/commons-math:0
	dev-java/gwt:2.8
	dev-java/jcommander:0
	dev-java/joml:0
	dev-java/jmh-core:0
	dev-java/jopt-simple:0
	dev-java/testng:0
	dev-lang/kotlin-bin:0
"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8
	app-arch/zip
	app-arch/zstd[static-libs(+)]
	dev-libs/dyncall
	dev-libs/xxhash[static-libs(+)]
	sci-physics/bullet"

# Runtime deps are optional
RDEPEND=">=virtual/jre-1.8"

#JAVA_PKG_STRICT=true
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="init compile-templates generate compile compile-native release"

PATCHES=(
	"${FILESDIR}/${PN}-3.2.3-system-kotlinc.patch"
	"${FILESDIR}/${PN}-3.2.3-remove-linesep.patch"
)

# FIXME: Switch to system-libs catchall flag or use sed?
src_prepare() {
	if tc-is-clang; then
		eapply "${FILESDIR}/${PN}-3.2.3-clang-warnings.patch" || die
		eapply "${FILESDIR}/${PN}-3.2.3-use-clang.patch" || die
	fi
	if use elibc_musl; then
		eapply "${FILESDIR}/${PN}-3.2.3-musl-memcpy.patch" || die
		eapply "${FILESDIR}/${PN}-3.2.3-musl-fd_set.patch" || die
	fi
	# dyncall
	eapply "${FILESDIR}/${PN}-3.2.3-system-dyncall.patch" || die
	rm -r ${S}/modules/lwjgl/core/src/main/c/dyncall || die
	# xxhash
	eapply "${FILESDIR}/${PN}-3.2.3-system-xxhash.patch" || die
	rm -r ${S}/modules/lwjgl/xxhash/src/main/c || die
	# lz4
	eapply "${FILESDIR}/${PN}-3.2.3-system-lz4.patch" || die
	rm -r ${S}/modules/lwjgl/lz4/src/main/c || die
	# zstd
	eapply "${FILESDIR}/${PN}-3.2.3-system-zstd.patch" || die
	rm -r ${S}/modules/lwjgl/zstd/src/main/c || die
	# nfd
	# rpmalloc
	# stb
	# tinyfd
	# tootle
	# yoga
	eapply "${FILESDIR}/${PN}-3.2.3-accept_old_jdk.patch" || die
	default
}

src_configure() {
	export LWJGL_BUILD_OFFLINE="true"
	local KOTLIN_COMPILER_JAR="$(java-pkg_getjar --build-only kotlin-bin kotlin-compiler.jar)"
	export KOTLINC_HOME="$(dirname $(dirname ${KOTLIN_COMPILER_JAR}))"
	java-ant-2_src_configure
}

src_install() {
	# Move natives
	# FIXME: Should the build system be patched to create only target arch natives?
	mkdir ${T}/natives || die
	mv ${S}/bin/RELEASE/*/*-natives-linux.jar ${T}/natives || "Moving natives"

	# FIXME: These are not installed
	mkdir ${T}/natives-arm32 || die
	mv ${S}/bin/RELEASE/*/*-natives-linux-arm32.jar ${T}/natives-arm32 || die "Moving arm32 natives"

	# FIXME: These are not installed
	mkdir ${T}/natives-arm64 || die
	mv ${S}/bin/RELEASE/*/*-natives-linux-arm64.jar ${T}/natives-arm64 || die "Moving arm32 natives"

	# Move javadocs
	mkdir ${T}/javadoc || die
	mv ${S}/bin/RELEASE/*/*-javadoc.jar ${T}/javadoc || die "Moving javadocs"

	# Move sources
	mkdir ${T}/sources || die
	mv ${S}/bin/RELEASE/*/*-sources.jar ${T}/sources || die "Moving sources"

	# Install pure java jars
	java-pkg_dojar ${S}/bin/RELEASE/*/*.jar || die "Installing jars"

	# Install natives
	# FIXME: Should this be in /usr/$(get_libdir)?
	java-pkg_dojar ${T}/natives/*.jar || die "Installing natives"

	if use doc; then
		java-pkg_dojavadoc ${T}/javadoc || die "Installing javadocs"
	fi
	if use source; then
		java-pkg_dosrc ${T}/sources || die "Installing sources"
	fi
}
