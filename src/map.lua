local lg = love.graphics;

map = {}
map.tileW = 0
map.tileH = 0

map.__index = map

local tileString = [[

^^^^^
#####
]]

local quadInfo = {
  { ' ', 7, 0 },
  { '#', 1, 0 },
  { '^', 0, 1 }
}

map.tileW, map.tileH = 128, 128

function map:loadTileset(file)
  self.tileset = lg.newImage('assets/spritesheet_ground.png')
  self.tilesetW = self.tileset:getWidth()
  self.tilesetH = self.tileset:getHeight()
end

function map:newTile(col, row)
  local tileW, tileH = self.tileW, self.tileH
  --return lg.newQuad(col * tileW, row * tileH, tileW, tileH, self.tilesetW, self.tilself.tilesetWself.tilesetWself.tilesetWesetW)
  return lg.newQuad(col * tileW, row * tileH, tileW, tileH, self.tilesetW, self.tilesetH)
end


function map:loadTileInfo(tileInfo)
  Quads = {}
  for _,quad in ipairs(quadInfo) do
    Quads[quad[1]] = self:newTile(quad[2], quad[3])
    -- Quads[quad[1]] = lg.newQuad(quad[2], quad[3], self.tileW, self.tileH, self.tilesetW, self.tilesetH)
  end

  self.Quads = Quads
end

function map:parseTileString(tileString)
  TileTable = {}
  local width = #(tileString:match("[^\n]+"))

  for x = 1, width, 1 do TileTable[x] = {} end

  local rowIndex, colIndex = 1, 1

  for row in tileString:gmatch("[^\n]+") do
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    colIndex = 1
    for character in row:gmatch(".") do
      TileTable[colIndex][rowIndex] = character
      colIndex = colIndex + 1
    end
    rowIndex=rowIndex+1
  end

  self.TileTable = TileTable
end

function map:draw()
  for cIndex, col in ipairs(self.TileTable) do
    for rIndex, char in ipairs(col) do
      local x,y = (cIndex-1)*self.tileW, (rIndex-1)*self.tileH
      lg.draw(self.tileset, self.Quads[char], x, y)
    end
  end
end


function map.create(tileW, tileH, tileInfo)
  local self = setmetatable({}, map)
  self.tileW, self.tileH = tileW, tileH
  map.loadTileset(self)
  map.loadTileInfo(self)
  map.parseTileString(self, tileString)
  return self
end
