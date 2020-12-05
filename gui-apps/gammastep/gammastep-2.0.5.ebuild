# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{7,8,9} )

inherit systemd autotools eutils gnome2-utils python-r1

DESCRIPTION="A fork of redshift with wayland support"
HOMEPAGE="https://gitlab.com/chinstrap/gammastep"

MY_PV="v${PV}"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI="https://gitlab.com/chinstrap/gammastep/-/archive/${MY_PV}/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ayatana geoclue gtk nls wayland"

COMMON_DEPEND="
	>=x11-libs/libX11-1.4
	x11-libs/libXxf86vm
	x11-libs/libxcb
	x11-libs/libdrm
	ayatana? ( dev-libs/libappindicator:3[introspection] )
	geoclue? ( app-misc/geoclue:2.0 dev-libs/glib:2 )
	gtk? ( ${PYTHON_DEPS} )
	wayland? (
		dev-libs/wayland
		gui-libs/wlroots
	)"
RDEPEND="
	${COMMON_DEPEND}
	gtk? (
		dev-python/pygobject[${PYTHON_USEDEP}]
		x11-libs/gtk+:3[introspection]
		dev-python/pyxdg[${PYTHON_USEDEP}]
	)"
DEPEND="
	${COMMON_DEPEND}
	>=dev-util/intltool-0.50
	nls? ( sys-devel/gettext )
"
REQUIRED_USE="gtk? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use gtk && python_setup

	econf \
		--disable-silent-rules \
		$(use_enable nls) \
		--enable-drm \
		--enable-randr \
		--enable-vidmode \
		\
		$(use_enable geoclue geoclue2) \
		\
		$(use_enable gtk gui) \
		--with-systemduserunitdir="$(systemd_get_userunitdir)" \
		$(use_enable wayland)
}

_impl_specific_src_install() {
	emake DESTDIR="${D}" pythondir="$(python_get_sitedir)" \
			-C src/gammastep_indicator install
}

src_install() {
	emake DESTDIR="${D}" UPDATE_ICON_CACHE=/bin/true install

	if use gtk; then
		python_foreach_impl _impl_specific_src_install
		python_replicate_script "${D}"/usr/bin/gammastep-indicator
		dosym gammashift-indicator /usr/bin/gammastep-indicator
	fi
}

pkg_preinst() {
	use gtk && gnome2_icon_savelist
}

pkg_postinst() {
	use gtk && gnome2_icon_cache_update
}

pkg_postrm() {
	use gtk && gnome2_icon_cache_update
}
