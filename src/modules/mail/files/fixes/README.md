Debian / Ubuntu Fixes
=====================

Support for postfix multi instances is not in various packaged Debian scripts
in Ubuntu <= 11.04 and Debian <= Squeeze, the problems are fixed in version 2.8.4-1.

init.d: http://anonscm.debian.org/gitweb/?p=users/lamont/postfix.git;a=blob;f=debian/init.d;h=b2114cecc68b3f7c1a3bdce76933529fb295b7ab;hb=ebb3c2226a7e1cb003d22d69b3e56b3103795fe9

References
----------

* http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=560682
* https://bugs.launchpad.net/debian/+source/postfix/+bug/624522
