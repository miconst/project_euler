-- problem #32
local job_time = os.time()

the_sum = 0
products = {}

function to_digit(t, a, b)
  local digit = 0
  for i = a, b do
    digit = digit + t[i] * 10 ^ (i - a)
  end
  return digit
end

function get_valid_products(pandigitals)
  local digit = to_digit(pandigitals, 1, 9)
  for i = 1, 4 do
    local multiplicand = math.modf(digit / 10 ^ (    1 - 1)) % 10 ^ (i - 0)
    for j = i + 1, 5 do
      local multiplier, product =
--~         to_digit(pandigitals, 1, i), to_digit(pandigitals, i + 1, j), to_digit(pandigitals, j + 1, 9)
        math.modf(digit / 10 ^ (i + 1 - 1)) % 10 ^ (j - i),
        math.modf(digit / 10 ^ (j + 1 - 1)) % 10 ^ (9 - j)
      if multiplicand * multiplier == product then
        products[product] = string.format("%d X %d", multiplicand, multiplier)
        print(product, "=", products[product])
      end
    end
  end
end

function reverse(t, first, last)
  local mid = (first + last) / 2
  for i = first, mid do
    local j = last + first - i
    t[i], t[j] = t[j], t[i]
  end
end

function next_permutation(t)
  -- permute and test for pure ascending
  local _Last = #t
  local _Next = _Last
  while _Next > 1 do
    -- find rightmost element smaller than successor
    local _Next1 = _Next
    _Next = _Next - 1
    if t[_Next] < t[_Next1] then
      -- swap with rightmost element that's smaller, flip suffix
      local _Mid = _Last
      while t[_Next] >= t[_Mid] do
        _Mid = _Mid - 1
      end
      t[_Next], t[_Mid] = t[_Mid], t[_Next]
      reverse(t, _Next1, _Last)
      return true
    end
  end
  -- pure descending, flip all
  reverse(t, 1, _Last)
end

function shallow_copy(t)
  local n = {}
  for k, v in pairs(t) do
    n[k] = v
  end
  return n
end

function try_permutations(mask, length, exclusive, try_func)
--~   local perms = {}
  local function permutate(perm, used)
    if #perm == length then
      --table.insert(perms, perm)
      try_func(perm)
    else
      for _, c in pairs(mask) do
        if not exclusive or not used[c] then
          local p = shallow_copy(perm)
          local u = shallow_copy(used)
          table.insert(p, c)
          u[c] = true
          permutate(p, u)
        end
      end
    end
  end

  permutate({}, {})
  --print(unpack(perms[1]))
--~   return perms
end

--try_permutations({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, 9, true, get_valid_products)

local t = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
get_valid_products(t)
while next_permutation(t) do
  get_valid_products(t)
end

for k, v in pairs(products) do
  the_sum = the_sum + k
end

print("problem #32", "the sum of all products:", the_sum, the_sum == 45228)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
