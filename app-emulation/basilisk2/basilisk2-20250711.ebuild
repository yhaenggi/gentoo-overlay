# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3

DESCRIPTION="Basilisk II is an emulator for Mac OS 7.x to 8.1"
HOMEPAGE="https://basilisk.cebix.net/"
EGIT_REPO_URI="https://github.com/kanjitalk755/macemu.git"
EGIT_COMMIT="55ac71ba2c0a093f86d9338a387b8d214a018488"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 arm64"

IUSE="bincue libvhd +gtk +sdl +jit esd"

DEPEND="
	arm64? (
		dev-libs/gmp
		dev-libs/mpfr
	)
	sdl? (
		media-libs/libsdl2[sound,video]
	)
	gtk? (
		x11-libs/gtk+:3
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	default
	cd BasiliskII/src/Unix || die
	NO_CONFIGURE="just-no" ./autogen.sh || die
}

src_configure() {
	cd BasiliskII/src/Unix || die
	econf \
		$(use_enable sdl sdl-audio) \
		$(use_enable sdl sdl-video) \
		$(use_enable jit jit-compiler) \
		$(use_with gtk) \
		$(use_with bincue) \
		$(use_with libvhd) \
		$(use_with esd)
}

src_compile() {
	cd BasiliskII/src/Unix || die
	default
}

src_install() {
	cd BasiliskII/src/Unix || die
	default
}
