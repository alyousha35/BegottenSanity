--[[
	© 2013 CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local COMMAND = Clockwork.command:New("Suicide");
COMMAND.tip = "Commit suicide.";
COMMAND.flags = CMD_DEFAULT;
COMMAND.arguments = 0;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local thirdPerson = "him";
	local gender = "He";
	local possessive = "his";
	local selfless = "himself";
	if (player:GetSharedVar("tied") == 0) then
	
	if (player:GetGender() == GENDER_FEMALE) then
		thirdPerson = "her";
		gender = "She";
		possessive = "her";
		selfless = "herself";
	end;
		Clockwork.player:Notify(player, "You have ended your pitiful fucking existence!");
		
		local SuicideMethods = 
		{
			"pulls a makeshift shiv out of "..possessive.." pocket and sticks it in "..possessive.." fucking neck.",
			"pulls out a fucking gun and shoots "..selfless.." in the fucking face.",
			"pulls a makeshift shiv out of "..possessive.." pocket and gouges it into both of "..possessive.." fucking eyes.",
			"pulls a makeshift shiv out of "..possessive.." pocket and plunges it deep into "..possessive.." god damn stomach.",
			"places "..possessive.." hands on "..possessive.." neck and twists it until it fucking snaps.",
			"pulls out a knife and cuts out "..possessive.." tongue. "..gender.." would then stuff it down "..possessive.." fucking throat, and would quickly suffocate "..selfless.." before falling over and dying.",
			"picks up a chunk of rubble off the ground. "..gender.." would then smash it into "..possessive.." fucking head, falling over and dying within a couple strikes."
		}
		
		Clockwork.chatBox:AddInTargetRadius(player, "me", table.Random(SuicideMethods), player:GetPos(), Clockwork.config:Get("talk_radius"):Get() * 2);
		
		player:Kill();

	else
		Clockwork.player:Notify(player, "You cannot do this right now!");
	end;
end;

COMMAND:Register();