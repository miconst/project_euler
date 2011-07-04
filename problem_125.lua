-- problem #125
job_time = os.time()

N_MAX = 10^8
palindromes = {}
count = 0

function is_palindrome(number)
  local digits = math.floor(math.log10(number)) + 1
  local mid = math.floor(digits / 2)
  local a = number % 10^mid
  local b = math.floor(number / (10^(digits - mid)))
  return a == tonumber(tostring(b):reverse())
end

sum = 0
for a = 1, math.sqrt(N_MAX) do
  local b = a + 1
  local number = a*a + b*b
  while number < N_MAX do
    if is_palindrome(number) then
--~       local s = "=" .. tostring(a) .."^2"
--~       for i = a + 1, b do
--~         s = s .. "+" .. tostring(i) .."^2"
--~       end
--~       print(number, s)
      if not palindromes[number] then
        palindromes[number] = true
        count = count + 1
        sum = sum + number
      end
    end
    b = b + 1
    number = number + b * b
  end
end

print("problem #125", "the sum of all the numbers that are both palindromic and can be written as the sum of consecutive squares:", sum, sum == 2906969179)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
