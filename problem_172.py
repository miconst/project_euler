import time, math

job_time = time.clock()

N = 18
FS = dict((x,math.factorial(x)) for x in [0, 1, 2, 3, N - 1])
NUM = range(4)

numbers = [0]*10
count = 0

def test(level=0):
  if level == len(numbers):
    if sum(numbers) == N:
      global count
      count += FS[N - 1] * (N - numbers[0]) / reduce(lambda a, b: a * FS[b], numbers, 1)
  else:
    for n in NUM:
      numbers[level] = n
      test(level + 1)

test()

print("problem #172. The number of 18-digit numbers:", count, count == 227485267000992000)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
