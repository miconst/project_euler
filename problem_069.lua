-- problem #60
local job_time = os.time()

primes = {}
prime_hash = {}

-- The General formula for Euler's Totient Function is:
-- euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
-- Where p1, p2, p3, . . . , pn are prime factors of m.

function euler_phi(number)
  local phi, n, prime_max = number, number, math.sqrt(number)
  for _, prime in ipairs(primes) do
    if n % prime == 0 then
      repeat
        n = n / prime
      until n % prime ~= 0

      phi = phi * (1 - 1 / prime)
      if n == 1 then
        --print("-", n, number)
        return math.floor(phi + 0.5), false
      elseif prime_hash[n] then
        --print("$", n, number)
        phi = phi * (1 - 1 / n)
        return math.floor(phi + 0.5), false
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
  return number - 1, true
end

-- Find the value of n <= 1000000 for which n/euler_phi(n) is a maximum.
local ratio = 0
for i = 2, 1000000 do
  local phi, prime = euler_phi(i)

  if not prime then
    local a = i / phi
    if a > ratio then
      print("-", i, phi, a)
      ratio = a
      value = i
    end
  end
end

print("problem #69", "value of n:", value, value == 510510)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
