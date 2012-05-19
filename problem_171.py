import time, math

job_time = time.clock()

N = 20
D = 9
F = [math.factorial(x) for x in range(N + 1)]

digits = [0] * D

def add(seq, num):
  x = 0
  for i, n in enumerate(seq):
    n += num + x
    x = n // 10
    seq[i] = n - x * 10

def get_all_square_sums(n, seq = [0] * 10, pos = 1, count = N):
  if n == 0:
    seq[0] = count
    x = reduce(lambda a, b: a / F[b], seq, F[N])
    y = 0
    for i, n in enumerate(seq):
      y += i * x * n / N
    add(digits, y)
  elif pos < 10 and count > 0 and n >= pos * pos:
    a = count
    b = n // (pos * pos)
    if b < a:
      a = b
    for i in range(a, -1, -1):
      seq[pos] = i
      get_all_square_sums(n - i * pos * pos, seq, pos + 1, count - i)

for i in range(1, int(math.ceil(math.sqrt(N * 9**2)))):
  get_all_square_sums(i*i)
  print(i, digits)

dsum = 0
for i, n in enumerate(digits):
  dsum += n * 10**i

print("problem #171. The last nine digits of the sum:", dsum, dsum == 142989277)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
