-- problem #116
job_time = os.time()

function factorial(mul, div)
  local s = 1
  for i = (div or 1) + 1, mul do
    s = s * i
  end
  return s
end

ROW_LENGTH = 50

local total_count = 0
for w = 2, 4 do
  for i = 1, ROW_LENGTH / w do
    local x = factorial(ROW_LENGTH - i * w + i, ROW_LENGTH - i * w) / factorial(i)
    total_count = total_count + x
  end
end

print("problem #116", "ways that the black tiles in a row measuring fifty units in length can be replaced:", total_count, total_count == 20492570929)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
