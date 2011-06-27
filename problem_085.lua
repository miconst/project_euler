-- problem #85
job_time = os.time()

function get_num_of_rectangles(area_width, area_height)
  local count = 0
  for x = 1, area_width do
    for y = 1, area_height do
      count = count + x * y
    end
  end
  return count
end

function rect_num(w, h)
  return w * (w + 1) * h * (h + 1) / 4
end

-- x * (x + 1) * y * (y + 1) / 4 - 2 * 10^6 = 0
-- x * (x + 1) = 10^6
-- x_max = (sqrt(4 * 10^6 + 1) - 1) / 2

RECT_MAX = 2 * 10^6
AREA_MAX = math.ceil((math.sqrt(2 * RECT_MAX + 1) - 1) / 2)

delta = RECT_MAX
w_min, h_min = 0, 0

for w = 1, AREA_MAX do
  for h = 1, AREA_MAX do
--~     assert(get_num_of_rectangles(w, h) == rect_num(w, h))
    local d = math.abs(rect_num(w, h) - RECT_MAX)
    if d < delta then
      delta, w_min, h_min = d, w, h
    end
  end
end

area = w_min * h_min
--~ print(delta, w_min, h_min, rect_num(w_min, h_min))

print("problem #85", "the area of the grid with the nearest solution:", area, area == 2772)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
