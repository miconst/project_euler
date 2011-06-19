-- problem #88
job_time = os.time()

NUM_MAX = 12

-- sum_max:
-- a1 + a2 + ... + an = a1 * a2 * ... * an =>
-- an = (a1 + a2 + ...) / (a1 * a2 * ... - 1) =>
-- (a1 * a2 * ... - 1) == 1, (a1 + a2 + ...) == 1 + 1 + ... + 2 = n, an = n
-- sum_max = n + n = 2 * n

local function get_primes(n)
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

primes, prime_hash = get_primes(NUM_MAX * 2)

local function get_divisors(number)
  local divisors = {}
  local i = 1
  while not prime_hash[number] do
    assert(i <= #primes)
    local prime = primes[i]
    if number % prime == 0 then
      number = number / prime
      table.insert(divisors, prime)
    else
      i = i + 1
    end
  end
  table.insert(divisors, number)
  return divisors
end

print(unpack(get_divisors(100)))
do return end

function get_product_sum_number(num)
  local sum_max = num * 2
--~   for m = sum_max - 1, num, -1 do
--~     for _, divs in ipairs(get_divisors(m)) do
--~       local s = num - #divs
--~       for _, n in ipairs(divs) do
--~         s = s + n
--~       end
--~       if s == m then
--~         sum_max = s
--~       end
--~     end
--~   end

  local t = {}
  local function permutate(pos, sum)
    if pos > num then
      local s, m = 0, 1
      for k, v in pairs(t) do
        s = s + v
        m = m * v
      end
      if s == m and s < sum_max then
        sum_max = s
        print(num, s, num * 2 - s, ":", unpack(t))
      end
    else
      local i_max = sum_max - sum - (num - pos) - 1
      if pos > 1 then
        i_max = math.min(i_max, t[pos - 1])
      end
      for i = 1, i_max do
        t[pos] = i
        permutate(pos + 1, sum + i)
      end
    end
  end
  permutate(1, 0)

  return sum_max
end

get_product_sum_number(10)
do return end

s = {}
for n = 2, NUM_MAX do
  local k = get_product_sum_number(n)
  s[k] = true
  print(n, ":", k)
end
sum = 0
for k, v in pairs(s) do
  sum = sum + k
end

---
print("problem #88", "the sum of all the minimal product-sum numbers:" , sum, sum ==  259679)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
