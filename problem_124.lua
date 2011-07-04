-- problem #124
job_time = os.time()

N_MAX = 100000

function get_radicals(n)
  local hash, radicals = {}, { 1 }
  -- generate a list of integers from 2 to N
  for i = 2, n do
    hash[i] = true
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if hash[i] then
      radicals[i] = i
      for j = i + i, n, i do
        hash[j] = nil
        radicals[j] = (radicals[j] or 1) * i
      end
    end
  end
  return radicals
end

--~ print(unpack(get_radicals(10)))
radicals = get_radicals(N_MAX)
E = { 1 }
for n = 2, N_MAX do
  E[n] = n
end
table.sort(E, function(a, b) return radicals[a] < radicals[b] end)

-- without sorting:
--[==[

primes, divisor_hash = {}, {}

function get_divisors(number)
  local divisors = divisor_hash[number]
  if divisors then
    return divisors
  else
    divisors = {}
    divisor_hash[number] = divisors
  end

  for i = 1, #primes do
    local prime = primes[i]
    if number % prime == 0 then
      divisors[prime] = true
      for n in pairs(get_divisors(number / prime)) do
        if not divisors[n] then
          divisors[n] = true
          prime = prime * n
        end
      end
      return divisors, prime
    end
  end

  -- ok, it's a prime, add it.
  primes[#primes + 1] = number
  divisors[number] = true
  return divisors, number
end

t = {}
for n = 2, N_MAX do
  t[n] = {}
  local d, x = get_divisors(n)
  table.insert(t[x], n)
end

E = { 1 }
for n = 2, N_MAX do
  for _, i in ipairs(t[n]) do
    table.insert(E, i)
  end
end

]==]--

print("problem #124", "E(10000):", E[10000], E[10000] == 21417)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
