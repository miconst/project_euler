-- problem #76
job_time = os.time()

-- Partition
-- http://en.wikipedia.org/wiki/Partition_(number_theory)

partisions = {}
function p(k, n)
  local x = tostring(k) .. "X" .. tostring(n)
  if not partisions[x] then
    if k > n then
      partisions[x] = 0
    elseif k == n then
      partisions[x] = 1
    else
      partisions[x] = p(k + 1, n) + p(k, n - k)
    end
  end
  return partisions[x]
end

function P(n)
  return p(1, n)
end

--~ sum_hash = {}

--~ local function get_all_sums(number)
--~   local sums = sum_hash[number]
--~   if sums then
--~     return sums
--~   else
--~     sums = {}
--~     sum_hash[number] = sums
--~   end

--~   local function add(t)
--~     table.sort(t)
--~     local k = table.concat(t, "+")
--~     if not sums[k] then
--~       sums[k] = t
--~     end
--~   end
--~   if number == 1 then
--~     add { number }
--~   else
--~     for i = 1, number - 1 do
--~       add { i, number - i }
--~       for _, v in pairs(get_all_sums(number - i)) do
--~         add { i, unpack(v) }
--~       end
--~     end
--~   end
--~   return sums
--~ end

count = P(100) - 1

print("problem #76", "ways 100 can be written as a sum of at least two positive integers:", count, count == 190569291)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
