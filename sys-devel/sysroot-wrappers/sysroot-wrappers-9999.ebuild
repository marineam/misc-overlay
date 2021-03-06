# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools git-2

DESCRIPTION="Build tool wrappers for using custom SYSROOTs"
HOMEPAGE="https://github.com/coreos/sysroot-wrappers"
EGIT_REPO_URI="https://github.com/coreos/sysroot-wrappers"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-*"
IUSE=""

src_prepare() {
	eautoreconf
}
