-- problem #58
local job_time = os.time()

function is_prime(number)
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

local i = 2
local side_length = 2
local diag_prime_count = 0

while true do
  local next_diag = i - 1 + side_length
  local last_diag = i - 1 + side_length * 4
  while next_diag <= last_diag do
    if is_prime(next_diag) then
      diag_prime_count = diag_prime_count + 1
	end
	next_diag = next_diag + side_length
  end
  if 10 * diag_prime_count < side_length + side_length + 1 then
    break
  end
  side_length = side_length + 2
  i = last_diag + 1
end

print("problem #58", "the side length of the square spiral:" , side_length + 1, side_length == 26241 - 1)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
