-- problem #139
job_time = os.time()

PERIMETER_MAX = 100000000

--~ magic_numbers = {
--~   5,
--~   29,
--~   169,
--~   985,
--~   5741,
--~   33461,
--~   195025,
--~   1136689,
--~   6625109,
--~   38613965,
--~   93222358,
--~ }

triangle_count = 0

for i = 2, PERIMETER_MAX do
  local d = 2 * i * i - 1
  local x = math.sqrt(d)
  if math.floor(x) == x then
    local n = x - 1

    local c = i
    local a = n / 2
    local b = 1 + n / 2

    local perimeter = a + b + c

    triangle_count = triangle_count + math.floor(PERIMETER_MAX / perimeter)
  end
end

print("problem #139", "Pythagorean triangles:", triangle_count, triangle_count == 10057761)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
