-- problem #243
job_time = os.time()

function euler_phi(m)
  local i, phi = 2, m
  while m ~= 1 do
    if m%i == 0 then
      phi = phi - phi / i
      while m%i == 0 do
        m = m / i
      end
    end
    i = i + 1
  end
  return phi
end

A = 15499
B = 94744

primes = { 2, 3, 5, 7, 11, 13, 17, 19, 23 }
powers = { 3, 1, 1, 1,  1,  1,  1,  1,  1 }
number = 1
for i = 1, #primes do
  number = number * primes[i]^powers[i]
end

print(number)
print(euler_phi(number)/(number - 1) - A/B)

print("problem #243", "The smallest denominator, having a resilience coef less than 15499/94744", number, number == 892371480)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
