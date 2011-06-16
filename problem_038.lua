-- problem #38
local job_time = os.time()

local max_pandigital = 987654321

function is_pandigital(n)
  if #n == 9 then
    for _, d in ipairs { '1', '2', '3', '4', '5', '6', '7', '8', '9' } do
      if not n:find(d) then
        return false
      end
    end
    return true
  end
  return false
end

pandigital = 0

for i = 1, 9876 do
  local n, j = i, 2
  while n < max_pandigital and j < 10 do
    local d = tostring(n) .. tostring(i * j)
    n = tonumber(d)
    if n > pandigital and is_pandigital(d) then
      pandigital = n
      print( n, i, j )
    end
    j = j + 1
  end
end

print("problem #38", "the largest pandigital 9-digit number:" , pandigital, pandigital == 932718654)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))

