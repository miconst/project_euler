-- problem #187
job_time = os.time()

N_MAX = 10^8 - 1 -- 30 - 1

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

primes = get_primes(math.sqrt(N_MAX))
n_sqrt = #primes
count = n_sqrt * (n_sqrt + 1) / 2

function is_prime(number)
  local n_max = math.sqrt(number) + 1
  for i = 1, n_sqrt do
    local prime = primes[i]
    if number % prime == 0 then
      return false
    elseif prime > n_max then
      break
    end
  end
  return true
end

print "making primes..."
for n = primes[n_sqrt] + 2, N_MAX / 2, 2 do
  if is_prime(n) then
    table.insert(primes, n)
  end
end

print "testing..."
for i = 1, n_sqrt do
  local p1 = primes[i]
  for j = n_sqrt + 1, #primes do
    local p2 = primes[j]
    if p1 * p2 > N_MAX then
      break
    else
      count = count + 1
    end
  end
end

print("problem #187", "the number of composite integers, with precisely two, not necessarily distinct, prime factors:", count, count == 17427258)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
