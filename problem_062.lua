-- problem #62
job_time = os.time()

function normalize(n)
  local t = {}
  while n > 0 do
    table.insert(t, tostring(n % 10))
    n = math.floor(n / 10)
  end
  table.sort(t)
  return table.concat(t)
end

cubes = {}
i = 1
while true do
  local c = i * i * i
  local s = normalize(c)

  if not cubes[s] then
    cubes[s] = {}
  end
  table.insert(cubes[s], i)

  if #cubes[s] == 5 then
    print(s, ":", unpack(cubes[s]))
    cube = cubes[s][1] * cubes[s][1] * cubes[s][1]
    break
  end
  i = i + 1
end

print("problem #62", "the smallest cube for which exactly 5 permutations of its digits are cube:", cube, cube == 127035954683)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
