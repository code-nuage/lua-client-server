local function generate_uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"
    return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and math.random(0, 15) or math.random(8, 11)
        return string.format("%x", v)
    end)
end

Player = {
    w = 32,
    h = 32,
    speed = 64
}
Player.__index = Player

function Player:new(name, x, y)
    local instance = setmetatable({}, Player)
    instance.name = name
    instance.uuid = tostring(generate_uuid())
    instance.x = x
    instance.y = y
    instance.w = Player.w
    instance.h = Player.h
    instance.speed = Player.speed
    return instance
end

function Player:update(dt)
    if love.keyboard.isDown("w") then
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown("s") then
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    end
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
end