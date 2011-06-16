-- problem #117
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

function factorial(n)
  return n == 0 and 1 or n * factorial(n - 1)
end

function reverse(t, first, last)
  local mid = (first + last) / 2
  for i = first, mid do
    local j = last + first - i
    t[i], t[j] = t[j], t[i]
  end
end

function next_permutation(t)
  -- permute and test for pure ascending
  local _Last = #t
  local _Next = _Last
  while _Next > 1 do
    -- find rightmost element smaller than successor
    local _Next1 = _Next
    _Next = _Next - 1
    if t[_Next] < t[_Next1] then
      -- swap with rightmost element that's smaller, flip suffix
      local _Mid = _Last
      while t[_Next] >= t[_Mid] do
        _Mid = _Mid - 1
      end
      t[_Next], t[_Mid] = t[_Mid], t[_Next]
      reverse(t, _Next1, _Last)
      return true
    end
  end
  -- pure descending, flip all
  reverse(t, 1, _Last)
end

function count_permutations(t)
  table.sort(t)
  local i = 1;
  while next_permutation(t) do
    i = i + 1
  end
  return i
end

ROW_LENGTH = 50
UNIT_1_MAX = math.floor(ROW_LENGTH / 1)
UNIT_2_MAX = math.floor(ROW_LENGTH / 2)
UNIT_3_MAX = math.floor(ROW_LENGTH / 3)
UNIT_4_MAX = math.floor(ROW_LENGTH / 4)

row_types = {}

for u_1 = 0, UNIT_1_MAX do
  for u_2 = 0, UNIT_2_MAX do
    for u_3 = 0, UNIT_3_MAX do
      for u_4 = 0, UNIT_4_MAX do
        local l = u_1 * 1 + u_2 * 2 + u_3 * 3 + u_4 * 4
        if l == ROW_LENGTH then
          table.insert(row_types, { u_1, u_2, u_3, u_4 })
        end
      end
    end
  end
end

print(#row_types)

local total_count = "0"
for i = 1, #row_types do
  local r = row_types[i]
  local a, b = 0, 1
  for i = 1, #r do
    a = a + r[i]
    b = b * factorial(r[i])
  end
  a = factorial(a)
  total_count = sum(total_count, tostring(a / b))

  --print(unpack(r), a / b)
end

print("problem #117", ":", total_count, total_count == "100808458960497")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
