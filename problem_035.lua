-- problem #35
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

local function get_rotations(number)
  local rot = {}
  for i = 2, #number do
    rot[tonumber(number:sub(i) .. number:sub(1, i - 1))] = true
  end
  return rot
end

local function is_circular_prime(number)
  if is_prime(number) then
    number = tostring(number)
    if not number:find "02468" then
      for n in pairs(get_rotations(number)) do
        if not is_prime(n) then
          return nil
        end
      end
      return true
    end
  end
end

local count = 1
for i = 3, 1000000, 2 do
  if is_circular_prime(i) then
    count = count + 1
    --print(i)
  end
end

print("problem #35", "circular primes:" , count, count == 55)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
