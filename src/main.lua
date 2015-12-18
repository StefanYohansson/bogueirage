
require('controls/keyboard')
require('player')

-- 3rd party dependencies
require('lib/AnAL')

function love.load()
  player = Player.create(0, 500, 1)
end

function love.update(dt)
   player:update(dt)
end

function love.draw()
   player:draw()
end

function love.keypressed(key)
  keyboard.pressed(key)
end

function love.keyreleased(key)
  keyboard.released(key)
end
