note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MEMCACHE_API

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end
	MEMCACHE_API
		undefine default_create
		end


feature {NONE} -- Events
	on_prepare
		local
		lhost_2: C_STRING
		do
			create mrt.default_create
			mc := memcached_create
			create lhost_2.make (host_2)
			memcached_return := memcached_server_add (mc, lhost_2.item, port_2)
			memcached_return := memcached_flush (mc, 0)
			assert ("Expected Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end

feature -- Test Memcached Connect Server

	test_connect_server_success
			-- New test routine
		local
			lhost_1: C_STRING
		do
			create lhost_1.make (host_1)
			memcached_return := memcached_server_add (mc, lhost_1.item, port_1)
			assert ("Expected Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end

	test_current_number_of_servers
			-- memcached_server_count() provides you a count of the current number of servers being used by a memcached_st structure.
		local
			ln : NATURAL_32
		do
			ln := memcached_server_count (mc)
			assert ("Expected 1 Server :", + ln = 1)
		end

feature -- Test Memcached ADD, SET, REPLACE, INCREMENT
	test_memcache_add
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end

	test_memcache_add_the_same_key_not_stored
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

			create lkey.make ("lkey")
			create lvalue.make ("lnewvalue")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Failure :" + mrt.memcached_notstored.out ,mrt.memcached_notstored = memcached_return)
		end

	test_memcache_set
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end

	test_memcache_set_the_same_key
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Set Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

			create lkey.make ("lkey")
			create lvalue.make ("lnewvalue")
			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Set Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end


	test_memcache_replace
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Set Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

			create lkey.make ("lkey")
			create lvalue.make ("lnewvalue")
			memcached_return := memcached_replace (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Replace Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end

	test_memcache_replace_key_does_not_exist
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lnewvalue")
			memcached_return := memcached_replace (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Replace NOT_STORED :" + mrt.memcached_notstored.out ,mrt.memcached_notstored = memcached_return)
		end

	test_memcache_add_key_to_big
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
			l: STRING
		do
			l := "[
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			]"

			create lkey.make (l)
			create lvalue.make ("lvalue")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Key To Long :" + mrt.memcached_bad_key_provided.out ,mrt.memcached_bad_key_provided = memcached_return)
		end


	test_memcache_increment
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
			error : C_STRING
			lreturn : POINTER
			str : STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("10")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

            memcached_return := memcached_increment (mc, lkey.item, lkey.bytes_count.as_natural_32, 1, lvalue.item)
			assert ("Expected Increment Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
			create error.make_empty (mrt.structure_size)

			lreturn := memcached_get (mc, lkey.item,lkey.bytes_count.as_natural_32,0,0, error.item)
			create str.make_from_c(lreturn)
			assert ("Expected Value 11 :" , str.to_integer = 11)
		end


test_memcache_decrement
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
			error : C_STRING
			lreturn : POINTER
			str : STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("10")
			memcached_return := memcached_add (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Add Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

            memcached_return := memcached_decrement (mc, lkey.item, lkey.bytes_count.as_natural_32, 1, lvalue.item)
			assert ("Expected Decrement Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
			create error.make_empty (mrt.structure_size)

			lreturn := memcached_get (mc, lkey.item,lkey.bytes_count.as_natural_32,0,0, error.item)
			create str.make_from_c(lreturn)
			assert ("Expected Value 9 :" , str.to_integer = 9)
		end

feature -- Test Memcached GET

	test_memcache_get
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
			error : C_STRING
			lreturn : POINTER
			a_value_length:NATURAL_32; a_flag:NATURAL_32
			s,l: STRING
			c: CHARACTER
		do
			l := "[
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
				xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
			]"
			create lkey.make ("lkey")
			create lvalue.make (l)

			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Set Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

			create error.make_empty (mrt.structure_size)
			create a_value_length.default_create
			create a_flag.default_create

			lreturn := memcached_get (mc, lkey.item, lkey.bytes_count.as_natural_32, a_value_length, a_flag, error.item)
			create lvalue.make_by_pointer (lreturn)
			assert ("Expected Get:lvalue", (lvalue.string).is_equal (l))
		end


	test_memcache_get_key_does_not_exist
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
			error : C_STRING
			lreturn : POINTER
			a_value_length:NATURAL_32; a_flag:NATURAL_32
			c : CHARACTER
			s: STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			create error.make_empty (mrt.structure_size)
			create a_value_length.default_create
			create a_flag.default_create

			lreturn := memcached_get (mc, lkey.item, lkey.bytes_count.as_natural_32, a_value_length, a_flag, error.item)

			assert ("Expected Get:", lreturn = default_pointer)

		end



feature -- Test Memcached DELETE

	test_memcache_delete
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do
			create lkey.make ("lkey")
			create lvalue.make ("lvalue")
			memcached_return := memcached_set (mc, lkey.item, lkey.bytes_count.as_natural_32, lvalue.item, lvalue.bytes_count.as_natural_32,0,0)
            assert ("Expected Set Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)

			create lkey.make ("lkey")

			memcached_return := memcached_delete (mc, lkey.item, lkey.bytes_count.as_natural_32,0)
            assert ("Expected Delete Success :" + mrt.memcached_success.out ,mrt.memcached_success = memcached_return)
		end



	test_memcache_delete_key_does_not_exist
		local
			lhost_1: C_STRING
			lkey : C_STRING
			lvalue : C_STRING
		do

			create lkey.make ("lkey")
			memcached_return := memcached_delete (mc, lkey.item, lkey.bytes_count.as_natural_32,0)
            assert ("Expected Delete Key Not Found :" + mrt.memcached_notfound.out ,mrt.memcached_notfound = memcached_return)
		end

feature {NONE} --implementation
	mc : POINTER
	mrt : MEMCACHE_RETURN_TYPE
	host_1 : STRING is "localhost"
	no_host : STRING is "error"
	port_1 : NATURAL_32 is 8000
	host_2 : STRING is "127.0.0.1"
	port_2 : NATURAL_32 is 11211
	memcached_return : INTEGER_32
end


