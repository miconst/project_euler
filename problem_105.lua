-- problem #105
job_time = os.time()


function string:split(delim, plain)
  delim = (not delim or delim == "") and "%s+" or delim
  local list = {}
  local s = self
  while s:len() > 0 do
    local a = { s:find(delim, 1, plain) }
    if a[1] then
      table.insert(list, s:sub(1, a[1] - 1))
      s = s:sub(a[2] + 1)
      for i = 3, #a do
        table.insert(list, a[i])
      end
    else
      table.insert(list, s)
      s = ""
    end
  end
  return list
end

--~ s1 = {81, 88, 75, 42, 87, 84, 86, 65}
--~ s2 = {157, 150, 164, 119, 79, 159, 161, 139, 158}

function test_set(s, mask_a)
  local sa = 0
  local ca = 0
  for i = 1, #s do
    if mask_a % (2 ^ i) >= (2 ^ (i - 1)) then
      ca = ca + 1
      sa = sa + s[i]
    end
  end
  for j = 1, 2^(#s - ca) - 1 do
    local mask_b = j
    local sb = 0
    local cb = 0
    for i = 1, #s do
      if mask_a % (2 ^ i) >= (2 ^ (i - 1)) then
        mask_b = mask_b * 2
      elseif mask_b % (2 ^ i) >= (2 ^ (i - 1)) then
        cb = cb + 1
        sb = sb + s[i]
      end
    end
    assert(ca > 0)
    assert(cb > 0)
    assert(ca + cb <= #s)
    if cb == ca then
      if sb == sa then
        return false, mask_a, j
      end
    else
      if (cb > ca) ~= (sb > sa) then
        return false, mask_a, j
      end
    end
  end
  return true
end

function is_special_set(s)
  for mask = 1, 2^#s - 2 do
    if not test_set(s, mask) then
--~       print(test_set(s, mask))
      return false
    end
  end
  return true
end

--~ print(is_special_set(s1))
--~ print(is_special_set(s2))
sum = 0
for l in assert(io.open "sets.txt"):lines() do
  local s = l:split "%p"
--~   print(unpack(s))
  local ok = is_special_set(s)
--~   print(ok)
  if ok then
    for _, n in pairs(s) do
      sum = sum + n
    end
  end
end

print("problem #105", "The value of the special sum sets:", sum, sum == 73702)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
