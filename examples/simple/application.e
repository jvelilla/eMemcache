note
	description : "simple application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	APPLICATION

inherit
	ARGUMENTS
	MEMCACHE_API
	MEMCACHE_RETURN_TYPE  rename make as make_return_type
						  undefine default_create end


create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			create_and_free
			connecting_to_servers_add_and_get
			add_get_delete_keys
		end

	create_and_free
		local
			mc : POINTER
		do
			mc := memcached_create
			memcached_free (mc)
		end

	connecting_to_servers_add_and_get
		local
			mc,error: POINTER
			host,str_error: C_STRING
			key,value:C_STRING
			mc_value : POINTER
			int :INTEGER_32
			mrt: MEMCACHE_RETURN_TYPE
			vl,f:NATURAL_32
			nr:NATURAL_32_REF
		do
			create nr.default_create
			create mrt.default_create
			mc := memcached_create
			create host.make ("localhost")

			error := memcached_server_add (mc, host.item, 8000)
			create key.make ("key")
			create value.make ("boca")
			int := memcached_add (mc, key.item, key.bytes_count.as_natural_32, value.item, value.bytes_count.as_natural_32,0,0)


			check int = memcached_success end

			mc_value:=memcached_get (mc, key.item, key.bytes_count.as_natural_32,vl,f,mrt.item)
			check int = memcached_success end
			check (create {STRING}.make_from_c(mc_value)).is_equal ("boca") end
			print (create {STRING}.make_from_c(mc_value))
			memcached_free (mc)

		end

	add_get_delete_keys
		local
			mc,error: POINTER
			host,str_error: C_STRING
			key,value:C_STRING
			mc_value : POINTER
			int :INTEGER_32
			mrt: MEMCACHE_RETURN_TYPE
			vl,f:NATURAL_32
			nr:NATURAL_32_REF
		do
			create nr.default_create
			create mrt.default_create
			mc := memcached_create
			create host.make ("localhost")

			error := memcached_server_add (mc, host.item, 8000)
			create key.make ("key1")
			create value.make ("boca1")
			int := memcached_add (mc, key.item, key.bytes_count.as_natural_32, value.item, value.bytes_count.as_natural_32,0,0)


			check int = memcached_success end

			mc_value:=memcached_get (mc, key.item, key.bytes_count.as_natural_32,vl,f,mrt.item)
			check int = memcached_success end
			check (create {STRING}.make_from_c(mc_value)).is_equal ("boca1") end
			print (create {STRING}.make_from_c(mc_value))

			int := memcached_delete (mc, key.item, key.bytes_count.as_natural_32, 0)
			check int = memcached_success end

			memcached_free (mc)

		end
end
