-- problem #51
local job_time = os.time()

-- Sieve of Eratosthenes
local function get_primes(n)
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

local function get_permutations(size)
  local mutations = {}
  local function permutate(mask)
    if #mask == size then
      mutations[mask] = true
    else
      permutate(mask .. "1")
      permutate(mask .. "0")
    end
  end
  permutate ""
  return mutations
end

local function get_smallest_prime()
  -- create primes
  local N = 2000000
  local primes, prime_hash = get_primes(N)

  local mask_size, mutations, pattern = 0, {}, ""

  for i = 1, #primes do
    local prime = primes[i]
    local s = tostring(prime)

    -- mask adjustment
    local new_mask_size = #s - 1
    if new_mask_size > mask_size then
      -- create all possible masks
      mask_size = new_mask_size
      mutations = get_permutations(mask_size)
      pattern = string.rep("([1-9])", mask_size)
      -- remove change_all and change_none masks
      mutations[string.rep("1", mask_size)] = nil
      mutations[string.rep("0", mask_size)] = nil
      print("mask_size update:", mask_size)
      --
      for mask in pairs(mutations) do
        local old_digit, new_digit = "x", "%"
        local repl = ""
        for i = 1, #mask do
          repl = repl .. (mask:sub(i, i) == "1" and "X" or ("%" .. tostring(i)))
        end
        mutations[mask] = repl
      end
    end

    -- apply the masks
    for mask, repl in pairs(mutations) do
      local s_mask = s:gsub(pattern, repl, 1)
      local prime_count = 1
      for i = 1, 9 do
        local s_new = s_mask:gsub("X", tostring(i))
        --print(i, s, s_new, mask, repl)
        if s_new ~= s and prime_hash[tonumber(s_new)] then
          prime_count = prime_count + 1
        end
      end

      if prime_count >= 8 then
        return prime
      end
    end
  end
end

local min_prime = get_smallest_prime()

print("problem #51", "the smallest prime:", min_prime, min_prime == 121313)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
