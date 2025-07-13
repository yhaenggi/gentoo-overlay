# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="An archive of classic Macintosh ROMs. For emulators or flashing old hardware"
HOMEPAGE="https://macintoshgarden.org/apps/macintosh-rom-archive"
SRC_URI="
	https://download.macintoshgarden.org/apps/mac-rom-archive-20110819.zip
	https://old.mac.gdn/apps/mac-rom-archive-20110819.zip
	https://archive.org/download/mac_rom_archive_-_as_of_8-19-2011/mac_rom_archive_-_as_of_8-19-2011.zip -> mac-rom-archive-20110819.zip

	https://smb4.s3.us-west-2.amazonaws.com/sheepshaver/apple_roms/newworld86.rom.zip
	https://archive.org/download/newworld86.rom/newworld86.rom.zip
"
RESTRICT="mirror"

LICENSE=""
SLOT="0"
KEYWORDS="x86 amd64 arm arm64 ppc ppc64"

IUSE="-all-firmware"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S=${WORKDIR}

src_install() {
	dodir /usr/share/mac-rom
	insinto /usr/share/mac-rom
	if use all-firmware; then
		doins -r "${S}/."
	else
		doins "${S}/newworld86.rom"
		doins "${S}/06684214 - Quadra 630.ROM"
		doins "${S}/F1ACAD13 - Quadra 610,650,maybe 800.ROM"
		doins "${S}/420DBFF3 - Quadra 700&900 & PB140&170.ROM"
		doins "${S}/3DC27823 - Quadra 950.ROM"
	fi
}
