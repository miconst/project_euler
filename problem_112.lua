-- problem #112
job_time = os.time()

function is_bouncy(n)
  local inc, dec
  local a, b = n % 10
  while n >= 10 do
    n = (n - a) / 10
    b = n % 10
    if a > b then
      inc = true
    elseif a < b then
      dec = true
    end
    if inc and dec then
      return true
    end
    a = b
  end
end

bouncy = 0
number = 1

while bouncy * 100 ~= number * 99 do
  number = number + 1
  if is_bouncy(number) then
    bouncy = bouncy + 1
  end
end

print("problem #112", "the least number for which the proportion of bouncy numbers is exactly 99%:", number, number == 1587000)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
