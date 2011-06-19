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

consec, start_pos, last_pos, prime = 0, #primes, #primes

pos = #primes
while pos > consec do
  local start_max = math.min(pos - 1 - consec, start_pos - 1)
  for start = 1, start_max do
    local i, sum = start, primes[pos]
    while sum > 0 and i < last_pos do
      sum = sum - primes[i]
      i = i + 1
    end
    if sum == 0 and consec < i - start then
      print("", start, i - start, primes[pos])
      consec = i - start
      prime = primes[pos]
      start_pos = start
      last_pos = start_pos + consec
      break
    end
  end
  pos = pos - 1
end

print("problem #50", "sum of the most consecutive primes:", prime, prime == 997651)
