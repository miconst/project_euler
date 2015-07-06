import time, math

job_time = time.clock()

N = 10**5 # primes below one-hundred thousand
S = 0 # the sum of all the primes

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

# remove 2 and 5
primes = []
for p in get_primes(N):
  if p%10 not in (2, 5):
    primes.append(p)
  else:
    S += p

for p in primes:
  s = p
  n = 0
  while True:
    while s%10 == 1:
      s /= 10
      n += 1
    if s == 0:
      break
    s += p
  while n > 0 and n % 2 == 0: n /= 2
  while n > 0 and n % 5 == 0: n /= 5
  
  if n != 1:
    S += p

print("problem #133. " +
      "The sum of all the primes below {0}: {1} ({2})".format(N, S, S == 453647705))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
