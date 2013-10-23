import time, math

job_time = time.clock()

# x > y > z > 0
# x + y, x - y, x + z, x - z, y + z, y - z are all perfect squares

# x + y = a2
# x - y = b2
# x + z = c2
# x - z = d2
# y + z = e2
# y - z = f2

# a > c > d > b
# e > f

def solve():
  a = 1
  while True:
    a2 = a*a
    for c in xrange(1, a):
      c2 = c*c
      for d in xrange(1, c):
        d2 = d*d
        if (c2 + d2) % 2 == 0 and (c2 - d2) % 2 == 0:
          b2 = c2 + d2 - a2
          if a2 > b2 > 0 and (a2 - b2) % 2 == 0:
            b = int(math.sqrt(b2))
            if b*b == b2:
              f2 = a2 - c2
              e2 = a2 - d2
              if f2 > 0:
                assert(e2 > f2)
                f = int(math.sqrt(f2))
                e = int(math.sqrt(e2))
                if f*f == f2 and e * e == e2:
                  x = (c2 + d2) / 2
                  y = (a2 - b2) / 2
                  z = (c2 - d2) / 2
                  return x, y, z
    a += 1

s = sum(solve())

print("problem #142. " +
      "The smallest x + y + z :" + str(s), s == 1006193)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
