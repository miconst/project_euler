-- problem #15
local job_time = os.time()

local X, Y = 12, 12
local sum = 0
--local test = {}

local function combinations(n, k)
  -- Combinations of k elements from a group of n
  local x = 1
  for i = n - k + 1, n do
    x = x * i
  end
  for i = 1, k do
    x  = x / i
  end
  return x
end

print(combinations(40, 20))

local function path(x, y)
  if x == X and y == Y then
    --print(p)
    sum = sum + 1
    --assert(test[p] == nil)
    --test[p] = true
  else
    -- right
    if x < X then
      path(x + 1, y) --, p .. string.format("[%dX%d]", x, y))
    end
    -- bottom
    if y < Y then
      path(x, y + 1) --, p .. string.format("[%dX%d]", x, y))
    end
  end
end

path(0, 0)

print("problem #15", "line number:" , sum)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
