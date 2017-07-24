Ruby = { }
Ruby.Version = 0.1

function Ruby.PrintDefault( text )
    if( DEFAULT_CHAT_FRAME ) then
	    DEFAULT_CHAT_FRAME:AddMessage("|cffff0000Ruby: |cffffffff"..text);
    end
end


function Ruby:OnRubyLoad()
    --print("Ruby OnRubyLoad called");
    --self:Print("Ruby OnRubyLoad called");
    --self:print("Ruby OnRubyLoad called");
    
    Ruby.PrintDefault("version "..Ruby.Version.." loaded.");

	--Ruby:RegisterEvent("PLAYER_ENTERING_WORLD")
	--Ruby:RegisterEvent("VARIABLES_LOADED")
    RubyFrame:RegisterEvent("PLAYER_REGEN_ENABLED");
    
    SLASH_RUBY1 = "/ruby";
    SlashCmdList["RUBY"] = function(msg)
        Ruby.PrintDefault("you have passed the command \""..msg.."\"");
    end

end


function Ruby:OnRubyEvent( event )
    --Ruby.PrintDefault("OnRubyEvent called");
    
    if event == "PLAYER_REGEN_ENABLED" then
        --Ruby.PrintDefault("the event was PLAYER_REGEN_ENABLED");
        
        if not GetItemCount("Mana Ruby") then
            Ruby.PrintDefault("You are missing a Mana Ruby! Don't forget to conjure another one.");
        end
        
        if not GetItemCount("Mana Citrine") then
            Ruby.PrintDefault("You are missing a Mana Citrine! Don't forget to conjure another one.");
        end
    else
        --Ruby.PrintDefault("the event was not PLAYER_REGEN_ENABLED");
    end
end