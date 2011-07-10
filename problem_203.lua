-- problem #203
job_time = os.time()

function get_main_primes(n)
  local primes = {}
  -- generate a list of integers from 2 to N
  for i = 1, n do
    primes[i] = i
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if primes[i] == i then
      for j = i + i, n, i do
        primes[j] = i
      end
    end
  end
  return primes
end

ROW_MAX = 51

main_primes = get_main_primes(ROW_MAX)

function factorial(mul, div)
  local s = 1
  local t = {}
  for i = (div or 1) + 1, mul do
    s = s * i
    local x = i
    while x > 1 do
      local p = main_primes[x]
      t[p] = (t[p] or 0) + 1
      x = x / p
    end
  end
  return s, t
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

distinct_numbers = { ["1"] = true }

function add_squarefree(primes)
  local m = "1"
  for p, n in pairs(primes) do
    if n > 1 then
      return
    else
      m = mul(m, p^n)
    end
  end
  distinct_numbers[m] = true
end

for n = 2, ROW_MAX do
  for k = 2, (n + 1) / 2 do
    local _, a = factorial(n - 1, k - 1)
    local _, b = factorial(n - k)
    for p, n in pairs(b) do
      a[p] = a[p] - n
      if a[p] == 0 then
        a[p] = nil
      end
    end
    add_squarefree(a)
  end
end

total_sum = "0"
for k in pairs(distinct_numbers) do
  total_sum = sum(total_sum, k)
end

print("problem #203", "the sum of the distinct squarefree numbers:", total_sum, total_sum == "34029210557338")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
