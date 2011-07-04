-- problem #75
job_time = os.time()

L = 1500000
count = 0
triangles = {}

c_max = math.sqrt(L / 2)
--~ print(c_max)

-- pythagorean triples:
-- http://www.wolframalpha.com/input/?i=x%5E2%2By%5E2%3Dz%5E2%2C+integer+solution
for c1 = 1, c_max do
  for c2 = 1, c1 - 1 do
    local a = c1^2 + c2^2
    local b = c1^2 - c2^2
    local c = 2 * c1 * c2
    if b > c then
      b, c = c, b
    end
    local l_min = a + b + c
    local z, x, y = a, b, c
    for l = l_min, L, l_min do
      if not triangles[l] then
        triangles[l] = { count = 0 }
      end
      local k = tostring(x) .. "X" .. tostring(y) .."X" .. tostring(z)
      if not triangles[l][k] then
        triangles[l][k] = true
        triangles[l].count = triangles[l].count + 1
      end
      z = z + a
      x = x + b
      y = y + c
    end
  end
end

--t = {}
for k, v in pairs(triangles) do
  if v.count == 1 then
    count = count + 1
--    v.count = nil
--    for t in pairs(v) do
--      print(k, ":", t)
--    end
--    t[count] = k
  end
end

--table.sort(t)
--print(table.concat(t, ","))

print("problem #75", "one integer sided right angle triangles:", count, count == 161667)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
