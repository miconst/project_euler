-- problem #29
nums = {}

for a = 2, 100 do
  for b = 2, 100 do
    nums[math.pow(a,b)] = true
  end
end

terms = 0
for k, v in pairs(nums) do
  terms = terms + 1
end

print("problem #29", "first four consecutive integer:", terms, terms == 9183)
