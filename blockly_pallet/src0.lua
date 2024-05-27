count_2 = 3
  local points_pallet1 = {}
  PalletCreate({P1,P2},{3},points_pallet1)
  local points_pallet2 = {}
  PalletCreate({P9,P8},{3},points_pallet2)
Sync()
for count = 1, math.floor(#points_pallet1) do
  Sync()
  print(count_2)
  MovJ((P10))
  MovJ(points_pallet2[count_2])
  DO(2,1)
  MovJ((P10))
  MovJ((P7))
  MovJ(points_pallet1[count_2])
  DO(2,0)
  MovJ((P7))
  count_2 = count_2 + -1
  Sleep(50)
end
MovJ((InitialPose))
