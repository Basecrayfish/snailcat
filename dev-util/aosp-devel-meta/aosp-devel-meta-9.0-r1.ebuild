# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Meta package providing AOSP build environment"
HOMEPAGE="https://source.android.com/source/initializing"

LICENSE="metapackage"
SLOT="9.0"
KEYWORDS="~amd64 ~x86"
IUSE="+ccache +repo"

RDEPEND="
	app-crypt/gnupg
	app-arch/zip[-natspec]
	app-arch/unzip
	dev-libs/libxslt
	dev-libs/libxml2
	dev-lang/python:2.7
	ccache? ( dev-util/ccache )
	dev-util/gperf
	repo? ( dev-vcs/repo )
	dev-vcs/git
	media-libs/mesa
	net-misc/curl
	sys-devel/bison
	sys-devel/flex
	sys-devel/gcc[cxx]
	sys-devel/make
	sys-libs/ncurses:5[abi_x86_32,tinfo]
	sys-libs/zlib[abi_x86_32]
	x11-base/xorg-proto
	x11-libs/libX11
"
