# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package providing LineageOS build environment"
HOMEPAGE="https://lineageos.org"

LICENSE="metapackage"
SLOT="16.0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-arch/lz4
	app-arch/lzop
	dev-util/aosp-devel-meta:9.0
	media-gfx/imagemagick
	media-gfx/pngcrush
	media-libs/libsdl
	net-misc/rsync
	sys-devel/bc
	sys-libs/readline[abi_x86_32]
	sys-process/schedtool
	sys-fs/squashfs-tools
	x11-libs/wxGTK:3.0
"
