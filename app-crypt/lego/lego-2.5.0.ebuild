# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/go-acme/lego
EGO_VENDOR=(
	"github.com/decker502/dnspod-go 83a3ba562b048c9fc88229408e593494b7774684" # master
	"github.com/dnsimple/dnsimple-go f5ead9c20763fd925dea1362f2af5d671ed2a459" # v0.21.0
	"github.com/namedotcom/go 08470befbe04613bd4b44cb6978b05d50294c4d4" # master
	"github.com/ovh/go-ovh c3e61035ea66f5c637719c90140da4e3ac3b1bf0" # master
	"github.com/rainycape/memcache 1031fa0ce2f20c1c0e1e1b51951d8ea02c84fa05" # master
	"github.com/timewasted/linode 37e84520dcf74488f67654f9c775b9752c232dc1" # master
	"github.com/nrdcg/goinwx d8152159450570012552f924a0ae6ab3d8c617e0" # v0.6.0
	"github.com/linode/linodego d0d31d8ca62fa3f7e4526ca0ce95de81e4ed001e" # v0.5.1
	"golang.org/x/crypto 614d502a4dac94afa3a6ce146bd1736da82514c6 github.com/golang/crypto" # master
	"golang.org/x/net 8a410e7b638dca158bf9e766925842f6651ff828 github.com/golang/net" # master
	"golang.org/x/oauth2 d2e6202438beef2727060aa7cabdd924d92ebfd9 github.com/golang/oauth2" # master
	"google.golang.org/api 0cbcb99a9ea0c8023c794b2693cbe1def82ed4d7 github.com/googleapis/google-api-go-client" # master
	"gopkg.in/ns1/ns1-go.v2 028658c6d9be774b6d103a923d8c4b2715135c3f github.com/ns1/ns1-go" # branch v2
	"github.com/sacloud/libsacloud a949b57af53e809207587f8c41571d81f140276e" # v1.19.0
	"github.com/exoscale/egoscale 4acc53d7aa0960f007acf1daedef69a6d24d8d1f" # v0.14.0
	"github.com/miekg/dns a220737569d8137d4c610f80bd33f1dc762522e5" # v1.1.0
	"github.com/akamai/AkamaiOPEN-edgegrid-golang 1471ce9c14c6d8c007516e129262962a628fecdf" # v0.7.2
	"github.com/oracle/oci-go-sdk f1ecb80f81a9cfa7dbfc964a34a3c62323277a9d" # v4.0.0
	"github.com/labbsr0x/bindman-dns-webhook 234ca2a50eebc2095f42a884709a6e9013366d86" # v1.0.0
)

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Let’s Encrypt client and ACME library written in Go."
HOMEPAGE="https://go-acme.github.io/lego/"
SRC_URI="https://github.com/go-acme/lego/archive/v${PV}.tar.gz -> ${P}.tar.gz
${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_compile() {
	EGO_PN=${EGO_PN}/cmd/lego
	golang-build_src_compile
}

src_install() {
	dobin lego
}
