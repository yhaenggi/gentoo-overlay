# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="UFI USB floppy disk formatter"
HOMEPAGE="https://github.com/tedigh/ufiformat"
SRC_URI="https://github.com/tedigh/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~amd64 ~x86"
IUSE=""

DEPEND="sys-kernel/linux-headers sys-fs/e2fsprogs"
RDEPEND="sys-fs/e2fsprogs"
