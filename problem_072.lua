-- problem #72
job_time = os.time()

-- http://oeis.org/A015614
-- a(n) = Sum( euler_phi(i), i=1..n) - 1

D_MAX = 10^6

-- The General formula for Euler's Totient Function is:
-- euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
-- Where p1, p2, p3, . . . , pn are prime factors of m.

primes = {}
prime_hash = {}
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

count = 0
for n = 2, D_MAX do
  count = count + euler_phi(n)
end

print("problem #72", "number of elements that contain in the set of reduced proper fractions:", count, count == 303963552391)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
