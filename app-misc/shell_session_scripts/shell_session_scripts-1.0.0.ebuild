# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="A collection of helper scripts for spawning shells."
HOMEPAGE="https://github.com/Basecrayfish/shell_session_scripts"
SRC_URI="https://github.com/Basecrayfish/shell_session_scripts/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_install() {
	dobin tc-tmux
	dobin su-tmux
	dobin remote-tmux
}
