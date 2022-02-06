--name NiggerAPI
--desc Put it into .eclipse/scripts/libs/
--author winston

--[[
    Some things are pasted ;w;
    
    implement it by `require("libs/niggerapi")`
]]

NIGGER_API_VERSION = 1.1 -- le version of le NiggerAPI

-- Math sex
NULL = 0;
M_PI = 3.14159265358979323846;
M_180_PI = 0.0174533;
M_PI_180 = 57.2958;
INT_MAX = 2147483647;
INFINITE = math.huge;

-- Radians to degrees
function RAD2DEG(x)
	return (x * M_PI_180);
end

-- Regrees to radians
function DEG2RAD(x)  
	return (x * M_180_PI);
end

-- Calculate distance between 2 vectors
-- @param vFirst - first Vec2
-- @param vSecond - second Vec2
function Distance2D(vFirst, vSecond) 
	return ((vFirst.x - vSecond.x) ^ 2) + ((vFirst.y - vSecond.y) ^ 2);
end



--[[
    Paste go woo woo
]]
-- WeaponInfo_t
WEAPDATA_MAX_CLIP = 0x05;
WEAPDATA_MAX_RESERVED_AMMO = 0x09; -- Max clip 2
WEAPDATA_TYPE = 0x28;
WEAPDATA_COST = 0x34;
-- Here should be reward, but i have some issues with brain
-- WEAPDATA_UNK = 0x53;
WEAPDATA_DAMAGE = 0x60;
WEAPDATA_ARMORRATIO = 0x64; -- float
WEAPDATA_BULLETS = 0x68; -- I think, that's unused
WEAPDATA_PENETRATION = 0x72; -- float

-- MoveType_t
MOVETYPE_NONE = 0; -- Freezes the entity, outside sources can't move it. 
MOVETYPE_ISOMETRIC = 1; -- For players in TF2 commander view etc. Do not use this for normal players! 
MOVETYPE_WALK = 2; -- Default player (client) move type. 
MOVETYPE_STEP = 3; -- NPC movement 
MOVETYPE_FLY = 4; -- Fly with no gravity. 
MOVETYPE_FLYGRAVITY = 5; -- Fly with gravity. 
MOVETYPE_VPHYSICS = 6; -- Physics movetype (prop models etc.) 
MOVETYPE_PUSH = 7; -- No clip to world, but pushes and crushes things.
MOVETYPE_NOCLIP = 8; -- Noclip, behaves exactly the same as console command.
MOVETYPE_LADDER = 9; -- For players, when moving on a ladder. 
MOVETYPE_OBSERVER = 10; -- Spectator movetype. DO NOT use this to make player spectate. 
MOVETYPE_CUSTOM = 11; -- Custom movetype, can be applied to the player to prevent the default movement code from running, while still calling the related hooks
MOVETYPE_LAST = MOVETYPE_CUSTOM;
MOVETYPE_MAX_BITS = 4;

-- Buttons
IN_ATTACK   = 1;       --  (1 << 0)  -- Fire weapon
IN_JUMP 	= 2;       --  (1 << 1)  -- Jump
IN_DUCK     = 4;       --  (1 << 2)  -- Crouch
IN_FORWARD  = 8;       --  (1 << 3)  -- Walk forward
IN_BACK     = 16;      --  (1 << 4)  -- Walk backwards
IN_USE      = 32;      --  (1 << 5)  -- Use (Defuse bomb, etc...)
IN_CANCEL   = 64;      --  (1 << 6)
IN_LEFT     = 128;     --  (1 << 7)  -- Walk left
IN_RIGHT    = 256;     --  (1 << 8)  -- Walk right
IN_MOVELEFT = 512;     --  (1 << 9)
IN_MOVERIGHT= 1024;    --  (1 << 10)
IN_ATTACK2  = 2048;    --  (1 << 11) -- Secondary fire (Revolver, Glock change fire mode, Famas change fire mode), zoom
IN_RUN      = 4096;    --  (1 << 12)
IN_RELOAD   = 8192;    --  (1 << 13) -- Reload weapon
IN_ALT1     = 16384;   --  (1 << 14)
IN_ALT2     = 32768;   --  (1 << 15)
IN_SCORE    = 65536;   --  (1 << 16) -- Used by client.dll for when scoreboard is held down
IN_SPEED    = 131072;  --  (1 << 17) -- Player is holding the speed key
IN_WALK     = 262144;  --  (1 << 18) -- Player holding walk key
IN_ZOOM     = 524288;  --  (1 << 19) -- Zoom key for HUD zoom
IN_WEAPON1  = 1048576; --  (1 << 20) -- weapon defines these bits
IN_WEAPON2  = 2097152; --  (1 << 21) -- weapon defines these bits
IN_BULLRUSH = 4194304; --  (1 << 22)
IN_GRENADE1 = 8388608; --  (1 << 23) -- grenade 1
IN_GRENADE2 = 16777216;--  (1 << 24) -- grenade 2
IN_ATTACK3  = 33554432;--  (1 << 25)

-- EntityFlags
FL_ONGROUND  = 1;  -- (1 << 0), At rest / on the ground
FL_DUCKING   = 2;  -- (1 << 1), Player flag -- Player is fully crouched
FL_ANIMDUCKING=4;  -- (1 << 2), Player flag -- Player is in the process of crouching or uncrouching but could be in transition
--		                                       Fully ducked:  FL_DUCKING &  FL_ANIMDUCKING
--           Previously fully ducked, unducking in progress:  FL_DUCKING & !FL_ANIMDUCKING
--                                           Fully unducked: !FL_DUCKING & !FL_ANIMDUCKING
--           Previously fully unducked, ducking in progress: !FL_DUCKING &  FL_ANIMDUCKING
FL_WATERJUMP = 8;  -- (1 << 3), Player jumping out of water
FL_ONTRAIN   = 16; -- (1 << 4), Player is _controlling_ a train, so movement commands should be ignored on client during prediction.
FL_INRAIN	   = 32; -- (1 << 5), Indicates the entity is standing in rain
FL_FROZEN    = 64; -- (1 << 6), Player is frozen for 3rd person camera
FL_ATCONTROLS= 128;-- (1 << 7), Player can't move, but keeps key inputs for controlling another entity
FL_CLIENT	   = 256;-- (1 << 8), Is a player
FL_FAKECLIENT= 512;-- (1 << 9), Fake client, simulated server side; don't send network messages to them
-- NON-PLAYER SPECIFIC (i.e., not used by GameMovement or the client .dll ) -- Can still be applied to players, though
FL_INWATER = 1024; -- (1 << 10), // In water
