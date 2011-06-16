-- problem #91

local job_time = os.time()

local na, nb, nc = {}, {}, {}
for a, b, c in assert(io.open"cipher1.txt"):read"*all":gmatch"(%d+),(%d+),(%d+)" do
  print(a, b, c)
  table.insert(na, tonumber(a))
  table.insert(nb, tonumber(b))
  table.insert(nc, tonumber(c))
end

local function is_valid_key(key, message)
  local t = {}

end



print("problem #59", "right triangles:", triangle_count, triangle_count == 14234)

job_time = os.time() - job_time
print(string.format("Job has taken %d min %d sec.", math.floor(job_time / 60), job_time % 60))
