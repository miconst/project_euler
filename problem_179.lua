-- problem #179
job_time = os.time()

N_MAX = 10^7

function get_main_primes(n)
  local primes = {}
  -- generate a list of integers from 2 to N
  for i = 1, n do
    primes[i] = i
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if primes[i] == i then
      for j = i + i, n, i do
        primes[j] = i
      end
    end
  end
  return primes
end

main_primes = get_main_primes(N_MAX - 1)

function get_divisors(number)
  local divisors = {}
  while number > 1 do
    local p = main_primes[ number ]
    if not divisors[p] then
      divisors[p] = 0
    end
    divisors[p] = divisors[p] + 1
    number = number / p
  end
  return divisors
end

function count_divisors(number)
  local c = 0
  for k, v in pairs(get_divisors(number)) do
    c = c * (v + 1) + v
  end
  return c
end

count = 0
local a = count_divisors(N_MAX - 1)
for n = N_MAX - 2, 2, -1 do
  local b = count_divisors(n)
  if a == b then
    count = count + 1
  end
  a = b
end

print("problem #179", "the number of integers, for which n and n + 1 have the same number of positive divisors:", count, count == 986262)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
