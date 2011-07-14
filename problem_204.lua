-- problem #204
job_time = os.time()

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

NUM_MAX = 10^9
PRIME_FACTOR = 100

primes = get_primes(PRIME_FACTOR)
count = 0

function get_Hamming_numbers(number, pos)
  if number <= NUM_MAX then
    if pos > #primes then
      count = count + 1
    else
      for k = 0, math.log(NUM_MAX/number) / math.log(primes[pos]) do
        get_Hamming_numbers(number * primes[pos]^k, pos + 1)
      end
    end
  end
end

get_Hamming_numbers(1, 1)

print("problem #204", "the number of generalised Hamming numbers of type 100:", count, count == 2944730)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
