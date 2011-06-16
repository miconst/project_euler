http = require "socket.http"
url = require "socket.url"

build_form = {
  region = "msk",
  action = "official",
  generation = "A",
  game = "TEMPLATE",
  platform = "Native",
  path ="",
  module = "svn:template_native",
  targets = "apoj",
  carrier = "device placeholder",
  log = "release notes placeholder",
  submitter_host = "mskkmikhailovxpd.glu.com",
  submitter = "build",
  destplat = "iphone_experimental",
  type = "Lead",
  branch = "branch_here",
}

s = ""
for k, v in pairs(build_form) do
  if #s > 0 then
    s = s .. "&"
  end
  s = s .. k .. "=" .. url.escape(v)
end

print(s)

do return end

function print_table(t)
  for k, v in pairs(t) do
    if type(v) == "table" then
      print_table(v)
    else
      print(k, v)
    end
  end
end

x = {}

t = {
  http.request("http://bm.glu.com/build/servlet/Authenticator",
    "username=build&pwd=b0bthebuilder")
}

print_table(t)

cookie = t[3]["set-cookie"]

_, _, JSESSIONID = cookie:find "JSESSIONID=([^;]+);"
_, _, buildmachine_user = cookie:find "buildmachine_user=([^;]+);"

print(cookie)
print(JSESSIONID, buildmachine_user)

--~ t1 = {
--~   http.request
--~     {
--~       url = "http://bm.glu.com/build/main.jsp",
--~       method = "POST",
--~       sink = ltn12.sink.table(x),
--~       headers = {
--~         cookie = string.format("JSESSIONID=%s; buildmachine_user=%s;", JSESSIONID, buildmachine_user)
--~       },
--~     }
--~ }

--"COMPUTERNAME"
--"USERDNSDOMAIN"

b = "region=msk&action=official&generation=A&game=TEMPLATE&platform=Native&path="
..
  "&module=svn:template_native&targets=apoj&carrier=device%20here&log=release%20notes%20here"
..
  "&submitter_host=mskkmikhailovxpd.glu.com&submitter=build"
..
  "&destplat=iphone_experimental&type=Lead&branch=brach_here"

t1 = {
  http.request
    {
      url = "http://bm.glu.com/build/servlet/RequestProcessor",
      method = "POST",
      sink = ltn12.sink.table(x),
      source = ltn12.source.string(b),
      headers = {
        cookie = string.format("JSESSIONID=%s; buildmachine_user=%s;", JSESSIONID, buildmachine_user),
        ["content-length"] = string.len(b),
        ["content-type"] = "application/x-www-form-urlencoded",
      },
    }
}


print "!"
print_table(t1)

print "*"
print_table(x)

--http://bm.glu.com/build/servlet/RequestProcessor
