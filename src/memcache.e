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
		DEBUG_OUTPUT
			undefine default_create
		end
create {ANY} default_create

-- TODO create a is_valid_key
--      create a is_valid_value
--      free the values from memcache
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
		-- Clean the contents of memcached servers,  causes an immediate flush
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


	set (a_key : STRING; a_value:STRING)
		-- Add a new item to memcached or replace an existing one with new data
		require
			key_not_void_or_empty: a_key /= Void and (not a_key.is_empty)
			is_a_valid_key_size  : (create {C_STRING}.make(a_key)).bytes_count <= memcached_max_key
			value_not_void_or_empty : a_value /= Void and (not a_value.is_empty)
		local
			lkey : C_STRING
			lvalue : C_STRING
		do
				create lkey.make (a_key)
				create lvalue.make (a_value)
				memcached_status := memcached_set (memcache_structure,lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
		ensure
			set_value_for_key : memcached_status = memcached_success
		end

feature -- Get value from the server

	get (a_key : STRING) : STRING
		-- Get an individual value from the server, based on a_key
		-- The object will be returned upon success and NULL will be returned on failure.
		require
			key_not_void_or_empty: a_key /= Void and (not a_key.is_empty)
			is_a_valid_key_size  : (create {C_STRING}.make(a_key)).bytes_count <= memcached_max_key
		local
			lkey : C_STRING
			error : C_STRING
			mrt : MEMCACHE_RETURN_TYPE
			lresult : POINTER
			lc : CHARACTER
		do
			create mrt
			create lkey.make (a_key)
			create error.make_empty (mrt.structure_size)
			lresult := memcached_get (memcache_structure, lkey.item, lkey.bytes_count.as_natural_32, 0,0, error.item)
			if lresult /= default_pointer then
				create Result.make_from_c(lresult)
			else
				status := error.string.at (1).code.out   -- Validate
				print ("%N MEMCACHED_GET:" + debug_output + "%N")
			end
		ensure
		   -- Which should be the postcondition here?
		   -- key_found : memcached_status = memcached_success
		   -- or key_not_found : memcached_status = memcached_notfound
		   added_key : memcached_status = memcached_success or memcached_status = memcached_notfound
		end

feature -- Remove Elements

	delete (a_key : STRING)
		-- delete the particular key `a_key'.
		require
	 		key_not_void_or_empty: a_key /= Void and (not a_key.is_empty)
			is_a_valid_key_size  : (create {C_STRING}.make(a_key)).bytes_count <= memcached_max_key
			-- exist the key `a_key'
		local
			lkey : C_STRING
		do
			create lkey.make (a_key)
			memcached_status := memcached_delete (memcache_structure, lkey.item,lkey.bytes_count.as_natural_32,0)
		ensure
			-- memcached_success or memcached_notfund
			delelted_key : memcached_status = memcached_success or memcached_status = memcached_notfound
		end


feature -- Query

	is_valid_key ( a_key : STRING ) : BOOLEAN
		-- The `a_key' cannot exceed 250 characters.
		-- The `a_key' cannot be null.
		-- The `a_key' cannot be empty.
		do
			Result :=  a_key /= Void and (not a_key.is_empty) and (create {C_STRING}.make(a_key)).bytes_count <= memcached_max_key
		end

feature -- Status report


	debug_output: STRING
            -- String that should be displayed in debugger to represent `Current'.
        do
            Result :=status
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

	status : STRING
		-- String representation of memcache return types.
invariant
	memcached_structed_created: memcache_structure /= default_pointer

end
