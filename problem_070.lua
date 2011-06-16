-- problem #70
test = { 1, 1, 2, 2, 4, 2, 6, 4, 6, 4, 10, 4, 12, 6, 8, 8, 16, 6, 18, 8,
 12, 10, 22, 8, 20, 12, 18, 12, 28, 8, 30, 16, 20, 16, 24, 12, 36, 18, 24, 16,
 40, 12, 42, 20, 24, 22, 46, 16, 42, 20, 32, 24, 52, 18, 40, 24, 36, 28, 58, 16,
 60, 30, 36, 32, 48, 20, 66, 32, 44, 24, 70, 24, 72, 36, 40, 36, 60, 24, 78, 32,
 54, 40, 82, 24, 64, 42, 56, 40, 88, 24, 72, 44, 60, 46, 72, 32, 96, 42, 60, 40,
 100, 32, 102, 48, 48, 52, 106, 36, 108, 40, 72, 48, 112, 36, 88, 56, 72, 58, 96,
 32, 110, 60, 80, 60, 100, 36, 126, 64, 84, 48, 130, 40, 108, 66, 72, 64, 136, 44,
 138, 48, 92, 70, 120, 48, 112, 72, 84, 72, 148, 40, 150, 72, 96, 60, 120, 48, 156,
 78, 104, 64, 132, 54, 162, 80, 80, 82, 166, 48, 156, 64, 108, 84, 172, 56, 120, 80,
 116, 88, 178, 48, 180, 72, 120, 88, 144, 60, 160, 92, 108, 72, 190, 64, 192, 96, 96,
 84, 196, 60, 198, 80, 132, 100, 168, 64, 160, 102, 132, 96, 180, 48, 210, 104, 140,
 106, 168, 72, 180, 108, 144, 80, 192, 72, 222, 96, 120, 112, 226, 72, 228, 88, 120,
 112, 232, 72, 184, 116, 156, 96, 238, 64, 240, 110, 162, 120, 168, 80, 216, 120, 164,
 100, 250, 72, 220, 126, 128, 128, 256, 84, 216, 96, 168, 130, 262, 80, 208, 108, 176,
 132, 268, 72, 270, 128, 144, 136, 200, 88, 276, 138, 180, 96, 280, 92, 282, 140, 144,
 120, 240, 96, 272, 112, 192, 144, 292, 84, 232, 144, 180, 148, 264, 80, 252, 150, 200,
 144, 240, 96, 306, 120, 204, 120, 310, 96, 312, 156, 144, 156, 316, 104, 280, 128, 212,
 132, 288, 108, 240, 162, 216, 160, 276, 80, 330, 164, 216, 166, 264, 96, 336, 156, 224,
 128, 300, 108, 294, 168, 176, 172, 346, 112, 348, 120, 216, 160, 352, 116, 280, 176, 192,
 178, 358, 96, 342, 180, 220, 144, 288, 120, 366, 176, 240, 144, 312, 120, 372, 160, 200,
 184, 336, 108, 378, 144, 252, 190, 382, 128, 240, 192, 252, 192, 388, 96, 352, 168, 260,
 196, 312, 120, 396, 198, 216, 160, 400, 132, 360, 200, 216, 168, 360, 128, 408, 160, 272,
 204, 348, 132, 328, 192, 276, 180, 418, 96, 420, 210, 276, 208, 320, 140, 360, 212, 240,
 168, 430, 144, 432, 180, 224, 216, 396, 144, 438, 160, 252, 192, 442, 144, 352, 222, 296,
 192, 448, 120, 400, 224, 300, 226, 288, 144, 456, 228, 288, 176, 460, 120, 462, 224, 240,
 232, 466, 144, 396, 184, 312, 232, 420, 156, 360, 192, 312, 238, 478, 128, 432, 240, 264,
 220, 384, 162, 486, 240, 324, 168, 490, 160, 448, 216, 240, 240, 420, 164, 498, 200, }

local job_time = os.time()

primes = {}
prime_hash = {}

-- The General formula for Euler's Totient Function is:
-- euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
-- Where p1, p2, p3, . . . , pn are prime factors of m.

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

local mask = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "0" }

function is_permutation(a, b)
  local sa, sb = tostring(a), tostring(b)
  if #sa == #sb then
    for _, n in ipairs(mask) do
      local ca, cb = 0, 0
      for _ in sa:gmatch(n) do
        ca = ca + 1
      end
      for _ in sb:gmatch(n) do
        cb = cb + 1
      end

      if ca ~= cb then
        return false
      end
    end
    return true
  end
  return false
end

-- Find the value of n, 1 < n < 10^7,
-- for which euler_phi(n) is a permutation of n
-- and the ratio n/euler_phi(n) produces a minimum.
local ratio = 2
for i = 2, 9999999 do
  local phi, prime = euler_phi(i)
--  if i <= 500 then
--    assert(phi == test[i])
--  end
--  if i == 87109 then
--    assert(phi == 79180)
--  end

  if not prime then
    local a = i / phi
    if a < ratio and is_permutation(phi, i) then
      print("-", i, phi, a)
      ratio = a
      value = i
    end
  end
end

print("problem #70", "value of n:", value, value == 8319823)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
