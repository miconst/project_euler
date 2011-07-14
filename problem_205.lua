-- problem #205
job_time = os.time()

function roll_dice(dice_size, dice_num, result, pos, totals)
  if pos > dice_num then
    -- count totals
    local n = 0
    for i = 1, dice_num do
      n = n + result[i]
    end
    totals[n] = (totals[n] or 0) + 1
  else
    for i = 1, dice_size do
      result[pos] = i
      roll_dice(dice_size, dice_num, result, pos + 1, totals)
    end
  end
end

-- Peter has 9 four-sided (pyramidal) dice
Pete_dice_size = 4
Pete_dice_num = 9
Pete_totals = {}
Pete_total_num = Pete_dice_size^Pete_dice_num

roll_dice(Pete_dice_size, Pete_dice_num, {}, 1, Pete_totals)

-- Colin has six six-sided (cubic) dice
Colin_dice_size = 6
Colin_dice_num = 6
Colin_totals = {}
Colin_total_num = Colin_dice_size^Colin_dice_num

roll_dice(Colin_dice_size, Colin_dice_num, {}, 1, Colin_totals)

total_num = Pete_total_num * Colin_total_num
Pete_win = 0
Colin_win = 0

for np, pp in pairs(Pete_totals) do
--~   local num_p = pp * Colin_total_num -- p * total_num / Pete_total_num
  for nc, pc in pairs(Colin_totals) do
    local num_c = pc * pp -- pc * num_p / Colin_total_num
    if np > nc then
      Pete_win = Pete_win + num_c
    elseif np < nc then
      Colin_win = Colin_win + num_c
    end
  end
end

--~ print(Pete_win, Colin_win, total_num)
probability = "0."..tostring(math.floor(Pete_win / total_num * 10^7 + 0.5))

print("problem #205", "the probability that Pyramidal Pete beats Cubic Colin:", probability, probability == "0.5731441")

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
