import time

job_time = time.clock()

def pow_mod(a, b, m):
  if b == 0:
    return 1
  elif b == 1:
    return a
  elif b % 2 == 0:
    return pow_mod( (a * a) % m, b / 2, m )
  else:
    return ( a * pow_mod( a, b - 1, m ) ) % m

def get_period(n, m):
  x = n
  p = 1
  while x != 1:
    x = (x * n) % m
    p += 1
  return p

M = 10**8

N = 1777
I = 1855

P = get_period(N, M)

# print( "period: ", P )

assert(N == pow_mod(N, P + 1, M))
assert(1 == pow_mod(N, P + 0, M))

n = N
i = I
while i > 2:
  i -= 1
  n = pow_mod(N, n, P)

last_digits = pow_mod(N, n, M)

print("problem #188. " +
      "The last 8 digits of {0}^^{1}: {2}".format(N, I, last_digits), last_digits == 95962097)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
