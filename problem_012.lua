-- problem #12
local job_time = os.time()
local triangle_number, next_number = 1, 2

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

primes, prime_hash = get_primes(math.floor(math.sqrt(76576500)) + 2)
divisors_hash = {}

local function get_divisors(number)
  if divisors_hash[number] then
    return divisors_hash[number]
  end

  local divisors = { [1] = true, [number] = true }

  if prime_hash[number] then
    return divisors
  end

  local len = #primes
  for i = 1, len do
    local prime = primes[i]
    if number % prime == 0 then
      divisors[prime] = true
      for n in pairs(get_divisors(number / prime)) do
        divisors[n] = true
        divisors[n * prime] = true
      end
      break
    end
  end
  return divisors
end

while true do
--~   print(triangle_number)
  local divisors = get_divisors(triangle_number)
  local count = 0
  for _ in pairs(divisors) do
    count = count + 1
  end

  if count > 500 then
--~     local t = {}
--~     for k in pairs(divisors) do
--~       table.insert(t, k)
--~     end
--~     table.sort(t)
--~     print("!", triangle_number)
--~     print("*", unpack(t))
--~     print("=", count)
    break
  end
  triangle_number = triangle_number + next_number
  next_number = next_number + 1
end


print("problem #12", "the value of the first triangle number:", triangle_number, triangle_number == 76576500)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
