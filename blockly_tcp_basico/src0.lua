resultCreate1,socket1 = TCPCreate(true, '192.168.1.6', 6601)
  if resultCreate1 == 0 then
      print("Create TCP Server Success!")
  else
      print("Create TCP Server failed, code:", resultCreate1)
  end
  resultCreate1 = TCPStart(socket1, 0)
  if resultCreate1 == 0 then
      print("Listen TCP Client Success!")
  else
      print("Listen TCP Client failed, code:", resultCreate1)
  end
  tcp1 = "go"
Sync()
while not ((resultCreate1)<0) do
  Sync()
  if (resultCreate1)==0 then
    resultRead1,tcp1 = TCPRead(socket1, 0, 'string')
    tcp1 = tcp1.buf
    Sync()
    print(tcp1)
    Sync()
    if string.find(tcp1,'go') ~= nil then
      resultWrite1 = TCPWrite(socket1, 'go to P1, P2')
      MovJ((P1))
      Sleep( math.ceil(1 * 1000) )
      MovJ((P2))
    end
    Sync()
    if string.find(tcp1,'close') ~= nil then
      resultWrite1 = TCPWrite(socket1, 'Close socket')
      TCPDestroy(socket1)
      break
    end
  end
  Sleep(50)
end
