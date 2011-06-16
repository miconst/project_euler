-- problem #93
job_time = os.time()

function shallow_copy(t)
  local n = {}
  for k, v in pairs(t) do
    n[k] = v
  end
  return n
end

function get_permutations(mask, length, exclusive)
  local perms = {}
  local function permutate(perm, used)
    if #perm == length then
      table.insert(perms, perm)
    else
      for _, c in pairs(mask) do
        if not exclusive or not used[c] then
          local p = shallow_copy(perm)
          local u = shallow_copy(used)
          table.insert(p, c)
          u[c] = true
          permutate(p, u)
        end
      end
    end
  end

  permutate({}, {})
  --print(unpack(perms[1]))
  return perms
end

--digit_set = get_permutations({ 1, 2, 3, 4 }, 4, true)

function format_sentence(dis, ops, ors)
--~   local dis = { digits:sub(1,1), digits:sub(2,2), digits:sub(3,3), digits:sub(4,4) }
--~   local ops = { operations:sub(1,1), operations:sub(2,2), operations:sub(3,3) }
--~   local ors = { order:sub(1,1), order:sub(2,2), order:sub(3,3) }
  local result = ""
  --print("!", unpack(dis))
  --print("!", unpack(ops))
  --print("!", unpack(ors))

  dis = shallow_copy(dis)
  --ops = shallow_copy(ops)
  --ors = shallow_copy(ors)

  for i = 1, #ors do
    for j = 1, #ors do
      if ors[j] == i then
        result = "(" .. tostring(dis[j]) .. ops[j] .. tostring(dis[j + 1]) .. ")"
        local x, t = j, dis[j]
        repeat
          dis[x] = result
          x = x - 1
        until dis[x] ~= t
        local x, t = j + 1, dis[j + 1]
        repeat
          dis[x] = result
          x = x + 1
        until dis[x] ~= t
        --print("@", unpack(dis))
      end
    end
  end
  return result
end

OPERATION_SET = get_permutations({ "+", "-", "*", "/" }, 3, false)
ORDER_SET = get_permutations({ 1, 2, 3 }, 3, true)

function test_permutation(digits)
  assert(#digits == 4)
  local result_set = {}
  local digit_set = get_permutations(digits, 4, true)
  for _, dis in pairs(digit_set) do
    for _, ops in pairs(OPERATION_SET) do
      for _, ors in pairs(ORDER_SET) do
        local s = format_sentence(dis, ops, ors)
        local x = assert(loadstring("return " .. s))()
        if x > 0 and math.floor(x) == x then
          result_set[x] = s
          --print(s, "=", x)
        end
      end
    end
  end
  return result_set
end

max_count = 0
max_numbers = {}

function test_ordered_permutations(n_max, length)
  local function permutate(numbers, used)
    if #numbers == length then
      local result_set = test_permutation(numbers)
      local count = 0
      for i = 1, #result_set do
        if not result_set[i] then
          break
        else
          count = i
        end
      end
      if count > max_count then
        print("!!", count, unpack(numbers))
        max_count = count
        max_numbers = numbers
      end
    else
      for i = (numbers[#numbers] or 0) + 1, n_max do
        if not used[i] then
          local n = shallow_copy(numbers)
          table.insert(n, i)
          local u = shallow_copy(used)
          u[i] = true
          permutate(n, u)
        end
      end
    end
  end

  permutate({}, {})
end

test_ordered_permutations(9, 4)

result = table.concat(max_numbers)

print("problem #93", "the set of four distinct digits:" , result, result == "1258")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
