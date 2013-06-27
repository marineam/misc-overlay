# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Commandline flags module for Python, equivalent to gflags for C++"
HOMEPAGE="http://code.google.com/p/python-gflags"
SRC_URI="http://python-gflags.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}"
DEPEND="${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=(
	${FILESDIR}/0001-Unit-test-updates-for-Python-2.7-compatibility.patch
	${FILESDIR}/0002-Install-gflags2man-explicity-as-a-script.patch
	${FILESDIR}/0003-Skip-a-permissions-check-when-running-as-root.patch
)

DOCS=( ChangeLog NEWS README )

python_test() {
	local testsuite
	for testsuite in tests/*.py; do
		${PYTHON} ${testsuite} || die
	done
}
