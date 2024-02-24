# Copyright 2023 Yves Hänggi
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A collection of utilites to work on MacOS Classic images in a cross platform way"
HOMEPAGE="http://www.hampa.ch/"
SRC_URI="http://www.hampa.ch/pub/pce/misc/mac-utils-20210820-08c01f11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="virtual/libc"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	mv mac-utils-20210820-08c01f11 mac-utils-20210820
}
