# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xen/Attic/xen-3.4.2-r4.ebuild,v 1.4 2012/05/13 17:25:20 pacho dead $

EAPI=5

inherit mount-boot flag-o-matic toolchain-funcs base

DESCRIPTION="The Xen virtual machine monitor"
HOMEPAGE="http://xen.org/"
SRC_URI="http://bits.xensource.com/oss-xen/release/${PV}/xen-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="debug custom-cflags pae acm flask xsm"

SLOT="${PV}"
#SLOT="0"
#PDEPEND="~app-emulation/xen-tools-${PV}"

PATCHES=(
	"${FILESDIR}/"${P}-werror.patch
)

RESTRICT="test"

# Approved by QA team in bug #144032
QA_WX_LOAD="boot/xen-syms-${PV}"

pkg_setup() {
	if [ -x "${S}/.config/" ]; then
		die "You will need to remove ${S}/.config by hand"
	fi
	if [[ -z ${XEN_TARGET_ARCH} ]]; then
		if use x86 && use amd64; then
			die "Confusion! Both x86 and amd64 are set in your use flags!"
		elif use x86; then
			export XEN_TARGET_ARCH="x86_32"
		elif use amd64; then
			export XEN_TARGET_ARCH="x86_64"
		else
			die "Unsupported architecture!"
		fi
	fi

	if use xsm ; then
		export "XSM_ENABLE=y"
		use acm && export "ACM_SECURITY=y"
		if use flask ; then
			! use acm  && export "FLASK_ENABLE=y"
			  use acm  && ewarn "Both acm and flask XSM specified, defaulting to acm."
		fi
	elif use acm || use flask ; then
		ewarn "acm and flask require USE=xsm to be set, dropping use flags"
	fi
}

src_prepare() {
	base_src_prepare

	# if the user *really* wants to use their own custom-cflags, let them
	if use custom-cflags; then
		einfo "User wants their own CFLAGS - removing defaults"
		# try and remove all the default custom-cflags
		find "${S}" -name Makefile -o -name Rules.mk -o -name Config.mk -exec sed \
			-e 's/CFLAGS\(.*\)=\(.*\)-O3\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-march=i686\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-fomit-frame-pointer\(.*\)/CFLAGS\1=\2\3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-g3*\s\(.*\)/CFLAGS\1=\2 \3/' \
			-e 's/CFLAGS\(.*\)=\(.*\)-O2\(.*\)/CFLAGS\1=\2\3/' \
			-i {} \;
	fi
}

src_compile() {
	local myopt
	use debug && myopt="${myopt} debug=y"
	use pae && myopt="${myopt} pae=y"

	if use custom-cflags; then
		filter-flags -fPIE -fstack-protector
		replace-flags -O3 -O2
	else
		unset CFLAGS
	fi

	# Send raw LDFLAGS so that --as-needed works
	emake CC="$(tc-getCC)" LDFLAGS="$(raw-ldflags)" -C xen ${myopt} || die "compile failed"
}

src_install() {
	local myopt
	use debug && myopt="${myopt} debug=y"
	use pae && myopt="${myopt} pae=y"

	emake LDFLAGS="$(raw-ldflags)" DESTDIR="${D}" -C xen ${myopt} install || die "install failed"

	# Remove potentially conflicting symlinks
	find "${D}"/boot -type l -delete || die
}
