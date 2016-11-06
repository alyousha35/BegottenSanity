local PLUGIN = PLUGIN;

function PLUGIN:PlayerSetDefaultColorModify(colorModify)
	local hunger = Clockwork.Client:GetSharedVar("sanity");
	if ( hunger >= 21 ) then
		colorModify["$pp_colour_brightness"] = 0;
		colorModify["$pp_colour_contrast"] = 1;
		colorModify["$pp_colour_colour"] = 1;
		colorModify["$pp_colour_addr"] = 0;
		colorModify["$pp_colour_addg"] = 0;
		colorModify["$pp_colour_addb"] = 0;
		colorModify["$pp_colour_mulr"] = 0;
		colorModify["$pp_colour_mulg"] = 0;
		colorModify["$pp_colour_mulb"] = 0;
	elseif ( hunger <= 20 ) then
		colorModify["$pp_colour_brightness"] = -0.15;
		colorModify["$pp_colour_contrast"] = 2;
		colorModify["$pp_colour_colour"] = 1;
		colorModify["$pp_colour_addr"] = 0;
		colorModify["$pp_colour_addg"] = 0;
		colorModify["$pp_colour_addb"] = 0;
		colorModify["$pp_colour_mulr"] = 0;
		colorModify["$pp_colour_mulg"] = 0;
		colorModify["$pp_colour_mulb"] = 0;
	else
		return
	end;
end;

function PLUGIN:GetBars(bars)
	local hunger = Clockwork.Client:GetSharedVar("sanity");
	if(hunger)then
		if (!self.hunger) then
			self.hunger = hunger;
		else
			self.hunger = math.Approach(self.hunger, hunger, 1);
		end;

		if ( hunger >= 61 ) then
			sanityText = "SANE"
		elseif ( hunger >= 60 ) then
			sanityText = "LOSING IT"
		elseif ( hunger >= 40 ) then
			sanityText = "INSANE"
		elseif ( hunger >= 20 ) then
			sanityText = "TWISTED"
		elseif ( hunger >= 10 ) then
			sanityText = "FUCKING TWISTED"
		elseif ( hunger <= 0 ) then
			sanityText = "ASCENDED"
		end;
		
		if ( hunger >= 100 ) then
			sanityColor = Color(60, 50, 110, 255);
		elseif ( hunger >= 60 ) then
			sanityColor = Color(76, 44, 89, 255); 
		elseif ( hunger >= 40 ) then
			sanityColor = Color(93, 38, 68, 255); 
		elseif ( hunger >= 20 ) then
			sanityColor = Color(109, 31, 46, 255);
		elseif ( hunger >= 10 ) then
			sanityColor = Color(125, 25, 25, 255);	
		elseif ( hunger <= 0 ) then
			sanityColor = Color(100, 0, 0, 255);	
		end;
		
		if ( hunger > 0 ) or ( hunger <= 0 ) then
			bars:Add("SANITY", sanityColor, sanityText, self.hunger, 100, self.hunger < 10);
		end;
	end;
end;

function PLUGIN:PlayerCanShowUnrecognised(player, x, y, color, alpha, flashAlpha)
	local sanity = player:GetSharedVar("sanity");
	if (sanity <= 30) then
		return "All you see is a worthless fucking pig ready to be slaughtered.";
	end;
end;

function HeartBeatSound() Clockwork.Client:EmitSound("begotten/heartbeat.wav", 75, 100, 1, CHAN_AUTO ) end;
function InsaneDrone1() Clockwork.Client:EmitSound("begotten/tone_alley_begotten.wav", 75, 90, 1, CHAN_AUTO ) end;
function InsaneDrone3() Clockwork.Client:EmitSound("begotten/choir.wav", 75, 80, 1, CHAN_AUTO ) end;
function InsaneDrone5() Clockwork.Client:EmitSound("begotten/citadel_ambient_scream.wav", 75, 70, 1, CHAN_AUTO ) end;

function PLUGIN:Think()
	local sanity = Clockwork.Client:GetSharedVar("sanity");
	if (Clockwork.Client:Alive()) then
		if (sanity >= 60) then
			timer.Create("InsaneDrone1", 19, 0, InsaneDrone1)
		end;
		if (sanity >= 30) then
			timer.Create("InsaneDrone3", 37, 0, InsaneDrone3)
		end;
		if (sanity >= 15) then
			timer.Create("InsaneDrone5", 17, 0, InsaneDrone5)
		end;
	else
		return
	end;
end;