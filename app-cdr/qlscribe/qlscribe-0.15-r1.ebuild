# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit base cmake-utils

DESCRIPTION="OS lightScribe labeler"
HOMEPAGE="http://sourceforge.net/projects/qlscribe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtgui:4
	dev-qt/qtdbus:4
	dev-libs/liblightscribe
	amd64? ( app-emulation/emul-linux-x86-baselibs )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-alarm.patch" )

src_configure() {
	local mycmakeargs=(
		"-DDBUS_SYSTEM_POLICY_DIR=/etc/dbus-1/system.d"
		"-DDBUS_SYSTEM_SERVICE_DIR=/usr/share/dbus-1/system-services" )

	cmake-utils_src_configure
}
