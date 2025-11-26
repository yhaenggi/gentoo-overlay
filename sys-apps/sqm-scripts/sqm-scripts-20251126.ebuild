# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="SQM scripts traffic shaper"
HOMEPAGE="https://www.bufferbloat.net/projects/cerowrt/wiki/Smart_Queue_Management/"
SRC_URI=""

EGIT_REPO_URI="https://github.com/tohojo/${PN}"
EGIT_COMMIT="81f19fe4031ede54b6ef3a82e445f78625572994"
EGIT_BRANCH="main"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="
	sys-apps/iproute2
"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	true
}

src_compile() {
	true
}

src_install() {
	default
	# why install a systemd file in / ...
	rm "${D}/sqm@.service"
}

pkg_pretend() {
	CHECK_CONFIG="
		CONFIG_IFB
		CONFIG_NET_SCH_HTB
		CONFIG_NET_SCH_CODEL
		CONFIG_NET_SCH_FQ_CODEL
		CONFIG_NET_SCH_CAKE
		CONFIG_NET_SCH_FQ
		CONFIG_NET_CLS_U32
		CONFIG_CLS_U32_PERF
		CONFIG_CLS_U32_MARK
		CONFIG_NET_CLS_FLOW
		CONFIG_NETFILTER_XT_MATCH_DSCP
		CONFIG_NETFILTER_XT_TARGET_DSCP
		CONFIG_NETFILTER_XT_MATCH_MARK
		CONFIG_NETFILTER_XT_TARGET_MARK
		CONFIG_NETFILTER_XT_MATCH_CONNMARK
		CONFIG_NETFILTER_XT_TARGET_CONNMARK
		CONFIG_NETFILTER_XT_CONNMARK
		CONFIG_NET_ACT_CONNMARK
	"
}
