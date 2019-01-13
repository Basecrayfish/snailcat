# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Script to manage system proton installations on gentoo"
HOMEPAGE="https://github.com/Basecrayfish/steam-proton-manager"
EGIT_REPO_URI="https://github.com/Basecrayfish/steam-proton-manager"

LICENSE=""
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin steam-proton-manager.sh
}
