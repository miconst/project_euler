local key_a = arg[1] or "test"
local key_b = arg[2] or "test"
local key_c = arg[3] or "test"

local a = { 1, 2, 3 }
local b = { 4, 6, unpack(a) }

--print(unpack(b))

test = "test/a\\b"
_, _, d, f = test:find "^(.-)[/\\]?([^/^\\]*)$"
print("." .. d .. ".")
print("." .. f .. ".")
