-- problem #202
job_time = os.time()

function get_divisors(n)
  local i, divs = 2, {}
  while n ~= 1 do
    if n%i == 0 then
      table.insert(divs, i)
      repeat
        n = n / i
      until n%i ~= 0
    end
    i = i + 1
  end
  return divs
end

-- The General formula for Euler's Totient Function is:
-- euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
-- Where p1, p2, p3, . . . , pn are prime factors of m.

function euler_phi(m)
  local i, phi = 2, m
  while m ~= 1 do
    while m%i == 0 do
      m = m / i
      phi = phi * (1 - 1 / i)
    end
    i = i + 1
  end
  return phi
end

-- Greatest Common Divisor. Euclid's Algorithm.
function gcd(a, b)
  while true do
    a, b = b, a % b
    if b == 0 then
      return a
    elseif b == 1 then
      return 1
    end
  end
end

N = 7
N = 1000001
N = 12017639147

A = (N + 3) / 2
B = (N - 1) / 6
if N%3 == 2 then
  B = (N - 5) / 6
end
x = gcd(A, B)
if x == 2 then
  A = A / 2
  B = B / 2 + 1 - N%3
elseif x == 4 then
  A = A / 2
  B = B / 2 - 1
end

print(A, B)

divisors = get_divisors(A)
s = [[
function get_count(n)
  local count = 0
  for b = n, 1, -2 do
    if b%]]..table.concat(divisors, "~=0 and b%")..[[~=0 then
      count = count + 1
    end
  end
  return count
end]]
assert(loadstring(s))()
count = get_count(B) * 2

print("problem #202", "Ways a laser beam can enter at vertex C and bounce off 12017639147 surfaces:", count, count == 1209002624)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
