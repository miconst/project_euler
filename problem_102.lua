-- problem #102
job_time = os.time()

function string:split(delim, plain)
  delim = (not delim or delim == "") and "%s+" or delim
  local list = {}
  local s = self
  while s:len() > 0 do
    local a = { s:find(delim, 1, plain) }
    if a[1] then
      table.insert(list, s:sub(1, a[1] - 1))
      s = s:sub(a[2] + 1)
      for i = 3, #a do
        table.insert(list, a[i])
      end
    else
      table.insert(list, s)
      s = ""
    end
  end
  return list
end

function sign(x0, y0, x1, y1, x, y)
  return (y0 - y1) * x + (x1 - x0) * y + (x0 * y1 - x1 * y0)
end

function origin_sign(x0, y0, x1, y1)
  local d = (x0 * y1 - x1 * y0)
  assert(d ~= 0, "line intersects the origin!")
  return d > 0
end

function is_origin_in(triangle)
  local a = origin_sign(triangle[1], triangle[2], triangle[3], triangle[4])
  local b = origin_sign(triangle[3], triangle[4], triangle[5], triangle[6])
  local c = origin_sign(triangle[5], triangle[6], triangle[1], triangle[2])
  return a == b and b == c
end

--~ A = { -340, 495, -153, -910, 835, -947 }
--~ B = { -175,  41, -421, -714, 574, -645 }
--~ print(is_origin_in(A))
--~ print(is_origin_in(B))

count = 0
for s in assert(io.open(arg[1] or "triangles.txt")):lines() do
  local t = s:split "%,"
--~   print(unpack(t))
  if is_origin_in(t) then
    count = count + 1
  end
end

print("problem #102", "the number of triangles for which the interior contains the origin:", count, count == 228)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
