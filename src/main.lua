ACTIVE_PLAYER = 0

require('controls/keyboard')
require('camera')
require('player')
require('player_assistant')

-- 3rd party dependencies
require('lib/AnAL')


function love.load()
  player = Player.create(55, 500, 1)
  player_assistant = PlayerAssistant.create(155, 500, 1)
end

function love.update(dt)
   player:update(dt)
   player_assistant:update(dt, player.x)
   camera:update(dt)
end

function love.draw()
  camera:set()
  player:draw()
  player_assistant:draw()
  camera:unset()
end

function love.keypressed(key)
  if key == 'tab' then
    ACTIVE_PLAYER = (ACTIVE_PLAYER == 1) and 0 or 1
  end
  keyboard.pressed(key)
end

function love.keyreleased(key)
  keyboard.released(key)
end
