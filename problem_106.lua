-- problem #106
job_time = os.time()

function copy(t)
  local c = {}
  for k, v in pairs(t) do
    c[k] = v
  end
  return c
end

subsets = {}
N = 12

function init(i, n, set)
  for j = i + 1, N do
    local t = copy(set)
    table.insert(t, j)
    if not subsets[#t] then
      subsets[#t] = {}
    end
    subsets[#t][n * 10 + j] = t
    init(j, n * 10 + j, t)
  end
end

init(0, 0, {})

function get_joint(a, b, a_start, b_start)
  for i = a_start or 1, #a do
    for j = b_start or 1, #b do
      if a[i] == b[j] then
        return i, j
      end
    end
  end
end

function not_less(a, b)
  for i = 1, #a do
    if a[i] >= b[i] then
      return true
    end
  end
end

function is_intersection(a, b)
  return not_less(a, b) and not_less(b, a)
end

tests = {}
for i = 2, N / 2 do
  local s = subsets[i]
  for ak, a in pairs(s) do
    for bk, b in pairs(s) do
      if not get_joint(a, b) and is_intersection(a, b) then
        local sa, sb = table.concat(a), table.concat(b)
        local k = a[1] < b[1] and sa .. "\t" .. sb or sb .. "\t" .. sa
        tests[k] = true
      end
    end
  end
end

count = 0
for k in pairs(tests) do
--~   print(k)
  count = count + 1
end

print("problem #106", "The number of the subset pairs that need to be tested for equality:", count, count == 21384)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
