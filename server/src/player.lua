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

function Player:send()
    if self.previousx ~= self.x or self.previousy ~= self.y then
        print("Sending PLAYERDATA: ", self.name, self.x, self.y)
        HOST:broadcast("PLAYERDATA," .. self.name .. "," .. self.x .. "," .. self.y)
        self.previousx, self.previousy = self.x, self.y
    end
end