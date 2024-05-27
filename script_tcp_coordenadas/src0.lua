local ip = "192.168.1.6"
local port = 6601
local err = 0
local socket = 0

while true do
  ::create_server::
  err, socket = TCPCreate(true, ip, port)
  if err ~= 0 then
    print("failed to connect")
    Sleep(1000)
    goto create_server
  end
  
  print("socket handle" .. socket)
  err = TCPStart(socket, 0)
  if err ~= 0 then
    print("failed to start" .. err)
    TCPDestroy(socket)
    Sleep(1000)
    goto create_server
  end
  print('err: ' .. err)
  TCPWrite(socket, "Se ha establecido la conexion correctamente")
  
  while true do 
    err, buf = TCPRead(socket, 0, "string")
    if err == 0 then
      data = buf.buf
      local values = {}

      for value in string.gmatch(data, '([^,]+)') do
          table.insert(values, tonumber(value))
      end
      
      local x = values[1]
      local y = values[2]
      local z = values[3]
      local theta = values[4]
      
      P = {coordinate={x,y,z,theta}}
      print(P)
      MovJ(P)
      
      if data == 'close' then
        print(data)
        TCPWrite(socket, "Se ha cerrado la conexion correctamente")
        TCPDestroy(socket)
        break
      end
    end
  end
end 