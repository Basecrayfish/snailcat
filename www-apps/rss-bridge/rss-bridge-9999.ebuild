# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit webapp git-r3

DESCRIPTION="The RSS feed for websites missing it"
HOMEPAGE="https://github.com/RSS-Bridge/rss-bridge"

LICENSE="Unlicense"
KEYWORDS=""
IUSE=""
EGIT_REPO_URI="https://github.com/RSS-Bridge/rss-bridge.git"

RDEPEND="
		>=dev-lang/php-5.6.40[ssl,xml,unicode,simplexml,curl,json]
		virtual/httpd-php
"

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r .

	webapp_serverowned -R "${MY_HTDOCSDIR}"/cache/

	webapp_src_install
}
