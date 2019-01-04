# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 qmake-utils

DESCRIPTION="GameStream client for PCs (Windows, Mac, and Linux)"
HOMEPAGE="https://moonlight-stream.org"
EGIT_REPO_URI="https://github.com/moonlight-stream/moonlight-qt"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+steamlink pulseaudio alsa +ffmpeg wayland vaapi vdpau"

DEPEND="
	dev-libs/openssl
	dev-qt/qtcore
	dev-qt/qtmultimedia
	dev-qt/qtsvg
	dev-qt/qtquickcontrols
	dev-qt/qtquickcontrols2
	media-libs/libsdl2
	media-libs/opus
	pulseaudio? ( media-sound/pulseaudio )
	alsa? ( media-libs/alsa-lib )
	ffmpeg? ( media-libs/ffmpeg )
	vaapi? (
		x11-libs/libva
		wayland? ( x11-libs/libva[wayland] )
	)
	"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default

	# Disable unwanted components
	if ! use pulseaudio; then
		sed -i -e '/PKGCONFIG += libpulse/d' src/app/app.pro || die
	fi
	if ! use alsa; then
		sed -i -e '/PKGCONFIG += alsa/d' src/app/app.pro || die
	fi
	if ! use ffmpeg; then
		sed -i -e '/packagesExist(libavcodec)/,/^    }/d' src/app/app.pro || die
	else
		if ! use vaapi; then
			sed -i -e '/packagesExist(libva)/,/^        }/d' src/app/app.pro || die
		else
			if ! use wayland; then
				sed -i -e '/CONFIG += libva-wayland/d' src/app/app.pro || die
			fi
		fi
		if ! use vdpau; then
			sed -i -e '/CONFIG += libvdpau' src/app/app/pro || die
		fi
	fi
	if use steamlink; then
		ewarn steamlink support is currently unavailable in this ebuild
	fi
}

src_configure() {
	eqmake5
}
