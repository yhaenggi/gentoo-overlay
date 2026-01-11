# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="NoteBook FanControl ported to Linux"
HOMEPAGE="https://github.com/nbfc-linux/nbfc-linux"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~i386"

DEPEND="
	net-misc/curl
	dev-libs/openssl
	net-dns/c-ares
	net-libs/nghttp3
	net-libs/nghttp2
	net-libs/libpsl
	net-dns/libidn2
	dev-libs/libunistring"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	./autogen.sh
	local myconfargs=(
		--with-init-system=openrc
		--prefix=/usr
		--sysconfdir=/etc
	)
	econf "${myeconfargs[@]}"
}
