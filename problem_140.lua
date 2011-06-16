-- problem # 140
job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(50)

------------------------------------------------------------------------------
-- 1. A000285 recurrence a(0) = 1, a(1) = 4, and a(n) = a(n-1) + a(n-2) (n>=2)
-- http://oeis.org/A000285
local sqrt_5  = bc.sqrt(5)

function a(n)
  return ((1 + sqrt_5)^n - (1 - sqrt_5)^n  + 6 * ((1 + sqrt_5)^(n - 1) - (1 - sqrt_5)^(n-1))) / (2^n * sqrt_5)
end

------------------------------------------------------------------------------
-- 2. The sum of a geometric series is finite as long as the q < 1
-- Sn = a + a*q + a*q^2 + ... + a*q^n-1 = a*(1 - q^n) / (1 - q)
-- S = a / (1 - q)
function s1(x)
  local c = 1 / sqrt_5
  local q = (1 + sqrt_5) * x / 2
  assert(math.abs(q) < 1)
  local s = 1 / (1 - q)
  return c * (s - 1)
end

function s2(x)
  local c = 1 / sqrt_5
  local q = (1 - sqrt_5) * x / 2
  assert(math.abs(q) < 1)
  local s = 1 / (1 - q)
  return c * (s - 1)
end

function s3(x)
  local c = 1 / (1 + sqrt_5)
  c = 6 * c / sqrt_5
  local q = (1 + sqrt_5) * x / 2
  assert(math.abs(q) < 1)
  local s = 1 / (1 - q)
  return c * (s - 1)
end

function s4(x)
  local c = 1 / (1 - sqrt_5)
  c = 6 * c / sqrt_5
  local q = (1 - sqrt_5) * x / 2
  assert(math.abs(q) < 1)
  local s = 1 / (1 - q)
  return c * (s - 1)
end

function s12(x)
  local s = x / (1 - x - x^2)
  return s
end

function s34(x)
  local s = 3 * ((1 - x)/(1 - x - x^2) - 1)
  return s
end

function S(x)
  return -3 + (3 - 2 * x) / (1 - x - x^2)
end

------------------------------------------------------------------------------
-- 3. solving S(n)
-- k = S(n) + 3
-- k*n^2 + (k - 2)*n + (3 - k) = 0,
-- An = k, Bn = (k - 2), Cn = (3 - k)
-- Determinant Dn = 5*k^2 - 16*k + 4 = y^2
-- 5*k^2 - 16*k + (4 - y^2) = 0
-- Ak = 5, Bk = -16, Ck = (4 - y^2)
-- Determinant Dk = 4 * (44 + 5 * y^2) = x^2

------------------------------------------------------------------------------
-- 4. solving x^2 - 5 * y^2 = 44, x>0, y>0 over the integers (Pell's equation)
-- results: f1(n), f2(n), ..., f6(n), n >= 0
local sqrt_80 = bc.sqrt(80)
local a_min = 9 - sqrt_80
local a_max = 9 + sqrt_80

function f1(n)
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = (7 * a_min_n - sqrt_5 * a_min_n + 7 * a_max_n + sqrt_5 * a_max_n) / 2
  local y = (5 * a_min_n - 7 * sqrt_5 * a_min_n + 5 * a_max_n + 7 * sqrt_5 * a_max_n) / 10
  return x, y
end

function f2(n)
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = 4 * a_min_n - sqrt_5 * a_min_n + 4 * a_max_n + sqrt_5 * a_max_n
  local y = (5 * a_min_n - sqrt_80 * a_min_n + 5 * a_max_n + sqrt_80 * a_max_n) / 5
  return x, y
end

function f3(n)
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = (13 * a_min_n -  5 * sqrt_5 * a_min_n + 13 * a_max_n +  5 * sqrt_5 * a_max_n) / 2
  local y = (25 * a_min_n - 13 * sqrt_5 * a_min_n + 25 * a_max_n + 13 * sqrt_5 * a_max_n) / 10
  return x, y
end

function f4(n)
  n = n + 1
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = ( 13 *a_min_n +  5 * sqrt_5 * a_min_n + 13 * a_max_n -  5 * sqrt_5 * a_max_n) / 2
  local y = (-25 *a_min_n - 13 * sqrt_5 * a_min_n - 25 * a_max_n + 13 * sqrt_5 * a_max_n) / 10
  return x, y
end

function f5(n)
  n = n + 1
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = 4 * a_min_n + sqrt_5 * a_min_n + 4 * a_max_n - sqrt_5 * a_max_n
  local y = (-5 * a_min_n - sqrt_80 * a_min_n - 5 * a_max_n + sqrt_80 *a_max_n) / 5
  return x, y
end

function f6(n)
  n = n + 1
  local a_min_n = bc.pow(a_min, n)
  local a_max_n = bc.pow(a_max, n)
  local x = (7 * a_min_n + sqrt_5 * a_min_n + 7 * a_max_n - sqrt_5 * a_max_n) / 2
  local y = (-5 * a_min_n - 7 * sqrt_5 * a_min_n - 5 * a_max_n + 7 *sqrt_5 * a_max_n) / 10
  return x, y
end

------------------------------------------------------------------------------
-- find the sum
function to_integer(number)
  return (string.gsub(tostring(number), "%.%d*", "", 1))
end

function get_sum(count)
  local pell_functions = { f1, f2, f3, f4, f5, f6 }
  local n, sum = 0, bc.number(0)
  while true do
    for _, f in ipairs(pell_functions) do
      local d_sq, y = f(n)
      local k = (8 + d_sq) + bc.number("0.0000001")
      if string.find(tostring(k), "[05]%.") then
        k = k / 5
        local s = k - 3
        sum = sum + s
        print(to_integer(s), to_integer(-(k - 2) + bc.sqrt(5*k*k - 16*k + 4)) .. " / " .. to_integer(2 * k))
        count = count - 1
        if count < 0 then
          return sum
        end
      end
    end
    n = n + 1
  end
end

sum = to_integer(get_sum(30))

print("problem #140", "the sum of the first thirty golden nuggets:", sum, sum == "5673835352990")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
