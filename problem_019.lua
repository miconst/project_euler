-- problem #19
-- How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

months = {
 31,  -- Jan
 28,  -- Feb
 31,  -- Mar
 30,  -- Apr
 31,  -- May
 30,  -- Jun
 31,  -- Jul
 31,  -- Aug
 30,  -- Sep
 31,  -- Oct
 30,  -- Nov
 31,  -- Des
}

-- A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.
function is_leap_year(year)
  if year % 400 == 0 then
    return true
  elseif year % 100 == 0 then
    return false
  elseif year % 4 == 0 then
    return true
  else
    return false
  end
end

function get_day_of_the_week(year, month, day)
  local days = day - 1
  for y = 1900, year - 1 do
    days = days + 365
    if is_leap_year(y) then
      days = days + 1
    end
  end
  for m = 1, month - 1 do
    days = days + months[m]
    if m == 2 and is_leap_year(year) then
      days = days + 1
    end
  end
  return days % 7 + 1
end

assert(get_day_of_the_week(2010, 4, 12) == 1)

sundays = 0
for year = 1901, 2000 do
  for month = 1, 12 do
    if get_day_of_the_week(year, month, 1) == 7 then
      sundays = sundays + 1
    end
  end
end

print("problem #19", "Sundays:", sundays, sundays == 171)
