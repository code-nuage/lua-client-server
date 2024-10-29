PLAYERS = {}

Player = {}
Player.__index = Player

function player_listener(data)
    local type, name, uuid, x, y = string.match(data, "(%w+),(%w+),(%w+),([%d%.]+),([%d%.]+)")
    print(name)
    if type == "PLAYERDATA" and name and uuid and x and y then

        if PLAYERS[uuid] == nil then
            PLAYERS[uuid] = Player:new(name, uuid, x, y)
        else
            PLAYERS[uuid]:update(x, y)
        end
    end
end

function Player:new(name, uuid, x, y)
    local instance = setmetatable({}, Player)
    instance.name = name
    instance.uuid = uuid
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
        print("Sending PLAYERDATA: ", self.name, self.uuid, self.x, self.y)
        HOST:broadcast("PLAYERDATA," .. self.name .. "," .. self.uuid .. "," .. self.x .. "," .. self.y)
        self.previousx, self.previousy = self.x, self.y
    end
end