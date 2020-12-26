# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3

DESCRIPTION="The Portable OpenGL FrameWork"
HOMEPAGE="https://www.glfw.org/"
EGIT_REPO_URI="https://github.com/ninja-/glfw.git"
EGIT_BRANCH="wayland_fixes"

LICENSE="ZLIB"
SLOT="0"
IUSE="wayland libdecoration"

RDEPEND="
	x11-libs/libxkbcommon
	!wayland? (
		virtual/opengl
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXxf86vm
	)
	wayland? (
		dev-libs/wayland
		dev-util/meson
		libdecoration? ( gui-libs/libdecoration )
		media-libs/mesa[egl,wayland]
	)
"
DEPEND="
	${RDEPEND}
	!wayland? ( x11-libs/libXi )
	wayland? ( dev-libs/wayland-protocols )
"
BDEPEND="
	wayland? ( kde-frameworks/extra-cmake-modules )
"

PATCHES=( "${FILESDIR}/${PN}-9999-libdecoration-cmake.patch" )

pkg_pretend() {
	if use libdecoration && ! use wayland; then
		ewarn "libdecoration USE flag has no effect without wayland"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DGLFW_BUILD_EXAMPLES=no
		-DGLFW_USE_WAYLAND="$(usex wayland)"
		-DGLFW_USE_LIBDECORATION="$(usex libdecoration)"
		-DBUILD_SHARED_LIBS=1
	)
	cmake_src_configure
}
