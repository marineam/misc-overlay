# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/plymouth/plymouth-0.8.8-r5.ebuild,v 1.1 2014/03/01 19:21:50 maksbotan Exp $

EAPI=5

EGIT_REPO_URI="git://anongit.freedesktop.org/plymouth"
EGIT_COMMIT="481388968d987727e038597877cd752e8f7f6d65"
AUTOTOOLS_AUTORECONF=1

inherit git-2 autotools-utils readme.gentoo systemd toolchain-funcs

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI="http://dev.gentoo.org/~aidecoe/distfiles/${CATEGORY}/${PN}/gentoo-logo.png"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug +gtk +drm +pango static-libs"

CDEPEND="
	>=media-libs/libpng-1.2.16
	virtual/udev
	gtk? (
		dev-libs/glib:2
		>=x11-libs/gtk+-2.12:2 )
	drm? ( x11-libs/libdrm )
	pango? ( >=x11-libs/pango-1.21 )
"
DEPEND="${CDEPEND}
	virtual/pkgconfig
"
RDEPEND="${CDEPEND}"

DOC_CONTENTS="
	Follow the following instructions to set up Plymouth:\n
	http://dev.gentoo.org/~aidecoe/doc/en/plymouth.xml
"

src_configure() {
	# Note: help text says --enable-drm-renderer but it is --enable-drm
	local myeconfargs=(
		--with-system-root-install=no
		--localstatedir=/var
		--without-rhgb-compat-link
		--enable-systemd-integration
		$(use_enable debug tracing)
		$(use_enable gtk gtk)
		$(use_enable drm)
		$(use_enable pango)
		)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	# Don't install run-time directory
	rm -rf "${D}"/var/run

	insinto /usr/share/plymouth
	newins "${DISTDIR}"/gentoo-logo.png bizcom.png

	# Install compatibility symlinks as some rdeps hardcode the paths
	dosym /usr/bin/plymouth /bin/plymouth
	dosym /usr/sbin/plymouth-set-default-theme /sbin/plymouth-set-default-theme
	dosym /usr/sbin/plymouthd /sbin/plymouthd

	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
	if ! has_version "sys-kernel/dracut" && ! has_version "sys-kernel/genkernel-next[plymouth]"; then
		ewarn "If you want initramfs builder with plymouth support, please emerge"
		ewarn "sys-kernel/dracut or sys-kernel/genkernel-next[plymouth]."
	fi
}
