-- problem #89
local job_time = os.time()

Roman_numerals = {
  I = 1,
  V = 5,
  X = 10,
  L = 50,
  C = 100,
  D = 500,
  M = 1000,
}

Roman_numbers = {
  { 1000,   "M" },
  {  900,  "CM" },
--  {  800, "CCM" },
  {  500,   "D" },
  {  400,  "CD" },
  {  100,   "C" },
  {   90,  "XC" },
--  {   80, "XXC" },
  {   50,   "L" },
  {   40,  "IC" },
  {   10,   "X" },
  {    9,  "IX" },
--  {    8, "IIX" },
  {    5,   "V" },
  {    4,  "IV" },
  {    1,   "I" },
}


characters = 0

function to_roman(number)
  local r = ""
  for _, t in ipairs(Roman_numbers) do
    while number >= t[1] do
      r = r .. t[2]
      number = number - t[1]
    end
  end
  assert(number == 0, tostring(number))
  return r
end

for s in assert(io.open(arg[1] or "E:/roman.txt")):lines() do
  local t = {}
  for d in s:gmatch "[IVXLCDM]" do
    d = Roman_numerals[d]
    if #t > 0 and d > t[#t] then
      t[#t] = d - t[#t]
    else
      table.insert(t, d)
    end
  end

  local n = 0
  for _, x in ipairs(t) do
    n = n + x
  end

  local sn = to_roman(n)
  assert(#s >= #sn)
  if #sn < #s then
    print("!", s, "-->", sn, n)
    characters = characters + (#s - #sn)
  end
end

print("problem #89", "total leters:" , characters, characters == 743)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
