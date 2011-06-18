-- problem #107
job_time = os.time()

-- todo: check this algorithm - http://en.wikipedia.org/wiki/Kruskal's_algorithm, and see if it works.

function is_valid(net)
  local size = #net
  local vertices  = {}
  local function flood(vertex)
    if not vertices[vertex] then
      vertices[vertex] = true
      for col = 1, size do
        if net[vertex][col] then
          flood(col)
        end
      end
    end
  end
  flood(1)
  for i = 1, size do
    if not vertices[i] then
      return false
    end
  end
  return true
end

function get_weight(net)
  local size = #net
  local weight = 0
  for row = 1, size do
    for col = row + 1, size do
      local n = tonumber(net[row][col])
      if n then
        weight = weight + n
      end
    end
  end
  return weight
end

function string:split(delim, plain)
  delim = (not delim or delim == "") and "%s+" or delim
  local list = {}
  local s = self
  while s:len() > 0 do
    local a = { s:find(delim, 1, plain) }
    if a[1] then
      table.insert(list, s:sub(1, a[1] - 1))
      s = s:sub(a[2] + 1)
      for i = 3, #a do
        table.insert(list, a[i])
      end
    else
      table.insert(list, s)
      s = ""
    end
  end
  return list
end

network = {}
for line in assert(io.open(arg[1] or "network.txt")):lines() do
  table.insert(network, line:split(",", true))
end

assert(is_valid(network))

weight_max = get_weight(network)

-- get edges
edges = {}
for row = 1, #network do
  network[row].count = 0
  for col = 1, #network do
    network[row][col] = tonumber(network[row][col])
    if network[row][col] then
      if row < col then
        table.insert(edges, { row, col, weight = network[row][col] })
      end
    end
  end
end

table.sort(edges, function (a, b) return a.weight < b.weight end)

optimized_network = {}
for i = 1, #network do
  optimized_network[i] = {}
end

for i = 1, #edges do
  if is_valid(optimized_network) then
    break
  end
  local row, col = edges[i][1], edges[i][2]
  optimized_network[row][col] = edges[i].weight
  optimized_network[col][row] = edges[i].weight
end
weight_mid = get_weight(optimized_network)

for i = #edges, 1, -1 do
  local row, col = edges[i][1], edges[i][2]
  optimized_network[row][col] = nil
  optimized_network[col][row] = nil
  if not is_valid(optimized_network) then
    optimized_network[row][col] = edges[i].weight
    optimized_network[col][row] = edges[i].weight
  end
end
weight_min = get_weight(optimized_network)

print(weight_max, weight_mid, weight_min)

saving = weight_max - weight_min
---
print("problem #107", "the maximum saving:" , saving, saving ==  259679)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
