# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multiprocessing toolchain-funcs

DESCRIPTION="EDK II Open Source UEFI Shell"
HOMEPAGE="http://tianocore.sourceforge.net"

LICENSE="BSD-2"
SLOT="0"
IUSE="debug"

if [[ ${PV} == 99999 ]]; then
	inherit subversion
	ESVN_REPO_URI="https://svn.code.sf.net/p/edk2/code/trunk/edk2"
	KEYWORDS="-* ~amd64"
else
	MY_P="edk2-${PV}"
	S="${WORKDIR}/${MY_P}"
	SRC_URI="http://storage.core-os.net/mirror/snapshots/${MY_P}.tar.xz"
	KEYWORDS="-* amd64"
fi

DEPEND=""
RDEPEND=""

src_prepare() {
	# This build system is impressively complicated, needless to say
	# it does things that get confused by PIE being enabled by default.
	# Add -nopie to a few strategic places... :)
	if gcc-specs-pie; then
		epatch "${FILESDIR}/edk2-nopie.patch"
	fi
}

src_configure() {
	./edksetup.sh || die

	TARGET_NAME=$(usex debug DEBUG RELEASE)
	TARGET_TOOLS="GCC$(gcc-version | tr -d .)"
	case $ARCH in
		amd64)	TARGET_ARCH=X64 ;;
		#x86)	TARGET_ARCH=IA32 ;;
		*)		die "Unsupported $ARCH" ;;
	esac
}

src_compile() {
	emake ARCH=${TARGET_ARCH} -C BaseTools -j1

	( . ./edksetup.sh && build \
		-a "${TARGET_ARCH}" \
		-b "${TARGET_NAME}" \
		-t "${TARGET_TOOLS}" \
		-n $(makeopts_jobs) \
		-p "./ShellPkg/ShellPkg.dsc" \
	) || die "build failed"
}

src_install() {
	local dir="Build/Shell/${TARGET_NAME}_${TARGET_TOOLS}/${TARGET_ARCH}"
	insinto "/boot"
	newins "${dir}/Shell.efi" "shell${TARGET_ARCH}.efi"
}
