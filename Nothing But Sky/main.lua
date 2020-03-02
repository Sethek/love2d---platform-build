local imageFile
local frames = {}
local activeFrame
local currentFrame = 1

function love.load()
  love.window.setMode(1080, 780)
  Oasis = love.physics.newWorld(0, 500, false)

  Oasis:setCallbacks(beginContact, endContact, preSolve, postSolve)

  sprites = {}
    sprites.coin_sheet = love.graphics.newImage('sprites/coin_sheet.png')
    sprites.p1_stand = love.graphics.newImage('sprites/p1_stand.png')
    sprites.p1_jump = love.graphics.newImage('sprites/p1_jump.png')
    sprites.p1_duck = love.graphics.newImage('sprites/p1_duck.png')
    sprites.p1_hurt = love.graphics.newImage('sprites/p1_hurt.png')
    sprites.p1_climb1 = love.graphics.newImage('sprites/p1_climb1.png')
    sprites.p1_climb2 = love.graphics.newImage('sprites/p1_climb2.png')
    sprites.ladder = love.graphics.newImage('sprites/items/ladder_mid.png')
    sprites.keyRed = love.graphics.newImage('sprites/items/keyRed.png')
    background = love.graphics.newImage('sprites/gameover.jpg')

  imageFile = love.graphics.newImage('sprites/p1_walk_grid.png')
  frames[1] = love.graphics.newQuad(0,0,66,92, imageFile:getDimensions())
  frames[2] = love.graphics.newQuad(66,0,66,92, imageFile:getDimensions())
  frames[3] = love.graphics.newQuad(132,0,66,92, imageFile:getDimensions())
  frames[4] = love.graphics.newQuad(0,92,66,92, imageFile:getDimensions())
  frames[5] = love.graphics.newQuad(66,92,66,92, imageFile:getDimensions())



  activeFrame = frames[currentFrame]


anim8 = require('anim8-master/anim8')
require('player')
require('show')
require('coins')
require('hearts')
require('ladders')
cameraFile = require('camera')
sti = require("Simple-Tiled-Implementation-master/sti")
oasismap = sti("maps/oasismap.lua")

cam = cameraFile()
myFont = love.graphics.newFont(30)

player.sprite = imageFile,activeFrame
gameState = 1
platforms = {}



  for i, obj in pairs(oasismap.layers["Ladder"].objects) do
    spawnLadder(obj.x, obj.y)
  end

  for i, obj in pairs(oasismap.layers["Platforms"].objects) do
    spawnPlatform(obj.x, obj.y, obj.width, obj.height)
  end

  for i, obj in pairs(oasismap.layers["Coins"].objects) do
    spawnCoin(obj.x, obj.y)
  end
end

local elapsedTime = 0

function love.update(dt)
  Oasis:update(dt)
  playerUpdate(dt)
  oasismap:update(dt)
  coinUpdate(dt)
  ladderUpdate(dt)

  elapsedTime = elapsedTime + dt

if love.keyboard.isDown("d", "a") and player.grounded == true and player.ducking == false then
  if(elapsedTime > 1) then
    if(currentFrame < 5) then
      currentFrame = currentFrame + 1
    else
      currentFrame = 1
    end
    activeFrame = frames[currentFrame]
    elapsedTime = .87
  end
end

  cam:lookAt(player.body:getX(), player.body:getY())

  for i,c in ipairs(coins) do
    c.animation:update(dt)
  end


  if #coins == 0 and gameState == 2 then
    gameState = 1
    player.body:setPosition(198, 443)

    if #coins == 0 then
      for i, obj in pairs(oasismap.layers["Coins"].objects) do
        spawnCoin(obj.x, obj.y)
      end
    end
  end


end

function love.draw()
  if gameState == 2 then
    playerLife()

      cam:attach()
        oasismap:drawLayer(oasismap.layers["Tile Layer 1"])


        for i,l in ipairs(ladders) do
          love.graphics.draw(sprites.ladder, l.x, l.y, nil, nil, nil, sprites.ladder:getWidth()/2, nil)
        end
        for i,c in ipairs(coins) do
          c.animation:draw(sprites.coin_sheet, c.x, c.y, nil, nil, nil, 20.5, 21)
        end


            if player.ducking == true then
                love.graphics.draw(sprites.p1_duck, player.body:getX(), player.body:getY()+15, nil, player.direction, 1, sprites.p1_stand:getWidth()/2, sprites.p1_stand:getHeight()/2)
              elseif player.grounded == false then
                love.graphics.draw(sprites.p1_jump, player.body:getX(), player.body:getY(), nil, player.direction, 1, sprites.p1_stand:getWidth()/2, sprites.p1_stand:getHeight()/2)
              else
                love.graphics.draw(imageFile,activeFrame, player.body:getX(), player.body:getY(), nil, player.direction, 1, sprites.p1_stand:getWidth()/2, sprites.p1_stand:getHeight()/2)
          end


      cam:detach()
  end


  if gameState == 1 then
    love.graphics.setFont(myFont)
    love.graphics.printf("Press any key to begin!", 0, 50, love.graphics.getWidth(), "center")
  end


  if gameState == 3 then
    love.graphics.draw(background)
  end

  if player.onLadder then
    love.graphics.print("onLadder is true", 0, 0)
  else
    love.graphics.print("onLadder is false", 0, 0)
  end
end



function spawnPlatform(x, y, width, height)
  local platform = {}
  platform.body = love.physics.newBody(Oasis, x, y, "static")
  platform.shape = love.physics.newRectangleShape(width/2, height/2, width, height)
  platform.fixture = love.physics.newFixture(platform.body, platform.shape)
  platform.width = width
  platform.height = height

  table.insert(platforms, platform)
end

function love.keypressed(key, scancode, isrepeat)
  if key == "space" and player.grounded == true then
    player.body:applyLinearImpulse(0, -3000)
  end

  if key == "escape" then
    deadPlayer()
  end

  if gameState == 1 then
    gameState = 2
    player.life = 6
  end

  if gameState == 3 then
    gameState = 1
  end
end

function beginContact(a, b, coll)
  x1, y1, x2, y2 = coll:getPositions() -- Gets the collision positions
  a_x = a:getBody():getX() -- Gets the X position of the player
  a_y = a:getBody():getY() -- Gets the Y position of the player
  b_x = b:getBody():getX() -- Gets the X position of the platform
  b_y = b:getBody():getY() -- Gets the Y position of the plaform
  -- The Y-position of the collision (vertical position) must be less than or equal to the Y position of the platform
  if (y1 <= b_y) and (y2 <= b_y) then
    player.grounded = true --If the collision = the position of the platform, GROUNDED
  else
    player.grounded = false --Else, not available to jump
  end
end

function endContact(a, b, coll)
  local x, y = player.body:getLinearVelocity()
  player.grounded = false
end

function distanceBetween(x1, y1, x2, y2)
  return math.sqrt((y2 - y1)^2 + (x2 - x1)^2)
end
