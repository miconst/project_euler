import time, math, random

job_time = time.clock()

# Fibbinary numbers
# https://oeis.org/A003714

N = 2**30
C = 0

for n in xrange(1, N + 1):
  if 2*n & n == 0:
    C += 1

print("problem #301. " +
      "The number of positive integers for n <= {0}: {1} ({2})".format(N, C, C == 2178309))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
