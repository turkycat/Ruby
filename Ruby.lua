Ruby = { };
Ruby.Version = 0.1;

local RubySettings = { };
RubySettings.Enabled = true;

RUBY_DEBUG = false;

function Ruby:Debug( msg )
    if RUBY_DEBUG then Ruby:Print( msg ) end
end


function Ruby:Print( text )
    if( DEFAULT_CHAT_FRAME ) then
	    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Ruby: |cffffffff"..text);
    elseif( ChatFrame1 ) then
        ChatFrame1:AddMessage("|cffff0000Ruby: |cffffffff"..text);
    end
end


function Ruby:RegisterForEvents()
    --RubyFrame:RegisterEvent("PLAYER_ENTERING_WORLD");
	--RubyFrame:RegisterEvent("VARIABLES_LOADED");
    RubyFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
end


function Ruby:UnregisterForEvents()
    RubyFrame:UnregisterEvent("PLAYER_REGEN_ENABLED");
end


function Ruby:SetEnabled( enabled )
    Ruby:Debug("SetEnabled called with " .. tostring( enabled ) .. " parameter");
    
    RubySettings.IsEnabled = enabled;
    Ruby:Print("Ruby is now " .. (RubySettings.IsEnabled and "enabled" or "disabled") .. " for this character." );
end


function Ruby:ProcessSlashCommand( msg )
    Ruby:Debug("ProcessSlashCommand called with msg parameter " .. tostring( msg ) .. " parameter");
    
    --TODO: print usage
    if not msg or msg == "" then return end
    
    --pattern matching that skips leading whitespace and whitespace between cmd and args
    --any whitespace at end of args is retained
    local i, j, cmd, args = string.find(msg, "%s?(%w+)%s?(.*)")
    Ruby:Debug("command message parsed. i = " .. tostring( i ) .. " j = " .. tostring( j ) .. " cmd = " .. tostring( cmd ) .. " args = " .. tostring( args ));
    
    if cmd == "enable" then
        Ruby:SetEnabled( true );
        Ruby:RegisterForEvents();
    elseif cmd == "disable" then
        Ruby:SetEnabled( false );
        Ruby:UnregisterForEvents();
    else
        Ruby:Print("Command "..cmd.." not understood.");
    end
end


function Ruby:OnRubyLoad()
    Ruby.Debug("OnRubyLoad called");
    
    Ruby.Print("version "..Ruby.Version.." loaded.");
    Ruby:Print("version "..Ruby.Version.." loaded.");
    Ruby:Debug("Ruby is "..(RubySettings.IsEnabled and "enabled" or "disabled").." for this character.");

	Ruby:RegisterForEvents();
    
    SLASH_RUBY1 = "/ruby";
    SlashCmdList["RUBY"] = function( msg )
        Ruby:ProcessSlashCommand( msg );
    end

end


function Ruby:OnRubyEvent( event )
    Ruby:Debug("OnRubyEvent called with event parameter: " .. tostring( event ));
    
    if not RubySettings.Enabled then
        Ruby.Debug("Ruby is disabled.");
        return;
    end
    
    --interestingly, the PLAYER_LEAVE_COMBAT event is not fired when a player runs from combat.
    --PLAYER_REGEN_ENABLED is fired whenever a character leaves combat for any reason, so we will use this for UI control.
    if event == "PLAYER_REGEN_ENABLED" then
        Ruby:Debug("the handled event was PLAYER_REGEN_ENABLED");
        
        if not GetItemCount("Mana Ruby") then
            Ruby:Print("You are missing a Mana Ruby! Don't forget to conjure another one.");
        end
        
        if not GetItemCount("Mana Citrine") then
            Ruby:Print("You are missing a Mana Citrine! Don't forget to conjure another one.");
        end
    else
        Ruby:Debug("the event "..event.." was not handled.");
    end
end