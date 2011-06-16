-- problem #92
local job_time = os.time()

finished = { [1] = true }
looped = { [89] = true }

threshold = 9 * 9 * 7

loop_count = 0

function get_next(n)
  local r = 0
  while n > 0 do
    local l = n % 10
    r = r + l * l
    n = math.floor(n / 10)
  end
  return r
end

for i = 1, 10000000 - 1 do
  local n = i
  while true do
    if looped[n] then
      if i <= threshold then
        --print("looped:", i)
        looped[i] = true
      end
      loop_count = loop_count + 1
      break
    elseif finished[n] then
      if i <= threshold then
        --print("finished:", i)
        finished[i] = true
      end
      break
    end
    n = get_next(n)
  end
end

print("problem #92", "stucked numbers:" , loop_count, loop_count == 8581146)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
