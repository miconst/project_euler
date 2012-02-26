-- problem #122
job_time = os.time()

done = { [1] = { 0, "1" } }

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
  local numbers = { [1] = 1 }
  local tested = {}

  local function test(level)
    local key = table.concat(numbers, "*")
    if tested[key] then
      --print(key)
      return
    else
      tested[key] = true
    end
    for i = #numbers, 1, -1 do
      for j = #numbers, 1, -1 do
        local n = numbers[i] + numbers[j]
        if level >= level_max then
          return
        elseif n == k then
          -- gotcha
          level_max = level
          table.insert(numbers, n)
          path = table.concat(numbers, "->")
          table.remove(numbers)
          return
        elseif level + 1 < level_max and n < k and n > numbers[#numbers] then
          table.insert(numbers, n)
          test(level + 1)
          table.remove(numbers)
        end
      end
    end
  end
  test(1)
  done[k] = { level_max, path }
  return level_max, path
end

sum = 0
for i = 2, 200 do
  local s, p = get_number_of_multiplications(i)
  print(i, s, p)
  sum = sum + s
end

print("problem #122", 'the sum:', sum, sum == 1582)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
