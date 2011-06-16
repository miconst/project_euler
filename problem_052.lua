-- problem #52
job_time = os.time()


function normalize(n)
  n = tostring(n)
  local tn = {}
  for i = 1, #n do
    table.insert(tn, n:sub(i, i))
  end
  table.sort(tn)
  return table.concat(tn)
end

number = 10
while true do
  local n = normalize(number)
  if n == normalize(number * 2) and
     n == normalize(number * 3) and
     n == normalize(number * 4) and
     n == normalize(number * 5) and
     n == normalize(number * 6) then
    break
  end
  number = number + 1
end

print("problem #52", "the smallest positive integer:", number, number == 142857)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
