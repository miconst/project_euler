-- problem #88
job_time = os.time()

function reverse(t, first, last)
  local mid = (first + last) / 2
  for i = first, mid do
    local j = last + first - i
    t[i], t[j] = t[j], t[i]
  end
end

function next_permutation(t)
  -- permute and test for pure ascending
  local last = #t
  local left = last
  while left > 1 do
    -- find rightmost element smaller than successor
    local right = left
    left = left - 1
    if t[left] < t[right] then
      -- swap with rightmost element that's smaller, flip suffix
      local mid = last
      while t[left] >= t[mid] do
        mid = mid - 1
      end
      t[left], t[mid] = t[mid], t[left]
      reverse(t, right, last)
      return true
    end
  end
  -- pure descending, flip all
  reverse(t, 1, last)
end

function f(m, n)
  local i, s = 1, n - 1
  while m > s do
    i = i + 1
    m = m - s
    s = s - 1
  end
  return i, m + i
end

function set_edge()
  local count = 0
  for i = 1, 10 do
    for j = i + 1, 10 do
      count = count + 1
      local x, y = f(count, 10)
      assert(x == i)
      assert(y == j)
      print(i, j)
    end
    print ""
  end
end

NUM_MAX = 12000

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

--print(unpack(get_divisors(100)))

num_max = 0

function get_product_sum_number(num)
  local sum_max = num * 2
--  for m = sum_max - 1, num, -1 do
    divs  = get_divisors(sum_max - 1)
    if #divs > num_max then
      num_max = #divs
      print(unpack(divs))
    end
    --print(unpack(divs))
--~       if s == m then
--~         sum_max = s
--~       end
--  end

--~   local t = {}
--~   local function permutate(pos, sum)
--~     if pos > num then
--~       local s, m = 0, 1
--~       for k, v in pairs(t) do
--~         s = s + v
--~         m = m * v
--~       end
--~       if s == m and s < sum_max then
--~         sum_max = s
--~         print(num, s, num * 2 - s, ":", unpack(t))
--~       end
--~     else
--~       local i_max = sum_max - sum - (num - pos) - 1
--~       if pos > 1 then
--~         i_max = math.min(i_max, t[pos - 1])
--~       end
--~       for i = 1, i_max do
--~         t[pos] = i
--~         permutate(pos + 1, sum + i)
--~       end
--~     end
--~   end
--~   permutate(1, 0)

  return sum_max
end

function get_all_divisors(number)
  local divs = get_divisors(number)
  local div_hash = {}
  div_hash[table.concat(divs, "*")] = divs
  repeat
    for mask = 1, 2^(#divs - 1) - 1 do
      local t = {}
      local i = 1
      while i <= #divs do
        local n = divs[i]
        while mask % (2 ^ i) >= (2 ^ (i - 1)) do
          i = i + 1
          n = n * divs[i]
        end
        i = i + 1
        table.insert(t, n)
      end
      table.sort(t)
      div_hash[table.concat(t, "*")] = t
    end
  until not next_permutation(divs)

  return div_hash
end

for k in pairs(get_all_divisors(50)) do
  print(k)
end
do return end

--get_product_sum_number(10)
count = 0
for n = 4, NUM_MAX * 2 do
  local divs = get_all_divisors(n)
--~   if #divs > num_max then
--~     num_max = #divs
--~     print(num_max, n, ":", unpack(divs))
--~   end
--~   repeat
--~     --print(unpack(t))
--~     for i = 1, 2^(#divs - 1) - 1 do
--~       count = count + 1
--~     end
--~   until not next_permutation(divs)
end
do return end

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

print(num_max)
---
print("problem #88", "the sum of all the minimal product-sum numbers:" , sum, sum ==  259679)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
