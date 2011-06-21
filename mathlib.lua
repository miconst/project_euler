function reverse(t, first, last)
  local mid = (first + last) / 2
  for i = first, mid do
    local j = last + first - i
    t[i], t[j] = t[j], t[i]
  end
end

function next_permutation(t)
  -- permute and test for pure ascending
  local last = #t
  local left = last
  while left > 1 do
    -- find rightmost element smaller than successor
    local right = left
    left = left - 1
    if t[left] < t[right] then
      -- swap with rightmost element that's smaller, flip suffix
      local mid = last
      while t[left] >= t[mid] do
        mid = mid - 1
      end
      t[left], t[mid] = t[mid], t[left]
      reverse(t, right, last)
      return true
    end
  end
  -- pure descending, flip all
  reverse(t, 1, last)
end

--~ print "permutation test"
--~ t = { 'a', 'b', 'c' }
--~ repeat
--~   print(unpack(t))
--~ until not next_permutation(t)

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

--~ print "primes test"
--~ print(unpack((get_primes(50))))

primes, prime_hash = get_primes(10000)

function get_divisors(number)
  local divisors = {}
  local i = 1
  while not prime_hash[number] do
    assert(i <= #primes)
    local prime = primes[i]
    if number % prime == 0 then
      number = number / prime
      table.insert(divisors, prime)
    else
      i = i + 1
    end
  end
  table.insert(divisors, number)
  return divisors
end

divisor_hash = {}

local function get_all_divisors(number)
  local divisors = divisor_hash[number]
  if divisors then
    return divisors
  else
    divisors = {}
    divisor_hash[number] = divisors
  end

  local function add(t)
    table.sort(t)
    local k = table.concat(t, "*")
    if not divisors[k] then
      divisors[k] = t
    end
  end
  if prime_hash[number] then
    add { number }
  else
    for i = 1, #primes do
      local prime = primes[i]
      if number % prime == 0 then
        for _, v in pairs(get_all_divisors(number / prime)) do
          add { prime, unpack(v) }
          local last = 0
          for j = 1, #v do
            if v[j] ~= last then
              last = v[j]
              local t = { unpack(v) }
              t[j] = t[j] * prime
              add(t)
            end
          end
        end
        break
      end
    end
  end
  return divisors
end

--~ print "divisors test"
--~ print(unpack(get_divisors(100)))
--~ for k, v in pairs(get_all_divisors(100)) do
--~   print(table.concat(v, "*"))
--~ end
