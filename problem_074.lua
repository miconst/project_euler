-- problem #74
job_time = os.time()

factorials = { [0] =  1, [1] =  1, [2] =  2, [3] =  6, [4] = 24, [5] = 120,
  [6] = 720, [7] = 5040, [8] = 40320, [9] = 362880 }

function get_next(number)
  local sum = 0
  while number > 0 do
    local x = number % 10
    sum = sum + factorials[x]
    number = (number - x) / 10
  end
  return sum
end

links = {}

function link(number)
  while not links[number] do
    links[number] = get_next(number)
    number = links[number]
  end
end

lengthes = {}

function get_length(number)
  local count = 0
  local done = {}
  local i = number
  while not done[i] do
    if lengthes[i] then
      count = count + lengthes[i]
      break
    else
      count = count + 1
    end
    done[i] = true
    i = links[i]
  end
  lengthes[number] = count
  return count
end

NUM_MAX = 10^6 - 1
count = 0

for i = 1, NUM_MAX do
  link(i)
  if get_length(i) == 60 then
    count = count + 1
  end
end

print("problem #74", "sixty non-repeating terms chains:", count, count == 402)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
