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

def get_invalid_pos(s, r={}):
  l = len(s)
  for i in range(l):
    pos = l - i - 1
    # rule #1: two cells cannot have the same colour
    if pos < l - 1 and s[pos] == s[pos + 1]:
      return pos
    # rule #2: the cell cannot have the defined color
    if pos in r and s[pos] == r[pos]:
      return pos
  return -1

def get_stats(seq, r2={}):
  stats = {}
  while True:
    pos = 0
    i = get_invalid_pos(seq, r2)
    if i < 0:
      k = tuple(seq[1:-1:2])
      if not k in stats:
        stats[k] = 1
      else:
        stats[k] += 1
    else:
      pos = i
    if not inc(seq, pos):
      break
  return stats

W = 15
stats = get_stats(make_row(W))

##count = 0
##for k,v in stats.items():
##  count += v
##print(count)

for w in range(W - 2, 0, -2):
  s = {}
  for k, v in stats.items():
    rule_b = {}
    for i in range(0, w, 2):
      rule_b[i] = k[i / 2]
    for kk, vv in get_stats(make_row(w), rule_b).items():
      if not kk in s:
        s[kk] = vv * v
      else:
        s[kk] += vv * v
  stats = s

count = 0
for k,v in stats.items():
  count = count + v
print("problem #189. The number of distinct valid colourings:", count, count == 10834893628237824)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))

