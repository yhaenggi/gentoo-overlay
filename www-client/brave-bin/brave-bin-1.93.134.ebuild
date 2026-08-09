# Copyright 1999-2025 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

BRAVE_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	af am ar az bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr 
	gu he hi hr hu id it ja ka km kn ko lt lv mk ml mn mr ms my nb nl pl 
	pt-BR pt-PT ro ru si sk sl sq sr sr-latin sv sw ta te th tr uk ur uz vi 
	zh-CN zh-TW
"

inherit chromium-2 xdg-utils desktop

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"

SRC_URI="
	amd64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-${PV}-linux-amd64.zip )
	arm64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-${PV}-linux-arm64.zip )
"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="keyring"

RDEPEND="
	${DEPEND}
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxshmfence
	x11-libs/libXxf86vm
	x11-libs/libXScrnSaver
	x11-libs/libXrandr
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXinerama
	x11-libs/libxkbcommon
	dev-libs/glib
	dev-libs/nss
	dev-libs/nspr
	net-print/cups
	sys-apps/dbus
	dev-libs/expat
	media-libs/alsa-lib
	x11-libs/pango
	x11-libs/cairo
	dev-libs/gobject-introspection
	dev-libs/atk
	app-accessibility/at-spi2-core
	app-accessibility/at-spi2-atk
	x11-libs/gtk+:3
	x11-libs/gdk-pixbuf
	dev-libs/libffi
	dev-libs/libpcre
	net-libs/gnutls
	sys-libs/zlib
	dev-libs/fribidi
	media-libs/harfbuzz
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/pixman
	>=media-libs/libpng-1.6.34
	media-libs/libepoxy
	dev-libs/libbsd
	dev-libs/libunistring
	dev-libs/libtasn1
	dev-libs/nettle
	dev-libs/gmp
	net-dns/libidn2
	media-gfx/graphite2
	app-arch/bzip2
	dev-qt/qtbase
"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	pushd "${S}/locales" > /dev/null || die
		chromium_remove_language_paks
	popd > /dev/null || die

	default
}

src_install() (
	shopt -s extglob

		declare BRAVE_HOME=/opt/${BRAVE_PN}

		dodir ${BRAVE_HOME%/*}

		insinto ${BRAVE_HOME}
			doins -r *
    # Brave has a bug in 1.27.105 where it needs crashpad_handler chmodded
    # Delete crashpad_handler when https://github.com/brave/brave-browser/issues/16985 is resolved.
			exeinto ${BRAVE_HOME}
				doexe brave chrome_crashpad_handler

		dosym ${BRAVE_HOME}/brave /usr/bin/${PN} || die

	# Install Icons for Brave. 
		newicon "${FILESDIR}/brave.png" "${PN}.png" || die
		newicon -s 128 "${FILESDIR}/brave.png" "${PN}.png" || die

	# install-xattr doesnt approve using domenu or doins from FILESDIR
		cp "${FILESDIR}"/${PN}.desktop "${S}"
		domenu "${S}"/${PN}.desktop
)

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
