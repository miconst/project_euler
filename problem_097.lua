-- problem #97
local job_time = os.time()

local a = 28433 * 2
local b = math.pow(2, 8)
local c = 7830456 / 8

local prime = a
for i = 1, c do
  prime = (prime * b) % 10000000000
end

prime = prime + 1

print("problem #97", "the last ten digits:" , prime, prime == 8739992577)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
