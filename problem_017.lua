-- problem #17
local job_time = os.time()

-- If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
numbers = { "one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten",
  "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen", "twenty",
  [30] = "thirty",
  [40] = "forty",
  [50] = "fifty",
  [60] = "sixty",
  [70] = "seventy",
  [80] = "eighty",
  [90] = "ninety",
  [1000] = "one thousand",
}

-- If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
word = ""
for i = 1, 1000 do
  local w = numbers[i]
  if not w then
    w = ""
    if i >= 100 then
      local a = math.floor(i / 100)
      w = w .. numbers[a] .. " hundred"
      i = i - a * 100
      if i > 0 then
        w = w .. " and "  -- The use of "and" when writing out numbers is in compliance with British usage.
      end
    end
    if i > 20 then
      local a = math.floor(i / 10) * 10
      w = w .. numbers[a]
      i = i - a
      if i > 0 then
        w = w .. "-"
      end
    end
    if i > 0 then
      w = w .. numbers[i]
    end
  end
  word = word .. w .. ";\n"
end

print(word)

-- NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters.
word = word:gsub("[%s%-%;]", "")


print("problem #17", "total leters:" , #word, #word == 21124)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
