import time
job_time = time.clock()

def inc(s, pos):
  for i in range(pos):
    s[i] = 1
  s[pos] += 1
  
  last = len(s) - 1
  while s[pos] > 3:
    if pos == last:
      return False
    else:
      s[pos] = 1
      pos += 1
      s[pos] += 1
  return True

# rule #1: near cells cannot have the same colour
def get_invalid_pos_1(s):
  for i in range(len(s)-2, -1, -1):
    if s[i] == s[i + 1]:
      return i
  return -1

# rule #2: the cell cannot have the previos row color
def get_invalid_pos_2(s, t):
  for i, c in enumerate(t):
    if s[i*2] == c:
      return i*2
  return -1

def get_stats(w, src = None):
  dst = {}
  seq = [1]*w
  while 1:
    pos = 0
    i = get_invalid_pos_1(seq)
    if i < 0:
      k = tuple(seq[1:-1:2])
      if src:
        for t, v in src.iteritems():
          if get_invalid_pos_2(seq, t) < 0:
            dst[k] = dst.get(k, 0) + v
      else:
        dst[k] = dst.get(k, 0) + 1
    else:
      pos = i
    if not inc(seq, pos):
      return dst

W = 15  # row width
stats = get_stats(W)

for w in range(W - 2, 0, -2):
  print(len(stats))
  stats = get_stats(w, stats)

count = 0
for k,v in stats.items():
  count = count + v
print("problem #189. The number of distinct valid colourings:", count, count == 10834893628237824)

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
