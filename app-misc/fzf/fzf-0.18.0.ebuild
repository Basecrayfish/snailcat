# Copyright 2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# Change this when you update the ebuild
GIT_COMMIT="ff951341c993ed84ad65344e496e122ee3dddf67"
EGO_PN="github.com/junegunn/${PN}"
# Note: Keep EGO_VENDOR in sync with glide.lock
EGO_VENDOR=(
	##"github.com/codegangsta/cli c6af8847eb2b"
	##"github.com/Masterminds/semver 15d8430ab864"
	##"github.com/Masterminds/vcs 6f1c6d150500"
	##"github.com/mitchellh/go-homedir b8bc1bf76747"
	##"gopkg.in/yaml.v2 287cf08546ab github.com/go-yaml/yaml"
	"github.com/gdamore/encoding b23993cbb635"
	"github.com/gdamore/tcell 0a0db94084df"
	"github.com/gopherjs/gopherjs d547d1d9531e"
	"github.com/jtolds/gls v4.2.1"
	"github.com/lucasb-eyer/go-colorful c900de9dbbc7"
	"github.com/mattn/go-isatty 66b8e73f3f5c"
	"github.com/mattn/go-runewidth 14207d285c6c"
	"github.com/mattn/go-shellwords v1.0.3"
	"github.com/smartystreets/assertions b2de0cb4f26d"
	"github.com/smartystreets/goconvey 044398e4856c"
	"golang.org/x/crypto 558b6879de74 github.com/golang/crypto"
	"golang.org/x/sys b90f89a1e7a9 github.com/golang/sys"
	"golang.org/x/text 4ee4af566555 github.com/golang/text"
)

inherit bash-completion-r1 golang-vcs-snapshot-r1

DESCRIPTION="A general-purpose command-line fuzzy finder"
HOMEPAGE="https://github.com/junegunn/fzf"
ARCHIVE_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="${ARCHIVE_URI} ${EGO_VENDOR_URI}"
RESTRICT="mirror"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug pie bash zsh fish tmux vim"

RDEPEND="tmux? ( app-misc/tmux )
	bash? ( app-shells/bash )
	zsh? ( app-shells/zsh )
	fish? ( app-shells/fish )
	vim? ( app-editors/vim )"

DOCS=( CHANGELOG.md README.md )
QA_PRESTRIPPED="usr/bin/.*"

G="${WORKDIR}/${P}"
S="${G}/src/${EGO_PN}"

src_compile() {
	export GOPATH="${G}"
	local myldflags=(
		"$(usex !debug '-s -w' '')"
		-X "main.revision=${GIT_COMMIT:0:7}"
	)
	local mygoargs=(
		-v
		"-buildmode=$(usex pie pie exe)"
		"-asmflags=all=-trimpath=${S}"
		"-gcflags=all=-trimpath=${S}"
		-ldflags "${myldflags[*]}"
	)
	go build "${mygoargs[@]}" || die
}

src_test() {
	go test -v ./src{,/algo,/tui,/util} || die
}

src_install() {
	dobin fzf
	use debug && dostrip -x /usr/bin/fzf
	einstalldocs

	doman man/man1/fzf.1

	if use bash; then
		newbashcomp shell/completion.bash
	fi
	if use zsh; then
		insinto /usr/share/zsh/site-functions/
		newins shell/completion.zsh _fzf
		insinto /usr/share/zsh/site-contrib/
		newins shell/key-bindings.zsh fzf.zsh
	fi
	if use fish; then
		insinto /usr/share/fish/functions/
		newins shell/key-bindings.fish fzf.fish
	fi
	if use tmux; then
		dobin bin/fzf-tmux
		doman man/man1/fzf-tmux.1
	fi
	if use vim; then
		insinto /usr/share/vim/vimfiles/plugin
		doins plugin/fzf.vim
		dodoc README-VIM.md
	fi
}
