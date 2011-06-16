-- problem # 50
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

primes = {}

for i = 3, 1000000, 2 do
  if is_prime(i) then
    table.insert(primes, i)
  end
end

consec, start_pos, last_pos,  prime_pos = 0, #primes, #primes

i = #primes
while i > consec do
  local j_max = math.min(i - 1 - consec, start_pos - 1)
  for j = 1, j_max do
    local k, s = j, primes[i]
    while s > 0 and k < last_pos do
      s = s - primes[k]
      k = k + 1
    end
    if s == 0 and consec < k - j then
      print(":", j, k - j, primes[i])
      consec = k - j
      prime_pos = i
      start_pos = j
      last_pos = start_pos + consec
      break
    end
  end
  i = i - 1
end

print("problem #50", "sum of the most consecutive primes:", primes[prime_pos], consec)
--


numbers = {}
sum = 0
for x_0 = 0, 9 do
  for x_1 = 0, 9 do
    for x_2 = 0, 9 do
      for x_3 = 0, 9 do
        for x_4 = 0, 9 do
        for x_5 = 0, 9 do
          local a
            = math.pow(x_0, 5)
            + math.pow(x_1, 5)
            + math.pow(x_2, 5)
            + math.pow(x_3, 5)
            + math.pow(x_4, 5)
            + math.pow(x_5, 5)
          local b
            = x_0 * math.pow(10, 0)
            + x_1 * math.pow(10, 1)
            + x_2 * math.pow(10, 2)
            + x_3 * math.pow(10, 3)
            + x_4 * math.pow(10, 4)
            + x_5 * math.pow(10, 5)
          if a == b and a >= 10 then
            print("!!", a)
            sum = sum + a
          end
        end
        end
      end
    end
  end
end

print("*", sum, "*", 443839)

function get_fraction(pos)
  local integer = "0"
  local skip_count = 0
  for i = 1, pos do
    if skip_count == 0 then
      integer = tostring(integer + 1)
      skip_count = #integer
    end
    skip_count = skip_count - 1
  end
  return integer:sub(#integer - skip_count, #integer - skip_count)
end
--~ print"!!!"
--~ io.write "0."
--~ for i = 1, 1000 do
--~   io.write(get_fraction(i))
--~ end
--~ print"!!!"
mul = 1
pos = 1
while pos <= 1000000 do
  mul = mul * get_fraction(pos)
  pos = pos * 10
end

print("@", mul)

function string.mul(a, b)
  local accum = ""
  for i = 1, #b do
    local x = b:get_digit(i)
    local r = string.rep("0", i - 1)
    local h = 0
    for j = 1, #a do
      y = a:get_digit(j) * x + h
      r = tostring(y % 10) .. r
      h = math.floor(y / 10)
    end
    if h > 0 then
      r = tostring(h) .. r
    end
    accum = accum:sum(r)
  end
  return accum
end

function string.get_digit(a, pos)
  return tonumber(a:sub(-pos, -pos)) or 0
end

function string.sum(a, b)
  local accum = ""
  local max_len = math.max(#a, #b)
  local h = 0
  for i = 1, max_len do
    local x = a:get_digit(i) + b:get_digit(i) + h
    accum = tostring(x % 10) .. accum
    h = math.floor(x / 10)
  end
  if h > 0 then
    accum = tostring(h) .. accum
  end
  return accum
end

a, b = "73167176531330624919225119674426574742355349194934", "96983520312774506326239578318016984801869478851843"
--a, b = "2598", "125"
--~ for a = 0, 1000 do
--~   for b = 0, 1000 do
--~     assert(a*b - string.mul(tostring(a), tostring(b)) == 0)
--~   end
--~ end

--print(a:mul(b), b:mul(a))

function fac(num)
  local accum = "1"
  for i = 2, num do
    accum = accum:mul(tostring(i))
  end
  return accum
end

a = fac(100)
sum = 0
for i = 1, #a do
  sum = sum + a:get_digit(i)
end
print("!", sum)

local tbl = {
  "73167176531330624919225119674426574742355349194934",
  "96983520312774506326239578318016984801869478851843",
  "85861560789112949495459501737958331952853208805511",
  "12540698747158523863050715693290963295227443043557",
  "66896648950445244523161731856403098711121722383113",
  "62229893423380308135336276614282806444486645238749",
  "30358907296290491560440772390713810515859307960866",
  "70172427121883998797908792274921901699720888093776",
  "65727333001053367881220235421809751254540594752243",
  "52584907711670556013604839586446706324415722155397",
  "53697817977846174064955149290862569321978468622482",
  "83972241375657056057490261407972968652414535100474",
  "82166370484403199890008895243450658541227588666881",
  "16427171479924442928230863465674813919123162824586",
  "17866458359124566529476545682848912883142607690042",
  "24219022671055626321111109370544217506941658960408",
  "07198403850962455444362981230987879927244284909188",
  "84580156166097919133875499200524063689912560717606",
  "05886116467109405077541002256983155200055935729725",
  "71636269561882670428252483600823257530420752963450",
}
local product = {}

for i = 1, #tbl - 4 do
  local t = tbl[i]
    :mul(tbl[i + 1])
    :mul(tbl[i + 2])
    :mul(tbl[i + 3])
    :mul(tbl[i + 4])
  product[i] = t
  local function cmp(a, b)
    return (#a == #b and a > b or #a > #b)
  end

  table.sort(product, cmp)
end

for i = 1, #product do
  print(i, product[i])
end
