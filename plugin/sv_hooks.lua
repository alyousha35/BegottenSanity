local PLUGIN = PLUGIN;
local sanitydelay = 60;

-- Called when an NPC is killed.
--function PLUGIN:OnNPCKilled(entity, attacker, weapon)
--	local class = entity:GetClass();
--	
--	if (class == "npc_vj_cof_baby") then
--		Clockwork.item:CreateInstance("blreach");
--	end;
--end;

-- Called at an interval while a player is connected.
function PLUGIN:PlayerThink(player, curTime, infoTable)
    -- Can't go insane if you're already dead
	if ( player:Alive() ) then
        -- Does the player not have a sanity drop scheduled? 
        if (!player.nextSanityDrop or curTime >= player.nextSanityDrop) then
            -- Set a base sanity modifier, starting at one
            local sanitydrop = 1
            local playerpos = player:GetPos();
            
            -- Check for nearby entities that have names that start with "npc_vj_"
            for k, v in pairs( ents.FindByClass("npc_vj_*") ) do
                local monsterpos = v:GetPos();
                -- Are they within 4000 units?
                if (monsterpos:Distance(playerpos) < 4000) then
                    -- If so, add two points to the sanity drop modifier
                    sanitydrop = sanitydrop + 0.5;
                end;
            end;
            
            -- Check for nearby entities within 1500 units
            for k, v in ipairs( ents.FindInSphere(playerpos, 1500) ) do
                -- Are they active players?
                if ((v:IsPlayer() and v:HasInitialized() and v != player)) then
                    -- Subtract a point from the sanity drop modifier
                    sanitydrop = sanitydrop - 2;
                end;
            end;
            
            -- Check to ensure the player's sanity stat isn't set to -1 (infinite)
		if (tonumber(player:GetCharacterData("sanity")) != -1) then
                -- How much sanity are they about to lose? Give them a custom message depending on that
                -- Remember, sanitydrop means how much sanity the player will LOSE, so higher is worse
                if (sanitydrop > 10) then
                    Clockwork.player:Notify(player, "Something is following you. Your head is swimming in a cacophony of voices, spewing obscene commands.");
                elseif (sanitydrop > 2) then
                    Clockwork.player:Notify(player, "This place feels wrong. You feel your mind rot away as if some nearby presence is sucking it dry.");
                elseif (sanitydrop == 1) then
                elseif (sanitydrop <= 0) then
                    Clockwork.player:Notify(player, "The presence of others is helping you regain your sanity.");
                end;
                -- Apply the sanitydrop modifier to their stats
				player:SetCharacterData( "sanity", math.Clamp(player:GetCharacterData("sanity") - sanitydrop, 0, 100) );
                -- Finally, schedule the next sanity drop
				player.nextSanityDrop = curTime + sanitydelay;
			end;
		end;
	
		local hunger = player:GetCharacterData("sanity");
		if (hunger >= 60 ) then
			player:BoostAttribute("SanityHinderance", ATB_ENDURANCE, -5, 60);
			player:BoostAttribute("SanityHinderance", ATB_STAMINA, -5, 60);
			player:BoostAttribute("SanityHinderance", ATB_AGILITY, 5, 60);
			player:BoostAttribute("SanityHinderance", ATB_ACROBATICS, 5, 60);
		elseif (hunger >= 40 ) then
			player:BoostAttribute("SanityHinderance", ATB_ENDURANCE, -10, 60);
			player:BoostAttribute("SanityHinderance", ATB_STAMINA, -10, 60);
			player:BoostAttribute("SanityHinderance", ATB_AGILITY, 10, 60);
			player:BoostAttribute("SanityHinderance", ATB_ACROBATICS, 10, 60);
		elseif (hunger >= 20 ) then
			player:BoostAttribute("SanityHinderance", ATB_ENDURANCE, -15, 60);
			player:BoostAttribute("SanityHinderance", ATB_STAMINA, -15, 60);
			player:BoostAttribute("SanityHinderance", ATB_AGILITY, 15, 60);
			player:BoostAttribute("SanityHinderance", ATB_ACROBATICS, 15, 60);
		elseif (hunger >= 10 ) then
			player:BoostAttribute("SanityHinderance", ATB_ENDURANCE, -20, 60);
			player:BoostAttribute("SanityHinderance", ATB_STAMINA, -20, 60);
			player:BoostAttribute("SanityHinderance", ATB_AGILITY, 20, 60);
			player:BoostAttribute("SanityHinderance", ATB_ACROBATICS, 20, 60);
		end;
	end;	
end;

function PLUGIN:PlayerSaveCharacterData(player, data)
	if ( data["sanity"] ) then
		data["sanity"] = math.Round( data["sanity"] );
	end;
end;

function PLUGIN:PlayerRestoreCharacterData(player, data)
	data["sanity"] = data["sanity"] or 100;
end;

function PLUGIN:PostPlayerSpawn(player, lightSpawn, changeClass, firstSpawn)
	if (!firstSpawn and !lightSpawn) then
		player:SetCharacterData("sanity", 100);
	end;
end;

function PLUGIN:PlayerSetSharedVars(player, curTime)
	player:SetSharedVar( "sanity", math.Round( player:GetCharacterData("sanity") ) );
end;