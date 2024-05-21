local http = game:GetService("HttpService")

local function decompileScript(scriptObject)
    local code = scriptObject.Source
    local f, loadErr = loadstring(code)
    if f then
        local bytecode = string.dump(f)
        print("bytecode from:", scriptObject:GetFullName())
        print(bytecode)

        if bytecode:find("anticheat") then
            print("found anticheat on:", scriptObject:GetFullName())
            scriptObject:Destroy()
            return
        end

        local dexv4 = loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua", true))
        if dexv4 then
            dexv4()
        else
            print("failed to load dex v4")
        end
    else
        print("failed to load script", loadErr)
    end
end

local function decompileAllScripts()
    local descendants = game:GetDescendants()
    for _, obj in ipairs(descendants) do
        if obj:IsA("LocalScript") or obj:IsA("ModuleScript") then
            decompileScript(obj)
        end
    end
end

decompileAllScripts()
