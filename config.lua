Config = Config or {}

Config.BlackmarketCycling = true -- Whether the blackmarket should move around
Config.BlackmarketMoveAtStart = false -- Make it so Blackmarket will only switch position every server restart!
Config.BlackmarketCanBuy = true -- Whether it's possible to sell items to blackmarket or not!
Config.CycleInterval = 240 -- How often in minutes the blackmarket should move around

Config.BlackmarketPed = 'g_m_m_unibanditos_01' -- What ped you want the blackmarket to be!
Config.BlackmarketPositions = { -- You can add as many positions, and it will spawn a random location every server start/interval, if you want him to be only one place, just only add 1 coord!
    vector4(825.86987, -1907.001, 42.511974, 58.496509),
    vector4(-1345.848, 2442.7258, 308.68823, 339.39105),
    vector4(-551.7838, 2708.5024, 323.44174, 149.95095),
    vector4(1202.0118, 612.41149, 91.206932, 101.94412),
    vector4(-4227.611, -3429.571, 37.2807, 45.342361)
}

Config.BlackmarketItems = { -- Items you can buy from blackmarket!
    {
        name = 'cocaineseeds', -- The name of the item in items.lua
        price = 1.5, -- The price to buy the item
        amount = 10, -- How many items will be in stock and can be bought at one time
        info = {}, -- This is extra info, need to have a basis knowhow to play with this, but basically contains the info you will see when hovering over items in inventory when it has a unique info.
        type = 'item', -- Just the type of item to buy!
        slot = 1, -- The slot of items in order, very important and to be unique too!
    },
    {
        name = 'morphine',
        price = 3.5,
        amount = 10,
        info = {},
        type = 'item',
        slot = 2,
    },
    {
        name = 'heroin',
        price = 4,
        amount = 10,
        info = {},
        type = 'item',
        slot = 3,
    },
    {
        name = 'lockpick',
        price = 1,
        amount = 50,
        info = {},
        type = 'item',
        slot = 4,
    },
    {
        name = 'dynamite',
        price = 8,
        amount = 5,
        info = {},
        type = 'item',
        slot = 5,
    },
}

Config.BlackmarketBuy = { -- Items that you can buy to blackmarket if enabled!
    {
        name = 'cocaine', -- The name of the item
        price = 2, -- The price to sell this item!
    },
    {
        name = 'raspberrymoonshine',
        price = 1,
    },
    {
        name = 'applemoonshine',
        price = 1.25,
    }
}