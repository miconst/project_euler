-- problem # 130

job_time = os.time()

local function get_primes(n)
  local primes, hash = {}, {}
  -- generate a list of integers from 2 to N
  for i = 2, n do
    hash[i] = true
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if hash[i] then
      table.insert(primes, i)
      for j = i + i, n, i do
        hash[j] = nil
      end
    end
  end

  return primes, hash
end

primes, prime_hash = get_primes(100000)

local function get_divisors(number)
  local divisors = { [1] = true, [number] = true }

  if prime_hash[number] then
    return divisors
  end

  local len = #primes
  for i = 1, len do
    local prime = primes[i]
    if number % prime == 0 then
      divisors[prime] = true
      for n in pairs(get_divisors(number / prime)) do
        divisors[n] = true
        divisors[n * prime] = true
      end
      break
    end
  end
  return divisors
end

function is_prime(number)
  if number > 3 then
    if number % 2 == 0 or number % 3 == 0 then
      return false
    end
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
  end
  return true
end

-- repunit
function R(n)
  return tonumber(string.rep("1", n))
end

R_10 = { R(1), R(2), R(3), R(4), R(5), R(6), R(7), R(8), R(9), R(10), }

function A(n)
  local divs = {}
  for k in pairs(get_divisors(n - 1)) do
    table.insert(divs, k)
  end
  table.sort(divs)

  for i = 1, #divs do
    local a, k = 0, divs[i]
    while k > 0 do
      local j = math.min(k, 10)
      k = k - j
      a = a * 10 ^ j + R_10[j]
      if a >= n then
        a = a - n * math.floor(a / n)
      end
    end
    if a == 0 then
      return divs[i]
    end
  end
end

-- (p - 1) should be divisible by A(p) and p is not a prime
sum, count = 0, 0
p = 7
while count < 25 do
  if p % 5 ~= 0 then
    -- there always exists a value, k, for which R(k) is divisible by n
    --print(i, A(i))
    if not prime_hash[p] then --- is_prime(p) then
      --io.write("\r", p)
      local A_p = A(p)
      --io.write("\t", A_p)
      --if (p - 1) % A_p == 0 then
      if A_p then
        sum = sum + p
        count = count + 1
        --io.write("\r")
        print(count, ":", p, A_p, sum)
      end
    end
  end
  p = p + 2
end

--io.write("\r")
print("problem #130", "the sum of the first 25 composite values:", sum, sum == 149253)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
