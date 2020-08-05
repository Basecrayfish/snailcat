# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="utmps is an implementation of the utmpx.h family of functions performing user accounting on Unix systems"
HOMEPAGE="https://www.skarnet.org/software/utmps/"
SRC_URI="https://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="nsss +shared-libs static static-libs +static-pic"

REQUIRED_USE="static? ( static-libs )"

STATIC_LIB_DEPEND=">=dev-libs/skalibs-2.9.1.0:=[static-libs]
	nsss? ( >=dev-libs/nsss-0.0.2.2:=[static-libs] )
"

SHARED_LIB_DEPEND=">=dev-libs/skalibs-2.9.1.0:=[shared-libs]
	nsss? ( >=dev-libs/nsss-0.0.2.2:=[shared-libs] )
"

RDEPEND="!static? ( ${SHARED_LIB_DEPEND} )
	shared-libs? ( ${SHARED_LIB_DEPEND} )"

DEPEND="${RDEPEND}
	static? ( ${STATIC_LIB_DEPEND} )"

PATCHES=( "${FILESDIR}"/${PN}-0.0.3.2-utmp.h-duplicate.patch )

HTML_DOCS=( doc/. )

src_prepare() {
	default

	# Avoid QA warning for LDFLAGS addition; avoid overriding -fstack-protector
	sed -i -e 's/.*-Wl,--hash-style=both$/:/' -e '/-fno-stack-protector$/d' \
		configure || die
}

src_configure() {
	econf \
		--bindir=/bin \
		--dynlibdir=/usr/$(get_libdir) \
		--libdir=/usr/$(get_libdir)/${PN} \
		--with-dynlib=/usr/$(get_libdir) \
		--with-lib=/usr/$(get_libdir)/skalibs \
		--with-sysdeps=/usr/$(get_libdir)/skalibs \
		$(use_enable nsss) \
		$(use_enable shared-libs shared) \
		$(use_enable static-pic all-pic) \
		$(use_enable static allstatic) \
		$(use_enable static static-libc) \
		$(use_enable static-libs static)
}
