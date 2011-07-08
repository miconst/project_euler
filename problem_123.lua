-- problem #123
job_time = os.time()

REMAINDER_MAX = 10^10

function get_primes(n)
  local hash, primes = {}, {}
  -- generate a list of integers from 2 to N
  for i = 2, n do
    hash[i] = i
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if hash[i] then
      table.insert(primes, i)
      for j = i + i, n, i do
        if hash[j] then
          hash[j] = nil
        end
      end
    end
  end
  return primes
end

primes = get_primes(25 * 10^4)

function pow_mod(n, k, m)
  local x = n
  for i = 2, k do
    x = x * n
    while x > m do
      x = x - m
    end
  end
  return x
end

n_min = 0
for i = 1, #primes do
  local prime = primes[i]
--~   local a1 = pow_mod(prime + 1, i, prime^2)
  local b1 = (prime * i + 1) % prime^2
--~   assert(a1 == b1)
--~   local a2 = pow_mod(prime - 1, i, prime^2)
  local b2 = (prime * i - 1) % prime^2
  if i % 2 == 0 then
    b2 = prime^2 - b2
  end
--~   assert(a2 == b2, tostring(i)..":"..tostring(a).."-"..tostring(b))
  local a = (b1 + b2) % prime^2
  if a > REMAINDER_MAX then
--~     print(i, prime, a, prime^2)
    n = i
    break
  end
end

print("problem #123", "the least value of n for which the remainder first exceeds 10^10:", n, n == 21035)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
