ladders = {}

function spawnLadder(x, y)
  ladder = {}
    ladder.x = x
    ladder.y = y

  table.insert(ladders, ladder)
end

function ladderUpdate(dt)
  for i,l in ipairs(ladders) do
    if distanceBetween(l.x, l.y, player.body:getX(), player.body:getY()) < 70 then
      player.onLadder = true
    else
      player.onLadder = false
    end
  end

end
