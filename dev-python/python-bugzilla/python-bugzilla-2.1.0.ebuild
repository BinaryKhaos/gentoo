# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit distutils-r1

DESCRIPTION="A python module for interacting with Bugzilla over XMLRPC"
HOMEPAGE="https://github.com/python-bugzilla/python-bugzilla"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
IUSE="test"
LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	|| ( dev-python/python-magic[${PYTHON_USEDEP}] sys-apps/file[python,${PYTHON_USEDEP}] )
	dev-python/requests[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/coverage
		dev-python/pep8
	)
"

python_test() {
	"${EPYTHON}" ./setup.py test
}
