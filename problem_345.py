import time, math

job_time = time.clock()

M0 =  [[  7,  53, 183, 439, 863],
      [497, 383, 563,  79, 973],
      [287,  63, 343, 169, 583],
      [627, 343, 773, 959, 943],
      [767, 473, 103, 699, 303]]
N0 = len(M0)

M1 =  [[ 7,  53, 183, 439, 863, 497, 383, 563,  79, 973, 287,  63, 343, 169, 583],
      [627, 343, 773, 959, 943, 767, 473, 103, 699, 303, 957, 703, 583, 639, 913],
      [447, 283, 463,  29,  23, 487, 463, 993, 119, 883, 327, 493, 423, 159, 743],
      [217, 623,   3, 399, 853, 407, 103, 983,  89, 463, 290, 516, 212, 462, 350],
      [960, 376, 682, 962, 300, 780, 486, 502, 912, 800, 250, 346, 172, 812, 350],
      [870, 456, 192, 162, 593, 473, 915,  45, 989, 873, 823, 965, 425, 329, 803],
      [973, 965, 905, 919, 133, 673, 665, 235, 509, 613, 673, 815, 165, 992, 326],
      [322, 148, 972, 962, 286, 255, 941, 541, 265, 323, 925, 281, 601,  95, 973],
      [445, 721,  11, 525, 473,  65, 511, 164, 138, 672,  18, 428, 154, 448, 848],
      [414, 456, 310, 312, 798, 104, 566, 520, 302, 248, 694, 976, 430, 392, 198],
      [184, 829, 373, 181, 631, 101, 969, 613, 840, 740, 778, 458, 284, 760, 390],
      [821, 461, 843, 513,  17, 901, 711, 993, 293, 157, 274,  94, 192, 156, 574],
      [ 34, 124,   4, 878, 450, 476, 712, 914, 838, 669, 875, 299, 823, 329, 699],
      [815, 559, 813, 459, 522, 788, 168, 586, 966, 232, 308, 833, 251, 631, 107],
      [813, 883, 451, 509, 615,  77, 281, 613, 459, 205, 380, 274, 302,  35, 805]]
N1 = len(M1)

S = 0

def next_permutation(t):
  # permute and test for pure ascending
  last = len(t) - 1
  left = last
  while left > 0:
    # find rightmost element smaller than successor
    right = left
    left -= 1
    if t[left] < t[right]:
      # swap with rightmost element that's smaller, flip suffix
      mid = last
      while t[left] >= t[mid]:
        mid -= 1

      t[left], t[mid] = t[mid], t[left]
      t[right:last+1] = t[last:right-1:-1]  # reverse
      return True
  # pure descending, flip all
  t[0:last+1] = t[last:-1:-1]
  return False

S = 0
col_set = set(range(N1))
for row in range(N1):
  i = max(col_set, key = lambda x: M1[row][x])
  S += M1[row][i]
  col_set.remove(i)

print(S)

def get_possible_max(row, available_cols):
  s = 0
  for r in range(row + 1, N1):
    s += M1[r][max(available_cols, key = lambda x: M1[r][x])]
  return s

x = range(N1)
while next_permutation(x):
  s = 0
  available = set(x)
  for row in range(N1):
    col = x[row]
    s += M1[row][col]
    available.remove(col)
    
    if s + get_possible_max(row, available) < S:
      x[row + 1:] = sorted(x[row + 1:], reverse=True)
      break
  if s > S:
    S = s
    print(S, x)

print("problem #345. The Matrix Sum: {0} ({1})".format(S, S == 13938))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
