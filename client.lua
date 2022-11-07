local screenW, screenH = guiGetScreenSize()
local relX, relY = screenW/1366, screenH/768

function getVehicleSpeed()
    if isPedInVehicle(getLocalPlayer()) then
        local vx, vy, vz = getElementVelocity(getPedOccupiedVehicle(getLocalPlayer()))
        return math.sqrt(vx^2 + vy^2 + vz^2) * 161
    end
    return 0
end

function drawSpeedo() 
    local vehSpeed = math.floor(getVehicleSpeed()+195)
    dxDrawCircle(screenW-140*relX, screenH-40*relY, 120*relX, 195, 345, tocolor(0, 0, 0, 100), tocolor(0, 0, 0, 0), 200)
	if vehSpeed >= 345 then 
    	dxDrawCircle(screenW-140*relX, screenH-40*relY, 120*relX, 195, 345, tocolor(80, 111, 255, 210), tocolor(0, 0, 0, 0), 200)
	else 
		dxDrawCircle(screenW-140*relX, screenH-40*relY, 120*relX, 195, vehSpeed, tocolor(80, 111, 255, 210), tocolor(0, 0, 0, 0), 200)
	end
	dxDrawText((vehSpeed-195), screenW-150*relX, screenH-75*relY, _, _, tocolor(234, 235, 236, 210), 1.4*relX, "pricedown")
	dxDrawText("km/h", screenW-130*relX, screenH-45*relY, _, _, tocolor(80, 111, 255, 210), 0.8*relX, "pricedown")
end 


addEventHandler("onClientResourceStart", getRootElement(),
	function ()
		if isPedInVehicle(getLocalPlayer()) then
			addEventHandler("onClientRender", getRootElement(), drawSpeedo)
		end
	end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
	function(thePlayer)
		if thePlayer == getLocalPlayer() then
			addEventHandler("onClientRender", getRootElement(), drawSpeedo)
		end
	end
)

addEventHandler("onClientVehicleStartExit", getRootElement(),
	function(thePlayer)
		if thePlayer == getLocalPlayer() then
			removeEventHandler("onClientRender", getRootElement(), drawSpeedo)
		end
	end
)