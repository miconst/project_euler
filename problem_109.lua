-- problem # 109

local job_time = os.time()

local SECTOR_NUM = 20
local singles, doubles, triples, scores = {}, {}, {}, {}

-- miss
table.insert(scores,  0)
-- sectors
for i = 1, SECTOR_NUM do
  table.insert(singles, i * 1)
  table.insert(doubles, i * 2)
  table.insert(triples, i * 3)
  table.insert(scores,  i * 1)
  table.insert(scores,  i * 2)
  table.insert(scores,  i * 3)
end
-- bulls-eye
table.insert(singles, 25)
table.insert(doubles, 50)
table.insert(scores,  25)
table.insert(scores,  50)

checkout_ways = 0

-- throw #1
for _, d in pairs(doubles) do
  local throw_1 = d
  -- throw #2
  for i = 1, #scores do
    local throw_2 = throw_1 + scores[i]
    -- throw #3
    for j = i, #scores do
      local throw_3 = throw_2 + scores[j]
      if throw_3 < 100 then
        checkout_ways = checkout_ways + 1
      end
    end
  end
end


print("problem #109", "the distinct checkout ways for a score less than 100:", checkout_ways, checkout_ways == 38182)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
