-- problem #108
job_time = os.time()

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

-- 1.
-- (x + 1) / 2 > DS => x > 2 * DS - 1
DS = 1000 -- distinct solutions
DN = 2 * DS -- number of divisors

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
  local number = 1
  if div_num >= DN then
    for i, n in pairs(t) do
      number = number * primes[i] ^ (n / 2)
    end
    print(unpack(t))
    print("", "=>", number )
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
  if perm_max / 2 ~= math.floor(perm_max / 2) then
    perm_max = perm_max + 1
  end
  permutations[#permutations] = nil

  print "!!!"
  permutate(permutations, 1, perm_max)
end
----
do return end
----
function get_square_divisors_num(n)
  local dn = 1
--  local n_2 = n * n
  for p = 2, n do
    local pn = 1
    while true do
      local a, b = math.modf(n / p)
      if b ~= 0 then
        break
      end
      pn = pn + 2
      n = a
    end
    dn = dn * pn
    if n <= 1 then
      break
    end
  end
  return dn
end

--n = 1260 -- 180180
n = 2
while true do
--  solutions = 1
--  local n_2 = n * n
--  for i = 2, n do
--    --local x = i + n
--    local j, f = math.modf(n_2 / i)
--    if f == 0 then
--      solutions = solutions + 1
--      --local y = j + n
--      --print( solutions, ":", x, y )
--    end
--  end
--  print( n, ":", solutions, ( get_square_divisors_num(n) + 1 ) / 2 )
  solutions = ( get_square_divisors_num(n) + 1 ) / 2
  if solutions > 100 then
    break
  else
    n = n + 2
  end
end

print("problem #108", "the least value of n:" , n, n == 180180)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
