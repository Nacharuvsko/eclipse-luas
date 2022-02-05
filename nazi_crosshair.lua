--name m00n crosshair
--desc become a m00n with this lua $$$
--author winston

local ffi = require("ffi")
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

-- trigonometric functions
local function DEG2RAD(x) return x * math.pi / 180 end
local function RAD2DEG(x) return x * 180 / math.pi end

local function hsv2rgb(h, s, v, a)
    local r, g, b
 
    local i = math.floor(h * 6);
    local f = h * 6 - i;
    local p = v * (1 - s);
    local q = v * (1 - f * s);
    local t = v * (1 - (1 - f) * s);
 
    i = i % 6
 
    if i == 0 then r, g, b = v, t, p
    elseif i == 1 then r, g, b = q, v, p
    elseif i == 2 then r, g, b = p, v, t
    elseif i == 3 then r, g, b = p, q, v
    elseif i == 4 then r, g, b = t, p, v
    elseif i == 5 then r, g, b = v, p, q
    end
 
    return r * 999, g * 999, b * 999, a * 999
end

--[[
    Renders crosshair

    @param x - x position of crosshair
    @param y - y position of crosshair
    @param size - size of le crosshair
]]
local rainbow = 0.00
local rotationdegree = 0.000;
function crosshair(x, y, size) -- le trolleing starts here >:3
    local frametime = globals[0][0].frametime
    local a = (size / 100) + ui.getConfigFloat("lua_m00ncrosshair_size")
    local gamma = math.atan(a / a)

    if rotationdegree > 89 then rotationdegree = 0 end

    local color
    if ui.getConfigBool("lua_m00ncrosshair_rainbow") then
        color = draw.HSVtoColor((globals[0][0].tickcount % 128) / 128, 1, 1, 1)
    else 
        color = ui.getConfigCol("lua_m00ncrosshair_color")
    end

    for i = 0, 4 do
        local p_0 = (a * math.sin(DEG2RAD(rotationdegree + (i * 90))))
        local p_1 = (a * math.cos(DEG2RAD(rotationdegree + (i * 90))))
        local p_2 =((a / math.cos(gamma)) * math.sin(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))
        local p_3 =((a / math.cos(gamma)) * math.cos(DEG2RAD(rotationdegree + (i * 90) + RAD2DEG(gamma))))

        draw.line(
            Vec2(x, y), 
            Vec2(x + p_0, y - p_1), 
            color, 
            2
        )
        draw.line(
            Vec2(x + p_0, y - p_1), 
            Vec2(x + p_2, y - p_3), 
            color,
            2
        )
    end
    rotationdegree = rotationdegree + (frametime * 150)
end

--[[
    Draw callback
]]
local crossalpha = eclipse.getConvar("cl_crosshairalpha"):getFloat()
function onDraw()
    local screen = draw.getScreenSize()
   
    if not eclipse.isInGame() then
        return
    end
   
    if(ui.getConfigBool("lua_m00ncrosshair_switch")) then
        eclipse.clientCmd("cl_crosshairalpha 0")
        crosshair(screen.x / 2, screen.y / 2, screen.y / 2)
    else
        eclipse.clientCmd("cl_crosshairalpha " .. crossalpha)
    end
end

--[[
    UI Controls section
]]
function onUI() 
    ui.checkbox("m00n crosshair", "lua_m00ncrosshair_switch")
    ui.sliderFloat("scale", "lua_m00ncrosshair_size", 0, 100, "%.2f")
    ui.colorPicker("crosshair color", "lua_m00ncrosshair_color")
    ui.checkbox("rainbow", "lua_m00ncrosshair_rainbow")
end

--[[
    Restore le crosshair alpha 
]]
function onUnload()
    eclipse.clientCmd("cl_crosshairalpha " .. crossalpha)
end

--[[
    Callbacks Registration
]]
eclipse.registerHook("UI", onUI)
eclipse.registerHook("draw", onDraw)
eclipse.registerHook("unload", onUnload)