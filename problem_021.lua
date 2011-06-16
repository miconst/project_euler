-- problem #21
local job_time = os.time()

-- Sieve of Eratosthenes
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

local N = 10000
local primes, prime_hash = get_primes(N)

-- sum of proper divisors of n
local function proper_divisors_sum(n)
  local sum = 0
  for i = 1, n / 2 do
    local x = n / i
    if math.floor(x) == x then
      sum = sum + i
    end
  end
  return sum
end

local pd_sums = {}
for i = 1, N - 1 do
  pd_sums[i] = proper_divisors_sum(i)
end

local total = 0
for i = 1, N - 1 do
  local j = pd_sums[i]
  if i ~= j and i == pd_sums[j] then
    total = total + i
  end
end


print("problem #21", "the sum of all the amicable numbers:", total, total == 31626)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
