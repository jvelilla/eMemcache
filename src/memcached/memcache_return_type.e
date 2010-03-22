note
	description: "Summary description for {MEMCACHE_RETURN_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMCACHE_RETURN_TYPE
	inherit
	--	ENUM
		MEMORY_STRUCTURE undefine default_create end
create {ANY} default_create

feature -- Initialization

	default_create
		do
			make
		end

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		do
			Result := struct_size
		end

	struct_size: INTEGER is
		external   "C inline use <libmemcached/memcached.h>"
		alias "sizeof(memcached_return_t)"
		end
feature -- Memcached_return_t enum	values	
	memcached_success : INTEGER
 		--  MEMCACHED_SUCCESS
        external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_SUCCESS
             }"
		end

	memcached_failure : INTEGER
		--  MEMCACHED_FAILURE
	 	external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_FAILURE
             }"
		end

	memcached_host_lookup_failure : INTEGER
		--  MEMCACHED_HOST_LOOKUP_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_HOST_LOOKUP_FAILURE
             }"
		end

	memcached_connection_failure : INTEGER
		--  MEMCACHED_CONNECTION_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_HOST_LOOKUP_FAILURE
             }"
		end

	memcached_connection_bind_failure : INTEGER
		--  MEMCACHED_CONNECTION_BIND_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_CONNECTION_BIND_FAILURE
             }"
		end

	memcached_write_failure : INTEGER
		--  MEMCACHED_WRITE_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_WRITE_FAILURE
             }"
		end

	memcached_read_failure : INTEGER
		--  MEMCACHED_READ_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_READ_FAILURE
             }"
		end

	memcached_unknown_read_failure : INTEGER
		--  MEMCACHED_UNKNOWN_READ_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_UNKNOWN_READ_FAILURE
             }"
		end

	memcached_protocol_error : INTEGER
		--  MEMCACHED_PROTOCOL_ERROR
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_PROTOCOL_ERROR
             }"
		end

	memcahced_client_error : INTEGER
		-- MEMCACHED_CLIENT_ERROR
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_CLIENT_ERROR
             }"
		end

	memcahced_server_error : INTEGER
		--  MEMCACHED_SERVER_ERROR
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_SERVER_ERROR
             }"
		end

	memcached_connection_socket_create_failure : INTEGER
		--  MEMCACHED_CONNECTION_SOCKET_CREATE_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_CONNECTION_SOCKET_CREATE_FAILURE
             }"
		end

	memcached_data_exists : INTEGER
		--  MEMCACHED_DATA_EXISTS
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_DATA_EXISTS
             }"
		end

	memcached_data_does_not_exist : INTEGER
		--  MEMCACHED_DATA_DOES_NOT_EXIST
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_DATA_DOES_NOT_EXIST
             }"
		end

	memcached_notstored : INTEGER
		--  MEMCACHED_NOTSTORED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_NOTSTORED
             }"
		end

	memcached_stored : INTEGER
		--  MEMCACHED_STORED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_STORED
             }"
		end


	memcached_notfound : INTEGER
		--  MEMCACHED_NOTFOUND
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_NOTFOUND
             }"
		end

	memcached_memory_allocation_failure : INTEGER
		--  MEMCACHED_MEMORY_ALLOCATION_FAILURE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_MEMORY_ALLOCATION_FAILURE
             }"
		end

	memcached_partial_read : INTEGER
		--  MEMCACHED_PARTIAL_READ
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_PARTIAL_READ
             }"
		end

	memcached_some_errors : INTEGER
		--  MEMCACHED_SOME_ERRORS
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_SOME_ERRORS
             }"
		end

	memcached_no_servers : INTEGER
		--  MEMCACHED_NO_SERVERS
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_NO_SERVERS
             }"
		end

	memcached_end : INTEGER
		--  MEMCACHED_END
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_END
             }"
		end

	memcached_deleted : INTEGER
		--  MEMCACHED_DELETED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_DELETED
             }"
		end

	memcached_value : INTEGER
		--  MEMCACHED_VALUE
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_VALUE
             }"
		end

	memcached_stat : INTEGER
	 	-- MEMCACHED_STAT
	 	external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_STAT
             }"
		end

	memcached_item : INTEGER
		--  MEMCACHED_ITEM
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_ITEM
             }"
		end

	memcached_errno : INTEGER
		--  MEMCACHED_ERRNO
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_ERRNO
             }"
		end

	memcached_fail_unix_socket : INTEGER
		--  MEMCACHED_FAIL_UNIX_SOCKET
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_FAIL_UNIX_SOCKET
             }"
		end

	memcached_not_supported : INTEGER
		--  MEMCACHED_NOT_SUPPORTED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_NOT_SUPPORTED
             }"
		end

	memcached_no_key_provided : INTEGER
		--  MEMCACHED_NO_KEY_PROVIDED, /* Deprecated. Use MEMCACHED_BAD_KEY_PROVIDED! */
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_NO_KEY_PROVIDED
             }"
		end


	memcached_fecth_nonfinished : INTEGER
		--  MEMCACHED_FETCH_NOTFINISHED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_FETCH_NOTFINISHED
             }"
		end

	memcached_timeout : INTEGER
		--  MEMCACHED_TIMEOUT
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_TIMEOUT
             }"
		end

	memcached_buffered : INTEGER
		--  MEMCACHED_BUFFERED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_BUFFERED
             }"
		end

	memcached_bad_key_provided : INTEGER
		--  MEMCACHED_BAD_KEY_PROVIDED
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_BAD_KEY_PROVIDED
             }"
		end

	memcached_invalid_host_protocol : INTEGER
		--  MEMCACHED_INVALID_HOST_PROTOCOL
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_INVALID_HOST_PROTOCOL
             }"
		end

	memcached_server_marked_dead : INTEGER
		--  MEMCACHED_SERVER_MARKED_DEAD
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_SERVER_MARKED_DEAD
             }"
		end

	memcached_unknown_stat_key : INTEGER
		--  MEMCACHED_UNKNOWN_STAT_KEY
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_UNKNOWN_STAT_KEY
             }"
		end

	memcached_e2big : INTEGER
		--  MEMCACHED_E2BIG
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_E2BIG
             }"
		end

	memcached_invalid_arguments : INTEGER
		--  MEMCACHED_INVALID_ARGUMENTS
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_INVALID_ARGUMENTS
             }"
		end

	memcached_key_too_big : INTEGER
		--  MEMCACHED_KEY_TOO_BIG
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_KEY_TOO_BIG
             }"
		end

	memcached_maximum_return : INTEGER
		--  MEMCACHED_MAXIMUM_RETURN /* Always add new error code before */
		external
	                "C inline use <libmemcached/memcached.h>"
        alias
                "{
               	MEMCACHED_MAXIMUM_RETURN
             }"
		end




end
