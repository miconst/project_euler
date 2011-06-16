-- problem # 129

job_time = os.time()

function A(n)
  local i, r, R_i = 1, 1, 1
  while R_i ~= 0 do
    r = (r * 10) % n
    R_i = (R_i + r) % n
    i = i + 1
  end
  return i
end

p = 1 + 1000000 -- since A(n) <= n
while true do
  if p % 5 ~= 0 then
    if A(p) > 1000000 then
      break
    end
  end
  p = p + 2
end

print("problem #129", "the least value of n for which A(n) first exceeds one-million:", p, p == 1000023)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
