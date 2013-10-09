-- problem #135
job_time = os.time()

-- arithmetic progression x, x - y, x - 2 * y.
-- x^2 - (x - y)^2 - (x - 2*y)^2 = -( x^2 - 6 * x * y + 5 * y^2 ) = f
-- it's a parabola.
-- for each y in [1, 10^6]:
-- f = 0 -> x = y and x = 5 * y
-- max(f) -> x = 3 * y

done = {}

for y = 1, 10^6 do
  for x = y + 1, 3 * y do
    local n = -( x * x - 6 * x * y + 5 * y * y )
--~     assert( n > 0, tostring( y ) .. ":" .. tostring( x ) )
    if n > 10^6 then
      break
    end
    if x > 2 * y and x < 3 * y then
      done[ n ] = 2 + (done[ n ] or 0)
    else
      done[ n ] = 1 + (done[ n ] or 0)
    end
  end
end

--~ print(done[27])
--~ print(done[1155])

count = 0

for _, v in pairs( done ) do
  if v == 10 then
    count = count + 1
  end
end

print("problem #135", "Number of n less than 10^6 with 10 distinct solutions:" , count, count == 4989)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
