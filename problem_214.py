import time, math

job_time = time.clock()

N = 40000000
L = 25
S = 0

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

# The General formula for Euler's Totient Function is:
# euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
# Where p1, p2, p3, . . . , pn are prime factors of m.
phi = range( N )
for p in primes:
  for i in xrange( p, N, p ):
    phi[ i ] -= phi[ i ] / p

done = { 1:1 }

def euler_phi_chain_length(m):
  if m not in done:
    done[m] = 1 + euler_phi_chain_length(phi[m])
  return done[m]

for p in primes:
  l = euler_phi_chain_length(p)
  if l == L:
    S += p

print("problem #214. " +
      "The sum of all primes less than {0} which generate a chain of length {1}: {2}".format(N, L, S), S == 1677366278943)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
