-- problem #114
job_time = os.time()

-- http://oeis.org/A005252

function factorial(mul, div)
  local s = 1
  for i = (div or 1) + 1, mul do
    s = s * i
  end
  return s
end

function count_permutations(t)
  local m = {}
  for _, i in pairs(t) do
    m[i] = (m[i] or 0) + 1
  end
  -- any two red blocks are separated by at least one black (1) square
  m[1] = m[1] * 2 + 1 - #t

  local i, n = next(m)
  local c = 1
  local sum = n
  while true do
    i, n = next(m, i)
    if not i then break end
    c = c * factorial(sum + n, sum) / factorial(n)
    sum = sum + n
  end
  return c
end

TILE_MAX = 50

row = {}
count = 1

function lay_tile(length, free_units, tile_num)
  if free_units == 0 then
    count = count + count_permutations(row)
  end
  if tile_num > 0 then
    for l = length, free_units do
      table.insert(row, l)
      lay_tile(l, free_units - l, tile_num - 1)
      table.remove(row)
    end
  end
end

for units = 1, TILE_MAX do
  row[units] = 1
  lay_tile(3, TILE_MAX - units, units + 1)
end

print("problem #114", "the number of ways a row can be filled:", count, count == 16475640049)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
