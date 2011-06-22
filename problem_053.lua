-- problem #53
job_time = os.time()

function factorial(mul, div)
  local s = 1
  for i = (div or 1) + 1, mul do
    s = s * i
  end
  return s
end

--~ print(factorial(100)/factorial(99) - factorial(100, 99))

function C(n, r)
  return factorial(n, r) / factorial(n - r)
end

--~ print(C(23, 10) - 1144066)

count, nf = 0, 1
for n = 1, 100 do
  nf = nf * n
  if nf > 10^6 then
    for r = 1, n - 1 do
      if C(n, r) > 10^6 then
        count = count + 1
      end
    end
  end
end

print("problem #53", "count:", count, count == 4075)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
