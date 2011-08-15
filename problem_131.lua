-- problem #191
job_time = os.time()

N = 10^6

-- http://mathworld.wolfram.com/CubanPrime.html

-- n*n*n + n*n*p = m*m*m
-- n = a*a*a
-- m = a*a*(a + 1)
-- p = 3*a*a + 3*a + 1


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

primes, prime_hash = get_primes(N)

count = 0
a = 1

prime_max = primes[#primes]

while true do
  local p = 3 * a^2 + 3 * a + 1
  if prime_hash[p] then
    count = count + 1
  elseif p > prime_max then
    break
  end
  a = a + 1
end

print("problem #131", 'the number of primes below one million:', count, count == 173)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
