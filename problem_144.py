import time, math

job_time = time.clock()

# ellipse equation 4*x**2 + y**2 = 100
#
# exit hole
# -0.01 <= x <= 0.01
# y**2 >= 99.9996
#
# start_point = (0.0, 10.1)
# impact_point = (1.4, -9.6)

# the slope m of the tangent line at any point (x,y) of the given ellipse is: m = -4x/y
# m = -4 * impact_point[0] / impact_point[1]

x0 =  0.0
y0 = 10.1

x =  1.4
y = -9.6

i = 0

while True:
  vx = x - x0
  vy = y - y0
  
  # print("V", vx, vy)

  a = -8 * x * y
  b = 16 * x * x - y * y
  # r = vx'/vy'
  r = (a * vx + b * vy) / (a * vy - b * vx)
  
  # print("abr", a, b, r)

  x1 = ((r * r - 4) * x + 4 * r * math.sqrt(25 - x *x)) / (r * r + 4)
  x2 = ((r * r - 4) * x - 4 * r * math.sqrt(25 - x *x)) / (r * r + 4)

  y1 = y + r * (x1 - x)
  y2 = y + r * (x2 - x)

  x0 = x
  y0 = y
  if abs((4 * x1 * x1 + y1 * y1) - 100) < 0.001:
    x = x1
    y = y1
  else:
    assert(abs((4 * x2 * x2 + y2 * y2) - 100) < 0.001)
    x = x2
    y = y2

  i += 1
  if -0.01 <= x <= 0.01 and y > 0:
    print i, x, y
    break

print("problem #144. The beam hits {0} times. ({1})".format(i, i == 354))

job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
