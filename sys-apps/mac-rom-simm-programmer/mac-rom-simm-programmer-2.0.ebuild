# Copyright 2023 Yves Hänggi
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 qmake-utils udev

DESCRIPTION="Mac ROM SIMM Programmer Software"
HOMEPAGE="https://github.com/dougg3/mac-rom-simm-programmer.software"
SRC_URI=""
EGIT_REPO_URI="https://github.com/dougg3/${PN}.software.git"
EGIT_COMMIT="96eae44200f992904ab39182c3f76125484507e8"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	virtual/libudev
	"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake5 || die "eqmake5 failed"
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	dobin SIMMProgrammer
	newbin SIMMProgrammer mac-rom-simm-programmer
	dodoc README.md
	udev_dorules 99-simm-programmer.rules
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
