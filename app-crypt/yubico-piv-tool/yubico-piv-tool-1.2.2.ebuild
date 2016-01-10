# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Configure your PIV-enabled YubiKey with X509 certificate"
HOMEPAGE="https://developers.yubico.com/yubico-piv-tool/"
SRC_URI="https://developers.yubico.com/${PN}/Releases/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

CDEPEND="
	sys-apps/pcsc-lite
	"

DEPEND="${CDEPEND}"

RDEPEND="${CDEPEND}"

DOCS=( COPYING ChangeLog NEWS README )
