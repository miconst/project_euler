import time

job_time = time.clock()

N = 5000
S = -6 * 10**11
PLACE_NUM = 12

r = 1
dr = 0.25
while dr > 10.0**-PLACE_NUM:
  dr /= 2
  s = sum((900 - 3 * k) * r**(k - 1) for k in xrange(1, N + 1))
  if s > S:
    r += dr
  elif s < S:
    r -= dr
  else:
    break

R = '%.12f' % r

print("problem #235. " +
      "The the value of r for which s({0}) = {1}: {2}".format(N, S, R), R == '1.002322108633')

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
