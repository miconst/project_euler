-- problem #79
local job_time = os.time()

local keys = {}

local f = assert(io.open(arg[1] or "keylog.txt"))
for l in f:lines() do
  local a = l:sub(1,2)
  local b = l:sub(2,3)
  --print(a,b)
  keys[a] = true
  keys[b] = true
end

function get_minimal()
  local t = {}
  for k in pairs(keys) do
    t[k:sub(1, 1)] = true
  end
  for k in pairs(keys) do
    t[k:sub(2, 2)] = nil
  end
  local r
  for k in pairs(t) do
    assert(r == nil)
    print(k)
    r = k
  end
  for k in pairs(keys) do
    if k:sub(1, 1) == r then
      keys[k] = nil
    end
  end
  return r
end

function get_count()
  local count = 0
  for k in pairs(keys) do
    count = count + 1
  end
  return count
end

local s = ""
while get_count() > 0 do
  s = s .. get_minimal()
end

print("problem #79", "value of n:" , s, s == "73162890")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
