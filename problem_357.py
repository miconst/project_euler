import time, math

job_time = time.clock()

# Numbers n such that for any positive integers (a, b),
# if a * b = n then a + b is prime.
# https://oeis.org/A080715

N = 10**8
S = 0

# generate a list of integers from 0 to N + 1
composite_numbers = bytearray(N + 2)

for i in xrange(2, N + 2):
  if composite_numbers[i] == 0:
    # strike (sift out) the multiples
    for j in xrange(i + i, N + 2, i):
      composite_numbers[j] = 1
    
    n = i - 1
    d_max = int(math.sqrt(n))
    for d in xrange(1, d_max + 1):
      if n % d == 0:
        a = n // d
        if composite_numbers[a + d] != 0:
          break
    else:
      S += n

print("problem #357. " +
      "The sum of all positive integers n not exceeding {0} such that for every"
      " divisor d of n, d+n/d is prime: {1} ({2})".format(N, S, S == 1739023853137))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
