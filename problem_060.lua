-- problem #60
primes = { [2] = true, [3] = true }

function is_prime(number)
  if not primes[number] then
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
    primes[number] = true
  end
  return true
end

doubles = {}
-- !	787	3119	3900162
-- !	787	3119	131
doubles_len = 0
doubles_hit = 0

function double_primarity_test(a, b)
  local k = tonumber(a .. b)
  -- if doubles[k] then
    -- doubles_hit = doubles_hit + 1
    -- return false
  -- end
  if not is_prime(k) then
--    doubles_len = doubles_len + 1
--    doubles[k] = true
    return false
  end
  k = tonumber(b .. a)
--  if doubles[k] then
--    doubles_hit = doubles_hit + 1
--    return false
--  end
  if not is_prime(k) then
--    doubles_len = doubles_len + 1
--    doubles[k] = true
    return false
  end
  return true
end

function is_valid_primes(...)
  local t, a = {...}
  for i = 1, #t - 1 do
    for j = i + 1, #t do
      a = tonumber(t[i] .. t[j])
      if doubles[a] then
        doubles_hit = doubles_hit + 1
        return false
      end
      if not is_prime(a) then
        doubles_len = doubles_len + 1
        doubles[a] = true
        return false
      end
      a = tonumber(t[j] .. t[i])
      if doubles[a] then
        doubles_hit = doubles_hit + 1
        return false
      end
      if not is_prime(a) then
        doubles_len = doubles_len + 1
        doubles[a] = true
        return false
      end
    end
  end
  return true
end

--function is_valid_primes()
--  return false
--end

number = 7
prime_arr = { 3 }


while true do
--print("!", number, doubles_len, doubles_hit)
  local len = #prime_arr
  local sn = tostring(number)
  for a = 1, len - 3 do
    local sa = tostring(prime_arr[a])
    if double_primarity_test(sa, sn) then
      for b = a + 1, len - 2 do
        local sb = tostring(prime_arr[b])
        if double_primarity_test(sb, sn)
          and double_primarity_test(sa, sb) then
          for c = b + 1, len - 1 do
            local sc = tostring(prime_arr[c])
            if double_primarity_test(sc, sn)
              and double_primarity_test(sa, sc)
              and double_primarity_test(sb, sc) then
              for d = c + 1, len do
                local sd = tostring(prime_arr[d])
                if double_primarity_test(sd, sn)
                  and double_primarity_test(sa, sd)
                  and double_primarity_test(sb, sd)
                  and double_primarity_test(sc, sd) then
                  assert(is_valid_primes(sa, sb, sc, sd, sn))
                  local s = number + prime_arr[a] + prime_arr[b] + prime_arr[c] + prime_arr[d]
                  if not sum or sum > s then
                    sum = s
                    print("*", prime_arr[a], prime_arr[b], prime_arr[c], prime_arr[d], number)
                  end
                end
              end
            end
          end
        end
      end
    end
  end

  table.insert(prime_arr, number)
  number = number + 2
  while not is_prime(number) do
    number = number + 2
  end

  if sum and sum < number then
    break
  end
end

print("problem #60", "lowest sum for a set of five primes:", sum, sum == 26033)
