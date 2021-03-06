# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit common-lisp-3 xdg-utils

MY_P="v${PV}"

DESCRIPTION="Provides Common Lisp implementations with knowledge about Unicode characters."
HOMEPAGE="http://weitz.de/cl-unicode/"
SRC_URI="https://github.com/edicl/${PN}/archive/${MY_P}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/commonlisp
		dev-lisp/flexi-streams"
RDEPEND="dev-lisp/cl-ppcre"

COMMONLISPS="sbcl clisp clozurecl cmucl ecls"

find-lisp-impl() {
	for lisp in ${COMMONLISPS} ; do
		[[ "$(best_version dev-lisp/${lisp})" ]] && echo "${lisp}" && return
	done
	die "No CommonLisp implementation found"
}

src_configure() {
	xdg_environment_reset
}

src_compile() {
	# cl-unicode builds parts of its source code automatically the first time it
	# is compiled, so we compile it here.
	local initclunicode="(progn (push \"${S}/\" asdf:*central-registry*) (require :${PN}))"

	common-lisp-export-impl-args "$(find-lisp-impl)"
	${CL_BINARY} ${CL_EVAL} "${initclunicode}"
}

src_install() {
	common-lisp-install-sources *.lisp test/
	common-lisp-install-sources -t all build/
	common-lisp-install-asdf
	dodoc CHANGELOG
	dodoc doc/index.html
}
