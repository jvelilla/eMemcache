note
	description: "Summary description for {MEMCACHE_CONSTANTS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	MEMCACHE_CONSTANTS

feature -- Access
	memcached_max_key : INTEGER
 		--  MEMCACHED_MAX_KEY
        external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_MAX_KEY
             }"
		end

	memcached_default_port : INTEGER
		-- MEMCACHED_DEFAULT_PORT
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_DEFAULT_PORT
             }"
		end


--#define MEMCACHED_MAX_BUFFER 8196
--#define MEMCACHED_MAX_HOST_SORT_LENGTH 86 /* Used for Ketama */
--#define MEMCACHED_POINTS_PER_SERVER 100
--#define MEMCACHED_POINTS_PER_SERVER_KETAMA 160
--#define MEMCACHED_CONTINUUM_SIZE MEMCACHED_POINTS_PER_SERVER*100 /* This would then set max hosts to 100 */
--#define MEMCACHED_STRIDE 4
--#define MEMCACHED_DEFAULT_TIMEOUT 1000
--#define MEMCACHED_CONTINUUM_ADDITION 10 /* How many extra slots we should build for in the continuum */
--#define MEMCACHED_PREFIX_KEY_MAX_SIZE 128
--#define MEMCACHED_EXPIRATION_NOT_ADD 0xffffffffU
--#define MEMCACHED_VERSION_STRING_LENGTH 24


end
