# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="Generates an init binary for s6-based init systems"
HOMEPAGE="https://www.skarnet.org/software/s6-linux-init/"
SRC_URI="https://www.skarnet.org/software/${PN}/${P}.tar.gz"

LICENSE="ISC"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="pie +shared-libs static static-libs +static-pic +sysv-utils utmps"

REQUIRED_USE="static? ( static-libs )
	pie? ( static static-libs !shared-libs !static-pic )" # Only static-pie is supported

STATIC_LIB_DEPEND=">=dev-lang/execline-2.5.3.0:=[static-libs]
	>=dev-libs/skalibs-2.9.1.0:=[static-libs?]
	>=sys-apps/s6-2.9.0.1:=[static-libs]
	utmps? ( >=sys-apps/utmps-0.0.3.2:=[static-libs] )
"

SHARED_LIB_DEPEND=">=dev-lang/execline-2.5.3.0:=[shared-libs]
	>=dev-libs/skalibs-2.9.1.0:=[shared-libs]
	>=sys-apps/s6-2.9.0.1:=[shared-libs]
	utmps? ( >=dev-libs/utmps-0.0.3.2:=[shared-libs] )
"

RDEPEND="!static? ( ${SHARED_LIB_DEPEND} )
	shared-libs? ( ${SHARED_LIB_DEPEND} )
	>=dev-lang/execline-2.5.3.0:=
	>=sys-apps/s6-2.9.0.1:=
"

DEPEND="${RDEPEND}
	static? ( ${STATIC_LIB_DEPEND} )
	sysv-utils? (
		!sys-apps/systemd[sysv-utils]
		!sys-apps/sysvinit
	)
"

HTML_DOCS=( doc/. )

src_prepare() {
	default

	# Avoid QA warning for LDFLAGS addition; avoid overriding -fstack-protector
	sed -i -e 's/.*-Wl,--hash-style=both$/:/' -e '/-fno-stack-protector$/d' \
		configure || die
}

src_configure() {
	if use pie ; then
		filter-flags -fpic -fPIC
		append-cflags -fpie
		append-cxxflags -fpie
		append-ldflags -static-pie
	fi

	econf \
		--bindir=/bin \
		--dynlibdir=/usr/$(get_libdir) \
		--skeldir=/etc/s6-linux-init/skel \
		--libdir=/usr/$(get_libdir)/${PN} \
		--with-dynlib=/usr/$(get_libdir) \
		--with-lib=/usr/$(get_libdir)/s6 \
		--with-lib=/usr/$(get_libdir)/skalibs \
		--with-lib=/usr/$(get_libdir)/utmps \
		--with-sysdeps=/usr/$(get_libdir)/skalibs \
		--disable-nsss \
		$(use_enable utmps) \
		$(use_enable shared-libs shared) \
		$(use_enable static-pic all-pic) \
		$(use_enable static allstatic) \
		$(use_enable static static-libc) \
		$(use_enable static-libs static)
}

src_install() {
	default

	if use sysv-utils ; then
		"${D}/bin/s6-linux-init-maker" -f "${D}/etc/s6-linux-init/skel" "${T}/dir" || die
		into /
		dosbin "${T}/dir/bin"/{halt,poweroff,reboot,shutdown,telinit}
	fi
}

pkg_postinst() {
	einfo "Read ${EROOT}/usr/share/doc/${PF}/html/quickstart.html"
	einfo "for usage instructions."
}
