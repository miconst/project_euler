local function fine_print(message, board)
  board = board or "-"
  message = "| " .. tostring(message) .. " |"
  board = board:rep(#message - 2):sub(1, #message)
  print("o" .. board .. "o")
  print(message)
  print("o" .. board .. "o")
end

--fine_print "My test message!"

function string:ends(with)
  local len = with:len()
  return len == 0 or self:sub(-len) == with
end

print(os.date("%x"))

test = "abc/c ba\\ttt /lua "

print(test:find("(.+)[/\\][^/^\\]+[/\\][^/^\\]+$"))

test = "resgen=1.5.13"
print(test:find("([^=]+)=(.+)"))

function string:split(delim, plain)
  delim = (not delim or delim == "") and "%s+" or delim
  local list = {}
  local s = self
  while s:len() > 0 do
    local a = { s:find(delim, 1, plain) }
    if a[1] then
      table.insert(list, s:sub(1, a[1] - 1))
      s = s:sub(a[2] + 1)
      for i = 3, #a do
        table.insert(list, a[i])
      end
    else
      table.insert(list, s)
      s = ""
    end
  end
  return list
end

s = "x:path1 y:path2"
print(unpack(s:split"(([a-zA-Z]):)"))
