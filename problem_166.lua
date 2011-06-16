-- problem #166
job_time = os.time()
count = 0

function is_ok(...)
  for _, n in pairs {...} do
    if n < 0 or n > 9 then
      return false
    end
  end
  return true
end

for a11 = 0, 9 do
for a12 = 0, 9 do
for a13 = 0, 9 do
for a14 = 0, 9 do
for a22 = 0, 9 do
for a23 = 0, 9 do
for a33 = 0, 9 do
  local sum = a11 + a12 + a13 + a14

  local a43 = sum - a13 - a23 - a33
  local a44 = sum - a11 - a22 - a33

  local b1 = sum - a22 - a23
  local b2 = sum - a33
  local b3 = sum - a43 - a44
  local b4 = sum - a11
  local b5 = sum - a12 - a22
  local b6 = sum - a14 - a44
  local b7 = sum - a14 - a23

  local a41 = (b7 + b3 - b5) / 2
  local a32 = b7 - a41
  local a42 = b3 - a41

  for a34 = 0, 9 do
    local a31 = b2 - a32 - a34
    local a24 = b6 - a34
    local a21 = b1 - a24

    -- test
    local s1 = a11 + a12 + a13 + a14
    local s2 = a21 + a22 + a23 + a24
    local s3 = a31 + a32 + a33 + a34
    local s4 = a41 + a42 + a43 + a44

    local s5 = a11 + a21 + a31 + a41
    local s6 = a12 + a22 + a32 + a42
    local s7 = a13 + a23 + a33 + a43
    local s8 = a14 + a24 + a34 + a44

    local s9 = a11 + a22 + a33 + a44
    local s10 = a14 + a23 + a32 + a41

    if is_ok(a21, a24, a31, a32, a34, a41, a42, a43, a44) and
      s1 == s2 and
      s1 == s3 and
      s1 == s4 and
      s1 == s5 and
      s1 == s6 and
      s1 == s7 and
      s1 == s8 and
      s1 == s9 and
      s1 == s10 then
--~       print "======================"
--~       print(a11, a12, a13, a14)
--~       print(a21, a22, a23, a24)
--~       print(a31, a32, a33, a34)
--~       print(a41, a42, a43, a44)
      count = count + 1
    end
  end

end
end
end
end
end
end
end


print("problem #166", "total number:", count, count == 7130034)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
