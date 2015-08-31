-- each screen has its own set of tags
tags = {}
for s = 1, screen.count() do
  tags[s] = awful.tag(
    { 1, 2, 3, 4, 5, 6, 7 },
    s,
    { layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1], layouts[1]}
  )
end
