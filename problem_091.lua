-- problem #91

local job_time = os.time()

N = 50

function is_right_angle(x1, y1, x2, y2)
  if x1 == x2 and y1 == y2 then
    return false
  end
  if x1 == 0 and y1 == 0 then
    return false
  end
  if x2 == 0 and y2 == 0 then
    return false
  end

  local a = x1 * x1 + y1 * y1
  local b = x2 * x2 + y2 * y2
  local c = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
  if a > c then
    c, a = a, c
  end
  if b > c then
    c, b = b, c
  end
  return a + b == c
end

triangle_count = 0

for x1 = 0, N do
  for y1 = 0, N do
    for x2 = 0, N do
      for y2 = 0, N do
        if is_right_angle(x1, y1, x2, y2) then
          triangle_count = triangle_count + 0.5
        end
      end
    end
  end
end

print("problem #91", "right triangles:", triangle_count, triangle_count == 14234)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
