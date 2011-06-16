-- problem #43
local job_time = os.time()

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

function to_digit(t, a, b)
  local digit = 0
  for i = a, b do
    digit = digit + t[i] * 10 ^ (b - i)
  end
  return digit
end

function is_valid_number(t)
  --d2d3d4=406 is divisible by 2
  local a, b = math.modf( (t[2] * 100 + t[3] * 10 + t[4] * 1) / 2 )
  if b ~= 0 then
    return
  end
  --d3d4d5=063 is divisible by 3
  local a, b = math.modf( (t[3] * 100 + t[4] * 10 + t[5] * 1) / 3 )
  if b ~= 0 then
    return
  end
  --d4d5d6=635 is divisible by 5
  local a, b = math.modf( (t[4] * 100 + t[5] * 10 + t[6] * 1) / 5 )
  if b ~= 0 then
    return
  end
  --d5d6d7=357 is divisible by 7
  local a, b = math.modf( (t[5] * 100 + t[6] * 10 + t[7] * 1) / 7 )
  if b ~= 0 then
    return
  end
  --d6d7d8=572 is divisible by 11
  local a, b = math.modf( (t[6] * 100 + t[7] * 10 + t[8] * 1) / 11 )
  if b ~= 0 then
    return
  end
  --d7d8d9=728 is divisible by 13
  local a, b = math.modf( (t[7] * 100 + t[8] * 10 + t[9] * 1) / 13 )
  if b ~= 0 then
    return
  end
  --d8d9d10=289 is divisible by 17
  local a, b = math.modf( (t[8] * 100 + t[9] * 10 + t[10] * 1) / 17 )
  if b ~= 0 then
    return
  end
  return true
end

t = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 }
the_sum = 0

repeat
  if is_valid_number(t) then
    local d = to_digit(t, 1, #t)
    print("!", d)
    the_sum = the_sum + d
  end
until not next_permutation(t)


print("problem #43", "the sum of all 0 to 9 pandigital numbers:", the_sum, the_sum == 16695334890)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
