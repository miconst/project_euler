-- problem #87
job_time = os.time()

NUM_MAX = 50000000
PRIME_MAX_2 = math.floor(NUM_MAX^(1/2)) + 1
PRIME_MAX_3 = math.floor(NUM_MAX^(1/3)) + 1
PRIME_MAX_4 = math.floor(NUM_MAX^(1/4)) + 1

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

primes, prime_hash = get_primes(PRIME_MAX_2)

a_max, b_max = 0, 0
for i = 1, #primes do
  if primes[i] >= PRIME_MAX_4 then
    a_max = i
    break
  end
end
for i = 1, #primes do
  if primes[i] >= PRIME_MAX_3 then
    b_max = i
    break
  end
end

numbers = {}
for a = 1, a_max do
  for b = 1, b_max do
    for c = 1, #primes do
      local n = primes[a]^4 + primes[b]^3 + primes[c]^2
      if n < NUM_MAX then
        numbers[n] = true
        --print(n, primes[a], primes[b], primes[c])
      end
    end
  end
end

count = 0
for k in pairs(numbers) do
  count = count + 1
end

---
print("problem #87", "numbers that can be expressed as the sum of a prime^2, prime^3, and prime^4:" , count, count ==  1097343)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
