-- problem #57
local job_time = os.time()

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

local a, b = "1", "2"

more_digits_count = 0

for i = 1, 1000 do
  local c = sum(a, b)
  if #c > #b then
    more_digits_count = more_digits_count + 1
  --print(c, b)
  end
  a, b = b, sum(b, c)
end


print("problem #57", "the number:", more_digits_count, more_digits_count == 153)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
