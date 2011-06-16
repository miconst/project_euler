-- problem #98
job_time = os.time()

words = {}

-- init
for s in assert(io.open("words.txt")):read("*all"):gmatch('"([^"]+)"') do
  local l = #s
  if l > 1 then
    words[l] = words[l] or {}
    table.insert(words[l], s)
  end
end

function get_chars(s)
  local t = {}
  for i = 1, #s do
    local c = s:sub(i, i)
    t[c] = 1 + (t[c] or 0)
  end
  return t
end

function is_anagram(a, b)
  assert(a ~= b)
  assert(#a == #b)

  a, b = get_chars(a), get_chars(b)
  for k, v in pairs(a) do
    if v ~= b[k] then
      return false
    end
  end
  return true
end

anagrams = {}
for _, t in pairs(words) do
  for i = 1, #t do
    for j = i + 1, #t do
      if is_anagram(t[i], t[j]) then
        anagrams[t[i] .. "|" .. t[j]] = true
        print(t[i], "|", t[j])
      end
    end
  end
end

mask = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }
permutations = {}

function add_permutation(p)
  if #p == #mask then
    assert(not permutations[p])
    permutations[p] = true
  else
    for _, s in pairs(mask) do
      if not p:find(s) then
        add_permutation(p .. s)
      end
    end
  end
end

add_permutation ""

function fill_table(t, s)
  local i = 1
  for k in pairs(t) do
    t[k] = s:sub(i, i)
    i = i + 1
  end
end

function is_square(number)
  number = math.sqrt(number)
  return math.floor(number) == number
end

largest_square = 0

for s in pairs(anagrams) do
  local l = (#s - 1) / 2
  local a, b = s:sub(1, l), s:sub(l + 2)
  local c = get_chars(a)
  for p in pairs(permutations) do
    fill_table(c, p)
    local na, nb = a, b
    for k, v in pairs(c) do
      na = na:gsub(k, v)
      nb = nb:gsub(k, v)
    end
    na, nb = tonumber(na), tonumber(nb)
    if (na > largest_square or nb > largest_square) and (is_square(na) and is_square(nb)) then
      if na > largest_square then
        print("Found square number:", na, a)
        largest_square = na
      end
      if nb > largest_square then
        print("Found square number:", nb, b)
        largest_square = nb
      end
    end
  end
end


print("problem #98", "the largest square number:" , largest_square, largest_square == 18769)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
