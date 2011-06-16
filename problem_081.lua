-- problem #81
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

--for _, t in ipairs(make_min_matrix(matrix)) do
--  print("!", unpack(t))
--end

local out = make_min_matrix(matrix)
local N = #matrix
local sum = out[N][N]

print("problem #81", "the minimal path sum:" , sum, sum == 427337)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
