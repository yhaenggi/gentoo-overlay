# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson gnome2-utils xdg git-r3

DESCRIPTION="Messaging client"
HOMEPAGE="https://gitlab.gnome.org/World/Chatty"
EGIT_REPO_URI="https://gitlab.gnome.org/World/Chatty.git"

LICENSE="GPL-3"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~arm64"

if [[ ${PV} != 9999 ]]; then
		#EGIT_COMMIT="tags/v${PV}"
		#EGIT_BRANCH="wip/sadiq/release-0.7.0alpha"
		EGIT_COMMIT=""
		#SRC_URI="https://source.puri.sm/Librem5/${PN}/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
		#S=${WORKDIR}/${PN}-v${PV}
else
	#inherit git-r3
	KEYWORDS=""
fi


DEPEND=">=gnome-extra/evolution-data-server-3.46.0
		dev-libs/feedbackd
		gui-libs/gtk
		gui-libs/libhandy
		dev-libs/olm
		net-im/pidgin
		app-text/gspell
		net-misc/modemmanager
		dev-libs/libphonenumber
		dev-libs/protobuf
		>=net-libs/libcmatrix-0.0.2
"
RDEPEND="${DEPEND}"
BDEPEND="${DEPEND}
		dev-util/itstool
"

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
