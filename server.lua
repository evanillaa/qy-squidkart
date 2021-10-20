QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

QBCore.Commands.Add("squidcard", "Etkinlik kartı verir", {}, false, function(source, args)
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local number = args[1]
    local info = {
		cardnumber = number,
	}
    xPlayer.Functions.AddItem("game_ticket", 1, nil, info)
end, 'admin')

QBCore.Functions.CreateUseableItem('game_ticket', function(source, item)
	TriggerClientEvent('qy:squidcard:open', source, item.info.cardnumber)
end)