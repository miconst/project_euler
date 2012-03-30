import math

def s(x):
  return x * (x + 1) / 2

def t(n):
  return s(7**n - 1)

def p(n):
  if n == 0:
    return 0
  else:
    return 21 * t(n - 1) + 28 * p(n - 1)

def q(n, r):
  x = 7**n
  return (x * (x - 1) - (x - r)*(x - r - 1)) / 2


def pascal(size):
  n = int(math.log(size, 7))
  row_size = 7**n
  row_num = size // row_size
  rest = size - row_num * row_size
  count = s(row_num - 1) * t(n) + s(row_num) * p(n)
  if rest > 0:
    count += row_num * q(n, rest)
    count += (row_num + 1) * pascal(rest)
  return count

print(s(100) - pascal(100))
print(s(10**9) - pascal(10**9))
