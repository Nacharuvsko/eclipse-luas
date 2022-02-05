--name Hands Changer
--desc changes your hands wow
--author winston

local cvar_hands = eclipse.getConvar("r_skin")

function onUI()
    ui.label("SEKC PLEACE ADD FUCKING COMBOBOX THANKS)))) :3 :D:D :P")
    if ui.button("None") then cvar_hands:setInt(0) end
    if ui.button("Nigger") then cvar_hands:setInt(1) end
    if ui.button("Dark") then cvar_hands:setInt(2) end
    if ui.button("Asian") then cvar_hands:setInt(3) end
    if ui.button("Red") then cvar_hands:setInt(4) end
    if ui.button("Tatoo") then cvar_hands:setInt(5) end
end

eclipse.registerHook("UI", onUI)