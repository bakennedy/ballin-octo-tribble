arg = {...}
depth = arg[1] or 64

function set(list)
  temp = {}
  for i=1,#list do
    temp[list[i]] = true
  end
  return temp
end

blacklist = set({
  "minecraft:stone",
  "minecraft:dirt",
  "minecraft:gravel",
  "chisel:diorite",
  "chisel:andesite",
  "chisel:granite",
  "chisel:marble"
})


function isValid(is, what)
  return is and not blacklist[what.name]
end

function isMine()
  is, what = turtle.inspect()
  return isValid(is, what)
end

function isMineUp()
  return isValid(turtle.inspectUp())
end

function isMineDown()
  return isValid(turtle.inspectDown())
end

function checkLeft()
  nav.left()
  if isMine() then
    turtle.dig()
  end
  nav.right()
end

function goBack(dist)
  nav.left(2)
  for i=1, dist-1 do
    nav.forward()
  end
end

function eachSlot(func)
  for i = 1, 16 do
    turtle.select(i)
    func()
  end
  return true
end

function bringBack(dist)
  goBack(dist)
  eachSlot(turtle.drop)
  goBack(dist)
end

function isFull()
  for i=1,16 do
    if turtle.getItemCount(i) == 0 then
      return false
    end
  end
  return true
end

for i=1,depth do 
  nav.forward()
  if isMineUp() then
    turtle.digUp()
  end
  if isMineDown() then
    turtle.digDown()
  end
  checkLeft()
  if isFull() then
    bringBack(depth)
  end
end

nav.left(2)

for i=1,depth do
  nav.forward()
  checkLeft()
  if isFull() then
    nav.right(2)
    bringBack(depth)
    nav.right(2)
  end
end
eachSlot(turtle.drop)