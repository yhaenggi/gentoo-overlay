# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake xdg-utils

DESCRIPTION="Animated sprite editor & pixel art tool"
HOMEPAGE="https://libresprite.github.io/"
SRC_URI=""
EGIT_REPO_URI="https://github.com/LibreSprite/LibreSprite.git"
EGIT_COMMIT="fda1e4281ccd3a0b5cbf37db4ef408d22d0b44dc"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	sys-devel/gcc
	net-misc/curl
	net-libs/gnutls
	media-libs/freetype
	media-libs/giflib
	x11-libs/pixman
	media-libs/libpng
	media-libs/libsdl2
	media-libs/sdl2-image
	dev-libs/tinyxml2
	sys-libs/zlib
	app-arch/libarchive
"
RDEPEND="${DEPEND}"
BDEPEND="
	${DEPEND}
	dev-build/cmake
	app-alternatives/ninja
	net-libs/nodejs
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

