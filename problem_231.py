import time

job_time = time.clock()

N = 20000000
K = 15000000

def get_sum( n, k ):
  # Generate a list of integers from 2 to N
  primes = set( xrange( 2, n + 1 ) )
  # Strike (sift out) the multiples
  p = 2
  s = 0
  while p <= n:
    if p in primes:
      x = 0
      for i in xrange( p, n + 1, p ):
        primes.discard( i )
        # plus range [k + 1, n]
        if k + 1 <= i <= n:
          j = i
          while j % p == 0:
            x += 1
            j /= p
        # minus range [1, n - k]
        if 1 <= i <= n - k:
          j = i
          while j % p == 0:
            x -= 1
            j /= p
      s += p*x
    p += 1
  return s

#~ S = get_sum(N, K)

def get_sum_2( n, k ):
  primes = [0] * (n + 1)
  # Strike (sift out) the multiples
  p = 2
  while p <= n:
    if primes[p] == 0:
      i = p
      while i <= n:
        for j in xrange(i, n + 1, i):
          primes[j] += p
        i *= p
    p += 1
  # plus range [k + 1, n]
  # minus range [1, n - k]
  return sum(primes[k + 1:n + 1]) - sum(primes[1:n - k + 1])

S = get_sum_2(N, K)

print("problem #231. " +
      "The sum of the terms in the prime factorisation of C({0}, {1}): {2}".format(N, K, S), S == 7526965179680)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
