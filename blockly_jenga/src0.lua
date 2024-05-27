i = 1
j = 1
k = 1
m = 2
partHeight = 11.3
rGrab = -25
rDropRef = rGrab
rDrop = rGrab
stack1X = 285.5
stack1Y = -125.1
stackDistX = 40
stackDistY = 130
stackQtyX = 2
stackQtyY = 2
stackQtyZ = 7
xGrab = stack1X
xDropRef = 150
xDrop = xDropRef
yDropRef = -250
yDrop = yDropRef
yGrab = stack1Y
zDrop = -50
zDropMin = -155.8
zGrabMin = -156.2
zGrab = zDropMin+((stackQtyZ*partHeight)-partHeight)
zDrop = zDropMin
DO(2,0)
MovJ((InitialPose))
Sync()
while not (i>stackQtyZ) do
  Jump(({coordinate = {xGrab,yGrab,zGrab,rGrab}, tool = 0, user = 0}), {Start=NaN, ZLimit=NaN, End=NaN})
  DO(2,1)
  Wait( math.ceil(0.3 * 1000) )
  Sync()
  print(xDrop)
  Sync()
  print(yDrop)
  Jump(({coordinate = {xDrop,yDrop,zDrop,rDrop}, tool = 0, user = 0}), {Start=NaN, ZLimit=NaN, End=NaN})
  DO(2,0)
  Wait( math.ceil(0.2 * 1000) )
  DO(1,1)
  Wait( math.ceil(0.3 * 1000) )
  DO(1,0)
  Sync()
  if k<stackQtyX then
    k = k + 1
    xGrab = xGrab+stackDistX
  else
    xGrab = stack1X
    k = 1
    Sync()
    if j<stackQtyY then
      j = j + 1
      yGrab = yGrab+stackDistY
    else
      j = 1
      yGrab = stack1Y
      zGrab = zGrab-partHeight
      i = i + 1
    end
  end
  Sync()
  if m==1 then
    zDrop = zDrop+partHeight
    m = m + 1
    rDrop = rDropRef
    xDrop = xDropRef
    yDrop = yDropRef
  else
    Sync()
    if m==2 then
      m = m + 1
      xDrop = xDropRef+45
    else
      Sync()
      if m==3 then
        m = m + 1
        zDrop = zDrop+partHeight
        rDrop = rDrop+90
        xDrop = xDropRef+26
        yDrop = yDropRef+26
      else
        Sync()
        if m==4 then
          m = 1
          yDrop = yDropRef-26
        else
          print('Hello world!')
        end
      end
    end
  end
  Sleep(50)
end
Jump((InitialPose), {Start=NaN, ZLimit=NaN, End=NaN})
