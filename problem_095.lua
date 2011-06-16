-- problem #95
local job_time = os.time()

divisors = {}
divisor_sums = {}

function tosum(t)
  local sum = 0
--  local test = {}
  for k in pairs(t) do
    sum = sum + k
--    table.insert(test, k)
  end
--  table.sort(test)
--  print("->", unpack(test))
  return sum
end

function append(dst, src)
  if src then
    for k in pairs(src) do
      dst[k] = true
    end
  end
end

-- Sieve of Eratosthenes
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

primes, prime_hash = get_primes(1000000)

--~ function is_prime_fast(number)
--~   local prime_max = math.sqrt(number)
--~   local len = #primes
--~   for i = 1, len do
--~     local prime = primes[i]
--~     if number % prime == 0 then
--~       return false
--~     elseif prime > prime_max then
--~       break
--~     end
--~   end

--~   assert(prime_hash[number] == nil)
--~   table.insert(primes, number)
--~   prime_hash[number] = true
--~   return true
--~ end

function get_divisors(number)
  local d = {}
  local len = #primes
  for i = 1, len do
    local prime = primes[i]
    if number % prime == 0 then
      table.insert(d, prime)
      repeat
        number = number / prime
      until number % prime ~= 0

      if number == 1 then
        break
      elseif prime_hash[number] then
        table.insert(d, number)
        break
      end
    end
  end
  return d
end

function divisor_sum(number)
--~   if is_prime_fast(number) then
--~     return 1
--~   end
  if prime_hash[number] then
    return 1
  end

  local divs = get_divisors(number)
  local len = #divs
  local sum = {}
  for i = 1, len do
    local prime = divs[i]
    local n = number
    local i = prime
    repeat
      n = n / prime
      sum[i] = true
      sum[n] = true
      i = i * prime
      append(sum, divisors[n])
    until n % prime ~= 0

    if n == 1 or divs[n] then
      sum[n * prime] = true
      break
    end
  end

  sum[1] = true
  sum[number] = nil
  divisors[number] = sum
  divisor_sums[number] = tosum(sum)
  return divisor_sums[number]
end

function divisor_sum_slow(number)
  local sum = 1
  for j = 2, number - 1 do
    local d = number / j
    if d == math.floor(d) then
      sum = sum + d
    end
  end
  return sum
end

for i = 2, 1000000 do
  local a = divisor_sum(i)
--  local b = divisor_sum_slow(i)
--  print(i, a, b)
--  assert(a == b)
end

if true then

divisors = nil
primes = nil
prime_hash = nil

chain = {}
chain_size = 0
for k in pairs(divisor_sums) do
  local seen = { [k] = true }
  local i = 1
  local key = k
  while true do
    local m = divisor_sums[key]
    if not m then
      break
    elseif not seen[m] then
      seen[m] = true
      i = i + 1
      key = m
    else
      if m == k then
        if i > chain_size then
          print("Found a new chain!", i)
          chain = seen
          chain_size = i
          for x in pairs(chain) do
            print("  #", x, "->", divisor_sums[x])
          end
        end
      end
      break
    end
  end
end

min_number = 1000000
for k in pairs(chain) do
  if k < min_number then
    min_number = k
  end
end

end

print("problem #95", "the number:", min_number, min_number == 14316)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
