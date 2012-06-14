-- problem #158

job_time = os.time()

function factorial(mul, div)
  local s = 1
  for i = (div or 1) + 1, mul do
    s = s * i
  end
  return s
end

function binomial(n, k)
  return factorial(n, k) / factorial(n - k)
end

function a(n)
  return 2^n - n - 1
end

function p(n)
  return binomial(N, n) * a(n)
end

N = 26
p_max = 0

for i = 1, N do
  x = p(i)
  if x > p_max then
    p_max = x
  end
end

print("problem #158", " the maximum value of p(n):", p_max, p_max == 409511334375)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
