-- problem # 25

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function sum(a, b)
  local h, s, i_max = 0, "", math.max(#a, #b)
  for i = 1, i_max do
    local x = get_digit(a, i) + get_digit(b, i) + h
    s = tostring(x % 10) .. s
    h = math.floor(x / 10)
  end
  if h > 0 then
    s = tostring(h) .. s
  end
  return s
end

function get_fibonacci(len)
  a, b, b_pos = "1", "1", 2
  while #b < len do
    local c = sum(a, b)
    a = b
    b = c
    b_pos = b_pos + 1
    --print("!", #b, b)
  end
  return b, b_pos
end

num, pos = get_fibonacci(1000)

print("problem #25", "first term in the Fibonacci sequence to contain 1000 digits:", pos, pos == 4782)
