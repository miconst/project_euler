import time, math

job_time = time.clock()

S = 0
N = 10**14

def is_harshad(number):
  """A Harshad number is a number that is divisible by the sum of its digits"""
  n = number
  s = 0
  while n:
    s += n % 10
    n //= 10
  return number % s == 0

# print(is_harshad(201))

def is_truncatable_harshad(number):
  """Truncatable Harshad number is a Harshad number that,
    while recursively truncating the last digit,
    always results in a Harshad number"""
  while number:
    if not is_harshad(number):
      return False
    number //= 10
  return True

# print(is_truncatable_harshad(201))

def get_primes( n ):
  # generate a list of integers from 2 to N
  primes = set( xrange( 3, n + 1, 2 ) )

  # Strike (sift out) the multiples
  for i in xrange( 3, n + 1, 2 ):
    if i in primes:
      for j in xrange( i + i, n + 1, i ):
        primes.discard( j )

  primes.add( 2 )

  return primes

primes = sorted(get_primes(int(math.sqrt(N))))

def is_prime(n):
  if n < 2:
    return False
  p_max = math.sqrt(n)
  for p in primes:
    if p > p_max:
      return True
    if n % p == 0:
      return False
  n /= 0
  return True

def is_strong_harshad(number):
  """a strong Harshad number is a Harshad number that, when divided by the sum
    of its digits, results in a prime a strong Harshad number"""
  n = number
  s = 0
  while n:
    s += n % 10
    n //= 10
  return number % s == 0 and is_prime(number / s)

def test_harshad(number):
  number *= 10
  if number < N // 10:
    for i in range(10):
      n = number + i
      if is_harshad(n):
        test_harshad(n)
        
        if is_strong_harshad(n):
          n *= 10
          for j in (1, 3, 7, 9):
            if is_prime(n + j):
              global S
              S += n + j

for i in range(1, 10):
  test_harshad(i)

print("problem #387. The sum of the strong, right truncatable Harshad primes " +
      "less than {0}: {1} ({2})".format(N, S, S == 696067597313468))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
