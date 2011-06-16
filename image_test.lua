require "ex"

function os.extension(path)
  if path then
    local _, _, ext = path:find "[%.]([^%.\\/]+)$"
    return ext or ""
  end
end

function os.is_dir(dname)
  if type(dname) == "string" then
    local entry = os.dirent(dname)
    if entry ~= nil and entry.type == "directory" then
      return true
    else
      return nil, dname .. " - not a directory!"
    end
  else
    return nil, "invalid input type"
  end
end

function os.for_each(pathname, what, entry_type, look_inside)
  local ok, err = os.is_dir(pathname)
  if ok then
    for entry in os.dir(pathname) do
      if not entry_type or entry_type == entry.type then
        what(pathname, entry.name)
      end

      if look_inside and entry.type == "directory" then
        ok, err = os.for_each(os.path(pathname, entry.name), what, entry_type, look_inside)
      end
    end
  end
  return ok, err
end

function os.for_each_file(pathname, what, look_inside)
  return os.for_each(pathname, what, "file", look_inside)
end


require "imlua"
require "imlua_process"



local dirname_src = "C:/Temp/out.grey"
local dirname_dst = "C:/Temp/out.grey.new"

local function make_image(dirname_src, filename_src)
  if os.extension(filename_src):lower() ~= "png" then
    return
  end

  print("Processing image:", filename_src)
  local image_src = assert(im.FileImageLoad(dirname_src .. "/" .. filename_src))
  local image_dst = assert(im.ImageCreate(image_src:Width(), image_src:Height(), im.GRAY, im.BYTE))

  local function render(x, y, d, param)
    local color = image_src[0][y][x]
    assert(color >= 0x00)
    assert(color <= 0xFF)
    if color < 0x40 then
      return 0
    elseif color < 0x80 then
      return math.floor(color / 2)
    elseif color > 0xF0 then
      return 0xFF
    else
      return color
    end
  end

  im.ProcessRenderOp(image_dst, render, "histogram", {}, 0)
  image_dst:Save(dirname_dst .. "/" .. filename_src, "PNG")
end

if not os.is_dir(dirname_dst) then
  assert(ex.mkdir(dirname_dst))
end
assert(os.is_dir(dirname_dst))

os.for_each_file(dirname_src, make_image)
