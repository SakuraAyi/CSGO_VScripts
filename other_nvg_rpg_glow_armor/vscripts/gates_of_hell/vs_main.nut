/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

::script_main <- self;
DoIncludeScript("gates_of_hell/vs_message.nut", this);
DoIncludeScript("gates_of_hell/vs_precache.nut", this);
DoIncludeScript("gates_of_hell/vs_event.nut", this);
DoIncludeScript("gates_of_hell/vs_effects.nut", this);
::work <- true;

//Constants
Pi <- 3.14159265
TwoPi <- 6.2831853
HalfPi <- 1.5707963

Rad <- 0.01745329251994329576923690768489
Deg <- 57.295779513082320876798154814105

::g_lang <- 0;
::clientcommand <- null;
::servercommand <- null;
clientcommand = Entities.FindByClassname(null, "point_clientcommand");servercommand = Entities.FindByClassname(null, "point_servercommand");clientcommand == null ? clientcommand = Entities.CreateByClassname("point_clientcommand") : null;servercommand == null ? servercommand = Entities.CreateByClassname("point_servercommand") : null

::FontColor <- {
	White = (1).tochar()
	Red = (2).tochar()
	Purple = (3).tochar()
	Green = (4).tochar()
	LightGreen = (5).tochar()
	LimeGreen = (6).tochar()
	LightRed = (7).tochar()
	Grey = (8).tochar()
	Yellow = (9).tochar()
	LightBlue = (10).tochar()
	Blue = (11).tochar()
	DarkBlue = (12).tochar()
	DarkGrey = (13).tochar()
	Pink = (14).tochar()
	OrangeRed = (15).tochar()
	Orange = (16).tochar()
};
const MapInfo = "[MapInfo] ";

class EX
{
    function GetHitPosition (end) { local start; if (handle.GetClassname() == "player") start = handle.EyePosition(); else start = handle.GetOrigin(); local fraction = TraceLine( start, end, null ); local hitpos = start + ( end - start ) * fraction; DebugDrawLine( start, end, 255, 255, 255, false, 0.1 ); DebugDrawLine( hitpos - Vector(10, 0, 0), hitpos + Vector(10, 0, 0), 255, 0, 0, true, 0.1 ); DebugDrawLine( hitpos - Vector(0, 10, 0), hitpos + Vector(0, 10, 0), 0, 255, 0, true, 0.1 ); DebugDrawLine( hitpos - Vector(0, 0, 10), hitpos + Vector(0, 0, 10), 0, 0, 255, true, 0.1 ); return hitpos; }
    function GetPlayerByUserid () { local l_uid = handle; local l_ent; for (l_ent = Entities.First(); l_ent != null; l_ent = Entities.Next(l_ent)) { if (l_ent.GetClassname() == "player" || l_ent.GetClassname() == "cs_bot") { local l_plr = l_ent; local l_sc; if (l_plr.ValidateScriptScope()) l_sc = l_plr.GetScriptScope(); try { if ("userid" in l_sc) { if (l_sc.userid == l_uid) return l_plr; else continue; } } catch (e) { Msg("\n"+e); return null; } } } }
    function GetEntityByIndex () { local idx = handle; local ent; for (ent = Entities.First(); ent != null; ent = Entities.Next(ent)) { local l_index = ent.entindex(); if (l_index == idx) { return ent; } } }
	function GetIDByUserid (n)
	{
		local uid;
		local ent;
		for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
		{
			if (BaseVS(ent).IsPlayer())
			{
				local l_plr = ent;
				local l_sc;
				if (l_plr.ValidateScriptScope())
				    l_sc = l_plr.GetScriptScope();
				if ("userid" in l_sc)
				{
					uid = handle;
					if (l_sc.userid == uid)
					{
					    local table = getconsttable();
					    if (n==0)
					        return table[l_sc.userid.tostring()][0];
				    	else
					        return table[l_sc.userid.tostring()][1];
					}
				}
			}
		}
	}
    function IsAlive () { if (handle.GetHealth() > 0) return true; else return false; }
    function SetParent (target, ori = null, ang = null) { EntFireByHandle(handle, "SetParent", target.GetName().tostring(), 0.00, handle, handle); if (ori != null) EntFireByHandle(handle, "SetLocalOrigin", ori.tostring(), 0.00, handle, handle); if (ang != null) EntFireByHandle(handle, "SetLocalAngles", ang.tostring(), 0.00, handle, handle); }
    function SetParentAttachment (target, attach, t=0) { EntFireByHandle(handle, "SetParent", target.GetName().tostring(), 0.00, handle, handle); if (t==0) EntFireByHandle(handle, "SetParentAttachment", attach.tostring(), 0.01, handle, handle); else EntFireByHandle(handle, "SetParentAttachmentMaintainOffset", attach.tostring(), 0.01, handle, handle); }
    function SetAttached (target) { if (handle.GetClassname().find("ornament") > 0) EntFireByHandle(handle, "SetAttached", target.GetName().tostring(), 0.00, handle, handle); else return; }
    function SetModelScale (num) { EntFireByHandle(handle, "AddOutput", "modelscale " + num, 0.00, handle, handle); }
    function SetAnim (seq, delay = 0.00) { if ((typeof seq) == "integer") EntFireByHandle(handle, "AddOutput", "sequence " + seq, delay, handle, handle); else EntFireByHandle(handle, "SetAnimation", "" + seq, delay, handle, handle); }
    function SetRenderAmt (mode, amt, delay = 0.00) { EntFireByHandle(handle, "AddOutput", "rendermode "+mode, delay, handle, handle); EntFireByHandle(handle, "AddOutput", "randeramt "+amt, delay, handle, handle); }
    function PlaySndForClient (snd, delay = 0.00) { EntFireByHandle(clientcommand, "command", "play "+snd, delay, handle, clientcommand); }
    function PlaySound (snd, delay) { EntFireByHandle(handle, "AddOutput", "message "+snd, delay, null, null); EntFireByHandle(handle, "PlaySound", "", delay null, null); }
    function IsPlayer () { if (handle.GetClassname() == "player" || handle.GetClassname() == "cs_bot") return true; else return false; }
    function SetBodyGroup (param, delay = 0.00) { EntFireByHandle(handle, "SetBodyGroup", param.tostring(), delay, handle, handle); }
	function SetSkin (param, delay = 0.00) { EntFireByHandle(handle, "Skin", param.tostring(), delay, handle, handle); }
    function Kill (delay) { EntFireByHandle(handle, "KillHierarchy", "", delay, handle, handle); }
    function GetItem(wpn, delay = 0.00) { local eq = items.CreateEquip(wpn); EntFireByHandle(eq, "Use", "", delay, handle, eq); EntFireByHandle(eq, "Kill", "", delay, null, null); }
    function RandomNotRepeat (params) { local arr = params; local temp = {}; local newarr = []; local len = arr.len(); local i = 0; while (true) { local r = RandomInt(0, len-1); local rand = arr[r]; if (!(r.tostring() in temp)) { temp[r.tostring()] <- 1; newarr.push(rand); i++; if (i==len) { return newarr; } } } }
	function SetPlayerSpeed (n, s, d = 0.00) { local speedmod = script_event.GetScriptScope().RunPlayerSpeedMod(n); EntFireByHandle(speedmod, "ModifySpeed", s.tostring(), d, handle, speedmod); }
	function ShowhintForClient (type, msg, delay = 0.00)
	{
		local sc = script_event.GetScriptScope();
		if (type == 0)
			sc.ShowHudhint(handle, msg, delay);
		else
		   null;
	}
	function SetLocalOrigin (vector)
	{
		EntFireByHandle(handle, "SetLocalOrigin", vector.tostring(), 0.00, null, null);
	}
};

class ::BaseVS extends EX
{
    handle = null;
    constructor (handle)
        this.handle=handle;

    function SetKeyValue(key, value)
    {
        switch(typeof value)
        {
            case "float"     : handle.__KeyValueFromFloat(key, value);     break;
            case "integer"   : handle.__KeyValueFromInt(key, value);       break;
            case "string"    : handle.__KeyValueFromString(key, value);    break;
            case "Vector"    : handle.__KeyValueFromVector(key, value);    break;
            default          : return;
        }
    }

    function IO (output, target, intput, params, delay, max)
    {
        local l_line = output + " " + target + ":" + intput + ":" + params + ":" + delay + ":" + max;
        EntFireByHandle(handle, "addoutput", l_line.tostring(), 0.00, handle, handle);
    }
};

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

//=================//
//--Trace Helpers--//
//=================//

class TraceInfo
{
    constructor(h, d)
    {
        Hit = h;
        Dist = d;
    }

    Hit = null;
    Dist = null;
};

TraceDir <- function (orig, dir, maxd, filter)
{
    local frac = TraceLine(orig, orig+dir*maxd, filter);
    return TraceInfo(orig+(dir*(maxd*frac)), maxd*frac);
};