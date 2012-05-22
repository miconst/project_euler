import time, bisect

job_time = time.clock()

def get_primes(n):
  # generate a list of integers from 2 to N
  primes = set(xrange(3, n + 1, 2))
  
  # strike (sift out) the multiples
  for i in xrange(3, n + 1):
    if i in primes:
      for j in xrange(i + i, n + 1, i):
        primes.discard(j)
  primes.add(2)
  return primes

N = 50

primes_sq = [x * x for x in get_primes(int(2**(N/2.0)))]
primes_sq.sort()
print(len(primes_sq))

def get_euler_coefs(number, level):
  n = [ 0 ]
  def get_coefs(x, cur_pos, num_of_elem):
    assert(x <= number)
    num_of_elem -= 1
    for pos in xrange(cur_pos, len(primes_sq)):
      y = primes_sq[pos] * x
      if y <= number:
        if num_of_elem == 0:
          n[0] += number // y
        else:
          get_coefs(y, pos + 1, num_of_elem)
      else: break
  get_coefs(1, 0, level + 1)
  return n[0]

def get_squarefree(number):
  x = 0
  for l in xrange(len(primes_sq)):
    n = get_euler_coefs(number, l)
    if n == 0: break
    x += (-1)**(l%2) * n
  return number - x

count = get_squarefree(2**N)
print("problem #193. The number of squarefree numbers below 2^50:", count, count == 684465067343069)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
