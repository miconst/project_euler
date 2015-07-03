import time, math, itertools

job_time = time.clock()

def A(cx, cy, cz, n):
  """returns the number of cubes to cover every visible face on a cuboid layer n"""
  a = cx - 1
  b = cy - 1
  c = cz - 1
  return 4 * n * n + 4 * n * (a + b + c) + 2 + 2 * (a * b + b * c + a * c)

def C(n):
  count = 0
  for a in range(n):
    for b in range(0, a + 1):
      if n <= 2*(a*b + 1):
        break
      for c in range(0, b + 1):
        if n <= 2*(a*b + a*c + b*c + 1):
          break
        
        y_2 = a*a + b*b + c*c + n - 2
        y = int(math.sqrt(y_2))
        if y * y == y_2:
          assert(y > a+b+c)
          l = y - a - b - c
          if l%2 == 0:
            l /= 2
            # if A(a+1, b+1, c+1, l) != n:
              # print(A(a+1, b+1, c+1, l), n, a, b, c, l)
            assert(A(a+1, b+1, c+1, l) == n)
            count += 1
  return count
        
print(C(22), C(46), C(78), C(118), C(154))

CN = 1000

solids = {}
for cx in itertools.count(1):
  for cy in itertools.count(cx):
    for cz in itertools.count(cy):
      for n in itertools.count(1):
        c = A(cx, cy, cz, n)
        if c not in solids:
          solids[c] = 1
        else:
          solids[c] += 1

        if c > 20000:
          break
      if n == 1:
        break
    if cz == cy:
      break
  if cy == cx:
    break

n = min(k for k, i in solids.items() if i == CN)
assert(C(n) == CN)

print("problem #126. " +
      "The least value of n for which C(n) = {0}: {1} ({2})".format(CN, n, n == 18522))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
