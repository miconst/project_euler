require "mathlib"

-- problem #215
job_time = os.time()

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function sum(a, b)
  local h, s, i_max = 0, "", math.max(#a, #b)
  for i = 1, i_max do
    local x = get_digit(a, i) + get_digit(b, i) + h
    s = tostring(x % 10) .. s
    h = math.floor(x / 10)
  end
  if h > 0 then
    s = tostring(h) .. s
  end
  return s
end

function get_patterns(row_length)
  local num_3 = row_length % 2 ~= 0 and 1 or 0
  local num_2 = (row_length - 3 * num_3) / 2
  local patterns = {}
  repeat
    local row = {}
    table.insert(patterns, row)
    for i = 1, num_2 do
      table.insert(row, 2)
    end
    for i = 1, num_3 do
      table.insert(row, 3)
    end
    num_2 = num_2 - 3
    num_3 = num_3 + 2
  until num_2 < 0
  return patterns
end

cracks = {}
for _, t in ipairs(get_patterns(32)) do
  repeat
    local row = {}
    table.insert(cracks, row)
    local pos = 0
    for i = 1, #t - 1 do
      pos = pos + t[i]
      row[pos] = true
    end
--~     print(unpack(t))
  until not next_permutation(t)
end

function get_running_crack(row_a, row_b)
  for c in pairs(row_a) do
    if row_b[c] then
      return c
    end
  end
end

compatibility_map = {}
for i = 1, #cracks do
  compatibility_map[i] = {}
end

for i = 1, #cracks - 1 do
  for j = i + 1, #cracks do
    if not get_running_crack(cracks[i], cracks[j]) then
      compatibility_map[i][j] = 1
      compatibility_map[j][i] = 1
    end
  end
end

function make_wall(row_num)
  local row_2 = {}
  for i = 1, #compatibility_map do
    for x in pairs(compatibility_map[i]) do
      row_2[x] = (row_2[x] or 0) + 1
    end
  end
  local last_row = row_2
  for row = 3, row_num do
    local next_row = {}
    for i, m in pairs(last_row) do
      for x in pairs(compatibility_map[i]) do
        next_row[x] = (next_row[x] or 0) + m
      end
    end
    last_row = next_row
  end
  local n = "0"
  for i, m in pairs(last_row) do
    n = sum(n, tostring(m))
  end
  return n
end

--~ print(#cracks)
count = make_wall(10)

print("problem #215", "The number of ways of forming a crack-free 32x10 wall:", count, count == "806844323190414")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
