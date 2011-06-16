-- problem #42
local job_time = os.time()

function get_sum(s)
  local sum = 0
  local A = string.byte("A", 1)
  s = s:upper()
  for i = 1, #s do
    sum = sum + s:byte(i) - A + 1
  end
  return sum
end

triangle_numbers = {}
for n = 1, 1000 do
  local i = n * (n + 1) / 2;
  triangle_numbers[i] = true
end

the_count = 0
for s in assert(io.open(arg[1] or "words.txt")):read "*all" :gmatch '"(%w*)"' do
  local n = get_sum(s)
  if triangle_numbers[n] then
    print(s, n)
    the_count = the_count + 1
  end
end

print("problem #42", "triangle words:", the_count, the_count == 162)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
