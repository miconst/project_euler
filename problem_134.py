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

def get_number( p1, p2, prime ):
  x1 = p1 % 10
  x2 = p2 % 10
  n = 0
  while x1 != x2:
    n += 1
    x2 = (x2 + prime) % 10
  p1 //= 10
  if p1 > 0:
    n += 10 * get_number( p1, ( p2 + prime * n ) // 10, prime )
  return n

primes = sorted( get_primes( 10**6 + 3 ) )

s = 0

for i in xrange( len( primes ) - 1 ):
  p1 = primes[ i ]
  p2 = primes[ i + 1 ]
  if p1 >= 5:
    s += ( 1 + get_number( p1, p2, p2 ) ) * p2

print( "problem #134. " +
       "The sum of S for every pair of consecutive primes [5, 10^6]:", s,
       s == 18613426663617118 )

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
