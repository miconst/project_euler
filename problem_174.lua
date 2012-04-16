-- problem #174
job_time = os.time()

TILE_MAX = 10^6

tile_type = {}

for w = 3, TILE_MAX / 4 do
  for i = w - 2, 1, -2 do
    local tiles = w^2 - i^2
    if tiles > TILE_MAX then
      break
    end
    tile_type[tiles] = (tile_type[tiles] or 0) + 1
  end
end
--~ print(tile_type[8], tile_type[32])

N = {}
for t, n in pairs(tile_type) do
  N[n] = (N[n] or 0) + 1
end
--~ print(N[15])

sum = 0
for n = 1, 10 do
  sum = sum + (N[n] or 0)
end

print("problem #174", "the sum of N(n) for 1 <= n <= 10:", sum, sum == 209566)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
