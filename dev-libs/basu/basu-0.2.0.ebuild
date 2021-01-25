# Copyright 2021 Gentoo Authors
# Distrubuted under the terms of the GNU General Public License V2

EAPI=7

inherit meson

HOMEPAGE="https://github.com/emersion/basu"
DESCRIPTION="The sd-bus library, extracted from systemd"
SRC_URI="https://github.com/emersion/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
KEYWORDS="~amd64"
SLOT=0
IUSE="audit +caps"

DEPEND="
	dev-util/gperf
	audit? ( sys-process/audit )
	caps? ( sys-libs/libcap )
"
RDEPEND=""

PATCHES="${FILESDIR}/${PN}-0.2.0-remove-libcap-automagic.patch"

src_configure() {
	local emesonargs=(
		$(meson_use caps)
		$(meson_use audit)
		-Dnobody-user="nobody"
		-Dsystem-bus-address="unix:path=/var/run/dbus/system_bus_socket"
	)
	meson_src_configure
}
