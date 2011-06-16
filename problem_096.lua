-- problem #96

local job_time = os.time()

local board = {
{3,0,0, 2,0,0, 0,0,0},
{0,0,0, 1,0,7, 0,0,0},
{7,0,6, 0,3,0, 5,0,0},

{0,7,0, 0,0,9, 0,8,0},
{9,0,0, 0,2,0, 0,0,4},
{0,1,0, 8,0,0, 0,5,0},

{0,0,9, 0,4,0, 3,0,1},
{0,0,0, 7,0,2, 0,0,0},
{0,0,0, 0,0,8, 0,0,6}}

local function get_values(board, row, col)
  assert(type(board[row][col]) ~= "number")
  local allowed = {}
  local N = #board
  for i = 1, N do
    allowed[i] = true
  end
  -- check the column
  for c = 1, N do
    allowed[board[row][c]] = nil
  end
  -- check the row
  for r = 1, N do
    allowed[board[r][col]] = nil
  end
  -- check the box
  local start_row = 3 * math.floor((row - 1) / 3) + 1
  local start_col = 3 * math.floor((col - 1) / 3) + 1
  --print(start_row, start_col)
  for r = start_row, start_row + 2 do
    for c = start_col, start_col + 2 do
      allowed[board[r][c]] = nil
    end
  end
  local values = {}
  for k in pairs(allowed) do
    --print( "found", k)
    table.insert(values, k)
  end
  assert(#values > 0, string.format("%dx%d", row, col))
  table.sort(values)
  return values
end

local function convert(board)
  local N, n = #board, 1
  for i = 1, N do
    for j = 1, N do
      if board[i][j] == 0 or type(board[i][j]) ~= "number" then
        board[i][j] = "x" .. tostring(n)
        n = n + 1
      end
    end
  end
end

local function update(board)
  convert(board)
  local N = #board
  -- for each row
  for i = 1, N do
    local row = {}
    local sum = 45
    for j = 1, N do
      if type(board[i][j]) == "number" then
        sum = sum - board[i][j]
      else
        table.insert(row, board[i][j])
      end
    end
    print(table.concat(row, " + ") .. " = " .. tostring(sum))
  end
  print("-------")
  -- for each column
  for j = 1, N do
    local col = {}
    local sum = 45
    for i = 1, N do
      if type(board[i][j]) == "number" then
        sum = sum - board[i][j]
      else
        table.insert(col, board[i][j])
      end
    end
    print(table.concat(col, " + ") .. " = " .. tostring(sum))
  end
  print("-------")
  -- for each box
  for b = 1, N do
    local start_row = 3 * math.floor((b - 1) / 3) + 1
    local start_col = 3 * math.floor((b - 1) % 3) + 1
    --print(start_row, start_col)
    local box = {}
    local sum = 45
    for i = start_row, start_row + 2 do
      for j = start_col, start_col + 2 do
        if type(board[i][j]) == "number" then
          sum = sum - board[i][j]
        else
          table.insert(box, board[i][j])
        end
      end
    end
    print(table.concat(box, " + ") .. " = " .. tostring(sum))
  end

  print("-------")
  local updated = false
  for i = 1, N do
    for j = 1, N do
      local n = board[i][j]
      if type(n) ~= "number" then
        local v = get_values(board, i, j)
        print(n, "=", unpack(v))
        if #v == 1 then
          updated =  true
          board[i][j] = v[1]
        end
      end
    end
  end

  if updated then
    print("!!")
    return update(board)
  end
end

--convert(board)
--print(unpack(get_values(board, 7, 6)))
update(board)

local function print_matrix(matrix)
  local N = #matrix
  print("++++++++++++++++++++")
  for i = 1, N do
    print(unpack(matrix[i]))
  end
end

print_matrix(board)

do return end



print_matrix(board)

local function get_valid_row(matrix, row, col)
  local N = #matrix
  for i = row, N do
    if matrix[i][col] ~= 0 then
      return i
    end
  end
end

local function determinant(matrix)
  local N, sign = #matrix, 1
  for i = 1, N - 1 do
    --print_matrix(matrix)
    local a = get_valid_row(matrix, i, i)
    if a == nil then
      return 0
    elseif a ~= i then
      sign = -sign
      print("sign has been changed!")
      matrix[i], matrix[a] = matrix[a], matrix[i]
    end
    local row_i = matrix[i]
    for j = i + 1, N do
      local row_j = matrix[j]
      local a, b = row_j[i], row_i[i]
      for k = 1, N do
        row_j[k] = row_j[k] - row_i[k] * a / b
      end
    end
  end
  local D = 1
  for i = 1, N do
    D = D * matrix[i][i]
  end
  return sign * D
end

local M = {
  { 0, 2, 3, 4 },
  { 5, -6, -7, 2 },
  { 5, 0, -7, -8 },
  { 10, 10, 10, -10 },
}

print(determinant(board))

print("problem #96", "right triangles:", count, count == 14234)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
