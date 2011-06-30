-- problem #145
job_time = os.time()

function get_num_of_reversible(n)
  local sum = 0
  -- 2 * i = n
  for i = 1, n / 2 do
    sum = sum + 20 * 30^(i - 1)
  end
  -- n = 4 * i + 3
  for i = 0, (n - 3) / 4 do
    sum = sum + 5 * 20 * (25 * 20)^i
  end
  return sum
end

print(get_num_of_reversible(1))
print(get_num_of_reversible(2))
print(get_num_of_reversible(3))
print(get_num_of_reversible(4))
print(get_num_of_reversible(5))
print(get_num_of_reversible(6))
print(get_num_of_reversible(7))
print(get_num_of_reversible(8))

count = get_num_of_reversible(9)

print("problem #145", "reversible numbers:" , count, count == 608720)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
