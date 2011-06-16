-- problem #96
local job_time = os.time()

local su_doku_sample = {
  "300 200 000",
  "000 107 000",
  "706 030 500",
  "070 009 080",
  "900 020 004",
  "010 800 050",
  "009 040 301",
  "000 702 000",
  "000 008 006",
}

local BOX_SIZE = 3
local BOARD_SIZE = BOX_SIZE * 3
local PERMS = {}
local DIGITALS = {}

for i = 1, BOARD_SIZE do
  DIGITALS[i] = tostring(i)
end

function get_intersection(a, b, c)
  local t = {}
  for i = 1, BOARD_SIZE do
    if not(a[i] or b[i] or c[i]) then
      table.insert(t, i)
    end
  end
  return t
end

function get_box_num(row, col)
  return 1 + math.floor((col - 1) / BOX_SIZE) + BOARD_SIZE / BOX_SIZE * math.floor((row - 1) / BOX_SIZE)
end

function analize_it(board)
  local row_moves, col_moves, box_moves = {}, {}, {}
  for i = 1, BOARD_SIZE do
    row_moves[i], col_moves[i], box_moves[i] = {}, {}, {}
  end

  for r = 1, BOARD_SIZE do
    for c = 1, BOARD_SIZE do
      local n = board[r][c]
      if n ~= 0 then
        row_moves[r][n] = true
        col_moves[c][n] = true
        box_moves[get_box_num(r,c)][n] = true
      end
    end
  end
  return row_moves, col_moves, box_moves
end

function set_obvious_moves(board)
  while true do
    local row_moves, col_moves, box_moves = analize_it(board)
    local updated = false
    local row_set, col_set, box_set = {}, {}, {}
    for i = 1, BOARD_SIZE do
      row_set[i], col_set[i], box_set[i] = {}, {}, {}
    end
    for r = 1, BOARD_SIZE do
      for c = 1, BOARD_SIZE do
        local n = board[r][c]
        if n == 0 then
          local b = get_box_num(r,c)
          local moves = get_intersection(row_moves[r], col_moves[c], box_moves[b])
          assert(#moves)
          for _, n in ipairs(moves) do
            if row_set[r][n] == nil then
              row_set[r][n] = { r = r, c = c }
            else
              row_set[r][n] = false
            end
            if col_set[c][n] == nil then
              col_set[c][n] = { r = r, c = c }
            else
              col_set[c][n] = false
            end
            if box_set[b][n] == nil then
              box_set[b][n] = { r = r, c = c }
            else
              box_set[b][n] = false
            end
          end
          if #moves == 1 then
            board[r][c] = moves[1]
            updated = true
          end
        end
      end
    end
    for i = 1, BOARD_SIZE do
      for n, t in pairs(row_set[i]) do
        if t then
          board[t.r][t.c] = n
          updated = true
          --print("A")
         end
      end
      for n, t in pairs(col_set[i]) do
        if t then
          board[t.r][t.c] = n
          updated = true
          --print("B")
         end
      end
      for n, t in pairs(box_set[i]) do
        if t then
          board[t.r][t.c] = n
          updated = true
          --print("C")
         end
      end
    end
    if not updated then
      local x = 1
      for r = 1, BOARD_SIZE do
        for c = 1, BOARD_SIZE do
          local n = board[r][c]
          if n == 0 then
            local moves = get_intersection(row_moves[r], col_moves[c], box_moves[get_box_num(r,c)])
            assert(#moves)
            --print("x_" .. tostring(x) .. " =", unpack(moves))
            --print("row moves:", unpack(row_moves[r]))
            --print("col moves:", unpack(col_moves[c]))
            --print("box moves:", unpack(box_moves[get_box_num(r,c)]))
            x = x + 1
          end
        end
      end
      break
    end
  end
end

local su_doku = {}

for i, s in ipairs(su_doku_sample) do
  local t = {}
  for d in s:gmatch "%d" do
    table.insert(t, tonumber(d))
  end
  su_doku[i] = t
end

function get_possible_moves(board, col, row)
  assert(board[row][col] == 0)
  local moves = {}
  -- scan the row
  for i = 1, BOARD_SIZE do
    if board[row][i] ~= 0 then
      if not moves[board[row][i]] then
        moves[board[row][i]] = true
      end
    end
  end
  -- scan the column
  for i = 1, BOARD_SIZE do
    if board[i][col] ~= 0 then
      if not moves[board[i][col]] then
        moves[board[i][col]] = true
      end
    end
  end
  -- scan the box
  local c_min = math.floor((col - 1) / BOX_SIZE) * BOX_SIZE
  local r_min = math.floor((row - 1) / BOX_SIZE) * BOX_SIZE
  for c =  c_min + 1, c_min + BOX_SIZE do
    for r =  r_min + 1, r_min + BOX_SIZE do
      if board[r][c] ~= 0 then
        if not moves[board[r][c]] then
          moves[board[r][c]] = true
        end
      end
    end
  end

  local possible_moves = { count = 0 }
  for i = 1, BOARD_SIZE do
    if not moves[i] then
      possible_moves.count = possible_moves.count + 1
      possible_moves[i] = true
    end
  end

  return possible_moves
end

function find_next_move(board)
  local t = {}
  for c = 1, BOARD_SIZE do
    for r = 1, BOARD_SIZE do
      if board[r][c] == 0 then
        t[r][c] = get_possible_moves(board, c, r)
        if n > moves.count then
          moves = m
          moves.count = n
          moves.col = c
          moves.row = r
        end
      end
    end
  end
  return moves
end

function count_empty_cells(board)
  local count = 0
  for c = 1, BOARD_SIZE do
    for r = 1, BOARD_SIZE do
      if board[r][c] == 0 then
        count = count + 1
      end
    end
  end
  return count
end

function get_valid_move(moves)
  for i = 1, BOARD_SIZE do
    if not moves[i] then
      return i
    end
  end
end

function print_board(board)
  local s, f = "-", "%d%d%d | %d%d%d | %d%d%d"

  print(s:rep(15))
  for i = 1, BOARD_SIZE, 3 do
    print(f:format(unpack(board[i])))
    print(f:format(unpack(board[i + 1])))
    print(f:format(unpack(board[i + 2])))
    print(s:rep(15))
  end
end

function convert_board(board)
  local N, n = #board, 1
  for c = 1, N do
    for r = 1, N do
      if board[r][c] == 0 then
        board[r][c] = "x_" .. tostring(n)
        n = n + 1
      end
    end
  end
end

function get_equations(board)
  local N = #board
  -- for each row
  for c = 1, N do
    local equ, sum = {}, 45
    for r = 1, N do
      local x = board[r][c]
      if type(x) == "number" then
        sum = sum - x
      else
        table.insert(equ, x)
      end
    end
    print(table.concat(equ, " + "), "=", sum)
  end
  print("###")
  -- for each column
  for r = 1, N do
    local equ, sum = {}, 45
    for c = 1, N do
      local x = board[r][c]
      if type(x) == "number" then
        sum = sum - x
      else
        table.insert(equ, x)
      end
    end
    print(table.concat(equ, " + "), "=", sum)
  end
  -- for each box
  print("###")
  for b = 1, N do
    local r0 = math.floor((b - 1)/3) * 3 + 1
    local c0 = math.floor((b - 1)%3) * 3 + 1
    local equ, sum = {}, 45
    for c = c0, c0 + 2 do
      for r = r0, r0 + 2 do
        local x = board[r][c]
        if type(x) == "number" then
          sum = sum - x
        else
          table.insert(equ, x)
        end
      end
    end
    print(table.concat(equ, " + "), "=", sum)
  end
end

local line_pattern = string.rep("%d", BOARD_SIZE) .. "%s-"
local board_pattern = "Grid%s-%d%d%s-(" .. line_pattern:rep(BOARD_SIZE) .. ")"

--~ local N = count_empty_cells(su_doku)
--~ for i = 1, N do
--~   local moves = find_next_move(su_doku)
--~   print(moves.count, moves.col, moves.row)
--~   su_doku[moves.row][moves.col] = get_valid_move(moves)
--~   print_board(su_doku)
--~ end

function get_moves(board, col, row)
  local N = #board
  local values = {}
  for i = 1, N do
    values[i] = true
  end
  -- for each in the row
  for c = 1, N do
    values[board[row][c]] = nil
  end
  -- for each in the column
  for r = 1, N do
    values[board[r][col]] = nil
  end
  -- for each in the box
  local c0, r0 = 3 * math.floor((col - 1) / 3) + 1, 3 * math.floor((row - 1) / 3) + 1
  for c = c0, c0 + 2 do
    for r = r0, r0 + 2 do
      values[board[r][c]] = nil
    end
  end

  local moves = {}
  for i = 1, N do
    if values[i] then
      table.insert(moves, i)
    end
  end
  return moves
end

function make_copy(board)
  local N = #board
  local b = {}
  for r = 1, N do
    b[r] = {}
    for c = 1, N do
      b[r][c] = board[r][c]
    end
  end
  return b
end

function get_empty_cells(board, level)
  local N = #board
  local e = {}
  for r = 1, N do
    for c = 1, N do
      if board[r][c] == 0 then
        local m = { row = r, col = c, moves = get_moves(board, c, r)}
        if #m.moves < 1 then
          return {} -- invalid board
        else
          table.insert(e, m)
        end
      end
    end
  end

  local even = #e % 2 == 0
  local function sort_it(a, b)
    local A, B = #a.moves, #b.moves
    --if A <= 2  or B <= 2 then
    if level > 1 then
      return A < B
    else
      return A > B
    end
  end

  table.sort(e, sort_it)
  return e
end

function is_board_solved(board)
  local N = #board
  for r = 1, N do
    for c = 1, N do
      if board[r][c] == 0 then
        return false
      end
    end
  end
  return true
end

function is_board_valid(board)
  local N = #board
  for r = 1, N do
    for c = 1, N do
      local n = board[r][c]
      board[r][c] = 0
      local m = get_moves(board, c, r)
      board[r][c] = n
      --assert(#m == 1, #m)
      --assert(m[1] == n)
      if #m ~= 1 or m[1] ~= n then
        return false
      end
    end
  end
  return true
end

function solve_board(board, level)
  for i, p in ipairs(get_empty_cells(board, level)) do
    -- shallow loop
    for _, n in ipairs(p.moves) do
      local b = make_copy(board)
      b[p.row][p.col] = n
      set_obvious_moves(b)
      if is_board_solved(b) then
        if is_board_valid(b) then
          print("!", "shallow", level)
          return true, b
        end
      end
    end
  end

  -- deep loop
  print("!", "deep", level)
  for i, p in ipairs(get_empty_cells(board, level)) do
    if level > 7 then
      print(level, i, #p.moves)
    end
    for _, n in ipairs(p.moves) do
      local b = make_copy(board)
      b[p.row][p.col] = n
      set_obvious_moves(b)
      if is_board_solved(b) then
        if is_board_valid(b) then
          return true, b
        end
      else
        local ok, b = solve_board(b, level + 1)
        if ok then
          return ok, b
        end
      end
    end
  end
end

--print_board(su_doku)
set_obvious_moves(su_doku)
local ok, b = solve_board(su_doku, 1)
assert(ok)
--print_board(su_doku)
--print_board(b)

--is_board_valid(su_doku)
--do return end

--[===[
convert_board(su_doku)
get_equations(su_doku)

print "!!!!! Possible Moves:"
local count = 1
for c = 1, BOARD_SIZE do
  for r = 1, BOARD_SIZE do
    local x = su_doku[r][c]
    if type(x) ~= "number" then
      print(x, "=", unpack(get_moves(su_doku, c, r)))
      count = count * #get_moves(su_doku, c, r)
    end
  end
end
print("!!!!!", count)

for _, l in ipairs(su_doku) do
  print(unpack(l))
end
--]===]

local i = 1
local sum = 0
for s in assert(io.open(arg[1] or "sudoku.txt")):read("*all"):gmatch(board_pattern) do
  local board = {}
  for l in s:gmatch(line_pattern) do
    local t = {}
    for d in l:gmatch "%d" do
      table.insert(t, tonumber(d))
    end
    table.insert(board, t)
  end

  set_obvious_moves(board)
  if is_board_solved(board) then
    print(i, "Easy!")
    assert(is_board_valid(board))
  else
    print(i, "Hard!")
    local ok, b = solve_board(board, 1)
    assert(ok)
    board = b
  end
  print_board(board)
  assert(is_board_solved(board))
  assert(is_board_valid(board))
  i = i + 1

  -- get the sum of the 3-digit numbers found in the top left corner of each solution grid
  sum = sum + board[1][1] * 100 + board[1][2] * 10 + board[1][3]

--~   print("!!!!!!!!!!!!!!!!!")
--~   local N = count_empty_cells(board)
--~   for i = 1, N do
--~     local moves = find_next_move(board)
--~     print(moves.count, moves.col, moves.row)
--~     board[moves.row][moves.col] = get_valid_move(moves)
--~     print_board(board)
--~   end
end

print("problem #96", "the number:", sum, sum == 24702)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
