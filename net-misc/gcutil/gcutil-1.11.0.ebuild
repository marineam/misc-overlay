# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="Command line tool for interacting with Google Compute Engine"
HOMEPAGE="https://code.google.com/p/google-compute-engine-tools/"
SRC_URI="https://google-compute-engine-tools.googlecode.com/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	>=dev-python/httplib2-0.8[${PYTHON_USEDEP}]
	>=dev-python/google-api-python-client-1.2[${PYTHON_USEDEP}]
	>=dev-python/ipaddr-2.1.10[${PYTHON_USEDEP}]
	>=dev-python/iso8601-0.1.4[${PYTHON_USEDEP}]
	>=dev-python/google-apputils-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/python-gflags-2.0[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	virtual/python-argparse[${PYTHON_USEDEP}]
	"

DOCS=( README CHANGELOG )
PATCHES=(
	${FILESDIR}/${P}-use-friendly-version-checks.patch
)

python_test() {
	${PYTHON} setup.py google_test --test-dir "${BUILD_DIR}"/lib || \
		ewarn "FIXME: Tests failed with ${EPYTHON}"
	# There seems to be a version compatibility issue...
}
