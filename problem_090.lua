-- problem #90
local job_time = os.time()

square_numbers = { 01, 04, 09, 16, 25, 36, 49, 64, 81 }
square_numbers_transformed = { "01", "04", "06", "16", "25", "36", "46", "64", "81" }
square_number_digits = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "6" }

sequence = {}
for i = 1, #square_number_digits - 3 do
  for j = i + 1, #square_number_digits - 2 do
    for k = j + 1, #square_number_digits - 1 do
      for l = k + 1, #square_number_digits do
        table.insert(sequence, { [i] = true, [j] = true, [k] = true, [l] = true })
      end
    end
  end
end

function is_valid(not_a, not_b)
  -- merge our cubes
  local possible_numbers = {}
  for a = 1, #square_number_digits do
    if not_a[a] == nil then
      local digit_a = square_number_digits[a]
      for b = 1, #square_number_digits do
        if not_b[b] == nil then
          local digit_b = square_number_digits[b]
          possible_numbers[digit_a .. digit_b] = true
          possible_numbers[digit_b .. digit_a] = true
        end
      end
    end
  end

  for _, n in ipairs(square_numbers_transformed) do
    if not possible_numbers[n] then
      return false
    end
  end

  return true
end

arrangements = 0
for i = 1, #sequence do
  for j = 1, #sequence do
    if is_valid(sequence[i], sequence[j]) then
      arrangements =  arrangements + 1
    end
  end
end

--print(#sequence * #sequence)


print("problem #90", "distinct arrangements of the two cubes:",  arrangements/2,  arrangements/2 == 1217)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
