# Copyright 2023 Yves Hänggi
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="LZ77-based compression with fast decompression on 68K and other legacy hardware"
HOMEPAGE="https://github.com/steve-chamberlin/fc8-compression"
SRC_URI=""
EGIT_REPO_URI="https://github.com/steve-chamberlin/fc8-compression"
EGIT_COMMIT="2f5ac4b27ef0c75583a721886dbb3a28da38f56a"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_configure() {
	true
}

src_compile() {
	gcc ${CFLAGS} compression.c fc8.c -o fc8
}

src_install() {
	dobin fc8
}
