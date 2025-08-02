# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Implementation of the Epson epsp-protocol for the PX-4/PX-8 CP/M laptop"
HOMEPAGE="http://electrickery.nl/comp/px4/vfloppy/"
EGIT_REPO_URI="https://github.com/electrickery/vfloppy.git"
EGIT_COMMIT="a9fabf78baa6a8690ddad08300ac7bfc6ab2c4e5"
EGIT_BRANCH="main"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm64"

IUSE=""

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	# nothing to do
	true
}

src_compile() {
	default
	cd vfman22
	default
}

src_install() {
	dobin epspdv3
	cd vfman22
	dobin img2d88 vfd2d88 vferase vformat vfread vfread
}
