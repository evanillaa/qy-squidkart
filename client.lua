RegisterNetEvent('qy:squidcard:open')
AddEventHandler('qy:squidcard:open', function(sendnumber)
    cardAnim()
    SendNUIMessage({action = "show", number = sendnumber})
    SetNuiFocus(true, true)
end)

RegisterNUICallback('close', function()
    closeGui()
end)

function closeGui()
    cardAnim()
    SendNUIMessage({action = "close"})
    SetNuiFocus(false, false)
end

local oObjectProp = "prop_ld_contact_card"
local oObject_net = nil
function cardAnim()
    local player = GetPlayerPed(-1)
    local playerID = PlayerId()
    local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
    local phoneRspawned = CreateObject(GetHashKey(oObjectProp), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
    local netid = ObjToNet(phoneRspawned)
    local ad = "amb@world_human_stand_mobile@female@text@enter"
    local ad2 = "amb@world_human_stand_mobile@female@text@base"
    local ad3 = "amb@world_human_stand_mobile@female@text@exit"
  
    if (DoesEntityExist(player) and not IsEntityDead(player)) then
        loadAnimDict(ad)
        loadAnimDict(ad2)
        loadAnimDict(ad3)
        RequestModel(GetHashKey(oObjectProp))
        if oIsAnimationOn == true then
            TaskPlayAnim(player, ad3, "exit", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
            Wait(1840)
            DetachEntity(NetToObj(oObject_net), 1, 1)
            DeleteEntity(NetToObj(oObject_net))
            Wait(750)
            ClearPedSecondaryTask(player)
            oObject_net = nil
            oIsAnimationOn = false
        else
            oIsAnimationOn = true
            Wait(500)
            TaskPlayAnim(player, ad, "enter", 8.0, 1.0, -1, 50, 0, 0, 0, 0)
            Wait(1360)
            AttachEntityToEntity(phoneRspawned,GetPlayerPed(playerID),GetPedBoneIndex(GetPlayerPed(playerID), 28422),-0.005,0.0,0.0,360.0,360.0,0.0,1,1,0,1,0,1)
            oObject_net = netid
            Wait(200)
        end
    end
end

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
end