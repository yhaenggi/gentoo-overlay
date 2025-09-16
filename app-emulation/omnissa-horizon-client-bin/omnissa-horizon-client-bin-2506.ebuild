# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="VMWare/Omnissa Horizon Client is a remote viewer/controll tool"
HOMEPAGE="https://customerconnect.omnissa.com/downloads/info/slug/virtual_desktop_and_apps/omnissa_horizon_clients/8"
SRC_URI="https://download3.omnissa.com/software/CART26FQ2_LIN_2506_TARBALL/Omnissa-Horizon-Client-Linux-2506-8.16.0-16536624989.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=$WORKDIR

src_unpack() {
	cp -Rav ${DISTDIR}/* ${WORKDIR} || die
	cd ${WORKDIR} || die
	unpack ${A} || die
	unpack Omnissa-Horizon-Client-Linux-*/x64/*.tar.gz
	cd Omnissa-Horizon-Client-Linux*/x64 || die
	#find . -type f -print0 | xargs -0 -n1 tar xvf || die
	rm -R *sdk*
}

src_install() {
	cp -R ${WORKDIR}/*/etc ${D} || die
	cp -R ${WORKDIR}/*/usr ${D} || die
	mv ${D}/usr/lib ${D}/usr/$(get_libdir)
	mv ${D}/usr/share/doc/omnissa-horizon-client ${D}/usr/share/doc/${PF} || die
	mkdir -p ${D}/lib/udev/rules.d || die
	cp ${D}/etc/udev/rules.d/* ${D}/lib/udev/rules.d || die
	rm -R ${D}/etc/udev || die
	sed -i 's:/usr/lib:/usr/lib64:g' ${D}/usr/bin/* || die
	dobin ${D}/usr/lib64/omnissa/horizon/usb/horizon-eucusbarbitrator
}
