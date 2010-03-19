note
	description: "Summary description for {MEMCACHE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	 MEMCACHE_API
	inherit ANY undefine is_equal, copy end

feature {} -- External calls

	memcached_create : POINTER is
 		-- http://docs.tangent.org/libmemcached/memcached_create.html
 		-- memcached_st *memcached_create(memcached_st *ptr);
        external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	memcached_create(NULL)
             }"
		end

	memcached_free ( a_mc: POINTER )
		-- http://docs.tangent.org/libmemcached/memcached_free.html
		-- void memcached_free(memcached_st *ptr);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	memcached_free((memcached_st *)$a_mc)
             }"
		end

feature -- Connecting to Servers

	memcached_server_list_append (a_hostname:POINTER; a_port: NATURAL_32; an_error:POINTER) : POINTER
		--	memcached_server_st *
		--    memcached_server_list_append (memcached_server_st *ptr,
		--                                  const char *hostname,
		--                                  unsigned int port,
		--                                  memcached_return_t *error);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	memcached_server_list_append(NULL, (const char *)$a_hostname, (unsigned int)$a_port , (memcached_return_t *)&($an_error))
             }"
		end

	memcached_server_add ( a_mc : POINTER; a_hostname:POINTER; a_port:NATURAL_32 ):POINTER
		--	memcached_return_t
		--    memcached_server_add (memcached_st *ptr,
		--                          const char *hostname,
		--                          in_port_t port);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
		    	memcached_server_add ((memcached_st *)$a_mc, (const char *)$a_hostname,(in_port_t)$a_port)
             }"
		end


feature -- Add Elements
	memcached_add ( a_ms : POINTER; a_key:POINTER; a_key_length:NATURAL_32; a_value:POINTER; a_value_length:NATURAL_32;an_expiration:NATURAL_32;a_flags:NATURAL_32 ): INTEGER_32
		--memcached_return_t
		--    memcached_add (memcached_st *ptr,
		--                   const char *key, size_t key_length,
		--                   const char *value, size_t value_length,
		--                   time_t expiration,
		--                   uint32_t flags);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
                memcached_return_t rc;
		    	rc = memcached_add ((memcached_st *)$a_ms,
                   (const char *)$a_key, (size_t)$a_key_length,
                   (const char *)$a_value, (size_t)$a_value_length, 
                   (time_t)$an_expiration,
                   (uint32_t)$a_flags);
                return rc
             }"
		end


feature -- Get Elements
	memcached_get ( a_ms:POINTER; a_key:POINTER; a_key_length:NATURAL_32; a_value_length:NATURAL_32; a_flag:NATURAL_32; an_error:POINTER):POINTER
		--  char *
		--    memcached_get (memcached_st *ptr,
		--                   const char *key, size_t key_length,
		--                   size_t *value_length,
		--                   uint32_t *flags,
		--                   memcached_return_t *error);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
				    memcached_get ((memcached_st *)$a_ms,
                   				(const char *)$a_key, (size_t)$a_key_length,
                   				(size_t *)&($a_value_length),
                   				(uint32_t *)&($a_flag),
                   				(memcached_return_t *)$an_error)


             }"
		end



feature -- Remove Elements


	memcached_delete (a_ms : POINTER; a_key:POINTER; a_key_length : NATURAL_32; an_expiration:NATURAL_32) : INTEGER
		--  memcached_return_t
		--    memcached_delete (memcached_st *ptr,
		--                      const char *key, size_t key_length,
		--                      time_t expiration)
				external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
				  memcached_delete ((memcached_st *)$a_ms,
                      (const char *)$a_key, (size_t)$a_key_length,
                      (time_t)$an_expiration)


             }"
		end
		
		

--  memcached_return_t
--  memcached_delete_by_key (memcached_st *ptr,
--                           const char *master_key, size_t master_key_length,
--                           const char *key, size_t key_length,
--                           time_t expiration);



end -- class MEMCACHE_API
