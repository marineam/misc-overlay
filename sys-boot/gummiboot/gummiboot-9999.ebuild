# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-2

DESCRIPTION="Simple UEFI Boot Manager"
HOMEPAGE="http://freedesktop.org/wiki/Software/gummiboot"
EGIT_REPO_URI="git://anongit.freedesktop.org/gummiboot"

if [[ "${PV}" != 9999 ]]; then
	EGIT_COMMIT="refs/tags/${PV}"
fi

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=sys-apps/util-linux-2.20"
DEPEND="${RDEPEND}
	>=sys-boot/gnu-efi-3.0s
	dev-util/pkgconfig"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --enable-blkid
}
