-- problem #147
job_time = os.time()

function C(w, h)
  if w < h then
    w, h = h, w
  end
  local a = w * (w + 1) * h * (h + 1) / 4
  local b = ((w + w - h) * (h * h * 4 - 1) - 3) * h / 6
  return a + b
end

function is_valid_rectangle(x, y, width, height, grid)
  for row = y, y + (height - 1) do
    if x < grid[row][1] or x + width - 1 > grid[row][2] then
      return false
    end
  end
  return true
end

function count_cross_hatched_rectangles(width, height, grid)
  local c = 0
  for x = 1, #grid - (width - 1) do
    for y = 1, #grid - (height - 1) do
      if is_valid_rectangle(x, y, width, height, grid) then
        c = c + 1
      end
    end
  end
  return c
end

function make_cross_hatched_grid(width, height)
  local grid = {}
  local D = width + height - 2
  local A = width - 2
  local B = height - 2
  local a, b = math.max(A + 1, 1), math.min(A + 2, D)
  for i = 1, D do
    grid[i] = { a, b }
    if i <= A then
      a = a - 1
    elseif i > A + 1 then
      a = a + 1
    end
    if i <= B then
      b = b + 1
    elseif i > B + 1 then
      b = b - 1
    end
  end
  return grid
end

function count_rectangles(width, height)
  local a, b, c = 0, 0, 0
  local grid = make_cross_hatched_grid(width, height)
  for h = 1, height do
    for w = 1, width do
      a = a + (1 + height - h) * (1 + width - w)
    end
  end
  for h = 1, #grid do
    for w = h, #grid do
      local x = count_cross_hatched_rectangles(w, h, grid)
      b = b + (h == w and x or 2 * x)
    end
  end
  c = a + b
  return c, a, b
end

W = 47 --3
H = 43 --2

count = 0
for w = 1, W do
  for h = 1, H do
--~     print(w, h, count_rectangles(w, h))
--~     count = count + count_rectangles(w, h)
--~     assert(count_rectangles(w, h) == C(w, h))
    count = count + C(w, h)
  end
end

print("problem #147", "the number of rectangles that could be situated within 47x43 and smaller grids:", count, count == 846910284)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
