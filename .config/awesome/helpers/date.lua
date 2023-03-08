local dateutils = {}

local days_map = {
  ["Mon"] = "Lun",
  ["Tue"] = "Mar",
  ["Wed"] = "Mer",
  ["Thu"] = "Jeu",
  ["Fri"] = "Ven",
  ["Sat"] = "Sam",
  ["Sun"] = "Dim"
}
function dateutils.french_day(day)
  return days_map[day]
end

local months_map = {
  ["Jan"] = "janv.",
  ["Feb"] = "févr.",
  ["Mar"] = "mars",
  ["Apr"] = "avril",
  ["May"] = "mai",
  ["Jun"] = "juin",
  ["Jul"] = "juil.",
  ["Aug"] = "août",
  ["Sep"] = "sept.",
  ["Oct"] = "oct.",
  ["Nov"] = "nov.",
  ["Dec"] = "déc."
}
function dateutils.french_month(month)
  return months_map[month]
end

function dateutils.no_leading_zero_day_num(num)
  if num:sub(1, 1) == "0" then
    return num:sub(2, 2)
  end
  return num
end

return dateutils
