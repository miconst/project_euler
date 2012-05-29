import time, math, fractions

job_time = time.clock()

def sym(l, n):
  ac = {}
  ns = [0] * n
  rg = range(n)
  def do_sym(level):
    if level == 0:
      x = reduce(lambda a, b: a * (b + 1), ns, 1)
      ac[x] = ac.get(x, 0) + 1
    else:
      for i in rg:
        ns[i] += 1
        do_sym(level - 1)
        ns[i] -= 1
  do_sym(l)
##  bp = reduce(lambda a, b: a * b, ac.iterkeys())
##  ap = reduce(lambda a, b: a + ac[b] * bp / b, ac.iterkeys(), 0)
##  gcd = fractions.gcd(ap, bp)
##  print(l, ap, bp, ap/gcd, bp/gcd)
  return ac

N = 16
M = 16
FS = [math.factorial(x) for x in range(M+1)]
SS_3 = [sym(x, 3) for x in range(N)]
SS_2 = [sym(x, 2) for x in range(N)]
      
def expand(x, y, n, SS):
  m = FS[y + n]
  r = 0
  for k in range(n + 1):
    a = n - k
    b = k
    c = x**a * m / (FS[a] * FS[b])

    for key, val in SS[b].items():
      r += c * val / key
  return r

def t3(n):
  return expand(N - 3, 3, n - 3, SS_3)

def t2(n):
  return expand(N - 2, 2, n - 2, SS_2)

def f(n):
  if n == 3:
    return 4
  else:
    return (N - 3) * t3(n - 1) + 2 * t2(n - 1) + f(n - 1)

count = hex(f(M)).upper().rstrip("L").replace("0X", "")

print("problem #162. The number of hex numbers containing at most 16 digits with 0,1 and A present:", count, count == '3D58725572C62302')

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
