# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg-utils

DESCRIPTION="Trackballs is a marble game inspired by the 80s Atari classic Marble Madness."
HOMEPAGE="https://trackballs.github.io/"
SRC_URI="https://github.com/trackballs/trackballs/archive/refs/tags/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-scheme/guile
	media-libs/libsdl2[X,sound,video,opengl]
	media-libs/sdl2-image
	media-libs/sdl2-mixer
	media-libs/sdl2-ttf
	sys-libs/zlib
	virtual/libintl
	virtual/opengl
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
		-DTRACKBALLS_DOC_DIR="${EPREFIX}"/usr/share/doc/${PF}
	)
	cmake_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}

