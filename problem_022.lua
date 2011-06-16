-- problem #22
local job_time = os.time()

function string:split(delim, plain)
  delim = (not delim or delim == "") and "%s+" or delim
  local list = {}
  local s = self
  while s:len() > 0 do
    local a, b = s:find(delim, 1, plain)
    if a then
      table.insert(list, s:sub(1, a - 1))
      s = s:sub(b + 1)
    else
      table.insert(list, s)
      s = ""
    end
  end
  return list
end

names = assert(io.open(arg[1] or "names.txt")):read"*all":split","

--print(names[1], names[#names])

-- begin by sorting it into alphabetical order
table.sort(names)

-- Then working out the alphabetical value for each name,
-- multiply this value by its alphabetical position in the list to obtain a name score.
a = string.byte("a", 1)
scores = 0
for i, name in ipairs(names) do
  name = name:lower()
  local score = 0
  for _, b in pairs { name:byte(2, #name - 1) } do
    score = score + b - a + 1
  end
  scores = scores + score * i
end

--print(names[1], names[#names], #names)

print("problem #22", "the total scores:", scores, scores == 871198282)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
