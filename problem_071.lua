-- problem #71
job_time = os.time()

N = 1000000

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

function is_reduced_proper(a, b)
  local len = #primes
  for i = 1, len do
    local prime = primes[i]
    local na, nb = a % prime, b % prime
    if na == 0 then
      if nb == 0 then
        return false
      end
      repeat
        a = a / prime
      until a % prime ~= 0
    end
    if nb == 0 then
      repeat
        b = b / prime
      until b % prime ~= 0
    end

    if a == 1 or b == 1 then
      return true
    end
    if a == b then
      return false
    end
    if prime_hash[a] or prime_hash[b] then
      return true
    end
  end
  assert(false)
end

min_diff = 1
min_d = 0
min_n = 0

for n = N, 1, -1 do
  -- we should be close to n/d == 3/7
  local d_min = math.floor(n * 7 / 3 - 1)
  --assert(n / d_min > 3 / 7)
  for d = d_min, N do
    if is_reduced_proper(n, d) then
      local diff = 3 / 7 - n / d
      if diff > 0 then
        if diff < min_diff then
          min_n = n
          min_d = d
          min_diff = diff
          print("!", n, d, n/d, diff)
        end
        break
      end
    end
  end
end

print("problem #71", "the numerator:" , min_n, min_n == 428570)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
