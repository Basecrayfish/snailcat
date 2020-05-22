# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CRATES="
aho-corasick-0.7.10
anyhow-1.0.29
anymap-0.12.1
arrayvec-0.5.1
autocfg-1.0.0
base64-0.12.1
bitflags-1.2.1
bstr-0.2.13
cargo_metadata-0.10.0
cfg-if-0.1.10
crossbeam-0.7.3
crossbeam-channel-0.4.2
crossbeam-deque-0.7.3
crossbeam-epoch-0.8.2
crossbeam-queue-0.2.1
crossbeam-utils-0.7.2
difference-2.0.0
drop_bomb-0.1.4
either-1.5.3
ena-0.13.1
ena-0.14.0
env_logger-0.7.1
filetime-0.2.10
fixedbitset-0.1.9
fnv-1.0.6
fst-0.4.3
getrandom-0.1.14
globset-0.4.5
goblin-0.2.3
heck-0.3.1
home-0.5.3
idna-0.2.0
indexmap-1.3.2
inotify-0.7.0
inotify-sys-0.1.3
iovec-0.1.4
itertools-0.9.0
itoa-0.4.5
jod-thread-0.1.1
lazy_static-1.4.0
lazycell-1.2.1
libc-0.2.70
libloading-0.6.2
lock_api-0.3.4
log-0.4.8
lsp-server-0.3.1
lsp-types-0.74.1
matches-0.1.8
maybe-uninit-2.0.0
memchr-2.3.3
memmap-0.7.0
memoffset-0.5.4
mio-0.6.22
mio-extras-2.0.6
net2-0.2.34
notify-4.0.15
num_cpus-1.13.0
once_cell-1.3.1
ordermap-0.3.5
parking_lot-0.10.2
parking_lot_core-0.7.2
percent-encoding-2.1.0
petgraph-0.4.13
pico-args-0.3.1
plain-0.2.3
ppv-lite86-0.2.6
proc-macro2-1.0.12
quote-1.0.5
ra_vfs-0.6.1
rand-0.7.3
rand_chacha-0.2.2
rand_core-0.5.1
rand_pcg-0.2.1
rayon-1.3.0
rayon-core-1.7.0
regex-1.3.7
regex-syntax-0.6.17
relative-path-1.0.0
rowan-0.10.0
rustc-ap-rustc_lexer-656.0.0
rustc-hash-1.1.0
ryu-1.0.4
salsa-0.14.1
salsa-macros-0.14.1
same-file-1.0.6
scoped-tls-1.0.0
scopeguard-1.1.0
scroll-0.10.1
scroll_derive-0.10.2
semver-0.9.0
semver-parser-0.7.0
serde-1.0.110
serde_derive-1.0.110
serde_json-1.0.53
serde_repr-0.1.5
slab-0.4.2
smallvec-1.4.0
smol_str-0.1.15
superslice-1.0.0
syn-1.0.21
synstructure-0.12.3
text-size-1.0.0
thin-dst-1.1.0
thread_local-1.0.1
threadpool-1.8.1
unicode-bidi-0.3.4
unicode-normalization-0.1.12
unicode-segmentation-1.6.0
unicode-xid-0.2.0
url-2.1.1
walkdir-2.3.1
"

inherit cargo

DESCRIPTION="An experimental Rust compiler front-end for IDEs"
HOMEPAGE="https://rust-analyzer.github.io"

MY_PV="2020-05-18"
MY_P="${PN}-${MY_PV}"
SRC_URI="$(cargo_crate_uris ${CRATES})
https://pubfiles.replicantprocess.com/chalk-20200512.tar.gz
https://github.com/rust-analyzer/${PN}/archive/${MY_PV}.tar.gz -> ${MY_P}.tar.gz"
S="${WORKDIR}/${MY_P}"

RESTRICT="mirror"
LICENSE="Apache-2.0 BSD-2 BSD CC0-1.0 ISC MIT"
SLOT="0"
KEYWORDS="~amd64"

src_unpack() {
	ebegin "Unpacking chalk repo snapshot"
	mkdir -p "${ECARGO_HOME}" || die
	tar -xf "${DISTDIR}/chalk-20200512.tar.gz" -C "${ECARGO_HOME}/" || die
	default
}

src_install() {
	dobin ${S}/target/release/rust-analyzer || die
	dodoc -r ${S}/docs
}
