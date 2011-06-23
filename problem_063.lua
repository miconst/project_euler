-- problem #63
job_time = os.time()

-- x^n >= 10^(n - 1) =>
-- x >= 10^((n - 1)/n) =>
-- log10(x) >= 1 - 1/n =>
-- n <= 1/(1 - log10(x)), x = 1,2, ..., 9
-- N_MAX(x) = math.floor(1/(1 - math.log10(x)))
function get_nmax(x)
  return math.floor(1/(1 - math.log10(x)))
end

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function sum(a, b)
  local h, s, i_max = 0, "", math.max(#a, #b)
  for i = 1, i_max do
    local x = get_digit(a, i) + get_digit(b, i) + h
    s = tostring(x % 10) .. s
    h = math.floor(x / 10)
  end
  if h > 0 then
    s = tostring(h) .. s
  end
  return s
end

function mul(a, b)
  local s = a
  for i = 2, b do
    s = sum(s, a)
  end
  return s
end

function pow(a, b)
  local s = a
  for i = 2, b do
    s = mul(s, a)
  end
  return s
end

count = 0
hash = {}

for x = 1, 9 do
  for n = 1, get_nmax(x) do
    local k = pow(tostring(x),n)
    assert(not hash[k])
    assert(#k == n)
    print(tostring(x) .. "^" .. tostring(n) .. " = " .. k)
    count = count + 1
    hash[k] = true
  end
end

print("problem #63", "n-digit positive integers:", count, count == 49)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
