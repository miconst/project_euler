-- problem #64
job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(100)
------------------------------------------------------------------------------
function to_integer(number)
  return (string.gsub(tostring(number), "%.%d*", "", 1))
end

-- The square root of a squarefree integer has a periodic continued fraction
-- of the form: sqrt(n) = { A0; A1, ..., An, 2 * A0 }

function get_pcf(d)
  local a0 = math.floor(math.sqrt(d))
  if a0^2 == d then
    return nil, "no solution, D is a perfect square"
  end
  local gp = { bc.number(0), bc.number(a0) }
  local gq = { bc.number(1), bc.number(d - a0 * a0) }
  local a = { bc.number(a0), bc.number(math.floor((a0 + a0) / (d - a0*a0))) }
  local n = 2
  while true do
    if to_integer(a[n]) == to_integer(2 * a0) then
      return a
    end
    gp[n + 1] = a[n] * gq[n] - gp[n]
    gq[n + 1] = bc.number(to_integer((d - gp[n + 1] * gp[n + 1]) / gq[n]))
    a [n + 1] = bc.number(to_integer((a[1] + gp[n + 1]) / gq[n + 1]))
    n = n + 1
  end
end

N_MAX = 10^4
count = 0

for n = 2, N_MAX do
  local a = get_pcf(n)
  if a then
    if #a % 2 == 0 then
      count = count + 1
    end
  end
end

print("problem #64", "number of continued fractions that have an odd period:", count, count == 1322)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
