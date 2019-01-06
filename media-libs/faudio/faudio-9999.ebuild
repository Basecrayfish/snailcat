# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-multilib git-r3

DESCRIPTION="Accuracy-focused XAudio reimplementation for open platforms"
HOMEPAGE="https://fna-xna.github.io/"
EGIT_REPO_URI="https://github.com/FNA-XNA/FAudio"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS=""
IUSE="+ffmpeg"

DEPEND="
	media-libs/sdl2[${MULTILIB_USEDEP}]
	ffmpeg? ( media-video/ffmpeg[${MULTILIB_USEDEP}] )
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DFFMPEG=$(usex ffmpeg)
	)
	cmake-multilib_src_configure
}
