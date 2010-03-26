note
	description: "[
		Eiffel tests that can be executed by testing tool.
	]"
	author: "EiffelStudio test wizard"
	date: "$Date$"
	revision: "$Revision$"
	testing: "type/manual"

class
	TEST_MEMCACHE

inherit
	EQA_TEST_SET
		redefine
			on_prepare
		end

feature {NONE} -- Events

	on_prepare
			-- <Precursor>
		do
			create memcache
			memcache.add_server (host1, port1)
			memcache.flush
		end

feature -- Test Add Values

	test_memcache_add
		do
			memcache.add ("hola", "valor")
			assert ("Expected value: valor", (memcache.get ("hola")).is_equal ("valor"))
		end


	test_memcached_set
		do
			memcache.add ("hola", "valor")
			assert ("Expected value: valor", (memcache.get ("hola")).is_equal ("valor"))

			memcache.set ("hola", "nuevo valor")
			assert ("Expected value: nuevo valor", (memcache.get ("hola")).is_equal ("nuevo valor"))
		end

feature -- Test Get Values
	test_memcached_get_key_does_not_exist
		do
			assert ("Expected value: void", (memcache.get ("key"))=Void)
		end


feature -- Delete values
	test_memcached_delete
		do
			memcache.add ("hola", "valor")
			assert ("Expected value: valor", (memcache.get ("hola")).is_equal ("valor"))
			memcache.delete ("hola")
			assert ("Expected value: void", (memcache.get ("hola"))=Void)
		end


	test_memcached_delete_key_does_not_exist
		do
			memcache.delete ("hola")
			-- Maybe memcache status should be accesible, last_status?
		end


feature -- Implementation
	memcache : MEMCACHE
	port1 : NATURAL_32 is 11211
	host1: STRING is "localhost"

	port2: 	INTEGER is 2000
	host2: STRING is "noexisto"

end


