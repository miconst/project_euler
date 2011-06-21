-- problem #77
job_time = os.time()

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

primes, prime_hash = get_primes(1000)

prime_sum_hash = {}

local function get_all_prime_sums(number)
  local sums = prime_sum_hash[number]
  if sums then
    return sums
  else
    sums = {}
    prime_sum_hash[number] = sums
  end

  local function add(t)
    table.sort(t)
    local k = table.concat(t, "+")
    if not sums[k] then
      sums[k] = t
    end
  end
  if prime_hash[number] then
    add { number }
  end

  for i = 1, #primes do
    local prime = primes[i]
    if prime < number + 1 then
      for _, v in pairs(get_all_prime_sums(number - prime)) do
        add { prime, unpack(v) }
      end
    else
      break
    end
  end
  return sums
end

--~ for k, v in pairs(get_all_prime_sums(10)) do
--~   print(k)
--~ end
--~ do return end

DIFFERENT_WAYS = 5000
number = 10
while true do
  local n = 0
  for k, v in pairs(get_all_prime_sums(number)) do
    n = n + 1
  end
  print(number, n)
  if n > DIFFERENT_WAYS then
    break
  else
    number = number + 1
  end
end

---
print("problem #77", "the number:" , number, number ==  71)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
