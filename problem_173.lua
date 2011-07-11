-- problem #173
job_time = os.time()

TILE_MAX = 10^6

count = TILE_MAX / 4 - 1
for w = 2, TILE_MAX / 4 do
  local free_tiles = TILE_MAX - w * 4
  for i = w - 2, 2, -2 do
    free_tiles = free_tiles - i * 4
    if free_tiles < 0 then
      break
    end
    count = count + 1
  end
end

print("problem #173", "the number of different square laminae:", count, count == 1572729)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
