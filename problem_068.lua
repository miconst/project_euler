-- problem #68
local job_time = os.time()

local N = 10
local S = 5
local D = 1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 + 10

local test = {}
local result = "0"

function tcopy(a)
  local b = {}
  for k, v in pairs(a) do b[k] = v end
  return b
end

function save_result_5(x)
  local t = {
    { x[ 1], x[2], x[3] },
    { x[ 4], x[3], x[5] },
    { x[ 6], x[5], x[7] },
    { x[ 8], x[7], x[9] },
    { x[10], x[9], x[2] },
  }
  while t[1][1] > math.min(t[2][1], t[3][1], t[4][1], t[5][1]) do
    t[1], t[2], t[3], t[4], t[5] = t[2], t[3], t[4], t[5], t[1]
  end

  local s = string.format("%d%d%d", unpack(t[1]))
    .. string.format("%d%d%d", unpack(t[2]))
    .. string.format("%d%d%d", unpack(t[3]))
    .. string.format("%d%d%d", unpack(t[4]))
    .. string.format("%d%d%d", unpack(t[5]))
    --print("-", s)
  --test[s] = true
  if #s == 16 and tonumber(s) > tonumber(result) then
    result = s
  end
end


function is_valid_5(x)
  local used = {}
  for i, v in pairs(x) do
    if used[v] or v <= 0 or v > N then
      return false
    end
    used[v] = true
  end
  return true
end

function test_x6(x)
  for x6 = 1, N do
    x[6] = x6
    x[7] = S - x[5] - x[6]
    x[10] = D - 3 * S - x[4] + x[7]
    x[9] = S - x[10] - x[2]
    x[8] = S - x[9] - x[7]

    if is_valid_5(x) then
      print(S, "!", unpack(x))
      save_result_5(x)
    end
  end
end

function test_x4(x)
  for x4 = 1, N do
    x[4] = x4
    x[5] = S - x[3] - x[4]
    --if x[4] ~= x[5] then
      test_x6(x)
    --end
  end
end

function test_x2(x)
  for x2 = 1, N do
    x[2] = x2
    x[3] = S - x[1] - x[2]
    --if x[2] ~= x[3] then
      test_x4(x)
    --end
  end
end

function solve_5()
  for x1 = 1, N do
    local x = {}
    x[1] = x1
    test_x2(x)
  end
end

while S <= D do
  solve_5()
  S = S + 1
  print(S)
end

print("[", result, "]")

do return end

function solve(...)
  local x = {...}
  table.insert(x, S - x[1] - x[2])
  table.insert(x, D - 2 * S + x[2])
  table.insert(x, 2 * S - D + x[1])
  table.insert(x, D - S - x[1] - x[2])
  return x
end

function is_valid(x)
  local valid = {}
  for i = 1, N do
    valid[i] = true
  end
  for i = 1, N do
    if valid[x[i]] then
      valid[x[i]] = nil
    else
      return false
    end
  end
  return true
end

function save_result(x)
  local t1, t2, t3 = { x[1], x[2], x[3] }, { x[4], x[3], x[5] }, { x[6], x[5], x[2] }
  while t1[1] > math.min(t2[1], t3[1]) do
    t1, t2, t3 = t2, t3, t1
  end

  local s = string.format("%d%d%d", unpack(t1))
    .. string.format("%d%d%d", unpack(t2))
    .. string.format("%d%d%d", unpack(t3))
    --print("-", s)
  test[s] = true
end

for a = 1, N do
  for b = 1, N do
    local x = solve(a, b)
    if is_valid(x) then
      save_result(x)
    end
  end
end

for k in pairs(test) do
  print(k)
end

print("problem #68", "value of n:" , s, s == "6531031914842725")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
