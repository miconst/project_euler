-- problem #78
local job_time = os.time()

p_n = 1
p_d = 1

function get_next_pair()
  local a = p_n + p_d
  local b = a + p_d
  p_n = b
  p_d = p_d + 1
  while p_n > 1000000 do
    --print("!", p_n)
    p_n = p_n - 1000000
  end
  while p_d > 1000000 do
    print("@", p_d)
    p_d = p_d - 1000000
    print("@", p_d, a, b)
  end
  return a, b
end

function p(n)
  local sum = n
  n = n - 3
  while n > 0 do
    sum = sum + n
    n = n - 2
  end
  return sum
end


print(p(9), p(10), p(11))

local n = 2
local last_pn = 0
while false do
  local a, b = get_next_pair() --pn = p(n)
--~   print(a)
--~   print(b)
--~   if pn >= 1000000 and pn % 1000000 == 0 then
--~     print(n, pn)
--~     break
--~   end
--~   if pn > 10000000 then
--~     print(n, pn, pn - last_pn)
--~   end
--~   last_pn = pn
  --n = n + 1
--~   if b > 30 then
--~     break
--~   end

  if a % 100 == 0 then
    print(n, a) --, p(n)/1000000)
    break
  end
  if b % 100 == 0 then
    print(n + 1, b) --, p(n)/1000000)
    break
  end
  n = n + 2
end

print("problem #78", "line number:" , line, line == 709)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
