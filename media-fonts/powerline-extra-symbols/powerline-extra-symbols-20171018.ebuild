# Copyright 2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit font git-r3

DESCRIPTION="Extra glyphs for your powerline separators"
HOMEPAGE="https://github.com/ryanoasis/powerline-extra-symbols"
EGIT_REPO_URI="https://github.com/ryanoasis/${PN}"
EGIT_COMMIT="7fa9262caf89c500d6024313d35f0571c90aae79"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

FONT_SUFFIX="otf"
FONT_CONF=( ${FILESDIR}/10-powerline-extra-symbols.conf )
