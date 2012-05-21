import time

job_time = time.clock()

def is_increasing(number):
  a = number % 10
  number = (number - a) / 10
  while number > 0:
    b = number % 10
    if b > a:
      return False
    a = b
    number = (number - a) / 10
  return True

def is_decreasing(number):
  a = number % 10
  number = (number - a) / 10
  while number > 0:
    b = number % 10
    if b < a:
      return False
    a = b
    number = (number - a) / 10
  return True

N = 100
inc_t = [[1] * 9 for i in range(N)]
dec_t = [[1] * 9 for i in range(N)]

for i in range(1, N):
  for j in range(9):
    inc_t[i][j] = sum(inc_t[i - 1][j:])
    dec_t[i][j] = sum(dec_t[i - 1][:j+1], 1)

count = -9 * N
for i in range(len(inc_t)):
  count += sum(inc_t[i]) + sum(dec_t[i])

##count_i = 0
##count_d = 0
##count_e = 0
##for i in xrange(1, 10**N):
##  if is_increasing(i):
##    count_i += 1
##  if is_decreasing(i):
##    count_d += 1
##  if is_increasing(i) and is_decreasing(i):
##    count_e += 1
##print(count, count_i + count_d - count_e)

print("problem #113. The numbers below a googol (10**100) that are not bouncy:", count, count == 51161058134250)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
