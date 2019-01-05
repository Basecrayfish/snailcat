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
	ffmpeg? ( >=media-video/ffmpeg-4.0.2 )
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
		sed -i -e '/PKGCONFIG += libpulse/d' soundio/soundio.pro || die
		sed -i -e '/packagesExist(libpulse)/,/^    }/d' soundio/soundio.pro || die
	fi
	if ! use alsa; then
		sed -i -e '/PKGCONFIG += alsa/d' app/app.pro || die
		sed -i -e '/packagesExist(alsa)/,/^    }/d' app/app.pro || die
	fi
	if ! use ffmpeg; then
		sed -i -e '/packagesExist(libavcodec)/,/^    }/d' app/app.pro || die
	else
		if ! use vaapi; then
			sed -i -e '/packagesExist(libva)/,/^        }/d' app/app.pro || die
		else
			if ! use wayland; then
				sed -i -e '/CONFIG += libva-wayland/d' app/app.pro || die
			fi
		fi
		if ! use vdpau; then
			sed -i -e '/CONFIG += libvdpau/d' app/app.pro || die
		fi
	fi
	if use steamlink; then
		ewarn steamlink support is currently unavailable in this ebuild
	else
		sed -i -e '/qtCompileTest(SLVideo)/d' moonlight-qt.pro || die
	fi
}

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
