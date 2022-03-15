//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

Pi <- 3.14159265
TwoPi <- 6.2831853
HalfPi <- 1.5707963

Rad <- 0.01745329251994329576923690768489
Deg <- 57.295779513082320876798154814105

//==================//
//--Math Functions--//
//==================//
//Distance between the x/y components of two 3D vectors.
function Distance2D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	
	return sqrt((a*a)+(b*b));
}

//Distance between two 3D vectors.
function Distance3D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	local c = (v2.z-v1.z);
	
	return sqrt((a*a)+(b*b)+(c*c));
}

//Return the Pitch and Yaw between two 3D vectors.
function AngleBetween(v1,v2)
{
		local aZ = atan2((v1.y - v2.y),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),Distance2D(v1,v2))+Pi;
		
		return Vector(aY,aZ,0.0);
}

function AngleBetween2(v1,v2)
{
		local aZ = atan2((v1.z - v2.z),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),(v1.y - v2.y))+Pi;
		
		return Vector(aY,aZ,0.0);
}

//Returns the difference between two angles
//actionsnippet.com/?p=1451
function AngleDiff(angle0,angle1)
{
    return (abs((angle0 + Pi -  angle1)%(Pi*2.)) - Pi);
}

//Normalizes a vector
function Normalize(v)
{
	local len = v.Length();
	return Vector(v.x/len,v.y/len,v.z/len);
}

//Cross product of two vectors
function Cross(v1, v2) 
{
	local v = Vector(0.0,0.0,0.0);
	v.x = ( (v1.y * v2.z) - (v1.z * v2.y) );
	v.y = ( (v1.x * v2.z) - (v1.z * v2.x) );
	v.z = ( (v1.x * v2.y) - (v1.y * v2.x) );
	return v;
}

//Constrain a number to a given range
function clamp(v,mi,ma)
{
	if(v < mi) return mi;
	if(v > ma) return ma;
	return v;
}

//Return the biggest of two numbers.
function max(v1,v2)
{
	if(v1 > v2) return v1;
	return v2;
}

//Return the smallest of two numbers.
function min(v1,v2)
{
	if(v1 < v2) return v1;
	return v2;
}
//Vector multiplication fix
function Mul(v1,v2)
{
	local typ = typeof(v2);
	
	//Vector * Scalar
	if(typ == "integer" || typ == "float")
	{
		return Vector(v1.x*v2,v1.y*v2,v1.z*v2);
	}
	//Vector * Vector
	if(typ == "Vector")
	{
		return Vector(v1.x*v2.x,v1.y*v2.y,v1.z*v2.z);
	}
	return null;
}

//=================//
//--Trace Helpers--//
//=================//
/*class TraceInfo 
{
	constructor(h,d)
	{
		Hit = h;
		Dist = d;
	}

	Hit = null;
	Dist = null;
}
//Returns the hit position of a trace between two points.
function TraceVec(start, end, filter)
{
	local dir = (end-start);
	local frac = TraceLine(start,end,filter);
	//return start+(dir*frac);
	return TraceInfo(start+(dir*frac),dir.Length());
}
//Returns the hit position of a trace along a normalized direction vector.
function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0) { return TraceInfo(orig+(dir*maxd),0.0);}
	return TraceInfo(orig+(dir*(maxd*frac)),maxd*frac);
}*/

//=================//
//--Debug Helpers--//
//=================//

//Draws a cross showing the X, Y, and Z axes.
function DrawAxis(pos,s,nocull,time)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}

//Draw the bounding box of a given entity.
function DrawEntityBBox(ent,r,g,b,a,time)
{
	DebugDrawBox(ent.GetOrigin(),ent.GetBoundingMins(), ent.GetBoundingMaxs(), r, g, b, a, time)
}

//Draws a line along a given normal.
function DrawNormal(pos,norm,s,time)
{
	local ns = norm*s;
	DebugDrawLine(Vector(pos.x,pos.y,pos.z), Vector(pos.x+ns.x,pos.y+ns.y,pos.z+ns.z), 0, 255, 255, false, time);	
}

::VS <- 
{
    function SendToServer (param)
    {
        EntFire("servercommand", "command", param);
        printl(param);
    },
    function GiveEquip (entity, param)
    {
        local eq = Entities.CreateByClassname( "game_player_equip" );
        eq.__KeyValueFromInt("spawnflags", 5);
        eq.__KeyValueFromInt(param, 1);
        EntFireByHandle(eq, "Use", "", 0.00, entity, eq);
        EntFireByHandle(eq, "Kill", "", 0.00, null, null);
    },
    function SendMsgToPlayer (entity, param)
    {
        local ent = Entities.CreateByClassname("env_message");
        ent.__KeyValueFromString("message", param);
        EntFireByHandle(ent, "ShowMessage", "", 0.00, entity, null);
    },
    function SetSpeed (entity ,mod, param)
    {

        for ( local i = 0; i < _speedmod.len(); i++ )
        {
            if ( i == mod )
                EntFireByHandle(::_speedmod[i], "ModifySpeed", param.tostring(), 0.01, entity, null);
            else
                EntFireByHandle(::_speedmod[i], "ModifySpeed", "1.0", 0.00, entity, null);
        }
    },
    function PlayClientSnd (entity, param)
    {
        EntFire("clientcommand", "command", "Play "+param, 0.00, entity);
    },
    function PlayPosSnd (vec,param,vol,delay)
    {
        local ent = Entities.FindByName(null, "map_world_sound");
        ent.__KeyValueFromString("message", param);
        ent.SetOrigin(vec);
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", vol.tostring(), 0.00, null, null);
    },
    function SetAni (entity, param)
    {
        EntFireByHandle(entity, "SetAnimation", param, 0.00, null, null);
    }

    function EntIO (entitiy,output,target,input,param,delay,max) {

    local line = output+" "+target+":"+input+":"+param+":"+delay+":"+max;
    EntFireByHandle(entitiy, "AddOutput", line, 0.00, null, null);
    }

    //ScriptPrintMessageChatAll("I/O Load");

};

LoadCmd <- function () {

};
//LoadCmd();

::m_lang <- 0;
//::ChangeLanguage <- function () { if (m_lang == 1) { m_lang = 0; ScriptPrintMessageChatAll("\x01 \x05 地图已更改语言为中文"); brushtext(0); } else { m_lang = 1; ScriptPrintMessageChatAll("\x01 \x05 Changed to English"); brushtext(1); } for ( local i = 0; i < Player.len(); i++ ) { if ( Player[i][0] != null && Player[i][0].IsValid() ) ::Charachter_info(i); } }

function Precache() {
    printl("预缓存...");
}

::neg <- function (param) {
    
    local a = param;
    local b = a - (a * 2);
    
    if (param <= 0)

    return a;

    else

    return b;

}

::GetPlayerByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        return user;
                        break;
                    }
                }
            }
        }
    }
}

::GetNameByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        local tb = getconsttable();
                        return tb[user.GetScriptScope().userid];
                    }
                }
            }
        }
    }
}

::Get32IDByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        local tb = getconsttable();
                        return tb[user.GetScriptScope().userid.tostring()];
                    }
                }
            }
        }
    }
}

::CreateSpeedTri <- function () { local ent = null; while ((ent = Entities.FindByClassname(ent, "player_speedmod")) != null) { if (ent.IsValid()) { ent.Destroy(); } } EntFire("Script", "RunScriptCode", "CreateSpeed_delay()", 1.00); }
::_speedmod <- [null, null, null];
CreateSpeed_delay <- function () { local ent = Entities.CreateByClassname("player_speedmod"); local name = "Player_SpeedMod_"; ent.__KeyValueFromString("targetname", name); local ent_limit = Entities.CreateByClassname("player_speedmod"); local name_limit = "Player_SpeedMod_limit"; ent_limit.__KeyValueFromString("targetname", name_limit); ent_limit.__KeyValueFromInt("spawnflags",13); local ent_limit_2 = Entities.CreateByClassname("player_speedmod"); local name_limit_2 = "Player_SpeedMod_limit_2"; ent_limit_2.__KeyValueFromString("targetname", name_limit_2); ent_limit_2.__KeyValueFromInt("spawnflags",12); DoEntFire("!self", "RunScriptCode", "RegSpeedMod()", 0.10, self, self); };
RegSpeedMod <- function () { local ent; for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) ) { if ( ent.GetName() == "Player_SpeedMod_" ) ::_speedmod[0] = ent; else if ( ent.GetName() == "Player_SpeedMod_limit" ) ::_speedmod[1] = ent; else if ( ent.GetName() == "Player_SpeedMod_limit_2" ) ::_speedmod[2] = ent; } }
