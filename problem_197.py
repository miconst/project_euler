import time, math

job_time = time.clock()

N = 10**12

def function(x):
  return math.floor(2**(30.403243784-x*x)) * 10**-9

a = function(-1)
b = function(a)

while True:
  c = function(b)
  d = function(c)
  if c == a and d == b: # just find the loop
    break
  a = c
  b = d

S = a + b

print("problem #197. " +
      "The sum of Un + Un+1 for n = 10**12: "+ str(S), S == 1.710637717)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
