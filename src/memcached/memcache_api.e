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

feature -- Clean the contents of memcached servers

	memcached_flush (a_ms : POINTER; an_expiration : NATURAL_32) : INTEGER_32
		--memcached_return_t
		--    memcached_flush (memcached_st *ptr,
		--                     time_t expiration);	
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	memcached_return_t rc;
		    	rc = memcached_flush ((memcached_st *)$a_ms,(time_t)$an_expiration);
                return rc
             }"
		end

feature -- Disconnect from all servers

	memcached_quit (a_ms : POINTER)
		--void memcached_quit (memcached_st *ptr);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	memcached_quit ((memcached_st *)$a_ms)
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

	memcached_server_add ( a_mc : POINTER; a_hostname:POINTER; a_port:NATURAL_32 ):INTEGER_32
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


	memcached_server_count (a_mc : POINTER) : NATURAL_32
		--	uint32_t memcached_server_count (memcached_st *ptr)	
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
		    	memcached_server_count ((memcached_st *)$a_mc)
             }"
		end

feature -- Add value server
	memcached_add ( a_ms : POINTER; a_key:POINTER; a_key_length:NATURAL_32; a_value:POINTER; a_value_length:NATURAL_32;an_expiration:NATURAL_32;a_flags:NATURAL_32 ): INTEGER_32
		-- Only store the data if the key does not exist. If the key exists,
		-- we get NOT_STORED, as the test1 shows below. Otherwise we get STORED -- SUCCESS
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

	memcached_set (a_ms :POINTER; a_key:POINTER; a_key_length:NATURAL_32; a_value:POINTER; a_value_length:NATURAL_32;an_expiration:NATURAL_32; a_flags:NATURAL_32 ) :INTEGER_32
		-- Add a new item to memcached or replace an existing one with new data
		--	memcached_return_t
		--    memcached_set (memcached_st *ptr,
		--                   const char *key, size_t key_length,
		--                   const char *value, size_t value_length,
		--                   time_t expiration,
		--                   uint32_t flags);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
                memcached_return_t rc;
		    	rc = memcached_set ((memcached_st *)$a_ms,
                   (const char *)$a_key, (size_t)$a_key_length,
                   (const char *)$a_value, (size_t)$a_value_length, 
                   (time_t)$an_expiration,
                   (uint32_t)$a_flags);
                return rc
             }"
		end

	memcached_replace (a_ms :POINTER; a_key:POINTER; a_key_length:NATURAL_32; a_value:POINTER; a_value_length:NATURAL_32;an_expiration:NATURAL_32; a_flags:NATURAL_32 ) :INTEGER_32
		-- Only store the data if the key already exists. If the key does not exists, we get NOT_STORED, Otherwise we get STORED.
		--	memcached_return_t
		--    memcached_replace (memcached_st *ptr,
		--                       const char *key, size_t key_length,
		--                       const char *value, size_t value_length,
		--                       time_t expiration,
		--                       uint32_t flags);	
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
                memcached_return_t rc;
		    	rc = memcached_replace ((memcached_st *)$a_ms,
                   (const char *)$a_key, (size_t)$a_key_length,
                   (const char *)$a_value, (size_t)$a_value_length, 
                   (time_t)$an_expiration,
                   (uint32_t)$a_flags);
                return rc
             }"
		end

	memcached_increment (a_ms : POINTER; a_key : POINTER; a_key_length:NATURAL_32; an_offset:NATURAL_32; a_value:POINTER ) : INTEGER_32
		--  memcached_return_t
		--    memcached_increment (memcached_st *ptr,
		--                         const char *key, size_t key_length,
		--                         unsigned int offset,
		--                         uint64_t *value);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
                memcached_return_t rc;
		    	rc =  memcached_increment ((memcached_st *)$a_ms, 
                         (const char *)$a_key, (size_t) $a_key_length,
                         (unsigned int)$an_offset,
                         (uint64_t *)$a_value);
                return rc
             }"
		end


	memcached_decrement (a_ms : POINTER; a_key : POINTER; a_key_length:NATURAL_32; an_offset:NATURAL_32; a_value:POINTER ) : INTEGER_32
		--  memcached_return_t
		--    memcached_decrement (memcached_st *ptr,
		--                         const char *key, size_t key_length,
		--                         unsigned int offset,
		--                         uint64_t *value);
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
                memcached_return_t rc;
		    	rc =  memcached_decrement ((memcached_st *)$a_ms, 
                         (const char *)$a_key, (size_t) $a_key_length,
                         (unsigned int)$an_offset,
                         (uint64_t *)$a_value);
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




end -- class MEMCACHE_API
