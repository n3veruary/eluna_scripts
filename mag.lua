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

function Mag.EnterCombat(event,creature,target) -- emote on combat entry, declare events for casts.
	creature:Emote(-1544015)
	creature:Emote(-154406)
	creature:RegisterEvent(Mag.Berserk,1200000,1)
	creature:RegisterEvent(Mag.Conflag, {10000, 15000}, 0)
	creature:RegisterEvent(Mag.Quake, 40000, 0)
	creature:RegisterEvent(Mag.Cleave, {10000, 15000}, 0)
	creature:ClearThreatList()
end

function Mag.KillsPlayer(event, creature, victim) -- send message when player dies, select next victim
	creature:Emote(-1544010)
end

function Mag.OnDrop(event, creature) -- wipe events when leaving combat
	creature:RemoveEvents()
end

function Mag.OnDeath(event, creature, killer) -- say message. wipe events on death.
	creature:SendChatMessageToPlayer(4,0,"The Legion will consume you all!")
	creature:RemoveEvents()
end

function Mag.Berserk(event, delay, pCall, creature) -- berserk. cast on timer.
	creature:CastSpell(creature,27680,true)
end

function Mag.Conflag(event, delay, pCall, creature) -- conflag. cast on timer. select random target on ground.
        x,y,z = creature:GetRelativePoint(math.random()*9, math.random()*math.pi*2)
        conflag = creature:CastSpellAoF( x, y, z, 30757)
end

function Mag.Quake(event, delay, pCall, creature) -- quake, cast on timer.
	creature:CastSpell(30657)
end

function Mag.Cage(event, creature, caster, spellid) -- cage handler. when hit by shadow grasp, apply dummy aura and stop movement. need to count to 5.  
	if Aura:GetStackAmount(30410)==5 then
		creature:SetRooted()
		creature:AttackStop()
		creature:MoveIdle()
		creature:CastSpell(30205)
end
end

function Mag.Cleave(event, delay, pCall, creature) -- cleave
	creature:SelectVictim()
	creature:CastSpell(30619)
end

RegisterCreatureEvent(17257, 1, Mag.EnterCombat)
RegisterCreatureEvent(17257, 2, Mag.OnDrop)
RegisterCreatureEvent(17257, 3, Mag.KillsPlayer)
RegisterCreatureEvent(17257, 4, Mag.OnDeath)
RegisterCreatureEvent(17257, 14, Mag.Cage)
