# Copyright 1999-2024 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fuse-based httpfs file system"
HOMEPAGE="http://httpfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/httpfs/httpfs2/httpfs2-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

IUSE=""

RDEPEND="sys-fs/fuse"

src_compile() {
	emake -j1 || die "ebuild failed"
}

src_install() {
	dosbin httpfs2
	dosbin httpfs2-mt
	dosbin httpfs2-ssl
	dosbin httpfs2-ssl-mt
	dodoc httpfs2.1.txt
}
