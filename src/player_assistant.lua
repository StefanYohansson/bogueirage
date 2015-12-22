PlayerAssistant = { corners = {-6, 5, -22, -0.5} }
PlayerAssistant.__index = PlayerAssistant

local PLAYER_ID = 1
local FLY_SPEED = 400
local MAX_FLY_SPEED = 160
local MAX_FLY_SPEED_CARRY = 90
local GRAVITY = 350

PS_RUN, PS_CARRY, PS_THROW = 0,1,2

local lg = love.graphics

function PlayerAssistant.create(x, y, level)
  local self = setmetatable({}, PlayerAssistant)

  self.x, self.y = x, y

  self.xspeed = 80
	self.yspeed = 80
  self.lastDir = 1
  self.dir = 1 -- -1 for left, 1 for right
  self.state = PS_RUN
  self.onGround = false

  self.tired = false

  self.width = 55
  self.height = 55
  local img_jump   = love.graphics.newImage("assets/hero_assistant/assistant_jump.png")
  local img_stand  = love.graphics.newImage("assets/hero_assistant/assistant_stand.png")
  local img_fly    = love.graphics.newImage("assets/hero_assistant/assistant_fly.png")
  self.PlayerAssistant_jump = newAnimation(img_jump, self.width, self.height, 0.1, 0)
  self.PlayerAssistant_stand = newAnimation(img_stand, self.width, self.height, 0.1, 0)
  self.PlayerAssistant_fly = newAnimation(img_fly, self.width, self.height, 0.1, 0)

  return self
end

function PlayerAssistant:update(dt)
  if ACTIVE_PLAYER ~= PLAYER_ID then
    return
  end

  self.lastDir = self.dir
  self.state = PS_RUN

  if keyboard['d'] then
    self.dir = 1
    self:updateFlying(dt)
  end
  if keyboard['a'] then
    self.dir = -1
    self:updateFlying(dt)
  end
end

function PlayerAssistant:updateFlying(dt)
  self.x = self.x + self.xspeed * dt * self.dir

  self.PlayerAssistant_stand:update(dt)
end

function PlayerAssistant:draw()
  self.PlayerAssistant_stand:draw(self.x, self.y, 0, self.dir, 1, self.width / 2, self.height / 2)
end