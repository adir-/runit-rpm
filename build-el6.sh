#!/bin/sh

whereami=$(dirname $0)

if [ ! -f "/etc/rpm/macros.dist" ] && \
   [ ! -f "/etc/rpm/macros.disttag" ];   then echo "please install 'buildsys-macros' rpm and try again" ; exit 1 ; fi
if [ ! -f "$(which rpmbuild)" ];         then echo "please install 'rpm-build' rpm and try again" ; exit 1 ; fi
if [ ! -f "$(which spectool)" ];         then echo "please install 'rpmdevtools' rpm and try again" ; exit 1 ; fi
if [ ! -f "$(which rpmdev-setuptree)" ]; then echo "please install 'rpmdevtools' rpm and try again" ; exit 1 ; fi

# creates ~/rpmbuild
/usr/bin/rpmdev-setuptree

cp -f ${whereami}/runit-el6.spec ~/rpmbuild/SPECS/
cp -f ${whereami}/*.patch    ~/rpmbuild/SOURCES/
/usr/bin/spectool -C ~/rpmbuild/SOURCES/ -g ${whereami}/runit-el6.spec

rpmbuild -bb ~/rpmbuild/SPECS/runit-el6.spec
