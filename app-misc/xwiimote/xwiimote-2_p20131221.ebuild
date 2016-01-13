# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
AUTOTOOLS_AUTORECONF=1

inherit autotools-utils udev vcs-snapshot

DESCRIPTION="Nintendo Wii Remote Linux Device Driver Tools"
HOMEPAGE="https://github.com/dvdhrm/xwiimote"
GIT_COMMIT="f2be57e24fc24652308840cec2ed702b9d1138df"
SRC_URI="${HOMEPAGE}/tarball/${GIT_COMMIT} -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND="sys-libs/ncurses
	virtual/libudev"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"

src_configure() {
	local myeconfargs=(
		$(use_with doc doxygen)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	udev_dorules res/70-udev-xwiimote.rules
	insinto /usr/share/X11/xorg.conf.d
	doins res/50-xorg-fix-xwiimote.conf
}
