-- problem #80
local job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(200)
------------------------------------------------------------------------------


function babylonian_sqrt(number)
  -- Start with an arbitrary positive start value x0 (the closer to the root, the better).
  local x = bc.number(math.sqrt(number))
  number = bc.number(number)
  local two = bc.number(2)

  -- Repeat until the desired accuracy is achieved.
  for i = 1, 100 do
    -- xn+1 is the average of xn and S / xn.
    x = (x + number / x) / two
  end

  return x
end

function get_digit(s, pos)
  return tonumber(s:sub(pos, pos))  -- or 0
end

-- For the first one hundred natural numbers, find the total of the digital sums of
-- the first one hundred decimal digits for all the irrational square roots.
sum = 0
for i = 1, 100 do
  if math.sqrt(i) ~= math.floor(math.sqrt(i)) then
    local a = babylonian_sqrt(i)
    local sa = tostring(a):gsub("%.", "")
    for j = 1, 100 do
      sum = sum + get_digit(sa, j)
    end
    --print(i, sa)
  end
end


print("problem #80", "total of the digital sums:", sum, sum == 40886)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
