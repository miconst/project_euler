-- problem #39
local job_time = os.time()

local solutions = {}

for p = 3, 1000 do
  for a = 1, p - 1 do
    for b = 1, p - 1 do
      if a * a + b * b == math.pow(p - a - b, 2) then
        --print("!", a, b, p)
        if not solutions[p] then
          solutions[p] = {}
        end
        solutions[p][tostring(math.min(a, b)) .. "X" .. tostring(math.max(a, b))] = true
      end
    end
  end
end

count = 0
for p, v in pairs(solutions) do
  local c = 0
  for _ in pairs(v) do
    c = c + 1
  end
  if c > count then
  print("!", count)
    perimeter = p
    count = c
  end
end

print("problem #39", "perimeter:" , perimeter, perimeter == 669171001)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
