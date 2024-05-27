count = 0
count_2 = 0 
--  Pallet

--直线位置线性插值
function lineInter(position1,position2,n,result)
	dx = (position2[1] - position1[1])/(n-1)
	dy = (position2[2] - position1[2])/(n-1)
	dz = (position2[3] - position1[3])/(n-1)
	for i = 1,n do
	    result[i] = {}
	    result[i][1] = position1[1] + dx*(i-1)  
	    result[i][2] = position1[2] + dy*(i-1)    
	    result[i][3] = position1[3] + dz*(i-1)  
	end
end

--四轴姿态线性插值
function rotInter(p,q,n,result)
   dleta_rz = (q - p)/(n-1);
   --result = {}
   for i = 1,n do
      result[i] = p + dleta_rz*(i-1)
   end
   
end
--生成直线路径点
function buildLine(startPoint,endPoint,counts,pointArray)
	 p1 = {}
	 p1[1] = startPoint["coordinate"][1]
	 p1[2] = startPoint["coordinate"][2]
	 p1[3] = startPoint["coordinate"][3]
	 r1 = startPoint["coordinate"][4]
	 p2 = {}
	 p2[1] = endPoint["coordinate"][1]
	 p2[2] = endPoint["coordinate"][2]
	 p2[3] = endPoint["coordinate"][3]
	 r2 = endPoint["coordinate"][4]
	 --位置线性插补
	 posArray = {}   --位置插值序列
	 rotArray = {}   --姿态插值序列
	 lineInter(p1,p2,counts[1],posArray)
	 rotInter(r1,r2,counts[1],rotArray)
	 --形成标准点位
	 for i=1,#posArray do
	     pointArray[i] = {armOrientation="left",coordinate={},joint={},user=0,tool=0}
	     pointArray[i]["armOrientation"] = startPoint["armOrientation"]
	     pointArray[i]["user"] = startPoint["user"]
	     pointArray[i]["tool"] = startPoint["tool"]
	     pointArray[i]["joint"][1] = startPoint["joint"][1]
	     pointArray[i]["joint"][2] = startPoint["joint"][2]
	     pointArray[i]["joint"][3] = startPoint["joint"][3]
	     pointArray[i]["joint"][4] = startPoint["joint"][4]
	     pointArray[i]["coordinate"][1] = posArray[i][1]
	     pointArray[i]["coordinate"][2] = posArray[i][2]
	     pointArray[i]["coordinate"][3] = posArray[i][3]
	     pointArray[i]["coordinate"][4] = rotArray[i]
	 end
end

--生成平面路径点
function buildPlane(teachArray,counts,pointArray)
	 --生成两个纵列点位L14 L23
	 count1={}
	 count2={}
	 count1[1]=counts[1]  --横长
	 count2[1]=counts[2]  --竖长
	 L14 = {}
	 buildLine(teachArray[1],teachArray[4],count2,L14)
	 L23 = {}
	 buildLine(teachArray[2],teachArray[3],count2,L23)
	 L = {}
	 for i=1,counts[2] do	     
	     buildLine(L14[i],L23[i],count1,L)
	     for j=1,counts[1] do
	     	 pointArray[(i-1)*counts[1]+j] = L[j]
	     end
	 end
end

--count[1]表示横长度
--count[2]表示竖长度
--count[3]表示高长度
--生成立体路径点
function buildVolume(teachArray,counts,VolumeArray)
	 --生成高度点位
	 count_height={}
	 count_height[1]=counts[3]
	 L15 = {}
	 buildLine(teachArray[1],teachArray[5],count_height,L15)
	 L26 = {}
	 buildLine(teachArray[2],teachArray[6],count_height,L26)
	 L37 = {}
	 buildLine(teachArray[3],teachArray[7],count_height,L37)
	 L48 = {}
	 buildLine(teachArray[4],teachArray[8],count_height,L48)
	 counts_plane ={counts[1],counts[2]}
	 planeArray={}
	 for i = 1, counts[3] do
	     plane={L15[i],L26[i],L37[i],L48[i]}
	     buildPlane(plane,counts_plane,planeArray)
	     for j=1,counts[1]*counts[2] do
	     	 VolumeArray[(i-1)*counts[1]*counts[2]+j] = planeArray[j]
	     end
	 
	 end
end

function PalletCreate(teachPoints, counts, resultArray)
	 --一维托盘
	 if (#counts == 1) then
	    buildLine(teachPoints[1],teachPoints[2],counts,resultArray)
	 --二维托盘
	 elseif(#counts == 2) then
	       buildPlane(teachPoints,counts,resultArray)
	 --三维托盘
	 elseif(#counts == 3) then
	       buildVolume(teachPoints,counts,resultArray)
	 else
	 print("Counts Error")
	 end
end
