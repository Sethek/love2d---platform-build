player = {}
  player.body = love.physics.newBody(Oasis, 400, 2200, "dynamic")
  player.shape = love.physics.newRectangleShape(66, 92)
  player.fixture = love.physics.newFixture(player.body, player.shape)
  player.speed = 250
  player.grounded = false
  player.ducking = false
  player.onLadder = false
  player.dead = false
  player.direction = 1
  player.life = 6
  player.body:setFixedRotation(true)





function playerUpdate(dt)

  if gameState == 2 then
    if love.keyboard.isDown("a") then
      player.body:setX(player.body:getX() - player.speed * dt)
      player.direction = -1
    end
    if love.keyboard.isDown("d") then
      player.body:setX(player.body:getX() + player.speed * dt)
      player.direction = 1
    end
    if love.keyboard.isDown("s") then
      player.ducking = true
    else
      player.ducking = false
    end

      if player.onLadder == true then
        Oasis:setGravity(0,0)
          if love.keyboard.isDown("w") and player.onLadder == true then
            player.body:setY(player.body:getY() - player.speed /3 * dt)
          end
      else
          Oasis:setGravity(0,500)
      end


    --[[  if love.keyboard.isDown("s") and player.grounded == false then
      player.body:setY(player.body:getY() + player.speed / 2 * dt)
    end
  if love.keyboard.isDown("s") and player.onLadder == true thenwwww
      player.body:setY(player.body:getY() - player.speed / 3 * dt)
    end]]

    if love.keyboard.isDown("p") then
      deadPlayer()
    end

    --[[if player.body:getY() > love.graphics:getHeight() then
      hurtPlayer()
    end]]
  end
end

function hurtPlayer()
    player.dead = true
    player.dead = false
    player.body:setX(200)
    player.body:setY(440)
  if player.life > 1 then
    player.life = player.life - 1
  else
    deadPlayer()
  end
end

function deadPlayer()
  gameState = 3

  for i=#coins,1,-1 do
    local c = coins[i]
      table.remove(coins, all)
  end
end
