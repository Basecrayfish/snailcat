# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_PN=github.com/go-acme/lego
EGO_VENDOR=(
	"github.com/miekg/dns b13675009d59c97f3721247d9efa8914e1866a5b" # v1.1.15
	"gopkg.in/square/go-jose.v2 730df5f748271903322feb182be83b43ebbbe27d github.com/square/go-jose" # v2.3.1
	"golang.org/x/crypto 614d502a4dac94afa3a6ce146bd1736da82514c6 github.com/golang/crypto" # master
	"golang.org/x/net 8a410e7b638dca158bf9e766925842f6651ff828 github.com/golang/net" # master
	"golang.org/x/oauth2 d2e6202438beef2727060aa7cabdd924d92ebfd9 github.com/golang/oauth2" # master
	"google.golang.org/api 0cbcb99a9ea0c8023c794b2693cbe1def82ed4d7 github.com/googleapis/google-api-go-client" # master
	"github.com/rainycape/memcache 1031fa0ce2f20c1c0e1e1b51951d8ea02c84fa05" # master
	"github.com/decker502/dnspod-go 71fbbdbdf1a7eeac949586de15bf96d416d3dd63" # v0.2.0
	"github.com/dnsimple/dnsimple-go 7e193cc468a07cdf74d76de1e6736c709c5a3872" # v0.30.0
	"github.com/namedotcom/go 08470befbe04613bd4b44cb6978b05d50294c4d4" # master
	"github.com/ovh/go-ovh ba5adb4cf0148a3dbdbd30586f075266256a77b1" # master
	"github.com/timewasted/linode 37e84520dcf74488f67654f9c775b9752c232dc1" # master
	"github.com/nrdcg/goinwx d8152159450570012552f924a0ae6ab3d8c617e0" # v0.6.0
	"github.com/linode/linodego 7adba57685c129bcd29a9edc7008ec3b05680240" # v0.10.0
	"gopkg.in/ns1/ns1-go.v2 6c599e5e57901a8e58e1729f444de1edeb77bf97 github.com/ns1/ns1-go" # branch v2
	"github.com/sacloud/libsacloud 6fb0c01c45716a08d5438f6d85a2a8984cc8a0a8" # v1.25.1
	"github.com/transip/gotransip efb64632cab7701ec33f1eaeaa738e2207efe68e" # v5.14
	"github.com/exoscale/egoscale 8f608c40ae891e0240bb6e696a72437be7069d83" # v0.18.1
	"github.com/akamai/AkamaiOPEN-edgegrid-golang 009960c8b2c7c57a0c5c488a3c8c778c16f3f586" # v0.7.4
	"github.com/oracle/oci-go-sdk 481415e15d394fa0817faedceabb7c59e21133b8" # v5.13.0
	"github.com/labbsr0x/bindman-dns-webhook 234ca2a50eebc2095f42a884709a6e9013366d86" # v1.0.0
	"github.com/Azure/azure-sdk-for-go 66cf3bc60d4d086e8e566d505b1cd30f5f506639" # v31.0.0
	"github.com/aliyun/alibaba-cloud-sdk-go 133cfe6c309b3d61b38d7076a852f155619d48ff" # v1.60.57
	"github.com/cloudflare/cloudflare-go 33ef9f42e17f33f6088dfe8c0dc95b916d1edfc6" # v0.9.2
	"github.com/cpu/goacmedns 565ecf2a84df654865cc102705ac160a3b04fc01" # master
	"github.com/nrdcg/namesilo a9d275011759a070d795b7d0ea99cc590915823f" # v0.2.0
	"github.com/vultr/govultr ca447e056e08d93aa6e5b09e6ae3565dd1825281" # v0.1.4
)

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Let’s Encrypt client and ACME library written in Go."
HOMEPAGE="https://go-acme.github.io/lego/"
SRC_URI="https://github.com/go-acme/lego/archive/v${PV}.tar.gz -> ${P}.tar.gz
${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
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
