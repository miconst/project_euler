-- problem # 47
primes = { 2, 3 }

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
  table.insert(primes, number)
  return true
end

local function is_number_valid(number)
  if is_prime(number) then
    return false
  end

  local t, c = {}, 0
  while number > 1 do
    for _, prime in ipairs(primes) do
      if number % prime == 0 then
        if not t[prime] then
          t[prime] = true
          c = c + 1
          if c > 4 then
            return false
          end
        end
        number = number / prime
        break
      end
    end
  end
  return c == 4
end

number = 4

local a, b, c, d =
  is_number_valid(number),
  is_number_valid(number + 1),
  is_number_valid(number + 2),
  is_number_valid(number + 3)

while not (a and b and c and d) do
  number = number + 1
  a = b
  b = c
  c = d
  d = is_number_valid(number + 3)
end

print("problem #47", "first four consecutive integer:", number, number == 134043)
