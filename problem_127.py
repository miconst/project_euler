import time, math
from fractions import gcd

job_time = time.clock()

N = 120000#120000
S = 0

# abc-hits:

#    GCD(a, b) = GCD(a, c) = GCD(b, c) = 1
#    a < b
#    a + b = c
#    rad(abc) < c

def get_primes( n ):
  # generate a list of integers from 2 to N
  primes = set( xrange( 3, n + 1, 2 ) )

  # Strike (sift out) the multiples
  for i in xrange( 3, n + 1, 2 ):
    if i in primes:
      for j in xrange( i + i, n + 1, i ):
        primes.discard( j )

  primes.add( 2 )

  return primes

primes = get_primes( N - 1 )

# The radical of n, rad(n), is the product of distinct prime factors of n.
prime_set = [set() for x in xrange(N)]
radicals = [1] * N
for p in primes:
  for j in xrange(p, N, p):
    prime_set[j].add(p)
    radicals[j] *= p

for c in xrange(3, N):
  #~ if c in primes:
    #~ continue
  rc = radicals[c]
  if rc + rc >= c:
    continue
  # check a = 1, b = c - 1
  if rc * radicals[c - 1] < c and prime_set[c - 1].isdisjoint(prime_set[c]):
    S += c
  elif 2 * 3 * rc >= c:
    continue
  for b in xrange(1 + c // 2, c - 1):
    a = c - b
    #~ assert(a > 0)
    #~ assert(a < b)
    r = rc * radicals[a] * radicals[b]
    if r < c and prime_set[a].isdisjoint(prime_set[b]) and prime_set[a].isdisjoint(prime_set[c]) and prime_set[b].isdisjoint(prime_set[c]):
    #~ if r < c and gcd(a, b) == 1 and gcd(a, c) == 1 and gcd(b, c) == 1:
      #~ print a, b, c
      S += c

'''
for b in xrange(2, N):
  if b in primes:
    continue
  rb = radicals[b]
  if rb + rb >= b:
    continue
  for a in xrange(1, min(b, N - b)):
    c = a + b
    r = rb * radicals[a] * radicals[c]
    if r < c and prime_set[a].isdisjoint(prime_set[b]) and prime_set[a].isdisjoint(prime_set[c]) and prime_set[b].isdisjoint(prime_set[c]):
    #~ if r < c and gcd(a, b) == 1 and gcd(a, c) == 1 and gcd(b, c) == 1:
      #~ print a, b, c
      S += c
'''

#18407904

print("problem #127. " +
      "The sum of abc-hits for n = {0}: {1}".format(N, S), S == 541276)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
