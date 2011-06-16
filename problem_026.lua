-- problem #26
local job_time = os.time()

function get_recurring_cycles(n)
  local a = 1
  local reminders = {}
  local i = 0
  while true do
    while a < n do
      a = a * 10
      i = i + 1
    end

    local b = a % n
    if b == 0 then break end

    if reminders[b] then
      return i - reminders[b]
    else
      reminders[b] = i
    end

    a = b
  end
  return 0
end

--print(get_recurring_cycles(983))
--do return end

cycle_max = 0

for i = 1, 1000 do
  local c = get_recurring_cycles(i)
  if c > cycle_max then
    number = i
    cycle_max = c
    print("!", i, c)
  end
end

print("problem #26", "the value of digit with the longest recurring cycle:" , number, number == 983)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
