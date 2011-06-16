-- problem #94
job_time = os.time()

function triangle_area_square(a, b_half)
  local area = b_half * b_half *((a + b_half) * (a - b_half))
  return area
end

perimeter_max = 1000000000

sqrt_table = {}

a_max = perimeter_max / 3

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

primes, prime_hash = get_primes(20000000)

--sqrt_max = triangle_area_square(a_max, (a_max + 1) / 2)
--print(triangle_area_square(a_max, (a_max + 1) / 2))

function triangle_area(a, b)
  local b_half = b / 2
  local area = b_half * math.sqrt((a + b_half) * (a - b_half))
  print(b_half, (a + b_half), (a - b_half))
  return area
end

function is_triangle_area_integral(a, b)
  local b_half = b / 2
  local l, r = a + b_half, a - b_half

  local area = math.sqrt(l * r)
  if math.floor(area) == area then
    return true
  else
    return false
  end
end

function get_divisors(number)
  local len = #primes
  local d = {}
  for i = 1, len do
    local prime = primes[i]
    if number % prime == 0 then
      d[prime] = 0
      repeat
        number = number / prime
        d[prime] = d[prime] + 1
      until number % prime ~= 0

      if number == 1 then
        break
      elseif prime_hash[number] then
        d[number] = 1
        number = 1
        break
      end
    end
  end
  if number ~= 1 then
    assert(number > primes[#primes])
    print("found number", number)
    d[number] = 1
  end
  return d
end

function is_triangle_area_integral_slow(a, b)
  local b_half = b / 2
  local l, r = a + b_half, a - b_half

  --local area = math.sqrt(l * r)
  local ld, rd = get_divisors(l), get_divisors(r)
  for k, v in pairs(ld) do
    rd[k] = v + (rd[k] or  0)
  end

  for k, v in pairs(rd) do
    if v % 2 ~= 0 then
      return false
    end
  end
  return true
end

perimeter_sum = 0
for a = 3, a_max, 2 do
  local b = a - 1
  if is_triangle_area_integral(a, b) then
    local s = triangle_area(a, b)
    print("Found A", a, b, s)
    if is_triangle_area_integral_slow(a, b) then
      perimeter_sum = perimeter_sum + a + a + b
    else
      print("Invalid!")
    end
  end
  local b = a + 1
  if is_triangle_area_integral(a, b) then
    local s = triangle_area(a, b)
    print("Found B", a, b, s)
    if is_triangle_area_integral_slow(a, b) then
      perimeter_sum = perimeter_sum + a + a + b
    else
      print("Invalid!")
    end
  end
end

print("problem #94", "the first ten digits:" , perimeter_sum, perimeter_sum == 518408346)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
