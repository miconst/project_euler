-- problem #90
local job_time = os.time()

square_numbers = { 01, 04, 09, 16, 25, 36, 49, 64, 81 }
square_numbers_transformed = { "01", "04", "06", "16", "25", "36", "46", "64", "81" }
square_number_digits = { "0", "1", "2", "3", "4", "5", "6", "8", }

function is_valid(cube_a, cude_b)
  -- merge our cubes
  local possible_numbers = {}
  for _, digit_a in ipairs(cube_a) do
    for _, digit_b in ipairs(cube_b) do
      possible_numbers[digit_a .. digit_b] = true
      possible_numbers[digit_b .. digit_a] = true
    end
  end

  for _, n in ipairs(square_numbers_transformed) do
    if not possible_numbers[n] then
      return false
    end
  end
  return true
end

len = math.pow(#square_number_digits, 6)

print(len*len)

for i = 1, len do
  for j = 1, len do
  end
end



print("problem #90", "total of the digital sums:", sum, sum == 40886)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
