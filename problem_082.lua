-- problem #82
job_time = os.time()

matrix = {}
for line in assert(io.open "matrix.txt"):lines() do
  local t = {}
  for n in line:gmatch "%d+" do
    table.insert(t, tonumber(n))
  end
  table.insert(matrix, t)
end

function make_min_matrix(m)
  local out = {}
  local N = #m
  for i = 1, N do
    out[i] = {}
  end

  -- set the first column
  for r = 1, N do
    out[r][1] = m[r][1]
  end

  -- fill the matrix
  for c = 2, N do
    for r = 1, N do
      local a1, a2, a3 = out[r][c - 1]
      if r > 1 then
        a2 = out[r - 1][c - 1] + m[r - 1][c]
      end
      if r < N then
        a3 = out[r + 1][c - 1] + m[r + 1][c]
      end
      out[r][c] = m[r][c] + math.min(a1, a2 or a1, a3 or a1)
    end
    local done
    repeat
      done = true
      for r = 1, N do
        local a1, a2, a3 = out[r][c] - m[r][c]
        if r > 1 then
          a2 = out[r - 1][c]
        end
        if r < N then
          a3 = out[r + 1][c]
        end
        local x = m[r][c] + math.min(a1, a2 or a1, a3 or a1)
        if x ~= out[r][c] then
          out[r][c] = m[r][c] + math.min(a1, a2 or a1, a3 or a1)
          done = false
        end
      end
    until done
  end

  return out
end

--~ for _, t in ipairs(make_min_matrix(matrix)) do
--~   print(unpack(t))
--~ end

N = #matrix
out = make_min_matrix(matrix)
sum = out[1][N]
for r = 2, N do
  if out[r][N] < sum then
    sum = out[r][N]
  end
end

print("problem #82", "the minimal path sum:" , sum, sum == 260324)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
