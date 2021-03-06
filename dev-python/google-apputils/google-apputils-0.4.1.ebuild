# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Google Application Utilities for Python"
HOMEPAGE="http://code.google.com/p/google-apputils-python/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="${PYTHON_DEPS}
    dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/python-gflags[${PYTHON_USEDEP}]
	dev-python/pytz[${PYTHON_USEDEP}]
	test? (
		dev-python/mox[${PYTHON_USEDEP}]
		virtual/python-unittest2[${PYTHON_USEDEP}]
	)"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

PATCHES=( "${FILESDIR}"/0.4.1-remove-broken-ez_setup-import.patch )

DOCS=( README )

python_test() {
	${PYTHON} setup.py google_test || \
		ewarn "FIXME: Tests failed with ${EPYTHON}"
	# The situation here is that tests/app_unittest.sh and
	# tests/appcommands_unittest.sh run PYTHON=$(which python) which
	# doesn't behave properly. Probably a simple sed patch though...
}
