-- problem #191
job_time = os.time()

D = 30

prize_table = {}
for d = 1, D do
  prize_table[d] = {}
  for a = 0, 2 do
    prize_table[d][a] = {}
  end
end

function prize(d, a, l)
  if d == 0 then
    return 1
  else
    local c = prize_table[d][a][l]
    if not c then
      c = prize(d - 1, 0, l)
      if a < 2 then c = c + prize(d - 1, a + 1, l) end
      if l < 1 then c = c + prize(d - 1, 0, l + 1) end
      prize_table[d][a][l] = c
    end
    return c
  end
end

count = prize(D, 0, 0)

print("problem #191", 'the number of "prize" strings:', count, count == 1918080160)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
