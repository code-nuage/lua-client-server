PLAYERS = {}

Player = {}
Player.__index = Player

function player_listener(data)
    local type, name, x, y = string.match(data, "(%w+),(%w+),([%d%.]+),([%d%.]+)")
    if type == "PLAYERDATA" and name and x and y then

        if PLAYERS[name] == nil then
            PLAYERS[name] = Player:new(name, x, y)
        else
            PLAYERS[name]:update(x, y)
        end

        print("Receive PLAYERDATA: ", PLAYERS[name].name, PLAYERS[name].x, PLAYERS[name].y)
    end
end

function Player:new(name, x, y)
    local instance = setmetatable({}, Player)
    instance.name = name
    instance.x = x
    instance.y = y
    return instance
end

function Player:update(x, y)
    self.x = x
    self.y = y
end