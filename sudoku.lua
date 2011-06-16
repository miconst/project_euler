su_doku_sample = {
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },

  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },

  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
}

su_doku_sample = {  -- todo
  { 0, 4, 0;  0, 1, 0;  0, 0, 0; },
  { 2, 0, 1;  9, 0, 0;  0, 0, 4; },
  { 8, 0, 0;  6, 4, 0;  7, 2, 0; },

  { 0, 9, 0;  0, 0, 0;  5, 4, 0; },
  { 0, 0, 0;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 6;  0, 0, 0;  0, 0, 0; },

  { 5, 6, 0;  0, 0, 9;  0, 0, 0; },
  { 0, 0, 0;  7, 8, 0;  1, 0, 6; },
  { 0, 0, 0;  5, 0, 0;  0, 0, 7; },
}

su_doku_sample = {
  { 0, 5, 0;  3, 7, 4;  0, 0, 0; },
  { 0, 0, 0;  0, 1, 0;  0, 7, 0; },
  { 0, 0, 0;  2, 0, 9;  0, 0, 1; },

  { 0, 0, 0;  1, 0, 0;  0, 9, 2; },
  { 0, 0, 3;  0, 9, 0;  0, 0, 7; },
  { 0, 2, 0;  0, 8, 3;  0, 0, 0; },

  { 0, 0, 2;  0, 0, 0;  0, 0, 0; },
  { 0, 0, 7;  0, 0, 0;  4, 0, 5; },
  { 3, 0, 0;  5, 0, 0;  2, 0, 0; },
}


--~ su_doku_sample = {
--~   { 0, 7, 2;  1, 0, 0;  0, 9, 4; },
--~   { 0, 3, 4;  0, 7, 0;  0, 2, 0; },
--~   { 0, 0, 0;  4, 2, 0;  6, 7, 0; },

--~   { 0, 0, 0;  5, 0, 7;  0, 0, 2; },
--~   { 5, 0, 0;  6, 0, 4;  0, 0, 0; },
--~   { 0, 0, 0;  0, 0, 0;  5, 4, 1; },

--~   { 0, 0, 1;  0, 6, 8;  0, 0, 0; },
--~   { 4, 5, 8;  7, 9, 1;  0, 0, 6; },
--~   { 0, 6, 0;  2, 0, 5;  8, 0, 0; },
--~ }

function make_copy(board)
  local N = #board
  local b = {}
  local mask = string.rep("|%d|", N)
  local key = ""
  for r = 1, N do
    b[r] = {}
    key = key .. mask:format(unpack(board[r]))
    for c = 1, N do
      b[r][c] = board[r][c]
    end
  end
  return b, key
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

function pos2key(row, col)
  return string.format("{ %d x %d }", row, col)
end

function key2pos(key)
  local _, _, row, col = key:find "(%d+) x (%d+)"
  return tonumber(row), tonumber(col)
end

function dump_positions(positions)
  local total = 0
  for n, t in ipairs(positions) do
    print(n)
    for i, pos in ipairs(t) do
      print("", unpack(pos))
      total = total + 1
    end
  end
  print("Total:", total)
end

function dump_doubles(positions)
  for k, v in pairs(positions) do
    print(k[1], k[2], ":", v[1], v[2])
  end
end

function table.dump(tbl, out)
  out = out or io.stdout

  local auto = (type(out) == "string")
  if auto then out = io.open(out, "w+") end

  if type(out) == "function" then
    local upvalue = out
    out = { write = function(self, ...) upvalue(...) end }
  end

  local seen={}

  local function dumpIt(t, i)
    --seen[t] = true

    for k, v in pairs(t) do
      local tp = type(v)
      if tp == "function" then
        out:write(i, k .. "()\n")
      elseif tp == "string" or tp == "number" or tp == "boolean" then
        out:write(i, k .. "=" .. tostring(v) .. "\n")
      else
        out:write(i, k .. "\n")
      end

      if tp == "table" and not seen[v] then dumpIt(v, i .. "\t") end
    end
  end

  dumpIt(tbl, "")

  if auto then out:close() end
end

function print_board(board)
  local s, f = "-", "%d%d%d | %d%d%d | %d%d%d"

  print(s:rep(15))
  for i = 1, #board, 3 do
    print(f:format(unpack(board[i])))
    print(f:format(unpack(board[i + 1])))
    print(f:format(unpack(board[i + 2])))
    print(s:rep(15))
  end
end

function box_position(pos)
  return (math.modf((pos - 1) / 3))
end

function pos2box(col, row)
  col = box_position(col)
  row = box_position(row)
  return 1 + col + 3 * row
end

function box2pos(box)
  local row = 1 +  math.modf((box - 1) / 3) * 3
  local col = 1 +           ((box - 1) % 3) * 3
  return row, col
end

function is_pos_occupied(board, row, col)
  return board[row][col] ~= 0
end

function is_row_occupied(board, number, row)
  for i = 1, 9 do
    if board[row][i] == number then
      return true
    end
  end
end

function is_col_occupied(board, number, col)
  for i = 1, 9 do
    if board[i][col] == number then
      return true
    end
  end
end

function is_box_occupied(board, number, row, col)
  local r = box_position(row) * 3
  local c = box_position(col) * 3

  for i = 1, 3 do
    for j = 1, 3 do
      if board[r + i][c + j] == number then
        return true
      end
    end
  end
end

function is_board_valid(board)
  local N = #board
  for r = 1, N do
    for c = 1, N do
      local number = board[r][c]
      if number > 0 then
        board[r][c] = 0
        assert(not is_pos_occupied(board, r, c))

        local err = is_row_occupied(board, number, r)
          or is_col_occupied(board, number, c)
          or is_box_occupied(board, number, r, c)

        board[r][c] = number
        assert(is_pos_occupied(board, r, c))

        if err then
          return false
        end
      end
    end
  end
  return true
end

function get_position_groups(positions)
  local row_positions, col_positions, box_positions = {}, {}, {}
  for i = 1, #positions do
    local pos = positions[i]
    local row, col = pos[1], pos[2]
    local box = pos2box(row, col)

    if row_positions[row] == nil then
      row_positions[row] = {}
    end
    table.insert(row_positions[row], pos)

    if col_positions[col] == nil then
      col_positions[col] = {}
    end
    table.insert(col_positions[col], pos)

    if box_positions[box] == nil then
      box_positions[box] = {}
    end
    table.insert(box_positions[box], pos)
  end

  return row_positions, col_positions, box_positions
end

function get_singles(positions)
  local row_positions, col_positions, box_positions = get_position_groups(positions)

  local singles = {}
  for k, v in pairs(row_positions) do
    if #v == 1 then
      singles[v[1]] = true
    end
  end
  for k, v in pairs(col_positions) do
    if #v == 1 then
      singles[v[1]] = true
    end
  end
  for k, v in pairs(box_positions) do
    if #v == 1 then
      singles[v[1]] = true
    end
  end

  return singles
end

function get_doubles(positions)
  local row_positions, col_positions, box_positions = get_position_groups(positions)

--  print "----box_positions:"
--  table.dump(box_positions)
--  print "----"

  local doubles = {}
  local rules = { row = {}, col = {}, box = {} }

  for k, v in pairs(row_positions) do
    if #v == 2 then
      doubles[v[1]] = v[2]
      --assert(not rules.row[v[1][1]])
      rules.row[v[1][1]] = { [v[1][2]] = true, [v[2][2]] = true }
    end
  end
  for k, v in pairs(col_positions) do
    if #v == 2 then
      doubles[v[1]] = v[2]
      --assert(not rules.col[v[1][2]])
      rules.col[v[1][2]] = { [v[1][1]] = true, [v[2][1]] = true }
    end
  end
  for k, v in pairs(box_positions) do
    if #v == 2 then
      doubles[v[1]] = v[2]
      local box = pos2box(v[1][1], v[1][2])
      assert(not rules.box[box])
      rules.box[box] = { [pos2key(v[1][1], v[1][2])] = true, [pos2key(v[2][1], v[2][2])] = true }
      if v[1][1] == v[2][1] then
        rules.row[v[1][1]] = { [v[1][2]] = true, [v[2][2]] = true }
        for r = 1, 9 do
          if r ~= v[1][1]
            and rules.row[r] and rules.row[r][v[1][2]] and rules.row[r][v[2][2]] then
            local box_2 = pos2box(r, v[1][2])
            if box ~= box_2 and rules.box[box_2] then
              rules.col[v[1][2]] = { [v[1][1]] = true, [r] = true }
              rules.col[v[2][2]] = { [v[1][1]] = true, [r] = true }
              break
            end
          end
        end
      elseif v[1][2] == v[2][2] then
        rules.col[v[1][2]] = { [v[1][1]] = true, [v[2][1]] = true }
        for c = 1, 9 do
          if c ~= v[1][2]
            and rules.col[c] and rules.col[c][v[1][1]] and rules.col[c][v[2][1]] then
            local box_2 = pos2box(v[1][1], c)
            if box ~= box_2 and rules.box[box_2] then
              rules.row[v[1][1]] = { [v[1][2]] = true, [c] = true }
              rules.row[v[2][1]] = { [v[1][2]] = true, [c] = true }
              break
            end
          end
        end
      end
    end
  end

  --table.dump(rules)

  return doubles, rules
end

function test_positions(positions, rules)
  local updated = false
  for i = #positions, 1, -1 do
    local pos = positions[i]
    local box = pos2box(pos[1], pos[2])
    if rules.row[pos[1]] and not rules.row[pos[1]][pos[2]] then
      print("Row rule:", "Removing invalid position:", unpack(pos))
      table.remove(positions, i)
      updated = true
    elseif rules.col[pos[2]] and not rules.col[pos[2]][pos[1]] then
      print("Col rule:", "Removing invalid position:", unpack(pos))
      table.remove(positions, i)
      updated = true
    elseif rules.box[box] and not rules.box[box][pos2key(pos[1], pos[2])] then
      print("Box rule:", "Removing invalid position:", unpack(pos))
      table.remove(positions, i)
      updated = true
    end
  end
  return updated
end

function get_positions(board, number)
  local positions = {}
  for r = 1, 9 do
    for c = 1, 9 do
      if not is_pos_occupied(board, r, c)
        and not is_row_occupied(board, number, r)
        and not is_col_occupied(board, number, c)
        and not is_box_occupied(board, number, r, c) then
        table.insert(positions, { r, c })
      end
    end
  end
  return positions
end

function table.intersection(t1, t2)
  local t = {}
  for k, v in pairs(t1) do
    if t2[k] == v then
      t[k] = v
    end
  end
  return t
end

function table.merge(t1, t2)
  local t = {}
  for k, v in pairs(t1) do
    t[k] = v
  end
  for k, v in pairs(t2) do
    t[k] = v
  end
  return t
end


function check_positions(positions)
  local rules = {}
  local test_doubles = {}
  local map_doubles = {}
  for n = 1, 9 do
--    print("!!", n)
    local doubles, rule = get_doubles(positions[n])
    --dump_doubles(doubles)

    for k, v in pairs(doubles) do
      local a = pos2key(k[1], k[2])
      local b = pos2key(v[1], v[2])
      if a > b then
        a, b = b, a
      end
      local key = a .. ":" .. b
      if test_doubles[key] then
        local x =  { [test_doubles[key].n] = true, [n] = true }
        if map_doubles[a] then
          map_doubles[a] = table.intersection(map_doubles[a], x)
          --map_doubles[a] = table.merge(map_doubles[a], x)
        else
          map_doubles[a] = x
        end
        if map_doubles[b] then
          map_doubles[b] = table.intersection(map_doubles[b], x)
          --map_doubles[b] = table.merge(map_doubles[b], x)
        else
          map_doubles[b] = x
        end
      else
        test_doubles[key] = { n = n, a = k, b = v }
      end
    end

    rules[n] = rule
  end

--  print "\nmap_doubles:"
--  table.dump(map_doubles)
--  print "\nrules:"
--  table.dump(rules)

  local updated = false
  for n = 1, 9 do
    local p = positions[n]
    for i = #p, 1, -1 do
      local key = pos2key(p[i][1], p[i][2])
      local map = map_doubles[key]
      if map then
        if not map[n] then
          print("Removing position:", n, key)
          table.remove(p, i)
          updated = true
        end
      end
    end
  end
  if not updated then
    for n = 1, 9 do
      print(n)
      if test_positions(positions[n], rules[n]) then
        updated = true
      end
    end
  end

  return updated
end

function set_singles(board)
  local found_single
  local positions
  repeat
    found_single = false
    positions = {}
    for n = 1, 9 do
      positions[n] = get_positions(board, n)
    end

    while check_positions(positions) do
      print "=!="
    end

    for n = 1, 9 do
      local singles = get_singles(positions[n])
      for pos in pairs(singles) do
        --print( n, "at", unpack(pos))
        board[pos[1]][pos[2]] = n
        found_single = true
      end
    end

    --print_board(board)
  until not found_single
  return positions
end


print_board(su_doku_sample)

checked_boards = {}

function solve(board)
  local test_board, test_key = make_copy(board)

  if checked_boards[test_key] then
    --print("Skipping:", test_key)
    return false
  else
    checked_boards[test_key] = true
  end

  local positions = set_singles(test_board)

  if not is_board_valid(test_board) then
    return false
  elseif is_board_solved(test_board) then
    return test_board
  else
    for number, number_positions in pairs(positions) do
      for i, pos in pairs(number_positions) do
        test_board[pos[1]][pos[2]] = number
        local res = solve(test_board)
        if res then
          return res
        end
        test_board[pos[1]][pos[2]] = 0
      end
    end
  end
end

assert(is_board_valid(su_doku_sample))
local positions = set_singles(su_doku_sample)
assert(is_board_valid(su_doku_sample))
print_board(su_doku_sample)

dump_positions(positions)
while check_positions(positions) do
  print("!!")
end

print"---"
dump_positions(positions)
--
--do return end
--

su_doku = solve(su_doku_sample)

assert(is_board_valid(su_doku))
print_board(su_doku)

--
do return end
--

--su_doku_sample[1][2] = 7
--su_doku_sample[8][7] = 9
dump_positions(set_singles(su_doku_sample))
assert(is_board_valid(su_doku_sample))

print "!"
positions = set_singles(su_doku_sample)


--table.dump(rules)
do return end

function box_positionitions(positions)
  box_positions = {}
end

function nuke_row(board_map, number, row)
  for c = 1, 9 do
    board_map[row][c][number] = false
  end
end

function nuke_col(board_map, number, col)
  for r = 1, 9 do
    board_map[r][col][number] = false
  end
end

function nuke_box(board_map, number, row, col)
  local r = box_position(row) * 3
  local c = box_position(col) * 3

  for i = 1, 3 do
    for j = 1, 3 do
      board_map[r + i][c + j][number] = false
    end
  end
end

function update_map(board, board_map)
  local ret = false
  for row = 1, 9 do
    for col = 1, 9 do
      local n = board[row][col]
      if n ~= 0 and board_map[row][col][0] == nil then
        board_map[row][col][0] = n

        nuke_row(board_map, n, row)
        nuke_col(board_map, n, col)
        nuke_box(board_map, n, row, col)

        ret = true
      end
    end
  end
  return ret
end

function get_box_singles(board_map, box)
  local singles = {}
  for n = 1, 9 do
    if cell[i] or cell[i] == nil then
      if n then
        return nil
      else
        n = i
      end
    end
  end
  return n
end

function analize(board_map)
  local ret = false
  for row = 1, 9 do
    for col = 1, 9 do
      local t = board_map[row][col]
      if not t[0] then
        -- 1. test for singles
        local n = get_single(t)
        if n then
          t[0] = n
          ret = true
        end
      end
    end
  end
  return ret
end

function update_board(board, board_map)
  local ret = false
  for row = 1, 9 do
    for col = 1, 9 do
      local n = board_map[row][col][0]
      if n ~= nil and board[row][col] == 0 then
        board[row][col] = n

        ret = true
      end
    end
  end
  return ret
end

-- make sudoku map
local sudoku_map = {}
for row = 1, 9 do
  sudoku_map[row] = {}
  for col = 1, 9 do
    sudoku_map[row][col] = {}
  end
end

while update_map(su_doku_sample, sudoku_map) do
  analize(sudoku_map)
  update_board(su_doku_sample, sudoku_map)
end

print_board(su_doku_sample)
do return end

function set_singles(board)
  local found_single
  local positions
  repeat
    found_single = false
    positions = {}
    for n = 1, 9 do
      positions[n] = get_positions(board, n)
    end

    for n = 1, 9 do
      local singles = get_singles(positions[n])
      for pos in pairs(singles) do
        print( n, "at", unpack(pos))
        board[pos[1]][pos[2]] = n
        found_single = true
      end
    end

    print_board(board)
  until not found_single

  print "==++=="
  local rows, cols, boxs = {}, {}, {}
  for n = 1, 9 do
    --print(n)
    local row_positions, col_positions, box_positions = get_position_groups(positions[n])
    --local doubles = get_doubles(positions[n])
    --for a, b in pairs(doubles) do
    --  print("", a[1], a[2], "-", b[1], b[2])
    --end
    --for _, p in ipairs(positions[n]) do
    --  print("", unpack(p))
    --end
    for r, p in pairs(row_positions) do
      if rows[r] == nil then
        rows[r] = {}
      end
      rows[r][n] = p
    end

    for c, p in pairs(col_positions) do
      if cols[c] == nil then
        cols[c] = {}
      end
      cols[c][n] = p
    end

    for b, p in pairs(box_positions) do
      if boxs[b] == nil then
        boxs[b] = {}
      end
      boxs[b][n] = p
    end
  end


  for i, b in pairs(boxs) do
    for n, t in pairs(b) do
      if #t == 2 then
        if t[1][1] == t[2][1] then
          -- stop row
          for c = 1, 9 do
            if c ~= t[1][2] and c ~= t[2][2] then
              stop_map[t[1][1]][c][n] = true
            end
          end
        elseif t[1][2] == t[2][2] then
          -- stop col
          for r = 1, 9 do
            if r ~= t[1][1] and r ~= t[2][1] then
              stop_map[r][t[1][2]][n] = true
            end
          end
        end
      end
    end
  end

  print "~~~~~~~~"
  table.dump(rows)

  print "~~~~~~~~"
  table.dump(cols)

  print "~~~~~~~~"
  table.dump(boxs)

  print "~~~~~~~~"
  print "~~~~~~~~"
  table.dump(stop_map)
end


do return end
-------------------------------------------------

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
