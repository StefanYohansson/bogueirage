Player = { corners = {-6, 5, -22, -0.5} }
Player.__index = Player

local RUN_SPEED = 400
local MAX_SPEED = 160
local MAX_SPEED_CARRY = 100
local BRAKE_SPEED = 250
local GRAVITY = 350

PS_RUN, PS_CARRY, PS_THROW, PS_DEAD = 0,1,2,3

local lg = love.graphics

function Player.create(x, y, level)
  local self = setmetatable({}, Player)

  self.x, self.y = x, y

  self.xspeed = 150
	self.yspeed = 0
  self.lastDir = 1
  self.dir = 1 -- -1 for left, 1 for right
  self.state = PS_RUN
  self.onGround = false

  self.fuel_burning = 3
  self.gears = 2
  self.overloaded = false
  self.broken = false

  self.num_gears = 0
  self.num_fuel = 0

  self.canGrab = false
	self.grabbed = nil

  local img  = love.graphics.newImage("assets/hero/hero_running.png")
  self.player_run = newAnimation(img, 55, 55, 0.1, 0)

  return self
end

function Player:update(dt)
  self.lastDir = self.dir
  self.state = PS_RUN

  if keyboard['d'] then
    self.dir = 1
    self:updateRunning(dt)
  end
  if keyboard['a'] then
    self.dir = -1
    self:updateRunning(dt)
  end
end

function Player:updateRunning(dt)
  self.x = self.x + self.xspeed * dt * self.dir

  self.player_run:update(dt)
end

function Player:draw()
  self.player_run:draw(self.x, self.y, 0, self.dir, 1)
end
