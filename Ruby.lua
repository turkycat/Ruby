Ruby = { }
Ruby.Version = 0.1

RUBY_DEBUG = true

function Ruby.Debug( msg )
    if RUBY_DEBUG then Ruby.Print( msg ) end
end

function Ruby.Print( text )
    if( DEFAULT_CHAT_FRAME ) then
	    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Ruby: |cffffffff"..text);
    elseif( ChatFrame1 ) then
        ChatFrame1:AddMessage("|cffff0000Ruby: |cffffffff"..text);
    end
end

function Ruby:OnRubyLoad()
    Ruby.Debug("OnRubyLoad called");
    
    Ruby.Print("version "..Ruby.Version.." loaded.");

	--RubyFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
	--RubyFrame:RegisterEvent("VARIABLES_LOADED")
    RubyFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
    
    SLASH_RUBY1 = "/ruby";
    SlashCmdList["RUBY"] = function(msg)
        Ruby.Print("you have passed the command \""..msg.."\"");
    end

end

function Ruby:OnRubyEvent( event )
    Ruby.Debug("OnRubyEvent called");
    
    --interestingly, the PLAYER_LEAVE_COMBAT event is not fired when a player runs from combat.
    --PLAYER_REGEN_ENABLED is fired whenever a character leaves combat for any reason, so we will use this for UI control.
    if event == "PLAYER_REGEN_ENABLED" then
        Ruby.Debug("the handled event was PLAYER_REGEN_ENABLED");
        
        if not GetItemCount("Mana Ruby") then
            Ruby.Print("You are missing a Mana Ruby! Don't forget to conjure another one.");
        end
        
        if not GetItemCount("Mana Citrine") then
            Ruby.Print("You are missing a Mana Citrine! Don't forget to conjure another one.");
        end
    else
        Ruby.Debug("the event "..event.." was not handled.");
    end
end