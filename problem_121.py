import time, math

job_time = time.clock()

TURNS = 15

chances = 1
for x in range( TURNS ):
  chances *= x + 2

wins = 0

for a in xrange( 2 ** TURNS ):
  if bin(a).count('1') > TURNS // 2:
    w = 1
    for i in range( TURNS ):
      if ( a & (1 << i) ) == 0:
        w *= i + 1
    wins += w
    
#print( wins, chances )

print("problem #121. " +
      "The maximum prize for {0} turns game: {1}".format( TURNS, chances // wins ) )
job_time = int(time.clock() - job_time)
print("Job has taken {0} min {1} sec.".format(job_time // 60, job_time % 60))
