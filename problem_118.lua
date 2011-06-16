-- problem # 118

job_time = os.time()

function is_prime(number)
  if number < 2 then
    return false
  end
  if number > 3 then
    if number % 2 == 0 or number % 3 == 0 then
      return false
    end
    -- all primes are of the form 6k ± 1
    local i_max = math.sqrt(number)  --number - 1
    for i = 5, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
    for i = 7, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
  end
  return true
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
  local last = #t
  local left = last
  while left > 1 do
    -- find rightmost element smaller than successor
    local right = left
    left = left - 1
    if t[left] < t[right] then
      -- swap with rightmost element that's smaller, flip suffix
      local mid = last
      while t[left] >= t[mid] do
        mid = mid - 1
      end
      t[left], t[mid] = t[mid], t[left]
      reverse(t, right, last)
      return true
    end
  end
  -- pure descending, flip all
  reverse(t, 1, last)
end

function is_set_valid(t, mask)
  local i, last_n = 1, 1
  while i <= 9 do
    local n = t[i]
    while mask % (2 ^ i) >= (2 ^ (i - 1)) do
      i = i + 1
      n = n * 10 + t[i]
    end
    if n < last_n or not is_prime(n) then
      return false
    end
    i = i + 1
    last_n = n
  end
  return true
end

num = 0

function get_valid_sets(t)
  for mask = 1, 255 do
    if is_set_valid(t, mask) then
      num = num + 1
    end
  end
end

local t = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }
get_valid_sets(t)
while next_permutation(t) do
  get_valid_sets(t)
end

print("problem #118", "the distinct sets number:", num, num == 44680)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
