-- problem #206
job_time = os.time()

------------------------------------------------------------------------------
-- load bc library
assert(package.loadlib("bc.dll","luaopen_bc"))()
bc.digits(22)
------------------------------------------------------------------------------

mask = "^1%d2%d3%d4%d5%d6%d7%d8%d9"

number = 101010103

while true do
  -- check 3-s and 7-s only
  local square = tostring(bc.pow(number, 2))
  if square:find(mask) then
    break
  end
  number = number + 4
  local square = tostring(bc.pow(number, 2))
  if square:find(mask) then
    break
  end
  number = number + 6
end
number = number * 10

print("problem #206", "the unique number:", number, number == 1389019170)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
