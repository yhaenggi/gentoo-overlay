# Copyright 2021-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="OpenGL 2.1/1.5 to GL ES 2.0/1.1 translation library"
HOMEPAGE="https://ptitseb.github.io/gl4es/"
EGIT_REPO_URI="https://github.com/ptitSeb/gl4es.git"
EGIT_BRANCH="master"
EGIT_COMMIT="e6bb082b495820b308d34b9e1338bc87bfa8e2fa"
LICENSE="MIT"
SLOT="0"
IUSE="X test odroid"
RESTRICT="!test? ( test )"

KEYWORDS="arm64"

DEPEND="
	media-libs/mesa[X?,egl(+)]
"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-debug/apitrace )"

# Note: Should be added into virtual/opengl if moved to ::gentoo

src_configure() {
	local mycmakeargs=(
		-DNOX11=$(usex !X)
		-DODROID=$(use odroid)
	)

	cmake_src_configure
}

src_install() {
	cmake_src_install

	#libs get installed into /usr/usr, prefix dosnt work properly.
	mv -v ${D}/usr/usr/* ${D}/usr
	rmdir -v ${D}/usr/usr
}

pkg_install() {
	einfo "To use this replacement library add ${PREFIX}/usr/lib/gl4es/ to LD_LIBRARY_PATH"
}
