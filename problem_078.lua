-- problem #78
local job_time = os.time()

local test = { 1, 2, 3, 5, 7, 11, 15, 22, 30, 42, 56, 77, 101, 135, 176, 231, 297, 385, 490, 627, 792, 1002, 1255, 1575 }

function pentagonal(n)
  return math.floor(n * (3 * n - 1) / 2)
end

function generalised_pentagonal(n)  -- 0, 1, -1, 2, -2
  if n < 0 then
    return 0
  end

  if n % 2 == 0 then
    return pentagonal(math.floor(n / 2) + 1)
  else
    return pentagonal(-(math.floor(n / 2) + 1))
  end
end

--for i = 0, 10 do
--  print("#", generalised_pentagonal(i))
--end

partitions = { [0] = 1 }
n = 1
while true do
  local r, f, i = 0, -1, 0
  while true do
    local k = generalised_pentagonal(i)
    if k > n then
      break
    end
    if i % 2 == 0 then
      f = -f
    end

    r = r + f * partitions[n - k]
--    if r > 10000000 then
      r = r % 10000000
--    end
    i = i + 1
  end
  partitions[n] = r
  if r % 1000000 == 0 then
    --print("!!", #partitions, r, n)
    break
  end
  n = n + 1
end

for i = 1, #test do
  assert(partitions[i] == test[i])
end

--[===[
function table.count(tbl)
  local n = 0
  for _ in pairs(tbl) do
    n = n + 1
  end
  return n
end

function string:split()
  local list = {}
  local s = self
  while s:len() > 0 do
    local a, b = s:find("+", 1, true)
    if a then
      table.insert(list, tonumber(s:sub(1, a - 1)))
      s = s:sub(b + 1)
    else
      table.insert(list, tonumber(s))
      s = ""
    end
  end
  return list
end

function sorted_pairs(tbl, order)
  if type(order) ~= "table" then
    local t = {}
    for k, _ in pairs(tbl) do table.insert(t, k) end

    if #t > 1 then table.sort(t, order) end

    order = t
  end

  local n, i = #order, 0
  return function()
    if i < n then
      i = i + 1
      return order[i], tbl[order[i]]
    end
  end
end

local t = {}
function sum(n, buf)
  if n == 0 then
    local x = buf:split()
    table.sort(x, function(a,b) return a > b end)
    x = table.concat(x, "+")
--    print(buf, x)
    t[x] = true
  else
    for i = n, 1, -1 do
      sum(n - i, buf .. tostring(i) .. (n == i and "" or "+"))
    end
  end
end

--sum(10, "")

-- for k, v in sorted_pairs(t,
 -- function(a,b)
    -- _, _, an = a:find "^(%d+)"
    -- _, _, bn = b:find "^(%d+)"
 -- return tonumber(an) > tonumber(bn) end) do
  -- print("!", k)
-- end
-- print(table.count(t))
c_old = 0
for i = 1, 30 do
  t = {}
  sum(i, "")
  local c = table.count(t)
  print(i, c, c - c_old)
  c_old = c
end

--]===]

print("problem #78", "value of n:" , #partitions, #partitions == 55374)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
