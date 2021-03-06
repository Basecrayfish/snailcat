# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Auto-Generated by cargo-ebuild 0.1.6

EAPI=7

CRATES="
adler32-1.0.3
aho-corasick-0.7.3
ansi_term-0.11.0
atty-0.2.11
autocfg-0.1.4
backtrace-0.3.20
backtrace-sys-0.1.28
bitflags-1.0.4
bstr-0.1.3
build_const-0.2.1
byteorder-1.3.1
bytes-0.4.12
bytesize-1.0.0
cargo-0.35.0
cc-1.0.37
cfg-if-0.1.9
clap-2.33.0
cloudabi-0.0.3
commoncrypto-0.2.0
commoncrypto-sys-0.2.0
core-foundation-0.6.4
core-foundation-sys-0.6.2
crates-io-0.23.0
crc-1.8.1
crc32fast-1.2.0
crossbeam-channel-0.3.8
crossbeam-utils-0.6.5
crypto-hash-0.3.3
curl-0.4.21
curl-sys-0.4.18
env_logger-0.6.1
failure-0.1.5
failure_derive-0.1.5
filetime-0.2.6
flate2-1.0.7
fnv-1.0.6
foreign-types-0.3.2
foreign-types-shared-0.1.1
fs2-0.4.3
fuchsia-cprng-0.1.1
fwdansi-1.0.1
git2-0.8.0
git2-curl-0.9.0
glob-0.2.11
globset-0.4.3
heck-0.3.1
hex-0.3.2
home-0.3.4
http-0.1.17
humantime-1.2.0
idna-0.1.5
ignore-0.4.7
im-rc-12.3.4
iovec-0.1.2
itoa-0.4.4
jobserver-0.1.13
kernel32-sys-0.2.2
lazy_static-1.3.0
lazycell-1.2.1
libc-0.2.55
libgit2-sys-0.7.11
libnghttp2-sys-0.1.1
libssh2-sys-0.2.11
libz-sys-1.0.25
log-0.4.6
matches-0.1.8
memchr-2.2.0
miniz-sys-0.1.12
miniz_oxide-0.2.1
miniz_oxide_c_api-0.2.1
miow-0.3.3
num_cpus-1.10.0
numtoa-0.1.0
opener-0.3.2
openssl-0.10.23
openssl-probe-0.1.2
openssl-sys-0.9.47
percent-encoding-1.0.1
pkg-config-0.3.14
proc-macro2-0.4.30
quick-error-1.2.2
quote-0.6.12
rand-0.6.5
rand_chacha-0.1.1
rand_core-0.3.1
rand_core-0.4.0
rand_hc-0.1.0
rand_isaac-0.1.1
rand_jitter-0.1.4
rand_os-0.1.3
rand_pcg-0.1.2
rand_xorshift-0.1.1
rdrand-0.4.0
redox_syscall-0.1.54
redox_termios-0.1.1
regex-1.1.6
regex-syntax-0.6.6
remove_dir_all-0.5.1
rustc-demangle-0.1.14
rustc-workspace-hack-1.0.0
rustc_version-0.2.3
rustfix-0.4.5
ryu-0.2.8
same-file-1.0.4
schannel-0.1.15
scopeguard-0.3.3
semver-0.9.0
semver-parser-0.7.0
serde-1.0.91
serde_derive-1.0.91
serde_ignored-0.0.4
serde_json-1.0.39
shell-escape-0.1.4
sized-chunks-0.1.3
smallvec-0.6.9
socket2-0.3.9
strsim-0.8.0
structopt-0.2.15
structopt-derive-0.2.15
syn-0.15.34
synstructure-0.10.2
tar-0.4.26
tempfile-3.0.8
termcolor-1.0.4
termion-1.5.2
textwrap-0.11.0
thread_local-0.3.6
time-0.1.42
toml-0.4.10
typenum-1.10.0
ucd-util-0.1.3
unicode-bidi-0.3.4
unicode-normalization-0.1.8
unicode-segmentation-1.3.0
unicode-width-0.1.5
unicode-xid-0.1.0
url-1.7.2
url_serde-0.2.0
utf8-ranges-1.0.2
vcpkg-0.2.6
vec_map-0.8.1
walkdir-2.2.7
winapi-0.2.8
winapi-0.3.7
winapi-build-0.1.1
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.2
winapi-x86_64-pc-windows-gnu-0.4.0
wincolor-1.0.1
"

inherit cargo

DESCRIPTION="Generates an ebuild for a package using the in-tree eclasses."
HOMEPAGE="https://github.com/cardoe/cargo-ebuild"
SRC_URI="$(cargo_crate_uris ${CRATES})
https://github.com/Basecrayfish/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
"

LICENSE="MIT Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=""
BDEPEND=""

src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	export CARGO_HOME="${ECARGO_HOME}"

	cargo build  \
		-j $(makeopts_jobs) \
		$(usex debug "" --release) "$@" \
	|| die "Cargo build failed"
}
