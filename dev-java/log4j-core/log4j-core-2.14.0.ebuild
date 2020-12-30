# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE=""

inherit java-pkg-2 java-pkg-simple

DESCRIPTION="A low-overhead robust logging package for Java"
HOMEPAGE="https://logging.apache.org/log4j/2.x/index.html"

MY_PN="logging-log4j2"

SRC_URI="https://github.com/apache/${MY_PN}/archive/rel/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="2"
KEYWORDS="~amd64"

# dev-java/log4j-plugins:${SLOT}
CP_DEPEND="dev-java/log4j-api:${SLOT}
	dev-java/disruptor:0
	dev-java/woodstox-core:6
	dev-java/jctools-core:0
	dev-java/jansi:1.11
	dev-java/jackson:2
	dev-java/jackson-databind:2
	dev-java/jackson-dataformat-xml:2
	dev-java/jackson-dataformat-yaml:2
	dev-java/commons-csv:1
	dev-java/commons-compress:0
	dev-java/mail:1"

RDEPEND="${CP_DEPEND}
	>=virtual/jre-1.8"

DEPEND="${CP_DEPEND}
	>=virtual/jdk-1.8"

S="${WORKDIR}/${MY_PN}-rel-${PV}"

JAVA_SRC_DIR="${PN}/src/main/java"

src_prepare() {
	default
	java-pkg_clean
	# Remove unimplemented optional dependancy
	rm ${JAVA_SRC_DIR}/org/apache/logging/log4j/core/async/DisruptorBlockingQueueFactory.java || die
	rm -r ${JAVA_SRC_DIR}/org/apache/logging/log4j/core/appender/mom || die
}
