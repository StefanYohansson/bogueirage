ACTIVE_PLAYER = 0

require('controls/keyboard')
require('camera')
require('player')
require('player_assistant')
require('map')

-- 3rd party dependencies
require('lib/AnAL')

local lg = love.graphics

function love.load()
  player = Player.create(55, 500, 1)
  player_assistant = PlayerAssistant.create(155, 500, 1)
  current_player = player
  mapa = map.create(128, 128)
  tileset = lg.newImage('assets/spritesheet_ground.png')
  Quad = lg.newQuad(0, 128, 128, 128, 1024, 2048)
end

function love.update(dt)
   player:update(dt)
   player_assistant:update(dt, player.x)
   camera:update(dt, current_player.camera_x, current_player.camera_y)
end

function love.draw()
  camera:set()
  -- lg.draw(tileset, mapa.Quads['#'], 0, 0)
  map.draw(mapa)
  mapa:draw()
  player:draw()
  player_assistant:draw()
  camera:unset()
end

function love.keypressed(key)
  if key == 'tab' then
    ACTIVE_PLAYER = (ACTIVE_PLAYER == 1) and 0 or 1
    if ACTIVE_PLAYER == 1 then
      current_player = player_assistant
    else
      current_player = player
    end
  end
  keyboard.pressed(key)
end

function love.keyreleased(key)
  keyboard.released(key)
end
