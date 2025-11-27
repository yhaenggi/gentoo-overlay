# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 linux-info

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

CHECK_CONFIG="
	~IFB
	~NET_SCH_HTB
	~NET_SCH_CODEL
	~NET_SCH_FQ_CODEL
	~NET_SCH_CAKE
	~NET_SCH_FQ
	~NET_SCH_INGRESS
	~NET_CLS_U32
	~CLS_U32_PERF
	~CLS_U32_MARK
	~NET_CLS_FLOW
	~NET_CLS_FW
	~NET_ACT_MIRRED
	~NETFILTER_XT_MATCH_DSCP
	~NETFILTER_XT_TARGET_DSCP
	~NETFILTER_XT_MATCH_MARK
	~NETFILTER_XT_TARGET_MARK
	~NETFILTER_XT_MATCH_CONNMARK
	~NETFILTER_XT_TARGET_CONNMARK
	~NETFILTER_XT_CONNMARK
	~NET_ACT_CONNMARK
"

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
