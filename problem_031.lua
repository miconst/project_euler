-- problem # 31

job_time = os.time()

coins = { 200, 100, 50, 20, 10, 5, 2, 1 }
count = 0

function collect_coins(sum, i_min)
  if sum == 200 then
    --print("gotcha!", ...)
    count = count + 1
  elseif sum < 200 then
    for i = i_min, #coins do
      collect_coins(sum + coins[i], i)
    end
  end
end

collect_coins(0, 1)

print("problem #31", "number of different ways:", count, count == 73682)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
