-- problem #56
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

max_sum = 0

for a = 99, 2, -1 do
  local sa = tostring(a)
  local sb = sa
  for b = 2, 99 do
    sb = mul(sb, a)
    local s = 0
    for i = 1, #sb do
      s = s + get_digit(sb, i)
    end
    if s > max_sum then
      max_sum = s
      print(max_sum, a, b, sb)
    end
  end
end

print("problem #56", "maximum digital sum:" , max_sum, max_sum == 972)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
