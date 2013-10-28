-- problem #136
job_time = os.time()

-- arithmetic progression x, x - y, x - 2 * y.
-- x^2 - (x - y)^2 - (x - 2*y)^2 = -( x^2 - 6 * x * y + 5 * y^2 ) = f
-- it's a parabola.
-- for each y in [1, 10^6]:
-- f = 0 -> x = y and x = 5 * y
-- max(f) -> x = 3 * y

N = 50*10^6
done = {}


for y = 1, N - 1 do
  for x = y + 1, 3 * y do
    local n = -( x * x - 6 * x * y + 5 * y * y )
    if n >= N then
      break
    end
    if x > 2 * y and x < 3 * y then
      done[ n ] = 2 + (done[ n ] or 0)
    else  -- x <= 2 * y or x >= 3 * y
      done[ n ] = 1 + (done[ n ] or 0)
    end
  end
end

count = 0

for _, v in pairs( done ) do
  if v == 1 then
    count = count + 1
  end
end

print("problem #136", "The number of the unique solutions for n less than 50*10^6:" , count, count == 2544559)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
