# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 xdg-utils

DESCRIPTION="Antares is a tactical space-combat, arcade shooter and real-time strategy game."
HOMEPAGE="http://arescentral.org/antares"
SRC_URI=""

EGIT_REPO_URI="https://github.com/arescentral/${PN}"
EGIT_COMMIT="5322a0a015da5790f28d2223b01af1245c9be222"
EGIT_BRANCH="master"

LICENSE="LGPL-3 CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	dev-libs/libzip
	dev-util/gn
	dev-util/pkgconf
	media-libs/libmodplug
	media-libs/libpng
	media-libs/libsndfile
	media-libs/openal
	media-libs/glfw
	net-libs/neon
	sys-devel/clang
	sys-libs/libcxx
	sys-libs/libcxxabi
	sys-libs/zlib
	virtual/glu
	virtual/opengl
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXinerama
	x11-libs/libXrandr
	x11-libs/libXxf86vm
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	./configure --mode opt --prefix=/usr
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
