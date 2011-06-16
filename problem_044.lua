-- problem #44
job_time = os.time()

function P(n)
  return n * (3 * n - 1) / 2
end

P_hash = {}
D_min = nil

--for i = 0, 100 do
--  local x = ((5 + 6 * i)^2 - 1) / 24
--  print(i, x)
--end

for i = 1, 10000 do
  P_hash[P(i)] = true
end

for j = 1, 3000 do
  local Pj = P(j)
  for k = j + 1, 3000 do
    local Pk = P(k)
    local S = Pk + Pj
    local D = Pk - Pj

    if P_hash[S] and P_hash[D] then
      print(j, k, S, D)
      if not D_min or D < D_min then
        D_min = D
      end
    end
  end
end

print("problem #44", "the value of D:", D_min, D_min == 5482660)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))


-- D_sqrt = 5 + 6 * i
-- D = (5 + 6 * i) * (5 + 6 * i)
function get_valid_P()
  for i = 1, 1000 do
    local D = 4 * 3 * i * (3 * i - 1) + 1
    local D_sqrt = math.sqrt(D)
    if math.modf(D_sqrt) == D_sqrt then
      print(i, P(i), D, D_sqrt, 5 + 6 * i - 6)
    end
  end
end

do return end

function isP(x)
  -- 3 * n ^ 2 - n - 2 * x == 0
  local D = 4 * 3 * 2 * x + 1
  local D_sqrt = math.sqrt(D)
end
