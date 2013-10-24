import time, math

job_time = time.clock()

def solve():
  s = 0
  a = 12
  da = 16
  n = 0
  while n < 6:
    #~ assert(a % 4 == 0)
    a2 = a*a
    #~ assert((16 + a2) % 80 == 0)
    #~ if (16 + a2) % 80 == 0:
    L2 = (16 + a2) // 80
    L = int(math.sqrt(L2))
    if L*L == L2:
      if da == 16:
        b = a + 8  # 2
        #~ assert(b % 10 == 0)
        b /= 10
        s += L
        n += 1
        print n, b, L, a
      else: # da == 4
        b = a - 8  # 8
        #~ assert(b % 10 == 0)
        b /= 10
        s += L
        n += 1
        print n, b, L, a

    a += da
    if da == 16:
      da = 4
    else:
      da = 16
  return s

S = solve()

print("problem #138. " +
      "The sum L for the 12 smallest isosceles triangles for which h = b +- 1: " + str(S), S == 1006193)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
