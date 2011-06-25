-- problem #73
job_time = os.time()

D_MAX = 12000
count = 0

function get_primes(n)
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

primes, prime_hash = get_primes(D_MAX)

function get_divisors(number)
  local divisors = {}
  local i = 1
  while not prime_hash[number] do
    assert(i <= #primes)
    local prime = primes[i]
    if number % prime == 0 then
      number = number / prime
      divisors[prime] = true
    else
      i = i + 1
    end
  end
  divisors[number] = true
  return divisors
end

-- is reduced proper fraction
function is_rpf(n, d)
  for k in pairs(get_divisors(n)) do
    if d % k == 0 then
      return false
    end
  end
  return true
end

for d = 2, D_MAX do
  local t = {}
  for n = 1, d - 1 do
    if d < 3 * n and 2 * n < d and d % n ~= 0 then
      t[n] = true
      count = count + 1
    end
  end
  for k in pairs(get_divisors(d)) do
    for n = k, d - 1, k do
      if t[n] then
        t[n] = nil
        count = count - 1
      end
    end
  end
end

print("problem #73", "fractions lie between 1/3 and 1/2:", count, count == 7295372)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
