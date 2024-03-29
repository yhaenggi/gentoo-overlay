# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Converts Apple DMG files to standard HFS+ images"
HOMEPAGE="http://vu1tur.eu.org/tools"
SRC_URI="http://vu1tur.eu.org/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

RDEPEND="app-arch/bzip2
	sys-libs/zlib
	dev-libs/openssl:0=
	"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-openssl11.patch #674168
)

src_prepare() {
	default
	sed -i -e 's:-s:$(LDFLAGS):g' Makefile || die "sed failed"
}

src_compile() {
	tc-export CC
	emake CFLAGS="${CFLAGS}"
}

src_install() {
	dobin dmg2img vfdecrypt
	dodoc README
	doman vfdecrypt.1

	ewarn
	ewarn "dmg2img has security issues that lead to RCE on malicious archives."
	ewarn "See gentoo bug #792336 ( https://bugs.gentoo.org/792336 )"
	ewarn "Use at your own risk, firejail it or something alike."
}
