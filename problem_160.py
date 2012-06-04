import time, math

job_time = time.clock()

N = 12
M = 5
MOD = 10**M

def pow_mod(n, k):
  if k%2 == 0:
    return pow_mod(n * n % MOD, k / 2)
  elif k > 1:
    return n * pow_mod(n, k - 1) % MOD
  else:
    return n

def split(n, accum):
  while n > 0:
    row_num = (n + 9) // 10
    x = (row_num - 1) * 10
    for i in [1,3,7,9]:
      y = x + i
      if y <= n:
        accum[i].append(y)
      elif y - 10 > 0:
        accum[i].append(y - 10)
    n_5 = 5 + (row_num - 1) * 10
    accum[5] += row_num
    if n_5 > n:
      n_5 -= 10
      accum[5] -= 1
    n = n_5 / 5

def factorial(n, accum):
  c = 0
  if n < 10:
    c = math.factorial(n)
  else:
    x = n % 10
    n -= x
    c = factorial(n / 2, accum)
    accum[2] += n / 2
    split(n, accum)
    for i in range(x):
      c *= (n + 1 + i)
    
  while c % 10 == 0:
    c /= 10
  while c % 5 == 0:
    c /= 5
    accum[5] += 1

  return c

ac = { 1:[], 2:0, 3:[], 5:0, 7:[], 9:[] }

digits = (factorial(10**N, ac) * pow_mod(2, ac[2] - ac[5])) % MOD

for a in [1,3,7,9]:
  print(digits)
  d = {}
  for x in ac[a]:
    x -= (x // MOD) * MOD
    d[x] = d.get(x, 0) + 1

  x = a
  while a < MOD:
    if a in d:
      digits = (digits * pow_mod(x, d[a])) % MOD
    a += 10
    x = (a * x) % MOD

print("problem #160. The last five digits of f(1,000,000,000,000):", digits, digits == 16576)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
