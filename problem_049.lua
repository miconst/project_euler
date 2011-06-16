-- problem #49

local job_time = os.time()

primes = {}
prime_hash = {}

function is_prime(number)
  local n, prime_max = number, math.sqrt(number)
  for _, prime in ipairs(primes) do
    if n % prime == 0 then
      repeat
        n = n / prime
      until n % prime ~= 0

      if n == 1 then
        --print("-", n, number)
        return false
      elseif prime_hash[n] then
        --print("$", n, number)
        return false
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
  return true
end

local mask = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

function get_permutation(number)
  local s, r = tostring(number), ""
  for _, n in ipairs(mask) do
    for _ in s:gmatch(n) do
        r = r .. n
    end
  end
  return r
end

permutations = {}

for i = 2, 9999 do
  if is_prime(i) and i >= 1000 then
    local key = get_permutation(i)
    if not permutations[key] then
      permutations[key] = {}
    end
    table.insert(permutations[key], i)
  end
end

for k, v in pairs(permutations) do
  local l = #v
  if l == 3 then
    if v[3] - v[2] == v[2] - v[1] then
      print "APOJ"
    end
  elseif l > 3  then
    print(unpack(v))
    local t = {}
    for i = 1, l - 1 do
      for j = i + 1, l do
        local d = v[j] - v[i]
        --print("!", d)
        if not t[d] then
          t[d] = {}
        end
        table.insert(t[d], { v[i], v[j] })
        --t[d] = 1 + (t[d] or 0)
        --if t[d] >= 2 then
        --  print "APOJ!"
        --end
      end
    end
    for a, b in pairs(t) do
      if #b == 2 and b[1][2] == b[2][1] then
        print("!", a, b[1][1], b[1][2], b[2][1], b[2][2])
      end
    end
  end
end

print("problem #49", "12-digit number:", sequence_a, sequence_b, sequence == 296962999629)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
