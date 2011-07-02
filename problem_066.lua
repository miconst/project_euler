-- problem #66
job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(100)
------------------------------------------------------------------------------
function to_integer(number)
  return (string.gsub(tostring(number), "%.%d*", "", 1))
end

-- get Pell's equation (x^2 - d * y^2 = 1) fundamental solution
function pell(d)
  local a0 = math.floor(math.sqrt(d))
  if a0 * a0 == d then
    return nil, "no solution, D is a perfect square"
  end
  local gp = { bc.number(0), bc.number(a0) }
  local gq = { bc.number(1), bc.number(d - a0*a0) }
  local a = { bc.number(a0), bc.number(math.floor((a0 + a0) / (d - a0*a0))) }
  local p = { a[1], a[1] * a[2] + 1 }
  local q = { 1, a[2] }
  local maxdepth
  local n, r = 1, 0
  while not maxdepth or n < maxdepth do
    if not maxdepth and a[#a] == 2 * a[1] then
      r = n - 1
      if r % 2 == 1 then
        return p[n], q[n]
      end
      maxdepth = 2 * r + 1
    end
    n = n + 1
    table.insert(gp, a[n] * gq[n] - gp[n])
    table.insert(gq, bc.number(to_integer((d - gp[n + 1] * gp[n + 1]) / gq[n])))
    table.insert(a, bc.number(to_integer((a[1] + gp[n + 1]) / gq[n + 1])))
    table.insert(p, a[n + 1] * p[n] + p[n - 1])
    table.insert(q, a[n + 1] * q[n] + q[n - 1])
  end
  return p[2*r + 2], q[2*r + 2]
end

D_MAX = 10^3

function get_d_max()
  local x_max, d_max = bc.number(0), 0
  local i = 1
  while true do
    for d = i^2 + 1, (i + 1)^2 - 1 do
      if d > D_MAX then
        return d_max
      else
        local x, y = pell(d)
        if x > x_max then
          x_max = x
          d_max = d
          print(d_max, to_integer(x_max))
        end
      end
    end
    i = i + 1
  end
end

d = get_d_max()
print("problem #66", "the value of D, for which the largest value of x:", d, d == 661)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
