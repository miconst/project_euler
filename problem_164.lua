-- problem #164
job_time = os.time()

function first_level()
  local t = {}
  for a = 1, 9 do
    for b = 0, 9 - a do
      t[a*10 + b] = 1
    end
  end
  return t
end

function next_level(level)
  local t = {}
  for k, v in pairs(level) do
    local b = k % 10
    local a = (k - b) / 10
    for c = 0, 9 - a - b do
      t[b*10+ c] = (t[b*10 + c] or 0) + v
    end
  end
  return t
end

lvl = first_level()
for i = 3,20 do
  lvl = next_level(lvl)
end

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
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


count = "0"
for k,v in pairs(lvl) do
  count = sum_s(count, tostring(v))
end

print("problem #164", "The number of 20 digit numbers:", count, count == "378158756814587")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
