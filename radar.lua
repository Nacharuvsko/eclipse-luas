--name Radar Hack
--desc Reveals enemies on radar
--author winston

local isEnabled

function onCreateMove(cmd)
    if not isEnabled then return end
    for i, ent in pairs(entitylist.getEntitiesByClassID(40)) do
        if ent:sane() then
            ent:setPropInt("DT_BaseEntity", "m_bSpotted", 1)
        end
    end
end

function onUI() 
    isEnabled = ui.checkbox("Enable", "lua_radarhack_switch")
end

-- Register le hooks
eclipse.registerHook("UI", onUI)
eclipse.registerHook("createMove", onCreateMove)