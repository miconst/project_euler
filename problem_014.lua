-- problem #14
local job_time = os.time()

function get_next(n)
  return n % 2 == 0
    and n / 2     -- n is even
    or 3 * n + 1  -- n is odd
end

numbers = { 1 }
longest_chain = 0
start_number = 0

for i = 1, 999999 do
  local j, c = i, 0

  while not numbers[j] do
    j = get_next(j)
    c = c + 1
  end

  c = c + numbers[j]
  numbers[i] = c

  if c > longest_chain then
    longest_chain = c
    start_number = i
  end
end

print("problem #14", "starting number:" , start_number, start_number == 837799)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
