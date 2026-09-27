# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A daemon that automatically manages the performance states of NVIDIA GPUs."
HOMEPAGE="https://github.com/sasha0552/nvidia-pstated"
SRC_URI="https://github.com/sasha0552/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

DEPEND="
	dev-util/nvidia-cuda-toolkit
	x11-drivers/nvidia-drivers
	dev-build/cmake
"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/nvidia-pstated_unbuffered_output.diff"
)

src_install() {
	dobin ${BUILD_DIR}/${PN}
	newinitd "${FILESDIR}/nvidia-pstated.initd" ${PN}
	newconfd "${FILESDIR}/nvidia-pstated.confd" ${PN}
}

pkg_postinst() {
	ewarn "Remember to add the service to the default runlevel:"
	ewarn "  rc-update add nvidia-pstated default"
}
