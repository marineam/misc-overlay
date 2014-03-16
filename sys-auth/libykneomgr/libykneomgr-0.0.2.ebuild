# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools-utils

DESCRIPTION="Yubico YubiKey NEO Manager C Library"
HOMEPAGE="https://github.com/Yubico/libykneomgr"
SRC_URI="http://opensource.yubico.com/libykneomgr/releases/${P}.tar.gz"

LICENSE="LGPL-3+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc static-libs"

RDEPEND=">=app-crypt/ccid-1.4.10[usb]
	dev-libs/libzip
	sys-apps/pcsc-lite"
DEPEND="${RDEPEND}
	dev-util/gengetopt
	sys-apps/help2man
	doc? ( dev-util/gtk-doc )"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
	local myeconfargs=(
		--with-backend=pcsc
		$(use_enable doc gtk-doc)
	)
	autotools-utils_src_configure
}
