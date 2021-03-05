--[[
    EmuDevs <http://emudevs.com/forum.php>
    Eluna Lua Engine <https://github.com/ElunaLuaEngine/Eluna>
    Eluna Scripts <https://github.com/ElunaLuaEngine/Scripts>
    Eluna Wiki <http://wiki.emudevs.com/doku.php?id=eluna>
    -= Script Information =-
    * Script Type: Boss Fight
    * Npc: Magtheridon
--]]
local Mag = {}
-- on spawn
local function Mag.EnterCombat(event,creature,target)
local nearest = creature:GetNearestPlayer(200,0,1)
creature:Emote(-1544015)
creature:Emote(-154406)
creature:RegisterEvent(Mag.Berserk,1200000,1)
creature:RegisterEvent(Mag.Conflag, {10000, 15000}, 0)
creature:RegisterEvent(Mag.Quake, 40000, 0)
creature:RegisterEvent(Mag.Nova, 55000)
creature:RegisterEvent(Mag.Cleave, 15000)
creature:ClearThreatList()
Unit:Attack(nearest)
end
-- on player kill
local function Mag.KillsPlayer(event, creature, victim)
creature:Emote(-1544010)
creature:SelectVictim()
end
--on leaving combat
local function Mag.OnDrop(event, creature)
creature:RemoveEvents()
end
--on death
local function Mag.OnDeath(event, creature, killer)
creature:RemoveEvents()
end
--berserk
local function Mag.Berserk(event, delay, pCall, creature)
creature:CastSpell(self,27680,true)
end
--conflag
local function Mag.Conflag(event, delay, pCall, creature)
        local x,y,z = creature:GetRelativePoint(math.random()*9, math.random()*math.pi*2)
        local conflag = creature:CastSpellAoF( x, y, z, 30757)
end
--quake
local function Mag.Quake(event, delay, pCall, creature)
creature:CastSpell(30657)
end
--nova
local function Mag.Nova(event, delay, pCall, creature)
    if !creature:HasAura(30168) then
	creature:CastSpell(30616)
	else
	creature:SetRooted()
	creature:AttackStop()
	creature:MoveIdle()
	creature:CastSpell(30205)
end
end
--cleave
local function Mag.Cleave(event, delay, pCall, creature)
creature:SelectVictim()
creature:CastSpell(30619)
end

RegisterCreatureEvent(17257, 1, Mag.EnterCombat)
RegisterCreatureEvent(17257, 2, Mag.OnDrop)
RegisterCreatureEvent(17257, 3, Mag.KillsPlayer)
RegisterCreatureEvent(17257, 4, Mag.OnDeath)