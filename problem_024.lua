-- problem #16
local job_time = os.time()

local function factorial(n)
  local s = 1
  for i = 2, n do
    s = s * i
  end
  return s
end

local function get_permutation(n, d)
  local perm = {}
  for i = 1, d do
    perm[i] = i - 1
  end

  local buf = ""
  while #perm > 0 do
    local size = factorial(#perm - 1)
    local i = math.floor(n / size)
    n = n - i * size

    buf = buf .. tostring(perm[i + 1])
    table.remove(perm, i + 1)
  end
  return buf
end

local p = get_permutation(1000000 - 1, 10)

print("problem #16", "millionth lexicographic permutation:" , p, p == "2783915460")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
