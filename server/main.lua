local RSGCore = exports['rsg-core']:GetCoreObject()
local coords = nil

Citizen.CreateThread(function()
    coords = Config.BlackmarketPositions[math.random(1, #Config.BlackmarketPositions)]

    if not Config.BlackmarketMoveAtStart and Config.BlackmarketCycling then
        while true do
            Wait(Config.CycleInterval * 60000)
            coords = Config.BlackmarketPositions[math.random(1, #Config.BlackmarketPositions)]
            TriggerClientEvent('jc-blackmarket:client:newPos', -1, coords)
        end
    end
end)

RSGCore.Functions.CreateCallback('getCoords', function(source, cb)
    local src = source
    cb(coords)
end)

RegisterNetEvent('jc-blackmarket:server:sellItems', function(item, amount, price)
    local src = source
    local Player = RSGCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(item, amount)
    TriggerClientEvent('inventory:client:ItemBox', src, RSGCore.Shared.Items[item], 'remove')
    Player.Functions.AddMoney('cash', price * amount)
end)