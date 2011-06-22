-- problem #55
job_time = os.time()

NUM_MAX = 10^4

function is_palindrome(s)
  local i = #s / 2
  local a, b = s:sub(1, i), s:sub(-i):reverse()
  return a == b
end

function get_digit(s, pos)
  return tonumber(s:sub(-pos, -pos)) or 0
end

function sum(a, b)
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

function is_lychrel(number)
  local s = tostring(number)
  for n = 0, 50 do
    s = sum(s, s:reverse())
    if is_palindrome(s) then
      return false
    end
  end
  return true
end

count = 0
for i = 10, NUM_MAX do
  if is_lychrel(i) then
    count = count + 1
  end
end

print("problem #55", "Lychrel numbers count:", count, count == 249)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
