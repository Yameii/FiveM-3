--Determins the rarity of common, uncommon and rare, so current chances are 60% chance of being common, 30% chance being uncommon and 10% chance being rare.
Rarity = {
  "Common", "Common", "Common", "Common", "Common", "Common",
  "Uncommon", "Uncommon", "Uncommon", 
  "Rare"
}
-- items can also be used like this to add more looting ideas in the future ("DeerAntlers", "DeerFoot") ect..
CItems = {
  "Meat"
} 
UDeerItems = { 
  "DeerHide"
} 
RDeerItems = {
  "DeerAntlers"
}
UCougarItems = { 
  "CougarFur"
} 
RCougarItems = {
  "CougarTooth"
}
UFoxItems = { 
  "FoxFur"
} 
RFoxItems = {
  "FoxTooth"
}
URabbitItems = { 
  "RabbitFur"
} 
RRabbitItems = {
  "LuckyRabbitFoot"
}
UBirdItems = { 
  "Feather"
} 
RBirdItems = {
  "GoldenFeather"
}

-- Finds out what is "chosen" and adds the correct random item from the rarity. Deer
function RandomDeerLoot()
  math.randomseed( GetGameTimer() )
  local chosen = Rarity[math.random(1,#Rarity)]

  if chosen == "Common" then
    for i=1, #CItems do
      return CItems[math.random(#CItems)]
    end
  elseif chosen == "Uncommon" then
    for i=1, #UDeerItems do
      return UDeerItems[math.random(#UDeerItems)]
    end
  elseif chosen == "Rare" then
    for i=1, #RDeerItems do
      return RDeerItems[math.random(#RDeerItems)]
    end
  end
end

--Cougar
function RandomCougarLoot()
  math.randomseed( GetGameTimer() )
  local chosen = Rarity[math.random(1,#Rarity)]

  if chosen == "Common" then
    for i=1, #CItems do
      return CItems[math.random(#CItems)]
    end
  elseif chosen == "Uncommon" then
    for i=1, #UCougarItems do
      return UCougarItems[math.random(#UCougarItems)]
    end
  elseif chosen == "Rare" then
    for i=1, #RCougarItems do
      return RCougarItems[math.random(#RCougarItems)]
    end
  end
end

--Fox
function RandomFoxLoot()
  math.randomseed( GetGameTimer() )
  local chosen = Rarity[math.random(1,#Rarity)]

  if chosen == "Common" then
    for i=1, #CItems do
      return CItems[math.random(#CItems)]
    end
  elseif chosen == "Uncommon" then
    for i=1, #UFoxItems do
      return UFoxItems[math.random(#UFoxItems)]
    end
  elseif chosen == "Rare" then
    for i=1, #RFoxItems do
      return RFoxItems[math.random(#RFoxItems)]
    end
  end
end

--Rabbit
function RandomRabbitLoot()
  math.randomseed( GetGameTimer() )
  local chosen = Rarity[math.random(1,#Rarity)]

  if chosen == "Common" then
    for i=1, #CItems do
      return CItems[math.random(#CItems)]
    end
  elseif chosen == "Uncommon" then
    for i=1, #URabbitItems do
      return URabbitItems[math.random(#URabbitItems)]
    end
  elseif chosen == "Rare" then
    for i=1, #RRabbitItems do
      return RRabbitItems[math.random(#RRabbitItems)]
    end
  end
end

--Bird
function RandomBirdLoot()
  math.randomseed( GetGameTimer() )
  local chosen = Rarity[math.random(1,#Rarity)]

  if chosen == "Common" then
    for i=1, #CItems do
      return CItems[math.random(#CItems)]
    end
  elseif chosen == "Uncommon" then
    for i=1, #UBirdItems do
      return UBirdItems[math.random(#UBirdItems)]
    end
  elseif chosen == "Rare" then
    for i=1, #RBirdItems do
      return RBirdItems[math.random(#RBirdItems)]
    end
  end
end

--gives 5 items just remove or add more lines for more/less loot. Deer
RegisterServerEvent('hunting:deerloot')
AddEventHandler('hunting:deerloot', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(RandomDeerLoot(), 1)
  xPlayer.addInventoryItem(RandomDeerLoot(), 1)
  xPlayer.addInventoryItem(RandomDeerLoot(), 1)
  xPlayer.addInventoryItem(RandomDeerLoot(), 1)
  xPlayer.addInventoryItem(RandomDeerLoot(), 1)
end)

--gives 6 items just remove or add more lines for more/less loot. Cougar
RegisterServerEvent('hunting:cougarloot')
AddEventHandler('hunting:cougarloot', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
  xPlayer.addInventoryItem(RandomCougarLoot(), 1)
end)

--gives 3 items just remove or add more lines for more/less loot. Fox
RegisterServerEvent('hunting:foxloot')
AddEventHandler('hunting:foxloot', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(RandomFoxLoot(), 1)
  xPlayer.addInventoryItem(RandomFoxLoot(), 1)
  xPlayer.addInventoryItem(RandomFoxLoot(), 1)
end)

--gives 2 items just remove or add more lines for more/less loot. Rabbit
RegisterServerEvent('hunting:rabbitloot')
AddEventHandler('hunting:rabbitloot', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(RandomRabbitLoot(), 1)
  xPlayer.addInventoryItem(RandomRabbitLoot(), 1)
end)

--gives 1 items just remove or add more lines for more/less loot. Bird
RegisterServerEvent('hunting:rabbitloot')
AddEventHandler('hunting:rabbitloot', function()
  local xPlayer = ESX.GetPlayerFromId(source)
  xPlayer.addInventoryItem(RandomBirdLoot(), 1)
end)