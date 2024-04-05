local RSGCore = exports['rsg-core']:GetCoreObject()
local blackmarketPed = nil

Citizen.CreateThread(function()
    local isLoggedIn = false

    while not isLoggedIn do
        Wait(1000)
        if LocalPlayer.state.isLoggedIn then
            isLoggedIn = true
            print('Player Logged in!')
        end
    end

    if not blackmarketPed then
        RSGCore.Functions.TriggerCallback('getCoords', function(coords)
            if coords then
                local model = 'amsp_robsdgunsmith_males_01'

                while not HasModelLoaded(model) do
                    Wait(1)
                    RequestModel(model)
                end

                blackmarketPed = CreatePed(model, coords.x, coords.y, coords.z - 1.0, coords.w, true, false, 0, 0)
                Citizen.InvokeNative(0x283978A15512B2FE, blackmarketPed, true)
                FreezeEntityPosition(blackmarketPed, true)
                SetEntityInvincible(blackmarketPed, true)
                SetBlockingOfNonTemporaryEvents(blackmarketPed, true)
                Wait(1)

                if Config.BlackmarketCanBuy then
                    exports['rsg-target']:AddTargetEntity(blackmarketPed, {
                        options = {
                            {
                                label = 'Open Market',
                                icon = 'fas fa-dollars',
                                action = function()
                                    local ShopItems = {}
                                    ShopItems.label = 'Blackmarket'
                                    ShopItems.items = Config.BlackmarketItems
                                    ShopItems.slots = #Config.BlackmarketItems
                                    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Blackmarket_'..math.random(1, 99), ShopItems)
                                end
                            },
                            {
                                label = 'Open Sell Market',
                                icon = 'fas fa-dollars',
                                action = function()
                                    local tableData = {}

                                    for _, items in pairs(Config.BlackmarketBuy) do
                                        tableData[#tableData + 1] = {
                                            title = RSGCore.Shared.Items[items.name].label,
                                            description = 'Sell ' .. RSGCore.Shared.Items[items.name].label .. ' for $' .. items.price,
                                            onSelect = function()
                                                local info = lib.inputDialog('Sell Items', {
                                                    {
                                                        type = 'number',
                                                        label = 'Amount',
                                                        description = 'Items to sell',
                                                        required = true,
                                                        min = 1,
                                                        default = 1,
                                                    }
                                                })

                                                if RSGCore.Functions.HasItem(items.name, info[1]) then
                                                    TriggerServerEvent('jc-blackmarket:server:sellItems', items.name, info[1], items.price)
                                                else
                                                    RSGCore.Functions.Notify('You don\'t have that many of this item!', 'error', 3000)
                                                end
                                            end
                                        }
                                    end

                                    lib.registerContext({
                                        id = 'sell_items',
                                        title = 'Sell Items',
                                        options = tableData
                                    })
                                    lib.showContext('sell_items')
                                end
                            },
                        }
                    })
                else
                    exports['rsg-target']:AddTargetEntity(blackmarketPed, {
                        options = {
                            {
                                label = 'Open Market',
                                icon = 'fas fa-dollars',
                                action = function()
                                    local ShopItems = {}
                                    ShopItems.label = 'Blackmarket'
                                    ShopItems.items = Config.BlackmarketItems
                                    ShopItems.slots = #Config.BlackmarketItems
                                    TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Blackmarket_'..math.random(1, 99), ShopItems)
                                end
                            }
                        }
                    })
                end
            end
        end)
    end
end)

RegisterNetEvent('jc-blackmarket:client:newPos', function(coords)
    if blackmarketPed then
        DeletePed(blackmarketPed)
        blackmarketPed = nil
    end

    local model = 'amsp_robsdgunsmith_males_01'

    while not HasModelLoaded(model) do
        Wait(1)
        RequestModel(model)
    end

    blackmarketPed = CreatePed(model, coords.x, coords.y, coords.z - 1.0, coords.w, true, false, 0, 0)
    Citizen.InvokeNative(0x283978A15512B2FE, blackmarketPed, true)
    FreezeEntityPosition(blackmarketPed, true)
    SetEntityInvincible(blackmarketPed, true)
    SetBlockingOfNonTemporaryEvents(blackmarketPed, true)
    Wait(1)

    if Config.BlackmarketCanBuy then
        exports['rsg-target']:AddTargetEntity(blackmarketPed, {
            options = {
                {
                    label = 'Open Market',
                    icon = 'fas fa-dollars',
                    action = function()
                        local ShopItems = {}
                        ShopItems.label = 'Blackmarket'
                        ShopItems.items = Config.BlackmarketItems
                        ShopItems.slots = #Config.BlackmarketItems
                        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Blackmarket_'..math.random(1, 99), ShopItems)
                    end
                },
                {
                    label = 'Open Sell Market',
                    icon = 'fas fa-dollars',
                    action = function()
                        local tableData = {}

                        for _, items in pairs(Config.BlackmarketBuy) do
                            tableData[#tableData + 1] = {
                                title = RSGCore.Shared.Items[items.name].label,
                                description = 'Sell ' .. RSGCore.Shared.Items[items.name].label .. ' for $' .. items.price,
                                onSelect = function()
                                    local info = lib.inputDialog('Sell Items', {
                                        {
                                            type = 'number',
                                            label = 'Amount',
                                            description = 'Items to sell',
                                            required = true,
                                            min = 1,
                                            default = 1,
                                        }
                                    })

                                    if RSGCore.Functions.HasItem(items.name, info[1]) then
                                        TriggerServerEvent('jc-blackmarket:server:sellItems', items.name, info[1], items.price)
                                    else
                                        RSGCore.Functions.Notify('You don\'t have that many of this item!', 'error', 3000)
                                    end
                                end
                            }
                        end

                        lib.registerContext({
                            id = 'sell_items',
                            title = 'Sell Items',
                            options = tableData
                        })
                        lib.showContext('sell_items')
                    end
                },
            }
        })
    else
        exports['rsg-target']:AddTargetEntity(blackmarketPed, {
            options = {
                {
                    label = 'Open Market',
                    icon = 'fas fa-dollars',
                    action = function()
                        local ShopItems = {}
                        ShopItems.label = 'Blackmarket'
                        ShopItems.items = Config.BlackmarketItems
                        ShopItems.slots = #Config.BlackmarketItems
                        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'Blackmarket_'..math.random(1, 99), ShopItems)
                    end
                }
            }
        })
    end
end)

RegisterCommand('tpBlackmarket', function(source, rawCommand, args)
    if blackmarketPed then
        local pos = GetEntityCoords(blackmarketPed)
        SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z, true, false, false, false)
    else
        RSGCore.Functions.Notify('There\'s no existing blackmarket peds!', 'error', 3000)
    end
end)