EAPI=7

DESCRIPTION="QEMU Linux user mode for the R5900 Emotion Engine in the PlayStation 2."
HOMEPAGE="https://github.com/frno7/qemu"
SRC_URI="https://download.qemu.org/qemu-${PV}.tar.xz"

LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc64"
IUSE="static-user"

ALL_DEPEND="
	dev-build/meson
	>=dev-libs/glib-2.0[static-libs(+)]
	sys-libs/zlib[static-libs(+)]"

RDEPEND=""
CDEPEND=""
DEPEND="${CDEPEND}
	static-user? ( ${ALL_DEPEND} )"
BDEPEND=""

S="${WORKDIR}/qemu-${PV}"

PATCHES=(
	"${FILESDIR}/qemu-mipsr5900el-${PV}-linux-user-mips-Support-the-n32-ABI-for-the-R5900.patch"
	"${FILESDIR}/qemu-mipsr5900el-${PV}-Revert-target-mips-Disable-R5900-support.patch"
)

DOC_CONTENTS="If you want to register binfmt handlers for QEMU user targets for OpenRC:
        # rc-update add qemu-mipsr5900el-binfmt"

handle_locales() {
	# Cheap hack to disable gettext .mo generation.
	rm -f po/*.po
}

src_prepare() {
	default

	# Verbose builds
	MAKEOPTS+=" V=1"

	# Run after we've applied all patches.
	handle_locales
}

src_configure() {
	local builddir=${S}/build

	mkdir "${builddir}"

	local conf_opts=(
		--prefix=/usr
		--sysconfdir=/etc
		--bindir=/usr/bin
		--libdir=/usr/$(get_libdir)
		--datadir=/usr/share
		--docdir=/usr/share/doc/${PF}/html
		--mandir=/usr/share/man
		--localstatedir=/var
		--disable-bsd-user
		--disable-guest-agent
		--disable-strip
		--disable-werror
		--disable-linux-io-uring
	)

	conf_opts+=(
		--disable-git-update
		--disable-modules
	)

	# Disable options not used by user targets. This simplifies building
	# static user targets (USE=static-user) considerably.
	conf_notuser() {
		echo "--disable-${2:-$1}"
	}
	conf_opts+=(
		$(conf_notuser accessibility brlapi)
		$(conf_notuser aio linux-aio)
		$(conf_notuser bzip2)
		$(conf_notuser capstone)
		$(conf_notuser caps cap-ng)
		$(conf_notuser curl)
		$(conf_notuser fdt)
		$(conf_notuser glusterfs)
		$(conf_notuser gnutls)
		$(conf_notuser gnutls nettle)
		$(conf_notuser gtk)
		$(conf_notuser iconv)
		$(conf_notuser infiniband rdma)
		$(conf_notuser iscsi libiscsi)
		$(conf_notuser jemalloc jemalloc)
		$(conf_notuser jpeg vnc-jpeg)
		$(conf_notuser kernel_linux kvm)
		$(conf_notuser libxml2)
		$(conf_notuser lzo)
		$(conf_notuser ncurses curses)
		$(conf_notuser nfs libnfs)
		$(conf_notuser numa)
		$(conf_notuser opengl)
		$(conf_notuser png vnc-png)
		$(conf_notuser rbd)
		$(conf_notuser sasl vnc-sasl)
		$(conf_notuser sdl)
		$(conf_notuser sdl-image)
		$(conf_notuser seccomp)
		$(conf_notuser smartcard)
		$(conf_notuser snappy)
		$(conf_notuser spice)
		$(conf_notuser ssh libssh)
		$(conf_notuser usb libusb)
		$(conf_notuser usbredir usb-redir)
		$(conf_notuser vde)
		$(conf_notuser vhost-net)
		$(conf_notuser vhost-user-fs)
		$(conf_notuser virgl virglrenderer)
		$(conf_notuser virtfs)
		$(conf_notuser vnc)
		$(conf_notuser vte)
		$(conf_notuser xen)
		$(conf_notuser xen xen-pci-passthrough)
		$(conf_notuser xfs xfsctl)
		$(conf_notuser xkb xkbcommon)
	)

	use static-user && conf_opts+=( --static --disable-pie )

	cd "${builddir}"
	../configure --target-list=mipsel-linux-user "${conf_opts[@]}"
}

src_compile() {
	local builddir=${S}/build

	cd "${builddir}"
	default
}

src_install() {
	local builddir=${S}/build

	mv "${builddir}"/mipsel-linux-user/qemu-mipsel \
	   "${builddir}"/mipsel-linux-user/qemu-mipsr5900el
	dobin "${builddir}"/mipsel-linux-user/qemu-mipsr5900el

	doinitd "${FILESDIR}"/qemu-mipsr5900el-binfmt
}
