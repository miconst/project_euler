-- problem #128
job_time = os.time()

function get_primes(n)
  local primes, hash = {}, {}
  -- generate a list of integers from 2 to N
  for i = 2, n do
    hash[i] = true
  end
  -- Strike (sift out) the multiples
  for i = 2, n do
    if hash[i] then
      table.insert(primes, i)
      for j = i + i, n, i do
        hash[j] = nil
      end
    end
  end

  return primes, hash
end

primes, prime_hash = get_primes(2000000)

function PD(number, hexagon)
  local c = 0
  for _, n in pairs(hexagon) do
    local d = number - n
    if d < 0 then
      d = -d
    end
    if d > 1 then
      assert(d < primes[#primes], "Out of range!")
      if prime_hash[d] then
        c = c + 1
      end
    end
  end
  return c
end

ROW_LENGTH = 6
hexagons = {}
hexagons[1] = { 2, 3, 4, 5, 6, 7 }
rings = {}
rings[1] = { 1 }

local s = 1
local level = 1

function next_ring()
  local r = {}
  for j = 1, ROW_LENGTH * level do
    s = s + 1
    table.insert(r, s)
  end
  level = level + 1
  rings[level] = r
end

function add_hexagons()
  local level_1 = level - 2
  local level_2 = level - 1
  local level_3 = level - 0

  local ring_1, ring_2, ring_3 = rings[level_1], rings[level_2], rings[level_3]
  for _, n in ipairs(ring_2) do
    hexagons[n] = {}
  end

  local next_angle = 1
  local next_cell = #ring_2
  for i, n in ipairs(ring_1) do
    table.insert(hexagons[ring_2[next_cell]], n)
    next_cell = next_cell + 1
    if next_cell > #ring_2 then
      next_cell = 1
    end
    table.insert(hexagons[ring_2[next_cell]], n)
    if i == next_angle then
      next_angle = next_angle + level_1 - 1
      next_cell = next_cell + 1
      table.insert(hexagons[ring_2[next_cell]], n)
    end
  end
  if level_1 == 1 then
    table.insert(hexagons[ring_2[next_cell + 1]], 1)
    table.insert(hexagons[ring_2[next_cell + 2]], 1)
    table.insert(hexagons[ring_2[next_cell + 3]], 1)
  end

  local next_angle = 1
  local next_cell = #ring_3
  for i, n in ipairs(ring_2) do
    table.insert(hexagons[n], ring_3[next_cell])
    next_cell = next_cell + 1
    if next_cell > #ring_3 then
      next_cell = 1
    end
    table.insert(hexagons[n], ring_3[next_cell])
    if i == next_angle then
      next_angle = next_angle + level_2 - 1
      next_cell = next_cell + 1
      table.insert(hexagons[n], ring_3[next_cell])
    end
  end

  for i, n in ipairs(ring_2) do
    local l, r = i - 1, i + 1
    if l < 1 then
      l = #ring_2
    end
    if r > #ring_2 then
      r = 1
    end

    table.insert(hexagons[n], ring_2[l])
    table.insert(hexagons[n], ring_2[r])
  end
end

pd_3_sequence = {}

next_ring()

function first_hexagon(value, level)
  local ring_length = level * ROW_LENGTH
  local prev_ring_length = level > 1 and ring_length - ROW_LENGTH or 1
  local next_ring_length = ring_length + ROW_LENGTH

  local h = {
    value + ring_length - 1,
    value + ring_length,
    value + ring_length + 1,
    value + 1,
    value - prev_ring_length,
    value + ring_length + next_ring_length - 1
  }
  return h
end

function last_hexagon(value, level)
  local ring_length = level * ROW_LENGTH
  local prev_ring_length = level > 1 and ring_length - ROW_LENGTH or 1
  local next_ring_length = ring_length + ROW_LENGTH

  local h = {
    value - 1,
    value + 1 - ring_length,
    value + 1 - ring_length - prev_ring_length,
    value + 1 - ring_length - prev_ring_length - 1,
    value + next_ring_length - 1,
    value + next_ring_length,
  }
  return h
end

next_hexagon = 1

pd_3_sequence = { 1, 2, }
value = 8
level = 2

LAST_ELEMENT = 2000

while true do
---  next_ring()
---  add_hexagons()

  --print("@", next_hexagon, s)
---  local cur_ring = rings[level - 1]
---  local last_hexagon = cur_ring[#cur_ring]

  --print(next_hexagon, last_hexagon)
--  while next_hexagon <= last_hexagon do
--    --print("!", next_hexagon, unpack(hexagons[next_hexagon]))
--    local x = PD(next_hexagon, hexagons[next_hexagon])
--    if x == 3 then
--      table.insert(pd_3_sequence, next_hexagon)
--    end
--    -- hexagon clean up
--    hexagons[next_hexagon] = nil
--    next_hexagon = next_hexagon + 1
--  end
---  local x = PD(next_hexagon, hexagons[next_hexagon])
---  if x == 3 then
---    table.insert(pd_3_sequence, next_hexagon)
---  end
---  if last_hexagon ~= next_hexagon then
---    local x = PD(last_hexagon, hexagons[last_hexagon])
---    if x == 3 then
---      table.insert(pd_3_sequence, last_hexagon)
---    end
---  end

  -- hexagon clean up
---  hexagons = {}
---  next_hexagon = last_hexagon + 1

  -- ring clean up
---  rings[level - 2] = nil

--print(level, value, ":", unpack(first_hexagon(value, level)))
  local x = PD(value, first_hexagon(value, level))
  if x == 3 then
    table.insert(pd_3_sequence, value)
  end
  value = value + ROW_LENGTH * level - 1
--print(level, value, ":", unpack(last_hexagon(value, level)))
  local x = PD(value, last_hexagon(value, level))
  if x == 3 then
    table.insert(pd_3_sequence, value)
  end
  value = value + 1
  level = level + 1

  if #pd_3_sequence > LAST_ELEMENT then
    break
  end
end

--print(unpack(pd_3_sequence))
print(pd_3_sequence[10])

--print(unpack(pd_3_sequence))

--for i = 1, #rings do
--  print("level:", i)
--  print(unpack(rings[i]))
--end

--print "+"
--for i = 1, #hexagons do
--  table.sort(hexagons[i])
--  print(i, ":", unpack(hexagons[i]))
--  print(PD(i, hexagons[i]))
--end


print("problem #128", "the 2000th tile", pd_3_sequence[LAST_ELEMENT], pd_3_sequence[LAST_ELEMENT] == 14516824220)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
