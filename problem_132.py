import time, math, fractions

job_time = time.clock()

def get_primes( n ):
  # generate a list of integers from 2 to N
  primes = set( xrange( 2, n + 1 ) )
  # Strike (sift out) the multiples
  for i in xrange( 2, n + 1 ):
    if i in primes:
      for j in xrange( i + i, n + 1, i ):
        primes.discard( j )

  return primes

primes = sorted( get_primes( 160001 ) )

def get_repunit( k ):
    n = 0
    while k > 0:
        n = n * 10 + 1
        k -= 1
    return n

def get_divisors( n ):
  ds = []
  for p in primes:
    if n == 1:
      break
    while n % p == 0:
      ds.append( p )
      n /= p
  return ds

def get_all_divisors(n):
  ds = set()
  def add_divisors(k):
    for d in set(get_divisors(k)):
      ds.add(d)
      x = k / d
      if x > 1 and x not in ds:
        ds.add(x)
        add_divisors(x)
  add_divisors(n)
  return ds


RL = 10**9  # repunit length

ds = set()

# brute force solution:
# for x in sorted(get_all_divisors(RL)):
  # ds |= set(get_divisors(get_repunit(x)))
  # print(x, len(ds), sorted(ds))
  # if len(ds) == 40:
    # break

# (10^k - 1) / 9 solution:
primes.remove(3)  # 3 is coprime with 9
for x in primes:
  if pow(10, RL, 9*x) == 1:
    ds.add(x)
    if len(ds) == 40:
      break

s = sum( ds )

print( "problem #132. " +
       "The sum of the first forty prime factors of R(10^9):", s,
       s == 843296 )

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
