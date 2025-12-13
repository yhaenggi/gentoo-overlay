# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1 git-r3 udev

DESCRIPTION="sheepnet kernel module for SheepShaver"
HOMEPAGE="https://github.com/kanjitalk755/macemu"

EGIT_REPO_URI="https://github.com/kanjitalk755/macemu.git"
EGIT_COMMIT="6864575dc2df3f90572bba36d10c7a6fc2c26f64"
EGIT_BRANCH="master"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/sheepnet-makefile-use-current-build.patch"
)

src_compile() {
	local modlist=( sheep_net=kernel/drivers/misc:BasiliskII/src/Unix/Linux/NetDriver)
	linux-mod-r1_src_compile
}

src_install() {
	local modlist=( sheep_net=kernel/drivers/misc:BasiliskII/src/Unix/Linux/NetDriver)
	linux-mod-r1_src_install
	udev_dorules "${FILESDIR}/50-sheep_net-permission.rules"
}

pkg_postinst() {
	udev_reload
}

pkg_postrm() {
	udev_reload
}
