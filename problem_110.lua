-- problem #110
job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(200)
------------------------------------------------------------------------------

-- local helpers
function is_prime(number)
  if number > 3 then
    if number % 2 == 0 or number % 3 == 0 then
      return false
    end
    -- all primes are of the form 6k - 1
    local i_max = math.sqrt(number)  --number - 1
    for i = 5, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
    for i = 7, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
  end
  return true
end

local function get_next_prime(i)
  i = i + 1
  local _, a = math.modf(i / 2)
  if a == 0 then
    i = i + 1
  end

  while not is_prime(i) do
    i = i + 2
  end
  return i
end

--
-- for more info see http://en.wikipedia.org/wiki/Divisor_function#Properties
--

-- 1.
-- (x + 1) / 2 > DS => x > 2 * DS - 1
DS = 4000000 -- distinct solutions
DN = 2 * DS -- number of divisors
min_value = nil

-- 2.
-- power_min == 2 => x = 3^n => 3^n >= DN => n >= log(DN) / log(3)
N = math.ceil(math.log(DN) / math.log(3))
--print(N, 3^N)

-- 3.
-- So we need only N primes/permutations
local primes, permutations = { 2 }, { 2 }
for i = 2, N do
  primes[i] = get_next_prime(primes[i -1])
  permutations[i] = 2
end

print "Primes:"
print(unpack(primes))
print ""

function test_permutation(t)
  --print(unpack(t))
  -- get number of divisors
  local div_num = 1
  for _, n in pairs(t) do
    div_num = div_num * (n + 1)
  end
  --print("#", div_num, (div_num + 1) / 2 > DS )

  -- test the number
  local number = bc.number(1)
  if div_num >= DN then
    for i, n in pairs(t) do
      number = number * (bc.number(primes[i]) ^ (n / 2))
    end
    print(unpack(t))
    print("", "=>", number )
    if not min_value or min_value > number then
      min_value = number
    end
  end
end

function permutate(t, i, n)
  test_permutation(t)
  if i > #t then return end

  local n1 = n
  while n1 > 0 do
    if i > 1 and t[i] >= t[i - 1] then
      break
    end
    t[i] = t[i] + 2
    n1 = n1 - 2
    permutate(t, i + 1, n1)
  end
  t[i] = t[i] - (n - n1)
end

-- 4.
-- permutate
perm_max = 0
permutate(permutations, 1, perm_max)
while #permutations > 1 do
  -- get the last prime
  perm_max = perm_max + math.ceil(math.log(primes[#permutations]))
  if perm_max % 2 ~= 0 then
    perm_max = perm_max + 1
  end
  permutations[#permutations] = nil

  --print "!!!"
  permutate(permutations, 1, perm_max)
end

---
print("problem #110", "the least value of n:" , min_value, tostring(min_value) == "9350130049860600")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
