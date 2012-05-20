import time, math

job_time = time.clock()

N = 20
D = 9
F = [math.factorial(x) for x in range(N + 1)]

class Solution:
  def __init__(self):
    self.seq = [0]*10
    self.sum = 0
  def get_all_square_sums(self, n, pos = 1, count = N):
    if n == 0:
      self.seq[0] = count
      x = reduce(lambda a, b: a / F[b], self.seq, F[N])
      for i, n in enumerate(self.seq):
        self.sum += i * x * n / N
    elif pos < 10 and count > 0 and n >= pos * pos:
      a = n // (pos * pos)
      if a > count:
        a = count
      for i in range(a, -1, -1):
        self.seq[pos] = i
        self.get_all_square_sums(n - i * pos * pos, pos + 1, count - i)

sol = Solution()
for i in range(1, int(math.ceil(math.sqrt(N * 9**2)))):
  sol.get_all_square_sums(i*i)

dsum = 0
for i in range(D):
  dsum += sol.sum * 10**i
dsum %= 10**D

print("problem #171. The last nine digits of the sum:", dsum, dsum == 142989277)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
