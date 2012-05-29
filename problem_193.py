import time

job_time = time.clock()

def get_primes_sq(n):
  # generate a list of integers from 2 to N
  primes = set(xrange(3, n + 1, 2))
  primes_sq = [2 * 2]
  
  # strike (sift out) the multiples
  for i in xrange(3, n + 1):
    if i in primes:
      primes_sq.append(i * i)
      for j in xrange(i, n + 1, i):
        primes.discard(j)
  return primes_sq

N = 50

primes_sq = get_primes_sq(int(2**(N/2.0)))
print("Got {0} prime squares.".format(len(primes_sq)))

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
