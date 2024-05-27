local Pallet1 = MatrixPallet(0,1, "IsUnstack=true, User=0") --Define the dismantling instance
local Pallet2 = MatrixPallet(1,2, "IsUnstack=false, User=0") --Define the palletizing instance
Reset(Pallet1) --Initialize the dismantling instance

Reset(Pallet2) --Initialize the palletizing instance while true do

while true do

PalletMoveIn(Pallet1) --Start the dismantling instance

Wait(1000)

DO(2,ON)

Wait(400)

PalletMoveOut(Pallet1) --Leave the dismantling instance

PalletMoveIn(Pallet2) --Start the palletizing instance

Wait(400)

DO(1,ON)

Wait(400)

DO(2,OFF)

DO(1,OFF)

PalletMoveOut(Pallet2) --Leave the palletizing instance

result=IsDone(Pallet2) --Check whether the palletizing instance is complete

if (result == true) --Determine whether the palletizing is completed
then 
print("exit")
break
end
end
Release(Pallet1)
Release(Pallet2)
DO(1,OFF)
