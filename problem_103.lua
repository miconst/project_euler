-- problem #103
job_time = os.time()

n1 = {1}
n2 = {1, 2}
n3 = {2, 3, 4}
n4 = {3, 5, 6, 7}
n5 = {6, 9, 11, 12, 13}
n6 = {11, 18, 19, 20, 22, 25}
n7 = {20, 11+20, 18+20, 19+20, 20+20, 22+20, 25+20}

-- It seems that for a given optimum set,
-- A = {a1, a2, ... , an}, the next optimum set is of the form
-- B = {b, a1+b, a2+b, ... ,an+b}, where b is the "middle" element on the previous row.

-- By applying this "rule" we would expect the optimum set for n = 6 to be
-- A = {11, 17, 20, 22, 23, 24}, with S(A) = 117.
-- However, this is not the optimum set, as we have merely applied an algorithm to provide a near optimum set.
-- The optimum set for n = 6 is A = {11, 18, 19, 20, 22, 25},

function sum(s)
  local x = 0
  for i = 1, #s do
    x = x + s[i]
  end
  return x
end

function test_set(s, mask_a)
  local sa = 0
  local ca = 0
  for i = 1, #s do
    if mask_a % (2 ^ i) >= (2 ^ (i - 1)) then
      ca = ca + 1
      sa = sa + s[i]
    end
  end
  for j = 1, 2^(#s - ca) - 1 do
    local mask_b = j
    local sb = 0
    local cb = 0
    for i = 1, #s do
      if mask_a % (2 ^ i) >= (2 ^ (i - 1)) then
        mask_b = mask_b * 2
      elseif mask_b % (2 ^ i) >= (2 ^ (i - 1)) then
        cb = cb + 1
        sb = sb + s[i]
      end
    end
    assert(ca > 0)
    assert(cb > 0)
    assert(ca + cb <= #s)
    if cb == ca then
      if sb == sa then
        return false, mask_a, j
      end
    else
      if (cb > ca) ~= (sb > sa) then
        return false, mask_a, j
      end
    end
  end
  return true
end

function is_special_set(s)
  for mask = 1, 2^#s - 2 do
    if not test_set(s, mask) then
      return false
    end
  end
  return true
end

function copy(t)
  local tt = {}
  for k,v in pairs(t) do
    tt[k] = v
  end
  return tt
end

--~ print(is_special_set(s1))
--~ print(is_special_set(n7))
--~ print(sum(n7))

assert(is_special_set(n7))
optimum_set = copy(n7)
minimum_sum = sum(n7)

-- a1 + a2 > a3
-- a1 + a2 + a3 > a4 + a5 => a1 + a2 + a3 - a4 > a5
N = 7
next_sum = minimum_sum - 1
s = { 0, 0, 0, 0, 0, 0, 0 }
for a1 = 1, next_sum / N do
  s[1] = a1
  for a2 = a1 + 1, (next_sum - a1) / (N - 1) do
    local a12_max = a1 + a2 - 1
    s[2] = a2
    for a3 = a2 + 1, math.min((next_sum - a1 - a2) / (N - 2), a12_max) do
      s[3] = a3
      for a4 = a3 + 1, math.min((next_sum - a1 - a2 - a3) / (N - 3), a12_max) do
        s[4] = a4
        local a123_max = a1 + a2 + a3 - a4 - 1
        for a5 = a4 + 1, math.min((next_sum - a1 - a2 - a3 - a4) / (N - 4), a12_max, a123_max) do
          s[5] = a5
          for a6 = a5 + 1, math.min((next_sum - a1 - a2 - a3 - a4 - a5) / (N - 5), a12_max, a123_max) do
            s[6] = a6
            for a7 = a6 + 1, math.min((next_sum - a1 - a2 - a3 - a4 - a5 - a6) / (N - 6), a12_max, a123_max, a1 + a2 + a3 + a4 - a5 - a6 - 1) do
              s[7] = a7
              local x = a1 + a2 + a3 + a4 + a5 + a6 + a7
              assert(x < minimum_sum)
              if is_special_set(s) then
                print(x, ":", unpack(s))
                optimum_set = copy(s)
                minimum_sum = x
              end
            end
          end
        end
      end
    end
  end
end

s = table.concat(optimum_set)
print("problem #103", "The optimum set string:", s, s == "20313839404245")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
