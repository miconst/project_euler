-- problem #23
job_time = os.time()

N = 28123

function is_abundant(number)
  local sum = 1
  for i = math.floor(number / 2), 2, -1 do
    if number % i == 0 then
      sum = sum + i
      if sum > number then
        return true
      end
    end
  end
  return false
end

abundants = {}

for i = 1, N do
  if is_abundant(i) then
    abundants[i] = true
  end
end

two_abundants = {}

for a in pairs(abundants) do
  for b in pairs(abundants) do
    two_abundants[a + b] = true
  end
end

sum = 0
for i = 1, N do
  if not two_abundants[i] then
    sum = sum + i
  end
end

print("problem #23", "the sum:" , sum, sum == 4179871)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
