-- problem #37
local job_time = os.time()

primes = {}
prime_hash = {}

function is_prime(number)
  if number < 2 then
    return false
  end

  if prime_hash[number] then
    return true
  end

  local n, prime_max = number, math.sqrt(number)
  for _, prime in ipairs(primes) do
    if n % prime == 0 then
      repeat
        n = n / prime
      until n % prime ~= 0

      if n == 1 then
        return false
      elseif prime_hash[n] then
        return false
      end
    elseif n == number and prime_max < prime then
      break
    end
  end

  assert(n == number)
  assert(prime_hash[number] == nil)

  table.insert(primes, number)
  prime_hash[number] = true
  return true
end

local function get_children(n)
  local children = {}
  local r = 10
  while r < n do
    children[n % r] = true
    children[math.floor(n / r)] = true
    r = r * 10
  end
  return children
end

local function is_interesting_prime(n)
  if is_prime(n) and n > 10 then
    for k in pairs(get_children(n)) do
      if not is_prime(k) then
        return
      end
    end
    return true
  end
end

is_prime(2)

local i, n, sum = 0, 3, 0
while i < 11 do
  if is_interesting_prime(n) then
    sum = sum + n
    i = i + 1
    print(i, n)
  end
  n = n + 2
end

print("problem #37", "the sum of all palindromic numbers:" , sum, sum == 748317)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
