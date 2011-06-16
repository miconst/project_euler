-- problem #48
local job_time = os.time()

local D_MOD = 10000000000

function pow(a, b)
  local s = a
  for i = 2, b do
    s = ( s * a ) % D_MOD
  end
  return s
end

max_sum = 0
for i = 1, 1000 do
  max_sum = (max_sum + pow(i, i)) % D_MOD
end

print("problem #48", "the last 10 digits:" , max_sum, max_sum == 9110846700)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
