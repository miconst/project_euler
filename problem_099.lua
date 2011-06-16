-- problem #99
local job_time = os.time()

local x, a, line
local l = 0

for s in assert(io.open(arg[1] or "base_exp.txt")):lines() do
  l = l + 1
  local _, _, y, b = s:find "(%d+),(%d+)"
  assert(y and b)
  -- we can calculate exponent * log(base) instead of base ^ exponent
  y = math.log(y) * b
  if not x or y > x then
    x, line = y, l
  end
end

print("problem #99", "line number:" , line, line == 709)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
