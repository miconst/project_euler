-- problem #36
local job_time = os.time()

local function is_string_palindromic(s)
  local half = math.floor(#s / 2)
  local a, b = s:sub(1, half), s:sub(#s - half + 1):reverse()
  return a == b
end

local function to_binary(n)
  local accum = ""
  repeat
    accum = tostring(n % 2) .. accum
    n = math.floor(n / 2)
  until n <= 0
  return accum
end

local function is_number_palindromic(n)
  return is_string_palindromic(tostring(n)) and
    is_string_palindromic(to_binary(n))
end

assert(is_number_palindromic(585))

local sum = 0
for i = 1, 1000000 - 1, 2 do
  if is_number_palindromic(i) then
    print("|", i)
    sum = sum + i
  end
end

print("problem #36", "the sum of all palindromic numbers:" , sum, sum == 872187)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
