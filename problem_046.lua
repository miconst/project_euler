-- problem #46
local job_time = os.time()

primes = { [2] = true, [3] = true }

function is_prime(number)
  if not primes[number] then
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
    primes[number] = true
  end
  return true
end

local function is_goldbach(n)
  for i = 1, n do
    local twice_a_square = 2 * i * i
    local prime = n - twice_a_square
    if prime <= 0 then
      return false
    end
    if is_prime(prime) then
      return true
    end
  end
end

local function get_odd_composite()
  local i = 3
  while true do
    if not is_prime(i) and not is_goldbach(i) then
      return i
    end
    i = i + 2
  end
end

local i = get_odd_composite()

print("problem #46", "the smallest odd composite:" , i, i == 5777)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
