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

primes = get_primes( N )
#~ print(len(primes))

# The General formula for Euler's Totient Function is:
# euler_phi(m) = m * (1 - 1 / p1) * (1 - 1 / p2) * (1 - 1 / p3) * ( ... ) * (1 - 1 / pn)
# Where p1, p2, p3, . . . , pn are prime factors of m.

def euler_phi(m):
  phi = m
  i = iter(primes)
  while m != 1:
    if m in primes:
      phi -= phi / m
      m = 1
    else:
      while True:
        p = i.next()
        if m % p == 0:
          while m % p == 0:
            m /= p
          phi -= phi / p
          break
  return phi

done = { 1:1 }

def euler_phi_chain_length(m):
  if m not in done:
    c = 0
    n = m
    while n not in done:
      n = euler_phi(n)
      c += 1
    done[m] = c + done[n]
  return done[m]

c = 0
for p in sorted(primes):
  l = euler_phi_chain_length(p)
  if l == L:
    c += 1
    #~ print(p)
    S += p

#~ print "!", c

print("problem #214. " +
      "The sum of all primes less than {0} which generate a chain of length {1}: {2}".format(N, L, S), S == 1677366278943)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
