-- problem #28
local job_time = os.time()

local H = 1001
local sum = 0
i, step = 1, 2
while i <= H * H - (H - 1) do
  sum = sum + i
  i = i + step
  step = step + 2
end

--sum = 0
i, step = 1, 4
while i < H * H do
  i = i + step
  sum = sum + i
  i = i + step
  sum = sum + i
  step = step + 4
end

print("problem #28", "sum of the diagonal numbers:", sum, sum == 669171001)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
