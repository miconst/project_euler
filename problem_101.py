import time, math

job_time = time.clock()

def OP(n, seq):
  return reduce(lambda a, i: a + seq[i] * n**i, range(len(seq)), 0)

def U(n):
  return OP(n, [(-1)**n for n in range(11)])

def gaussian_elimination(m):
  for a in range(len(m) - 1):
    x = m[a][a]
    for b in range(a + 1, len(m)):
      y = m[b][a]
      for i in range(len(m[b])):
        m[b][i] = m[b][i] * x - m[a][i] * y
  return m

def make_matrix(n):
  m = [[r**k for k in range(n)] for r in range(1, n + 1)]
  for i, r in enumerate(m):
    r.append(U(i + 1))
  return m

def solve(m):
  gaussian_elimination(m)
  h = len(m)
  x = [0] * h

  for r in range(h - 1, -1, -1):
    d = reduce(lambda s, k: s + m[r][k] * x[k], range(r + 1, h), 0)
    x[r] = (m[r][h] - d) / m[r][r]
  return x

N = 10

print([U(n) for n in range(1, N + 1)])
  
s = 0
for n in range(1, N + 1):
  a = solve(make_matrix(n))
  op = [OP(i, a) for i in range(1, n + 2)]
  s += op[len(op) - 1]
  print(op)

print("problem #101. The sum of FITs for the BOPs:", s, s == 37076114526)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
