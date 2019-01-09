# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Manage active wine version"
HOMEPAGE="https://bitbucket.org/NP-Hardass/eselect-wine"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://bitbucket.org/NP-Hardass/eselect-wine.git"
	EGIT_BRANCH="master"
	inherit git-r3
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="https://bitbucket.org/NP-Hardass/${PN}/raw/v${PV}/wine.eselect -> wine.eselect-${PV}"
	KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

RDEPEND="app-admin/eselect
	dev-util/desktop-file-utils
	!!app-emulation/wine:0"

S=${WORKDIR}

src_prepare() {
	eapply "${FILESDIR}/00_steam-proton.patch"
	default
}

src_install() {
	cp "${S}"/eselect-wine-"${PV}"/wine.eselect "${DISTDIR}"/wine.eselect-"${PV}"
	keepdir /etc/eselect/wine

	insinto /usr/share/eselect/modules
	newins "${DISTDIR}"/wine.eselect-${PV} wine.eselect
}

pkg_postinst() {
	# <eselect-wine-v0.3_rc7 installed symlinks with leading double-slashes.
	# In /usr/include this breaks gcc build.
	# https://bugs.gentoo.org/434180
	if [[ $(readlink "${EROOT%/}"/usr/include/wine) == //* ]]; then
		ewarn "Leading double slash in ${EPREFIX%/}/usr/include/wine symlink detected."
		ewarn "Re-setting wine symlinks..."
		eselect wine update --if-unset
	fi
}

pkg_prerm() {
	# Avoid conflicts with wine[-multislot] installed later
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		elog "${PN} is being uninstalled, removing symlinks"
		eselect wine unset --all || die
	else
		einfo "${PN} is being updated/reinstalled, not modifying symlinks"
	fi
}
