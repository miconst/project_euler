-- problem #88
job_time = os.time()

NUM_MAX = 12000

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
divisor_hash = {}

local function get_all_divisors(number)
  local divisors = divisor_hash[number]
  if divisors then
    return divisors
  else
    divisors = {}
    divisor_hash[number] = divisors
  end

  local function add(t)
    table.sort(t)
    local k = table.concat(t, "*")
    if not divisors[k] then
      local sum = 0
      for i = 1, #t do
        sum = sum + t[i]
      end
      t.sum = sum
      divisors[k] = t
    end
  end
  if prime_hash[number] then
    add { number }
  else
    for i = 1, #primes do
      local prime = primes[i]
      if number % prime == 0 then
        for _, v in pairs(get_all_divisors(number / prime)) do
          add { prime, unpack(v) }
          local last = 0
          for j = 1, #v do
            if v[j] ~= last then
              last = v[j]
              local t = { unpack(v) }
              t[j] = t[j] * prime
              add(t)
            end
          end
        end
        break
      end
    end
  end
  return divisors
end

-- sum_max:
-- a1 + a2 + ... + an = a1 * a2 * ... * an =>
-- an = (a1 + a2 + ...) / (a1 * a2 * ... - 1) =>
-- (a1 * a2 * ... - 1) == 1, (a1 + a2 + ...) == 1 + 1 + ... + 2 = n, an = n
-- sum_max = n + n = 2 * n

function get_product_sum_number(num)
  local sum_max = num * 2
  for m = num, sum_max - 1 do
    for k, v in pairs(get_all_divisors(m)) do
      local s = v.sum + (num - #v)
      if s == m then
        return s
      end
    end
  end
  return sum_max
end

s = {}
for n = 2, NUM_MAX do
  local k = get_product_sum_number(n)
  s[k] = true
  --print(n, ":", k)
end
sum = 0
for k, v in pairs(s) do
  sum = sum + k
end

---
print("problem #88", "the sum of all the minimal product-sum numbers:" , sum, sum ==  7587457)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
