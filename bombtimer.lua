--name Bomb Timer
--desc A lua that indicates le bomb time until allah akbar
--author sekc & winston

local isEnabled
local lineColor

local ffi = require("ffi")

-- Get Globals
ffi.cdef([[
typedef struct {
    float realtime;
    int framecount;
    float absoluteframetime;
    float absoluteframestarttimestddev;
    float curtime;
    float frametime;
    int maxClients;
    int tickcount;
    float tickInterval;
    float interpolation_amount;
    int simTicksThisFrame;
    int network_protocol;
    void* pSaveData;
    bool m_bClient;
    bool m_bRemoteClient;
} Globals;
]])
local hudUpdate = ffi.cast("void***", memory.getInterface("./csgo/bin/linux64/client_client.so", "VClient"))[0][11]
local globals = ffi.cast("Globals**", memory.getAbsoluteAddress(tonumber(ffi.cast("uintptr_t", hudUpdate)) + 13, 3, 7))

function faded(x) 
    return Color(2 * x, 2 * (1 - x), 0, 255)
end

-- Some constants
local bombMaxTime = 40 -- time before le big boom boom

-- Draw hook
function onDraw()

    if not isEnabled then return end

    local screen_size = draw.getScreenSize()

    for i, ent in pairs(entitylist.getEntitiesByClassID(129)) do
        if ent:sane() then

            local time_to_defuse = ( globals[0][0].curtime - ent:getPropFloat( "DT_PlantedC4", "m_flDefuseCountDown" )) * -1
            local time_to_explosion = ( globals[0][0].curtime - ent:getPropFloat( "DT_PlantedC4", "m_flC4Blow") ) * -1
            local c4_blowtime_l = ent:getPropFloat( "DT_PlantedC4", "m_flTimerLength" )
            local defuser = ent:getPropFloat( "DT_PlantedC4", "m_hBombDefuser")
            local isDefused = ent:getPropInt( "DT_PlantedC4", "m_bBombDefused")
            local ticking = ent:getPropFloat( "DT_PlantedC4", "m_bBombTicking")
            
           -- print("ttd: " .. tostring(time_to_defuse))
           -- print("tte: " .. tostring(time_to_explosion))
           -- print("c4bt: " .. tostring(c4_blowtime_l))
           print(tostring(isDefused))
            

            if time_to_explosion > 0.0 and isDefused < 1 then

                local can_defuse = time_to_explosion > time_to_defuse
                draw.text(Vec2( screen_size.x * ( time_to_explosion / c4_blowtime_l ), 15), Color(255, 255, 255, 255), string.format( "%.1f", time_to_explosion ))

                local lineMainColor = faded((40 - time_to_explosion) / 40) -- sex ufff jaaaa $$$

                local text
                local textCol
                if can_defuse then
                    text = "Defuse"
                    textCol = Color(0, 255, 0, 255)
                else
                    text = "Run"
                    textCol = Color(255, 0, 0, 255)
                end

                if tostring(defuser) ~= "nan" then -- please kill me
                    draw.text(Vec2( screen_size.x / 2, screen_size.y / 2), textCol, text)
                end

                draw.filledRectangle( Vec2( 0, 0 ), Vec2( screen_size.x, 15 ), lineColor )
		        draw.filledRectangle( Vec2( 0, 0 ), Vec2( screen_size.x * ( time_to_explosion / c4_blowtime_l ), 15 ), lineMainColor )
            end
        end
    end
end

function onUI()
    isEnabled = ui.checkbox("Enable", "lua_bombtimer_switch")
    lineColor = ui.colorPicker("Line Background Color", "lua_bombtimer_linebg")
end

-- register le hooks
eclipse.registerHook("UI", onUI)
eclipse.registerHook("draw", onDraw)