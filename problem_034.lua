-- problem #34
local job_time = os.time()

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function factorial(n)
  local i = 1
  while n > 0 do
    i = i * n
    n = n - 1
  end
  return i
end

factorials = {}

for i = 0, 9 do
  factorials[i] = factorial(i)
end

number = 10
sum = 0

while true do
  local x = tostring(number)
  if number > #x * factorials[9] then
    print("!! exit number:", number)
    break
  end
  local s = 0
  for i = 1, #x do
    s = s + factorials[get_digit(x, i)]
  end
  if s == number then
    sum = sum + s
    print("!", number)
  end
  if number - s > factorials[9] then
    local y = x:gsub("[1-8]([9]-)$", '9%1', 1)
    if y ~= x then
      number = tonumber(y)
      --print("%", x, y)
    else
      number = number + 1
    end
  else
    number = number + 1
  end
end

print("problem #34", "value of n:" , sum, sum == 40730)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
