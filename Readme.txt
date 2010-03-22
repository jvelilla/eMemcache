Eiffel memcache wrapper is based on libmemcached library http://tangent.org/552/libmemcached.html.

This library (wrapper is under development).

REQUIREMENTS
============

1)Install memcached and libevent:
#>sudo apt-get install memcached

2)Install libmemcached http://tangent.org/552/libmemcached.html

3) Add this environment variable 
	export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" 

EXECUTION
=========

1) start memcached server
#> memcached -p 8000 -vv 

2) run your example.



