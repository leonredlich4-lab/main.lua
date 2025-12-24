local http = game:GetService("HttpService")
local url = "https://ugntsrckpwlyyumsbncm.supabase.co/functions/v1/smooth-action"

local function executeAndTrack(scriptCode)
    -- Script ausführen
    local success, result = pcall(loadstring(scriptCode))
    
    -- Ergebnisse an Supabase senden
    local data = {
        scriptHash = game:GetService("HashService"):ComputeMD5Async(scriptCode),
        executionTime = os.time(),
        success = success,
        result = tostring(result),
        playerId = game.Players.LocalPlayer.UserId
    }
    
    pcall(function()
        http:PostAsync(url, http:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    
    return success, result
end
