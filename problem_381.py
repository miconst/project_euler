import time, math

job_time = time.clock()

# links:
# Fast way to calculate n! mod m where m is prime:
# http://stackoverflow.com/questions/9727962/fast-way-to-calculate-n-mod-m-where-m-is-prime
# Wilson's theorem:
# https://en.wikipedia.org/wiki/Wilson%27s_theorem
# if n is prime then (n - 1)! % n == (-1 % n)
# Modular inverse:
# http://www.algorithmist.com/index.php/Modular_inverse

# Iterative Algorithm (xgcd)
def iterative_egcd(a, b):
    x,y, u,v = 0,1, 1,0
    while a != 0:
        q,r = b//a,b%a; m,n = x-u*q,y-v*q # use x//y for floor "floor division"
        b,a, x,y, u,v = a,r, u,v, m,n
    return b, x, y
 
# Recursive Algorithm
def recursive_egcd(a, b):
    """Returns a triple (g, x, y), such that ax + by = g = gcd(a,b).
       Assumes a, b >= 0, and that at least one of them is > 0.
       Bounds on output values: |x|, |y| <= max(a, b)."""
    if a == 0:
        return (b, 0, 1)
    else:
        g, y, x = recursive_egcd(b % a, a)
        return (g, x - (b // a) * y, y)
 
egcd = iterative_egcd  # or recursive_egcd(a, m)
 
def modinv(a, m):
    g, x, y = egcd(a, m) 
    if g != 1:
        return None
    else:
        return x % m

def modfac(n, m):
    f = 1
    for i in range(n + 1, m):
      f = (f * i) % m
    f = modinv(f, m)
    f = -f + m
    return f % m

N = 10**8
S = 0

def mod_factorial(n, m):
  f = 1
  while n > 1:
    f *= n
    f %= m
    n -= 1
  return f

# generate a list of integers from 0 to N + 1
composite_numbers = bytearray(N)

for i in xrange(2, N):
  if composite_numbers[i] == 0:
    # strike (sift out) the multiples
    for j in xrange(i + i, N, i):
      composite_numbers[j] = 1
    
    if i >= 5:
      # assert(mod_factorial(i - 1, i) == (-1 % i))
      s = modfac(i - 5, i) * (1 + (i - 4) + (i - 4)*(i - 3) + (i - 4)*(i - 3)*(i - 2) + (i - 4)*(i - 3)*(i - 2)*(i - 1))
      s %= i
      S += s

print("problem #381. The sum for for 5 <= p < {0}: {1} ({2})".format(N, S, S == 139602943319822))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
