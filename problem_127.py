import time, math

job_time = time.clock()

N = 120000 #120000
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

# The radical of n, rad(n), is the product of distinct prime factors of n.
primes = [set() for x in xrange(N)]
rad = [1] * N
for p in get_primes( N - 1 ):
  for j in xrange(p, N, p):
    primes[j].add(p)
    rad[j] *= p

rad_sets = dict()
for n in xrange(1, N):
  r = rad[n]
  if r not in rad_sets:
    rad_sets[r] = set()
  rad_sets[r].add(n)

rad_keys = sorted(rad_sets.keys())

for c in xrange(3, N):
  rc = rad[c]
  if rc + rc >= c:
    continue
  # check a = 1, b = c - 1
  if rc * rad[c - 1] < c and primes[c - 1].isdisjoint(primes[c]):
    S += c
  elif 2 * 3 * rc >= c:
    continue
  b_min = 1 + c // 2
  b_max = c - 2
  for rb in rad_keys:
    r = rb * rc
    if r > c:
      break
    for b in rad_sets[rb]:
      if b_min <= b <= b_max:
        a = c - b
        if r * rad[a] < c and primes[a].isdisjoint(primes[b]) and primes[a].isdisjoint(primes[c]) and primes[b].isdisjoint(primes[c]):
          S += c

print("problem #127. " +
      "The sum of abc-hits for n = {0}: {1}".format(N, S), S == 18407904)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
