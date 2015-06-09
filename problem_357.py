import time, math

job_time = time.clock()

# Numbers n such that for any positive integers (a, b),
# if a * b = n then a + b is prime.
# https://oeis.org/A080715

N = 10**8
P_MAX = int(math.sqrt(N))

primes = [2]

for i in xrange(3, P_MAX, 2):
  p_max = math.sqrt(i)
  for p in primes:
    if p > p_max:
      primes.append(i)
      break

    d = i // p
    if d * p == i:
      break

# print len(primes)

def is_prime(n):
  p_max = math.sqrt(n)
  for p in primes:
    if p > p_max:
      break
    if n % p == 0:
      return False
  return True

S = 1

for n in xrange(2, N, 2):
  d_max = int(math.sqrt(n))
  for d in xrange(1, d_max + 1):
    if n % d == 0:
      a = n // d
      if not is_prime(a + d):
        break
  else:
    # print n
    S += n

print("problem #357. " +
      "The sum of all positive integers n not exceeding {0} such that for every"
      " divisor d of n, d+n/d is prime: {1} ({2})".format(N, S, S == 1739023853137))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
