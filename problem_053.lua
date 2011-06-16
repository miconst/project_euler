-- problem #53
job_time = os.time()

function factorial(n)
  local s = 1
  for i = 2, n do
    s = s * i
  end
  return s
end

function C(n, r)
  local a = factorial(n)
  local b = factorial(r)
  local c = factorial(n - r)
  return a / ( b * c )
end

count = 0
for n = 1, 100 do
  for r = 0, n do
    if C(n, r) > 1000000 then
      count = count + 1
      break
    end
  end
end

print("problem #53", "count:", count, count == 100)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
