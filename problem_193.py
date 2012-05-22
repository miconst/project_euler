import time

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

def get_euler_coefs(number):
  ns = []
  def get_coefs(x=1, cur_pos=0, level=0):
    assert(x <= number)
    if level == len(ns):
      ns.append(0)
    for pos in xrange(cur_pos, len(primes_sq)):
      y = primes_sq[pos] * x
      if y <= number:
        ns[level] += number // y
        get_coefs(y, pos + 1, level + 1)
      else: break

  get_coefs()
  return ns

def get_squarefree(number):
  x = 0
  for i, n in enumerate(get_euler_coefs(number)):
    x += (-1)**(i%2) * n
  return number - x

count = get_squarefree(2**N)
print("problem #193. The number of squarefree numbers below 2^50:", count, count == 684465067343069)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
