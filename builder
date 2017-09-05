#!/usr/bin/env bash

set -eo pipefail; [[ "$TRACE" ]] && set -x

main() {
	declare version="${1:-$GLIBC_VERSION}" prefix="${2:-$PREFIX_DIR}"

	: "${version:?}" "${prefix:?}"

	{
		wget -qO- "http://ftp.gnu.org/gnu/glibc/glibc-$version.tar.gz" \
			| tar zxf -
		mkdir -p /glibc-build && cd /glibc-build
		"/glibc-$version/configure" \
			--host=i686-linux-gnu \
			--build=i686-linux-gnu \
			"CFLAGS=-m32 -O2-march=i686" \
			"CXXFLAGS=-m32 -O2 -march=i686" \
			"LDFLAGS=-m32" \
			--prefix="$prefix" \
			--libdir="$prefix/lib" \
			--libexecdir="$prefix/lib" \
		make && make install
		tar --hard-dereference -zcf "/glibc-bin-$version.tar.gz" "$prefix"
	} >&2

	[[ $STDOUT ]] && cat "/glibc-bin-$version.tar.gz"
}

main "$@"
