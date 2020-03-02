hearts = {}
  heartFull = love.graphics.newImage('sprites/hud/hud_heartFull.png')
  heartHalf = love.graphics.newImage('sprites/hud/hud_heartHalf.png')
  heartEmpty = love.graphics.newImage('sprites/hud/hud_heartEmpty.png')


function hearts6()
  love.graphics.draw(heartFull, 10, love.graphics.getHeight()-50, nil, nil)
  love.graphics.draw(heartFull, 65, love.graphics.getHeight()-50, nil, nil)
  love.graphics.draw(heartFull, 120, love.graphics.getHeight()-50, nil, nil)
end

function hearts5()
    love.graphics.draw(heartFull, 10, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartFull, 65, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartHalf, 120, love.graphics.getHeight()-50, nil, nil)
end

function hearts4()
    love.graphics.draw(heartFull, 10, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartFull, 65, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 120, love.graphics.getHeight()-50, nil, nil)
end

function hearts3()
    love.graphics.draw(heartFull, 10, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartHalf, 65, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 120, love.graphics.getHeight()-50, nil, nil)
end

function hearts2()
    love.graphics.draw(heartFull, 10, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 65, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 120, love.graphics.getHeight()-50, nil, nil)
end

function hearts1()
    love.graphics.draw(heartHalf, 10, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 65, love.graphics.getHeight()-50, nil, nil)
    love.graphics.draw(heartEmpty, 120, love.graphics.getHeight()-50, nil, nil)
end

function playerLife()
  if player.life == 6 then
    hearts6()
  elseif player.life == 5 then
    hearts5()
  elseif player.life == 4 then
    hearts4()
  elseif player.life == 3 then
    hearts3()
  elseif player.life == 2 then
    hearts2()
  elseif player.life == 1 then
    hearts1()
  elseif player.life > 1 then
    playerDead()
  end
end
