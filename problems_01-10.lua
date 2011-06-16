-- problem #1
sum = 0
for i = 1, 999 do
  local a, b = i % 3, i % 5
  if a == 0 or b == 0 then
    sum = sum + i
  end
end

print("problem #1", "sum:", sum, sum == 233168)

-- problem #2
Fibonacci = { 1, 2 }
while Fibonacci[#Fibonacci] < 4000000 do
  local i = #Fibonacci
  Fibonacci[i + 1] = Fibonacci[i] + Fibonacci[i-1]
end

sum = 0
for _, f in ipairs(Fibonacci) do
  if f%2 == 0 then
    sum = sum + f
  end
end

print("problem #2", "sum:", sum, sum == 4613732)

-- problem #3
num = 600851475143

function is_prime(number)
  if number > 3 then
    if number % 2 == 0 or number % 3 == 0 then
      return false
    end
    -- all primes are of the form 6k ± 1
    local i_max = math.sqrt(number)  --number - 1
    for i = 5, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
    for i = 7, i_max, 6 do
      if number % i == 0 then
        return false
      end
    end
  end
  return true
end

local prime

for i = 2, num - 1 do
  if num % i == 0 and is_prime(num / i) then
    prime = num / i
  break
  end
end

print("problem #3", "largest prime factor:", prime, prime == 6857)

-- problem #4
local function is_palindrome(number)
  local s = tostring(number)
  local i = #s / 2
  local a, b = s:sub(1, i), s:sub(-i)
  return a == b:reverse()
end

max_palindrome = 0
for a = 999, 1, -1 do
  for b = 999, 1, -1 do
    local p = a * b
  if is_palindrome(p) and p > max_palindrome then
    max_palindrome = p
  end
  end
end

print("problem #4", "largest palindrome:", max_palindrome, max_palindrome == 906609)

-- problem #5
primes = {}
local function get_primes(number)
  local t = {}
  while number > 1 do
    for p in pairs(primes) do
      if number % p == 0 then
        t[p] = 1 + (t[p] or 0)
        number = number / p
        break
      end
    end
  end
  return t
end

for i = 2, 20 do
  if is_prime(i) then
    primes[i] = 1
  else
    for k, v in pairs(get_primes(i)) do
      if primes[k] < v then
      primes[k] = v
    end
    end
  end
end

mul = 1
for k, v in pairs(primes) do
  mul = mul * math.pow(k, v)
end

print("problem #5", "smallest number:", mul, mul == 232792560)

-- problem #6
a, b = 0, 0
for i = 1, 100 do
  a = a + i * i
  b = b + i
end
dif = b * b - a

print("problem #6", "difference:", dif, dif == 25164150)

-- problem #7
local prime = 1
for i = 1, 10001 do
  prime = prime + 1
  while not is_prime(prime) do
    prime = prime + 1
  end
end

print("problem #7", "10001st prime number:", prime, prime == 104743)

-- problem #8
product = 0
num =
[[
73167176531330624919225119674426574742355349194934
96983520312774506326239578318016984801869478851843
85861560789112949495459501737958331952853208805511
12540698747158523863050715693290963295227443043557
66896648950445244523161731856403098711121722383113
62229893423380308135336276614282806444486645238749
30358907296290491560440772390713810515859307960866
70172427121883998797908792274921901699720888093776
65727333001053367881220235421809751254540594752243
52584907711670556013604839586446706324415722155397
53697817977846174064955149290862569321978468622482
83972241375657056057490261407972968652414535100474
82166370484403199890008895243450658541227588666881
16427171479924442928230863465674813919123162824586
17866458359124566529476545682848912883142607690042
24219022671055626321111109370544217506941658960408
07198403850962455444362981230987879927244284909188
84580156166097919133875499200524063689912560717606
05886116467109405077541002256983155200055935729725
71636269561882670428252483600823257530420752963450
]]
digits = {}
for d in num:gmatch "%d" do
  table.insert(digits, tonumber(d))
end

for i = 1, #digits - 4 do
  local d = digits[i] * digits[i + 1] * digits[i + 2] * digits[i + 3] * digits[i + 4]
  if d > product then
    product = d
  end
end

print("problem #8", "greatest product:", product, product == 40824)

-- problem #9
local function get_pythagorean_triplet(sum)
  local a_max = sum / 2 - 2
  for a = 0, a_max do
    local b_max = (sum - a) / 2 - 1
    for b = a + 1, b_max do
      local c = sum - a - b
      if a * a + b * b == c * c then
        return a, b, c
      end
    end
  end
end
a, b, c = get_pythagorean_triplet(1000)

print("problem #9", "product abc:", a * b * c, a * b * c == 31875000)

-- problem #10
prime_sum = 2
for i = 3, 2000000, 2 do
  if is_prime(i) then
    prime_sum = prime_sum + i
  end
end

print("problem #10", "sum of all the primes:", prime_sum, prime_sum == 142913828922)

-- problem #20
sum = 0
for i = 1, 100 do
  sum = sum + i
end

print("problem #20", "sum of the digits:", sum, prime_sum == 142913828922)

-- problem #45

function T(n)
  return n * (n + 1)/2  -- 1, 3, 6, 10, 15, ...
end

function P(n)
  return n * (3 * n - 1)/2  -- 1, 5, 12, 22, 35, ...
end

function H(n)
  return n * (2 * n - 1)  -- 1, 6, 15, 28, 45, ...
end

t, p, h = 286, 166, 144
while true do
  num = T(t)
  while P(p) < num do
    p = p + 1
  end
  if P(p) == num then
    while H(h) < num do
    h = h + 1
  end
  end
  if num == P(p) and num == H(h) then
    break
  end
  t = t + 1
end

print("problem #45", "next triangle number:", T(t), T(t) == 1533776805)















