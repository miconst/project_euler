-- problem #41
job_time = os.time()

perm = { "a", "b", "c", "d", "e" }

perms = {}

function add_perm(p)
  if #p == 4 then
    assert(not perms[p])
    perms[p] = true
    return
  end
  for _, s in pairs(perm) do
    if not p:find(s) then
      add_perm(p .. s)
    end
  end
end

add_perm("")

for k in pairs(perms) do
 -- print("!", k)
end

max_pandigital = 0

function is_prime_fast(number)
  if number % 2 == 0 or number % 3 == 0 or number % 5 == 0 then
    return false
  end
--print(number)
  -- all primes are of the form 6k ± 1
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

  return true
end

function test_pandigital(p)
  if #p == N then
    p = tonumber(p)
    if is_prime_fast(p) and p > max_pandigital then
      max_pandigital = p
      --print("!", max_pandigital)
    end
  else
    for _, n in pairs(PANDIGITAL) do
      if not p:find(n) then
        test_pandigital(p .. n)
      end
    end
  end
end

N = 2
while N < 9 do
  PANDIGITAL = {}
  for i = 1, N do
    PANDIGITAL[i] = tostring(i)
  end
  test_pandigital("")
  N = N + 1
end

function is_pandigital(number)
  number = tostring(number)
  local used = {}
  for i = 1, #number do
    local n = number:byte(i)
    if used[n] then
      return false
    end
    used[n] = true
  end
  return true
end

primes = {}
prime_hash = {}

function is_prime(number)
  local n, prime_max = number, math.sqrt(number)
  for _, prime in ipairs(primes) do
    if n % prime == 0 then
      repeat
        n = n / prime
      until n % prime ~= 0

      if n == 1 then
        --print("-", n, number)
        return false
      elseif prime_hash[n] then
        --print("$", n, number)
        return false
      end
    elseif n == number and prime_max < prime then
      --print("$", number, prime, prime_max)
      break
    end
  end

  assert(n == number)
  assert(prime_hash[number] == nil)

  table.insert(primes, number)
  prime_hash[number] = true
  return true
end

print("problem #41", "the largest n-digit pandigital prime:" , max_pandigital, max_pandigital == 7652413)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
