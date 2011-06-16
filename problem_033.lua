-- problem #33
local job_time = os.time()

local function is_non_trivial_fraction(a, b, c, d)
--~   if d == 0 then
--~     return false
--~   end

  local ab, cd = a * 10 + b, c * 10 + d
  local ratio = ab / cd
  if ab >= cd then
    return false
  end

  if a == c then
    if math.abs( ratio - b / d ) < 0.000000001 then
      return true
    end
  end

  if b == c then
    if math.abs( ratio - a / d ) < 0.000000001 then
      return true
    end
  end

--~   if c == 0 then
--~     return false
--~   end

  if a == d then
    if math.abs( ratio - b / c ) < 0.000000001 then
      return true
    end
  end

  if b == d then
    if math.abs( ratio - a / c ) < 0.000000001 then
      return true
    end
  end
end

numerator, denominator = 1, 1

for a = 1, 9 do
  for b = 1, 9 do
    for c = 1, 9 do
      for d = 1, 9 do
        if is_non_trivial_fraction( a, b, c, d ) then
          --print( a, b, c, d )
          local ab, cd = a * 10 + b, c * 10 + d
          numerator = numerator * ab
          denominator = denominator * cd
        end
      end
    end
  end
end

local i = numerator
while i > 1 do
  local a, b = numerator / i, denominator / i
  if math.floor( a ) == a and math.floor( b ) == b then
    numerator, denominator = a, b
    i = numerator
  end
end

print("problem #33", "the product the denominator:", denominator, denominator == 100)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
