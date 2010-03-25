note
	description: "Summary description for {MEMCACHE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMCACHE
	inherit
		MEMCACHE_API
			undefine default_create
		end
		MEMCACHE_CONSTANTS
			undefine default_create
		end
		MEMCACHE_RETURN_TYPE
			undefine default_create
		end

create {ANY} default_create

feature -- Initialization
	default_create
		-- create a memcached_st structure that will then be used by other features
		-- to communicate with the server
		do
			memcache_structure := memcached_create
		ensure then
			allocation_ok : memcache_structure /= default_pointer
		end

feature -- Clean Memcache Memory

	free
		--	To clean up memory associated with a the current memcache structure
		do
			memcached_free (memcache_structure)
		end

feature -- Wipe contents of memcached servers

	flush
		-- Clean the contents of memcached(1) servers,  causes an immediate flush
		-- It will flush the servers in the order that they were added.
		do
			memcached_status := internal_flush (0)
		ensure
			servers_flused : memcached_status = memcached_success
		end

	flush_with_expiration (an_expiration : NATURAL_32)
		-- Clean the contents of memcached(1) servers, based on the expiration time passed
		-- It will flush the servers in the order that they were added.
		do
			memcached_status := internal_flush (an_expiration)
		ensure
			servers_flused : memcached_status = memcached_success

		end

feature -- Manage Sever
	add_server (a_host: STRING; a_port: NATURAL_32)
		--  Add a single TCP server into the memcached structure
		require
			a_valid_host : a_host /= Void and (not a_host.is_empty)
		local
			l_host : C_STRING
		do
			create l_host.make (a_host)
			memcached_status := memcached_server_add (memcache_structure, l_host.item, a_port)
		ensure
			server_added : memcached_status = memcached_success
		end

	server_count : NATURAL_32
		-- Current number of servers being used by  the memcache structure
		do
			Result := memcached_server_count (memcache_structure)
		end
feature -- Disconnect from all servers

	quit
		--	Disconnect from all currently connected servers.
		--  It will also reset the state of the connection
		--  This function is called automatically when you call free.
		-- OBS:  maybe this feature is not needed here!!!!
		do
			memcached_quit (memcache_structure)
		end

feature -- Add value to the server
	add ( a_key : STRING; a_value:STRING)
		-- Only store the data if the key does not exist. If the key exists,
		-- we get NOT_STORED, Otherwise we get STORED -- SUCCESS
		require
			key_not_void_or_empty: a_key /= Void and (not a_key.is_empty)
			is_a_valid_key_size  : (create {C_STRING}.make(a_key)).bytes_count <= memcached_max_key
			value_not_void_or_empty : a_value /= Void and (not a_value.is_empty)
		local
			lkey:C_STRING
			lvalue:C_STRING
		do
			create lkey.make (a_key)
			create lvalue.make (a_value)
			memcached_status := memcached_add (memcache_structure, lkey.item,lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32, 0,0)
		ensure
			is_valid_response : memcached_notstored = memcached_status or memcached_success = memcached_status
		end

feature {NONE} -- Implementation

	internal_flush ( an_expiration: NATURAL_32 ) : INTEGER_32
		-- internal implementation of flush
		do
			Result := memcached_flush (memcache_structure, 0)
		end

	memcache_structure: POINTER
		-- represent a memcached_st structure

	memcached_status : INTEGER_32

invariant
	memcached_structed_created: memcache_structure /= default_pointer

end
