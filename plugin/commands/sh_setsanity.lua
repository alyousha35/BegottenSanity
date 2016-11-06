local Clockwork = Clockwork;

local COMMAND = Clockwork.command:New("SetSanity");
COMMAND.tip = "Set a players Sanity level.";
COMMAND.text = "<string Name> [number Amount]";
COMMAND.flags = CMD_DEFAULT;
COMMAND.access = "s";
COMMAND.arguments = 1;
COMMAND.optionalArguments = 1;

-- Called when the command has been run.
function COMMAND:OnRun(player, arguments)
	local target = Clockwork.player:FindByID(arguments[1]);

	if (target) then
		local amount = arguments[2];
		if (!amount) then
			amount = 0;
		else
			amount = math.Clamp(tonumber(amount), 0, 100);
		end;

		target:SetCharacterData("sanity", amount);

		if (player != target)	then
			Clockwork.player:Notify(target, player:Name().." has set your sanity to "..amount..".");
			Clockwork.player:Notify(player, "You have set "..target:Name().."'s sanity to "..amount..".");
		else
			Clockwork.player:Notify(player, "You have set your own sanity to "..amount..".");
		end;
	else
		Clockwork.player:Notify(player, arguments[1].." is not a valid player!");
	end;
end;

COMMAND:Register();