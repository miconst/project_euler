-- problem #61
local job_time = os.time()

-- Triangle   P3(n)=n * (n+1) / 2
-- 1, 3, 6, 10, 15, ...
function P3(n) return n * (n + 1) / 2 end

-- Square     P4(n) = n * n
-- 1, 4, 9, 16, 25, ...
function P4(n) return n * n end

-- Pentagonal P5(n) = n * (3 * n - 1) / 2
-- 1, 5, 12, 22, 35, ...
function P5(n) return n * (3 * n - 1) / 2 end

-- Hexagonal  P6(n) = n * (2 * n - 1)
-- 1, 6, 15, 28, 45, ...
function P6(n) return n * (2 * n - 1) end

-- Heptagonal P7(n) = n * (5 * n - 3) / 2
-- 1, 7, 18, 34, 55, ...
function P7(n) return n * (5 * n - 3) / 2 end

-- Octagonal  P8(n) = n * (3 * n - 2)
-- 1, 8, 21, 40, 65, ..
function P8(n) return n * (3 * n - 2) end

--for i = 1, 5 do
--  print(P7(i))
--end

polygonal_functions = { P3, P4, P5, P6, P7, P8 }

polygonal_numbers = {}
polygonal_groups = { [P3] = {}, [P4] = {}, [P5] = {}, [P6] = {}, [P7] = {}, [P8] = {} }

for _, f in pairs(polygonal_functions) do
  local i = 1
  while true do
    local n = f(i)
    if n > 9999 then
      break
    elseif n > 999 then
      polygonal_numbers[n] = true
      polygonal_groups[f][n] = i
    end
    i = i + 1
  end
end

function copy_table(t)
  local c = {}
  for k, v in pairs(t) do
    c[k] = v
  end
  return c
end

cyclics = {}

--~ function get_type(t)
--~   for k, v in pairs(t) do
--~     local count, number = 0
--~     for n in pairs(v) do
--~       count = count + 1
--~       number = n
--~     end
--~     if count == 1 then
--~       return k, v, number
--~     end
--~   end
--~ end

function is_circle_valid(circle)
  local ok = {}
  for i = 1, #circle - 1 do
    local n = circle[i]
    for f, t in pairs(polygonal_groups) do
      if t[n] then
        ok[f] = ok[f] or {}
        ok[f][t[n]] = true
      end
    end
  end
  return ok[P3] and ok[P4] and ok[P5] and ok[P6] and ok[P7] and ok[P8]

--~   if ok[P3] and ok[P4] and ok[P5] and ok[P6] and ok[P7] and ok[P8] then
--~     for i = 1, 6 do
--~       local f, t, n = get_type(ok)
--~       if not f then
--~         return false
--~       end
--~       ok[f] = nil
--~       for _, okf in pairs(ok) do
--~         okf[n] = nil
--~       end
--~     end
--~     return true
--~   end
end

sums = {}

function get_cyclic(circle)
  local i = #circle
  local a, b = circle[1], circle[i]
  if i == 7 then
    if a == b and is_circle_valid(circle) then
      table.insert(cyclics, circle)
      local s = 0
      for j = 1, #circle - 1 do
        s = s + circle[j]
      end
      sums[s] = true
    end
  else
    local n_min = (b % 100) * 100
    local n_max = n_min + 100
    for n in pairs(polygonal_numbers) do
      if n > n_min and n < n_max and n ~= b then
        local c = copy_table(circle)
        table.insert(c, n)
        get_cyclic(c)
      end
    end
  end
end

for n in pairs(polygonal_numbers) do
  get_cyclic { n }
end

for _, c in pairs(cyclics) do
  print(unpack(c))
end

for s in pairs(sums) do
  print("!", s)
end

print("problem #61", "value of n:" , #polygonal_numbers, sum == 28684)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
