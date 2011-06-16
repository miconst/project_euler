-- problem # 120

local job_time = os.time()

remainder_sum = 0

for a = 3, 1000 do
  local a_sq = a * a
  local a_1, a_2 = 1, 1
  local b_1, b_2 = 1, 1
  local remainder_max = 0
  for n = 1, a * 2 do
--    a_1 = a_1 * (a - 1)
--    a_2 = a_2 * (a + 1)

    b_1 = b_1 * (a - 1)
    b_2 = b_2 * (a + 1)

    while b_1 > a_sq do
      b_1 = b_1 - a_sq
    end
    while b_2 > a_sq do
      b_2 = b_2 - a_sq
    end
    local b = b_1 + b_2
    while b >= a_sq do
      b = b - a_sq
    end

    if remainder_max < b then
      remainder_max = b
    end
--    local r = (a_1 + a_2) % a_sq
--    assert(r == (b_1 % a_sq + b_2 % a_sq) % a_sq)
--    assert(r == b)
    --print(a_1, a_2, r)
  end

  remainder_sum = remainder_sum + remainder_max
end

print("problem #120", "the remainder sum:", remainder_sum, remainder_sum == 333082500)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
