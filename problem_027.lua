-- problem #37
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

local N, A, B = 0

for a = -999, 999 do
  for b = 3, 999, 2 do
    if is_prime(b) then
      local n = 0
      while true do
        local x = n * n + a * n + b
        if x < 2 or not is_prime(x) then
          break
        end
        n = n + 1
      end
      if n > N then
        N, A, B = n, a, b
        print(N, A, B)
      end
    end
  end
end

print("problem #27", "a and b:" , A * B, A * B == -59231)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
