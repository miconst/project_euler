-- problem #122
job_time = os.time()

done = { { 0, "1" }, { 1, "1->2" } }

function get_number_of_multiplications(k)
  if k % 2 == 0 then
    local level_max = done[k / 2][1] + 1
    local path = done[k / 2][2] .. "->" .. tostring(k)
    done[k] = { level_max, path }
    return level_max, path
  end

  local level_max = done[k - 1][1] + 1
  local path = done[k - 1][2] .. "->" .. tostring(k)

  ---print(level_max)
  local numbers = { 1, 2 }
  --local tested = {}

  local function test(level, tested)
--    local key = table.concat(numbers, "*", 3, level)
--    if tested[key] then
--      --print(key)
--      return
--    else
--      tested[key] = true
--    end
    if tested[numbers[level]] then
      return
    else
      tested[numbers[level]] = {}
    end

    local num_hash = {}
    for i = level, 1, -1 do
      for j = level, i, -1 do
        local n = numbers[i] + numbers[j]
        --if level >= level_max then
        --  return
        --else
        if n == k then
          -- gotcha
          level_max = level
          numbers[level + 1] = n
          path = table.concat(numbers, "->", 1, level + 1)
          return
        elseif level + 1 < level_max and n < k and n > numbers[level] then
          num_hash[n] = true
        end
      end
    end
    tested = tested[numbers[level]]
    level = level + 1
    if level < level_max then
      for n in pairs(num_hash) do
        numbers[level] = n
        test(level, tested)
      end
    end
  end
  test(#numbers, {})
  done[k] = { level_max, path }

  return level_max, path
end

sum = 1
for i = 3, 200 do
  local s, p = get_number_of_multiplications(i)
  print(i, s, p)
  sum = sum + s
end

print("problem #122", 'the sum:', sum, sum == 1582)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
