--name $kateboard
--desc noooo u cant just slide!!! - hehe, legs go woosh
--author winston

require("libs/niggerapi")

local isEnabled

function onCreateMove(cmd)

    cmd.buttons = bit.band(cmd.buttons, bit.bnot(IN_BACK))
    cmd.buttons = bit.band(cmd.buttons, bit.bnot(IN_FORWARD))
    cmd.buttons = bit.band(cmd.buttons, bit.bnot(IN_MOVELEFT))
    cmd.buttons = bit.band(cmd.buttons, bit.bnot(IN_MOVERIGHT))
    
    if isEnabled then 

        if cmd.forwardmove > 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_BACK)
        elseif cmd.forwardmove < 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_FORWARD)
        end

        if cmd.sidemove > 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_MOVELEFT)
        elseif cmd.sidemove < 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_MOVERIGHT)
        end
    else 
        if cmd.forwardmove > 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_FORWARD)
        elseif cmd.forwardmove < 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_BACK)
        end

        if cmd.sidemove > 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_MOVERIGHT)
        elseif cmd.sidemove < 0 then
            cmd.buttons = bit.bor(cmd.buttons, IN_MOVELEFT)
        end
    end

    eclipse.setCmd(cmd)
end

function onUI() 
    isEnabled = ui.checkbox("Enable $kateboarding", "lua_skateboard_switch")
end

eclipse.registerHook("UI", onUI)
eclipse.registerHook("createMove", onCreateMove)