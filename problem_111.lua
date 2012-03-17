-- problem #111
require "mathlib"

job_time = os.time()

function is_prime(number)
  if number > 3 then
    if number % 2 == 0 or number % 3 == 0 then
      return false
    end
    -- all primes are of the form 6k - 1
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

sum = 0
for i = 1, 9 do
  for j = 1, 9 do
    local n = i * 10^9 + j
    if is_prime(n) then
      sum = sum + n
    end
  end
end
--~ assert(sum == 67061)

for _, k in ipairs { 1, 3, 4, 5, 6, 7, 9 } do
  for i = 0, 9 do
    local numbers = { k, k, k, k, k, k, k, k, k, i }
    table.sort(numbers)
    repeat
      if numbers[1] ~= 0 then
        local n = numbers[1]
        for j = 2, #numbers do
          n = n * 10 + numbers[j]
        end
        if is_prime(n) then
          sum = sum + n
        end
      end
    until not next_permutation(numbers)
  end
end

for _, k in ipairs { 2, 8 } do
  for i = 0, 9 do
    local numbers = { k, k, k, k, k, k, k, k, i }
    table.sort(numbers)
    repeat
      if numbers[1] ~= 0 then
        local n0 = numbers[1]
        for j = 2, #numbers do
          n0 = n0 * 10 + numbers[j]
        end
        for j = 1, 9, 2 do
          local n = n0 * 10 + j
          if is_prime(n) then
            sum = sum + n
          end
        end
      end
    until not next_permutation(numbers)
  end
end

print("problem #111", "The sum of all S(10, d):", sum, sum == 612407567715)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
