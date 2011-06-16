
-------------------------------------------------------------------------------
-- mathematical library
-------------------------------------------------------------------------------

--- shift logical left

function math.shl(value, shift)
  return (value * (2 ^ shift)) % (2 ^ 32)
end

--- shift logical right

function math.shr(value, shift)
  return math.floor(value / (2 ^ shift)) % (2 ^ 32)
end

--- single bit test

function math.is_bit(value, shift)
  return math.shr(value, shift) % 2 == 1
end

--- invert each bit (not)

function math.invert(x)
  local result = 0
  for p = 0, 31 do
    if not math.is_bit(x, p) then
      result = result + (2 ^ p)
    end
  end
  return result
end

--- logical and

function math.land(x, y)
  local result = 0
  for p = 0, 31 do
    if math.is_bit(x, p) and math.is_bit(y, p) then
      result = result + (2 ^ p)
    end
  end
  return result
end

--- logical or

function math.lor(x, y)
  local result = 0
  for p = 0, 31 do
    if math.is_bit(x, p) or math.is_bit(y, p) then
      result = result + (2 ^ p)
    end
  end
  return result
end

--- logical exclusive or

function math.xor(x, y)
  local result = 0
  for p = 0, 31 do
    if math.is_bit(x, p) ~= math.is_bit(y, p) then
      result = result + (2 ^ p)
    end
  end
  return result
end
-------------------------------------------------------------------------------


-- problem #59
local job_time = os.time()

local a = {}
for n in assert(io.open(arg[1] or "cipher1.txt")):read("*all"):gmatch("(%d+)") do
  table.insert(a, tonumber(n))
end

-- the encryption key consists of three lower case characters
local first, last = string.byte("a", 1), string.byte("z", 1)

local ra, rb, rc = {}, {}, {}

for i = first, last do
  local ta, tb, tc = {}, {}, {}
  for j = 1, #a, 3 do
    table.insert(ta, string.char(math.xor(a[j], i)))
	if j + 1 <= #a then
	  table.insert(tb, string.char(math.xor(a[j + 1], i)))
	end
	if j + 2 <= #a then
	  table.insert(tc, string.char(math.xor(a[j + 2], i)))
	end
  end

  if table.concat(ta):find "^[%w%s%p]+$" then
    --print(string.char(i), table.concat(ta))
	ra[i] = ta
  end

  if table.concat(tb):find "^[%w%s%p]+$" then
    --print(string.char(i), tb)
	rb[i] = tb
  end

  if table.concat(tc):find "^[%w%s%p]+$" then
    --print(string.char(i), tc)
	rc[i] = tc
  end
end


function concat(a, b, c)
  local s, sum = "", 0
  for i = 1, #a do
    s = s .. a[i] .. (b[i] or "") .. (c[i] or "")
	sum = sum + a[i]:byte(1) + (b[i] and b[i]:byte(1) or 0) + (c[i] and c[i]:byte(1) or 0)
  end
  return s, sum
end

local dictionary = {
  "beginning",
  "already",
  "with",
  "there",
  "nothing",
  "that",
  "this",
  "life",
  "through",
  "never",
  "everyone",
  "about",
  "light",
  "himself",
  "going",
  "world",
  "although",
  "children",
}

function is_readable(s)
  for w in s:gmatch "(%S+)" do
    if #w > 50 then
      --print("String is too long!")
      return false
    end
  end
  for _, w in ipairs(dictionary) do
    if s:find("[%s%p]" .. w .. "[%s%p]") then
      return true
    end
  end
  return false
end

for ca, a in pairs(ra) do
  for cb, b in pairs(rb) do
    for cc, c in pairs(rc) do
	  local s = concat(a, b, c)
	  if is_readable(s) then
		print(ca, cb, cc, s)
	  end
	end
  end
end

text, sum = concat(ra[103], rb[111], rc[100])
--print(#text, text:sub(1200))

print("problem #59", "sum of the ASCII values:" , sum, sum == 107359)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
