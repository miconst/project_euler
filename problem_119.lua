-- problem #119
job_time = os.time()

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function get_sum_s(n)
  local sum = 0
  for i = 1, #n do
    sum = sum + get_digit(n, i)
  end
  return sum
end

function sum_s(a, b)
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

function mul_s(a, b)
  local s = a
  for i = 2, b do
    s = sum_s(s, a)
  end
  return s
end

local interesting_numbers = {}

for i = 2, 100 do
  local n = tostring(i * i)
  while #n < 16 do
    interesting_numbers[n] = interesting_numbers[n] or {}
    interesting_numbers[n][i] = true
    n = mul_s(n, i)
  end
end

local numbers = {}
for n in pairs(interesting_numbers) do
  table.insert(numbers, n)
end
table.sort(numbers, function(a,b) if #a == #b then return a < b else return #a < #b end end)

local number_count = 0
local number

for _, n in ipairs(numbers) do
  local sum = get_sum_s(n)
  if interesting_numbers[n][sum] then
    number_count = number_count + 1
    print(number_count, ":", n, sum)
    if number_count == 30 then
      number = n
      break
    end
  end
end

print("problem #119", "a_30:" , number, number == "248155780267521")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
