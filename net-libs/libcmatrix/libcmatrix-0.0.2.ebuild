# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg git-r3

DESCRIPTION="Matric client library written in GObjectified C"
HOMEPAGE="https://source.puri.sm/Librem5/libcmatrix"
EGIT_REPO_URI="https://source.puri.sm/Librem5/libcmatrix.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="examples test introspection doc"
KEYWORDS="~amd64 ~arm64"

if [[ ${PV} != 9999 ]]; then
		#EGIT_COMMIT="tags/v${PV}"
		#EGIT_BRANCH="wip/sadiq/release-0.7.0alpha"
		EGIT_COMMIT="a338cafc420656a30adeb873430e978f0a688a33"
		#SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
		#S=${WORKDIR}/${PN}-v${PV}
else
	#inherit git-r3
	KEYWORDS=""
fi


DEPEND="
	>=dev-libs/glib-2.7
	>=net-libs/libsoup-3
	dev-libs/libgcrypt
	dev-libs/olm
	>=dev-db/sqlite-3.34
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use examples build-examples)
		$(meson_use test build-tests)
		$(meson_use introspection)
		$(meson_use doc gtk_doc)
	)
	meson_src_configure
}
