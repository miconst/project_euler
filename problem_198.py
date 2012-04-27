import time
job_time = time.clock()

def make_row(w):
  return [1]*w

##def make_rule_a(w):
##  return dict((x, x+1) for (x) in xrange(w-1))

def norm(s):
  for i in range(len(s) - 1):
    if s[i] > 3:
      s[i] = 1
      s[i + 1] += 1
  return s[-1] <= 3

def inc(s, pos):
  for i in range(pos):
    s[i] = 1
  s[pos] += 1
  return norm(s)

# rule #1: near cells cannot have the same colour
def get_invalid_pos_1(s):
  for i in range(len(s)-2, -1, -1):
    if s[i] == s[i + 1]:
      return i
  return -1

# rule #2: the cell cannot have the previos row color
def get_invalid_pos_2(s, t):
  for i in range(len(t)):
    if s[i*2] == t[i]:
      return i*2
  return -1

def get_stats(w, src = None, dst = {}):
  seq = [1]*w
  while 1:
    pos = 0
    i = get_invalid_pos_1(seq)
    if i < 0:
      k = tuple(seq[1:-1:2])
      if src:
        for t, v in src.items():
          if get_invalid_pos_2(seq, t) < 0:
            if not k in dst:
              dst[k] = v
            else:
              dst[k] += v
      else:
        if not k in dst:
          dst[k] = 1
        else:
          dst[k] += 1
    else:
      pos = i
    if not inc(seq, pos):
      return dst

W = 15  # row width
stats = get_stats(W)

##count = 0
##for k,v in stats.items():
##  count += v
##print(count)

for w in range(W - 2, 0, -2):
  s = {}
  print(len(stats))
  stats = get_stats(w, stats, s)

count = 0
for k,v in stats.items():
  count = count + v
print("problem #189. The number of distinct valid colourings:", count, count == 10834893628237824)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
