import time, math

job_time = time.clock()

# solve y^2 = (16+x^2)/80 over the integers:
#
# n >= 0
#
# x = -2 * ( 2 * ( 9 - 4 * sqrt(5) )^n +
#      sqrt(5) * ( 9 - 4 * sqrt(5) )^n +
#            2 * ( 9 + 4 * sqrt(5) )^n -
#      sqrt(5) * ( 9 + 4 * sqrt(5) )^n )
# y =    ( -5 * ( 9 - 4 * sqrt(5) )^n -
# 2 * sqrt(5) * ( 9 - 4 * sqrt(5) )^n -
#           5 * ( 9 + 4 * sqrt(5) )^n + 
# 2 * sqrt(5) * ( 9 + 4 * sqrt(5) )^n ) / 10

SQRT_5 = math.sqrt(5)
A = ( 9 - 4 * SQRT_5 )
B = ( 9 + 4 * SQRT_5 )

S = 0
for n in range(2, 14):
  x = int( 2 * ( SQRT_5 * ( B**n - A**n ) - 2 * ( A**n + B**n ) )  + 0.125 )
  y = int( ( 5 * ( A**n  + B**n ) + 2 * SQRT_5 * ( A**n - B**n ) ) / 10 + 0.125 )

  #~ print x, y, y*y - ((16 + x*x) / 80)
  
  #~ assert(y*y == (16 + x*x) / 80)
  S += y

# http://oeis.org/A007805
def Fibonacci(n):
  done = { 0:0, 1:1 }
  def DoFibonacci(n):
    if n not in done:
      done[n] = DoFibonacci(n - 1) + DoFibonacci(n - 2)
    return done[n]
  return DoFibonacci(n)

def A007805(n):
  return Fibonacci(6 * n + 3) / 2

Sf = 0
for n in range(1, 13):
  #~ print( A007805(n) )
  Sf += A007805(n)

assert( S == Sf )

# brute-force solution
def solve():
  s = 0
  a = 12
  da = 16
  n = 0
  while n < 6:
    #~ assert(a % 4 == 0)
    a2 = a*a
    #~ assert((16 + a2) % 80 == 0)
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

#~ S = solve()

print("problem #138. " +
      "The sum L for the 12 smallest isosceles triangles for which h = b +- 1: " + str(S), S == 1118049290473932)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
