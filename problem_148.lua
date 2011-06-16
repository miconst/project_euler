--~ require "imlua"
--~ require "imlua_process"

-- problem #148
job_time = os.time()

row_height = 7

function count_entries(height)
  local total = height * (height + 1) / 2
  local filled_area = 0
  local tri_count = 0

  local pow = math.floor(math.log(height) / math.log(row_height))
  local small_tri_area = row_height * (row_height - 1) / 2
  local normal_tri_area = row_height * (row_height + 1) / 2

  for i = 1, pow do
    local line_height = 7 ^ i
    local line_num = math.floor(height / line_height)
    local tri_num = line_num * (line_num - 1) / 2


    local tri_area = small_tri_area * (normal_tri_area ^ (i - 1))
    print("tri:", i, tri_num, tri_area, tri_area * tri_num)

    filled_area = filled_area + tri_area * tri_num
    tri_count = tri_count + tri_num

    local remain_lines = height - line_num * line_height
    local remain_tri_num = line_num
    local remain_tri_area = row_height * remain_lines - (remain_lines + 1) * remain_lines / 2

    print("", remain_lines, remain_tri_num, remain_tri_area)

    filled_area = filled_area + remain_tri_area * remain_tri_num
  end

  return total, total - filled_area, filled_area, tri_count
end

function get_next_row(row)
  local size = #row
  local next_row = { [1] = 1, [size + 1] = 1 }
  for i = 1, size - 1 do
    local a, b = row[i], row[i + 1]
    if a > 7 then
      a = a - 7
    end
    if b > 7 then
      b = b - 7
    end
    local c = a + b
    if c > 7 then
      c = c - 7
    end
    next_row[i + 1] = c
  end
  return next_row
end

--row_max = 10^9
--pow_max = math.floor(math.log(row_max) / math.log(row_height))
--print(row_max, pow_max, 7^pow_max, row_max - math.floor(row_max / (7^pow_max)) * (7^pow_max))
row_max = 0
while true do
  row_max = row_max + 1

  triangle_row = { 1 }
  count = 0
  entry_count = 0
  entry_count_2 = 0

  while #triangle_row <= row_max do
    count = count + #triangle_row
    for i = 1, #triangle_row do
      if triangle_row[i] == 7 then
        entry_count_2 = entry_count_2 + 1
      else
        entry_count = entry_count + 1
      end
    end

  --~   local s = table.concat(triangle_row)
  --~   s = s:gsub("7", "-"):gsub("[1-6]", "|")
  --~   print(s)

  --~   table.insert(triangles, triangle_row)
    triangle_row = get_next_row(triangle_row)
  end

--~ local render = function(x, y, d, param)
--~   x = x + 1
--~   --y = y + 1
--~   assert(x > 0)
--~   --assert(y > 0)
--~   assert(y <= #triangles)
--~   assert(triangles[row_max - y])
--~   local x = triangles[row_max - y][x]

--~   if x == nil then
--~     return 0
--~   elseif x == 7 then
--~     return 255
--~   else
--~     return 128
--~   end
--~ end

--~ image = im.ImageCreate(row_max, row_max, im.GRAY, im.BYTE)
--~ im.ProcessRenderOp(image, render, "histogram", {}, 0)
--~ image:Save("Pascal.png", "PNG")

--~ end

--~ print("problem #148", "total number:", count, entry_count, entry_count_2, entry_count + entry_count_2)

--~ job_time = os.time() - job_time
--~ print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))

--~ local _count, _entry_count, _entry_count_2 = count_entries(row_max)
--~ print("count:", count, _count, count == _count)
--~ print("empty:", entry_count_2, _entry_count_2, entry_count_2 == _entry_count_2)
--~ print("filled:", entry_count, _entry_count, entry_count == _entry_count)


-- test
height = row_max


local tri_6x6_area = 21 -- row_height * (row_height - 1) / 2
local tri_7x7_area = 28 -- row_height * (row_height + 1) / 2


--~ local tri_6x6_count = math.max(math.floor(height / row_height) - 1, 0)
--~ local area = tri_6x6_area * tri_6x6_count * (tri_6x6_count + 1) / 2

--~ local remain_lines = height - math.floor(height / row_height) * row_height
--~ local remain_tri_area = row_height * remain_lines - (remain_lines + 1) * remain_lines / 2

--~ area = area + remain_tri_area * (tri_6x6_count + 1)


--~ local remain_lines = height - math.floor(height / row_height^2) * row_height^2

function get_points(height, tri_size)
  if height > row_height then
    local tri_area = tri_size * (tri_size + 1) / 2

    local full_row_count = math.max(math.floor(height / row_height) - 1, 0)
    local full_tri_count = full_row_count * (full_row_count + 1) / 2

    local area = full_tri_count * tri_area

    local remain_lines = height - (full_row_count + 1) * row_height
    local remain_tri_area = tri_size * remain_lines - (remain_lines - 1) * remain_lines / 2

    print(remain_lines, remain_tri_area)
    area = area + remain_tri_area * (full_row_count + 1)

    return area
  else
    return 0
  end
end

--~ print(get_points(49, 7) - get_points(49 - 1, 7))
--~ do return end


area_2 = get_points(height, 6)
local pow_max = math.floor(math.log(height) / math.log(row_height))

local tri_height_max = 7 ^ pow_max
local line_num_max = math.floor(height / tri_height_max)
local height_max = line_num_max * tri_height_max
local remain_lines = height - line_num_max * tri_height_max
local remain_height = height_max

for pow = pow_max, 2, -1 do
  local tri_height = 7 ^ pow
  local line_num = math.floor(height_max / tri_height)
  local tri_num = line_num * (line_num - 1) / 2

  local tri_area = tri_6x6_area * (tri_7x7_area ^ (pow - 1))
--~   print("tri:", i, tri_num, tri_area, tri_area * tri_num)

  area_2 = area_2 + tri_area * tri_num

  if remain_lines > 0 then
    local line_num = math.floor(remain_height / tri_height)
    if pow ~= pow_max then
      line_num = line_num * 2
    end
    local x = line_num * (get_points(tri_height, 7) - get_points(tri_height - remain_lines, 7))
    print(height, ":", pow, "!!", remain_lines, tri_height, x)
    area_2 = area_2 + x

    remain_height = remain_lines - 1
    remain_lines = remain_lines - 7 ^ (pow - 1)
    --remain_lines = height - math.floor(height / 7 ^ (pow - 1)) * 7 ^ (pow - 1)
    --print((get_points(49, 7) - get_points(1, 7)))
  end
end

--~ local t_min = height % row_height ^ 2
--~ print("t_min", t_min)

--~ local t_max = row_height - math.floor((t_min + row_height -1) / row_height)
--~ print("t_max", t_max)

--~ area = area + t_max * t_min

--~ print("!", area, area_2)

  if area_2 ~= entry_count_2 then
    print(row_max, area_2, entry_count_2, area_2 - entry_count_2)
    return
  end
end
