-- Sieve of Eratosthenes
local job_time = os.time()

local output = { { 1, 2, 3, 4, 5, 6 } }

local function permutations( inp, s )
  for j = s, #inp do
    for i  =  j + 1, #inp do
      local tmp = { unpack( inp ) }
      print( unpack( inp ) )
      tmp[ i ], tmp[ j ] = tmp[ j ], tmp[ i ]
      --inp[ i ], inp[ j ] = inp[ j ], inp[ i ]
      --table.insert( output, tmp )
      permutations( tmp, j + 1 )
      --permutations( inp, j + 1 )
    end
  end
end

--permutations( output[ 1 ], 1 )
permutations( { 1, 2, 3, 4, 5, 6 }, 1 )

print( "SIZE:", #output )
for _, t in ipairs( output ) do
  print( "!!!", unpack( t ) )
end

do return end

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

get_primes(200000)

p = get_primes(100)
print("!", unpack(p))


job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))


print(os.date())
