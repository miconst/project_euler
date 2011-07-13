-- problem #86
job_time = os.time()

M = 0
count = 0

-- test pythagorean triples:
while count < 10^6 do
  local couples = {}
  M = M + 1

  local Lmin = math.sqrt(M^2 + 4)
  local Lmax = math.sqrt(5) * M

  for k1 = 1, M do
    for k2 = 1, k1 - 1 do
      local a = k1^2 - k2^2
      local b = 2 * k1 * k2
      local c = k1^2 + k2^2

      if c > Lmax then
        break
      end

      if M % a == 0 then
        local x = M * b / a
        if not couples[x] then
          couples[x] = true
          local z_max = math.floor(x / 2)
          if x <= M then
            count = count + z_max
          else
            local z_min = x - M
            if z_max >= z_min then
              count = count + z_max - z_min + 1
            end
          end
        end
      end

      if M % b == 0 then
        local x = M * a / b
        if not couples[x] then
          couples[x] = true
          local z_max = math.floor(x / 2)
          if x <= M then
            count = count + z_max
          else
            local z_min = x - M
            if z_max >= z_min then
              count = count + z_max - z_min + 1
            end
          end
        end
      end
    end
  end
--~   io.write("\r                    \r", M, ",", count)
end

print("problem #86", "the least value of M:", M, M == 1818)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
