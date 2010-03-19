note
	description: "{ENUM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class ENUM

feature -- Access
	is_valid_state: BOOLEAN is
			-- Is the value of the enumeration valid?
		do
			Result := is_valid_value(value)
		end


	value: INTEGER
			-- The current value of the enumeration.

	set_value (a_value: INTEGER) is
		require
         is_valid_value(a_value)
		do
			value:=a_value
		end

	is_valid_value (a_value: INTEGER): BOOLEAN is
			-- Can `a_value' be used in a `set_value' feature call?
		deferred
		end

invariant is_valid_state
end -- class ENUM
