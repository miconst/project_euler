-- problem #16
local job_time = os.time()

local sum = 0
local s_test = "10715086071862673209484250490600018105614048117055336074437503883703510511249361224931983788156958581275946729175531468251871452856923140435984577574698574803934567774824230985421074605062371141877954182153046474983581941267398767559165543946077062914571196477686542167660429831652624386837205668069376"

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function sum_it(a, b)
  local h, s, i_max = 0, "", math.max(#a, #b)
  for i = 1, i_max do
    local x = get_digit(a, i) + get_digit(b, i) + h
    s = tostring(x % 10) .. s
    h = math.floor(x / 10)
  end
  if h > 0 then
    s = tostring(h) .. s
  end
  return s
end

local s = "2"

for i = 2, 1000 do
  s = sum_it(s, s)
end

assert(s == s_test)

for i = 1, #s do
  sum = sum + tonumber(s:sub(i,i))
end

print("problem #16", "line number:" , sum, sum == 1366)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
