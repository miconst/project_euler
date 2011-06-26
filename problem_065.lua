-- problem #65
job_time = os.time()

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

-- e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...]
-- 2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

-- http://oeis.org/A113873
numerators = {}

function A(n)
  if not numerators[n] then
    if n < 2 then
      numerators[n] = "1"
    elseif n == 2 then
      numerators[n] = "2"
    else
      if n % 3 == 0 then
        numerators[n] = sum(A(n - 1), A(n - 2))
      elseif n % 3 == 1 then
        numerators[n] = sum(mul(A(n - 1), 2 * (n - 1) / 3), A(n - 2))
      else
        numerators[n] = sum(A(n - 1), A(n - 2))
      end
    end
  end
  return numerators[n]
end

--~ print(A(1), A(2), A(3), A(4), A(5), A(6), A(7), A(8), A(100))
number = A(101)
print(number)

sum = 0
for i = 1, #number do
  sum = sum + get_digit(number, i)
end

print("problem #65", "the sum of digits in the numerator of the 100th convergent of the continued fraction for e:", sum, sum == 402)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
