-- problem # 104
job_time = os.time()

used = { [0] = true }
function is_pandigital(number)
  used[1] = false used[2] = false used[3] = false
  used[4] = false used[5] = false used[6] = false
  used[7] = false used[8] = false used[9] = false
  for i = 1, 9 do
    local n = number % 10
    if used[n] then
      return false
    end
    used[n] = true
    number = (number - n) / 10
  end
  return true
end

-- b >= a
function sum(a, b)
  local al, bl = #a, #b

  -- tail
  a[1] = a[1] + b[1]
  if a[1] >= 1000000000 then
    a[1] = a[1] - 1000000000
    if 1 < bl then
      a[1 + 1] = a[1 + 1] + 1
    else
      a[1 + 1] = 1
      b[1 + 1] = 0
    end
  end

  -- head
  for i = math.max(2, bl - 5), bl do
    a[i] = a[i] + b[i]
    if a[i] >= 1000000000 then
      a[i] = a[i] - 1000000000
      if i < bl then
        a[i + 1] = a[i + 1] + 1
      else
        a[i + 1] = 1
        b[i + 1] = 0
      end
    end
  end
end

function get_first_nine_digits(t)
  local i = #t
  local x = math.floor(math.log10(t[i])) + 1
  local y = 9 - x
  return t[i] * 10^y + math.floor(t[i - 1] / 10^x)
end

function get_fibonacci_pandigital()
  local a, b, k = { 1 }, { 1 }, 3
  while true do
    sum(a, b)
    b, a = a, b
    if is_pandigital(b[1]) then
      local x = get_first_nine_digits(b)
--~       print(k, (#b - 1) * 9 + math.floor(math.log10(b[#b])) + 1, x, b[1])
      if is_pandigital(x) then
        return k
      end
    end
    k = k + 1
  end
end

k = get_fibonacci_pandigital()

print("problem #104", "the first Fibonacci number for which the first nine digits and the last nine digits are 1-9 pandigital:", k, k == 329468)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
