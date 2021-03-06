-- problem #83
local job_time = os.time()

local matrix = {}
for line in assert(io.open "matrix.txt"):lines() do
  local t = {}
  for n in line:gmatch "%d+" do
    table.insert(t, tonumber(n))
  end
  table.insert(matrix, t)
end

local function make_min_matrix(m)
  local out = {}
  local N = #m
  for i = 1, N do
    out[i] = {}
  end

  -- set the first row/column
  out[1][1] = m[1][1]
  for i = 2, N do
    out[1][i] = out[1][i - 1] + m[1][i]
    out[i][1] = out[i - 1][1] + m[i][1]
  end

  -- fill the matrix
  for i = 2, N do
    for j = 2, N do
      out[i][j] = m[i][j] + math.min(out[i][j - 1], out[i - 1][j])
    end
  end

  return out
end

--~ for _, t in ipairs(make_min_matrix(matrix)) do
--~   print(unpack(t))
--~ end

local map = make_min_matrix(matrix)
local N = #matrix
local sum_min = map[N][N]

for r = 1, N do
  for c = 1, N do
    map[r][c] = sum_min
  end
end

function make_path(sum, row, col)
  sum = sum + matrix[row][col]
  if sum < sum_min and sum < map[row][col] then
    map[row][col] = sum
    if col == N and row == N then
      print(sum_min)
      sum_min = sum
    else
      -- we can move up, down, left or right
      -- 1. up
      if row > 1 then
        make_path(sum, row - 1, col)
      end
      -- 2. down
      if row < N then
        make_path(sum, row + 1, col)
      end
      -- 3. left
      if col > 1 then
        make_path(sum, row, col - 1)
      end
      -- 4. right
      if col < N then
        make_path(sum, row, col + 1)
      end
    end
  end
end

make_path(0, 1, 1)

print("problem #83", "the minimal path sum:" , sum_min, sum_min == 425185)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
