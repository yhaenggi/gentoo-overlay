# Copyright 2025 Yves Hänggi/Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 cmake desktop xdg-utils

DESCRIPTION="Desktop tools for working with Open PS2 Loader storages."
HOMEPAGE="https://github.com/brainstream/OPL-PC-Tools"
SRC_URI=""
EGIT_REPO_URI="https://github.com/brainstream/OPL-PC-Tools.git"
EGIT_COMMIT="3cdcfc7898d51761359681b8247d44d2844a3264"
EGIT_BRANCH="master"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="dev-qt/qtbase:6[network,widgets,gui]"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX="${EPREFIX}"/usr
	)
	cmake_src_configure || die "cmake configure failed"
}

src_install() {
	dobin "${WORKDIR}"/"${PF}"_build/oplpctools || die "dobin failed"
	dodoc "${WORKDIR}"/"${PF}"/README.md

	"${WORKDIR}"/"${PF}"/release/assets/linux/make-desktop-file.sh
	mv "${WORKDIR}"/"${PF}"/*.desktop opl-pc-tools.desktop
	sed -i 's/Exec=.*/Exec=oplpctools/' opl-pc-tools.desktop
	sed -i 's/Icon=.*/Icon=oplpctools/' opl-pc-tools.desktop
	domenu opl-pc-tools.desktop
	newicon "${WORKDIR}"/"${PF}"/src/OplPcTools/Resources/images/application.png oplpctools.png
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
