note
	description: "Summary description for {MEMCACHE_RETURN_TYPE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MEMCACHE_RETURN_TYPE
	inherit
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


end
