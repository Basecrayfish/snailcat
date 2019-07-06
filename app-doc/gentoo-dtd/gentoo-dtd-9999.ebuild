# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Document Type Definition for Gentoo-related XML files"
HOMEPAGE="https://gitweb.gentoo.org/data/dtd.git/"
EGIT_REPO_URI="https://anongit.gentoo.org/git/data/dtd.git"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	insinto /dtd
	doins *.dtd
}
