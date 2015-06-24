import time, math

job_time = time.clock()

N = 10**7
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

primes = sorted(get_primes(N/2))

# M = dict()

for i in xrange(len(primes) - 1):
    a = primes[i]
    # assert(not a in M)
    # M[a] = dict()
    for j in xrange(i + 1, len(primes)):
        b = primes[j]
        if a*b > N:
            break
        
        assert(a < b and a*b <= N)

        # assert(not b in M[a])
        # M[a][b] = a*b
        M = a*b
        for ka in range(1, int(math.log(N, a)) + 1):
            for kb in range(1, int(math.log(N, b)) + 1):
                n = a**ka * b**kb
                if M < n <= N:
                    M = n
        S += M

# for a in M:
    # print(a,":", M[a])
    # for b in M[a]:
        # S += M[a][b]

# print(M[2][3])
# print(M[3][5])
# print(M[2][73])

# print(M)

print("problem #347. " +
      "The sum of all distinct M(p,q,N) for n <= {0}: {1} ({2})".format(N, S, S == 11109800204052))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
