# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN="github.com/bullettrain-sh/bullettrain-go-core"
EGO_VENDOR=(
	"github.com/bullettrain-sh/bullettrain-go-git d5f35b39e897b1f66fac4134aec9c3ce793f13d6" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-golang e72db4d906785e070e061f5315b57fac44b4bcc9" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-nodejs f083703512eca241c6eaf04adbbbe3e7c4a33e93" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-php 05371c5076de5e2a09d050420ef81f93cd2725ba" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-python ed4846f9162682b6accd463826fe70fe877f7088" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-ruby ddafbf46446b4e2101ac3f3c715c989f636ccc6f" # v1.0.0
	"github.com/bullettrain-sh/bullettrain-go-openvpn cf27b236c16eb30934bda8b31e57a3db3619ce3f" # master
)

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Single executable shell prompt builder with very low latency."
HOMEPAGE="https://github.com/bullettrain-sh/bullettrain-go-core"
ARCHIVE_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

src_install() {
	mv bullettrain-go-core bullettrain-go
	dobin bullettrain-go
}
