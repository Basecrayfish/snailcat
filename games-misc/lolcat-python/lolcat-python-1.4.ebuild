# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=(python{2_7,3_5,3_6,3_7})
inherit distutils-r1

MY_PN="lolcat"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Rainbows and unicorns (without Ruby! jay!)"
HOMEPAGE="https://github.com/tehmaze/lolcat/"
SRC_URI="https://github.com/tehmaze/lolcat/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="BEER-WARE"

KEYWORDS="amd64 ~x86"
SLOT="0"
DEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	${DEPEND}
"

S="${WORKDIR}/${MY_P}"
