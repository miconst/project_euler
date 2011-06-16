-- problem # 100

sqrt_2 = math.sqrt(2)

function get_total_discs(n)
  local x = math.pow(3 - 2 * sqrt_2, n)
  local y = math.pow(3 + 2 * sqrt_2, n)
  return (-x - sqrt_2 * x - y + sqrt_2 * y + 2) / 4
end

function get_blue_discs(n)
  local x = math.pow(3 - 2 * sqrt_2, n)
  local y = math.pow(3 + 2 * sqrt_2, n)
  return (2 * x + sqrt_2 * x + 2 * y - sqrt_2 * y + 4) / 8
end

i = 1
while get_total_discs(i) < math.pow(10, 12) do
  i = i + 1
end

blue_discs = get_blue_discs(i)

print("problem #100", "number of blue discs:", blue_discs, blue_discs - 756872327473)
