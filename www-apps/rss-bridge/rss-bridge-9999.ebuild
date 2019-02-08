# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 webapp

DESCRIPTION="The RSS feed for websites missing it"
HOMEPAGE="https://github.com/RSS-Bridge/rss-bridge"

LICENSE="Unlicense"
KEYWORDS=""
IUSE=""

RDEPEND="
		>=dev-lang/php-5.6.40[ssl,xml,unicode,simplexml,curl,json]
		virtual/httpd-php
"
need_httpd

src_install() {
	webapp_src_preinst

	dodoc README.md
	webapp_serverowned -R .cache/

	webapp_src_install
}
