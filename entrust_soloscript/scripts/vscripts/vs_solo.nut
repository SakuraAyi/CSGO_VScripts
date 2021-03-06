//Squirrel
/*
----Copyright (c) 2021 SakuraAyi(11)
----Language Squirrel
----For Counter-Strike:Global Offensive Vscript

----My Bilibili link -> https://space.bilibili.com/2601958
----My Weibo link -> https://weibo.com/u/5239535121
----My QQ Group -> 547256416

 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
*/

Pi <- 3.14159265;
TwoPi <- 6.2831853;
HalfPi <- 1.5707963;

Rad <- 0.01745329251994329576923690768489;
Deg <- 57.295779513082320876798154814105;

SECOND <- 0;

SCRIPT_MODE_SWITCH <- false;
//触发 -> 对脚本实体输入RunScriptCode - Selection() 即可运行；
//WAITINGROOM <- null;
SCRIPT_MAP_INFO <- "地图信息";
SCRIPT_SET_PLAYER_WEAPON <- "weapon_deagle" /**单挑玩家所规定使用的武器 不需要可进行清空@class */
SCRIPT_SET_PLAYER_WEAPON2 <- "" //同上，可多添加一个装备
SCRIPT_SET_PLAYER_WEAPON3 <- "" //同上
SCRIPT_TERRORIST_SPAWNPOS <- Vector(-2064,-1496,48); /**@T 阵营一人入选后进入的位置坐标；@xyz */
SCRIPT_TERRORIST_YAW <- 90; /**@T 入选后的位置位置朝向 @param int */
SCRIPT_COUNTER_STRIKE_SPAWNPOS <- Vector(-2064,-568,48); /**@CT 阵营一人入选后进入的位置坐标；@xyz */
SCRIPT_COUNTER_STRIKE_YAW <- -90; /**@CT 入选后的位置位置朝向 @param int */
SCRIPT_PLAYER_HEALTH <- 100; /**玩家的生命值，入选对局后生效 @param int*/
SCRIPT_PLAYER_DEATH_EFFECT <- ""; //玩家死后播放的特效 类型为sprite,清空可关闭，清空例：""

SCRIPT_SOLO_TIMELIMIT <- 20; /**solo的时间限制，时间结束后如果两个都没有击败对方，处死双方。@unit 秒（/s） */
SCRIPT_KILL_PLAYER_DAMAGE <- 99999; //处死玩家时候的伤害值

SCRIPT_TERRORIST_FAILSOUND <- //T阵营一人被击败后将会播放的音效 例：voice/xx.mp3，随机性，可在下方新增, 清空列表后关闭，如需清空只需要删除下面所有行即可
[
    "pudding/ni_qi_bu_qi.mp3",
    "pudding/wan_bu_liao_la.mp3",
    "pudding/zou_hao_bu_song.wav",
    "pudding/ceeeb.wav"
]; 
SCRIPT_TERRORIST_FAILTEXT <- //T阵营一人被击败后将会显示的信息，随机性，可在下方新增, 清空列表后关闭，如需清空只需要删除下面所有行即可
[
    "匪方被击倒一人！",
    "警方拿一分！",
    "匪方下一位！"
];

SCRIPT_COUNTER_STRIKE_FAILSOUND <- //CT阵营一人被击败后将会播放的音效，随机性，可在下方新增, 清空列表后关闭，如需清空只需要删除下面所有行即可
[
    "pudding/ni_qi_bu_qi.mp3",
    "pudding/wan_bu_liao_la.mp3",
    "pudding/zou_hao_bu_song.wav",
    "pudding/ceeeb.wav"
];
SCRIPT_COUNTER_STRIKE_FAILTEXT <- //CT阵营一人被击败后将会显示的信息，随机性，可在下方新增, 清空列表后关闭，如需清空只需要删除下面所有行即可
[
    "警方被击倒一人！",
    "匪方拿一分！",
    "警方下一位！"
];

SCRIPT_EFFECT_AMBIENT <- "player/halloween/ghost_impact_c_0";

FontColor <- 
{
    White = (1).tochar(),Red = (2).tochar(),Purple = (3).tochar(),Green = (4).tochar(),
	LightGreen = (5).tochar(),LimeGreen = (6).tochar(),LightRed = (7).tochar(),Grey = (8).tochar(),
	Yellow = (9).tochar(),LightBlue = (10).tochar(),Blue = (11).tochar(),DarkBlue = (12).tochar(),
	DarkGrey = (13).tochar(),Pink = (14).tochar(),OrangeRed = (15).tochar(),Orange = (16).tochar()
};
g_mapinfo <- "["+FontColor.Yellow+SCRIPT_MAP_INFO+FontColor.White+"]";
ChatMsg <- function (param, msg){local team = param;if ( team != 0 )ScriptPrintMessageChatTeam(team, msg);else ScriptPrintMessageChatAll(msg);};

function OnPostSpawn()
{
    //WAITINGROOM = Entities.FindByName(null, "1v1.deagle-target_1");
    //local num =  SCRIPT_TERRORIST_FAILSOUND.len() - (SCRIPT_TERRORIST_FAILSOUND.len() - SCRIPT_COUNTER_STRIKE_FAILSOUND.len())
    if (SCRIPT_TERRORIST_FAILSOUND.len() != 0){for (local i = 0; i < SCRIPT_TERRORIST_FAILSOUND.len() ; i++){self.PrecacheSoundScript(SCRIPT_TERRORIST_FAILSOUND[i]);}}
    if (SCRIPT_COUNTER_STRIKE_FAILSOUND.len() != 0){for (local i = 0; i < SCRIPT_COUNTER_STRIKE_FAILSOUND.len(); i++){self.PrecacheSoundScript(SCRIPT_COUNTER_STRIKE_FAILSOUND[i]);}}
    //if (SCRIPT_EFFECT_AMBIENT != "")for (local i = 1; i <= 5; i++){self.PrecacheSoundScript(SCRIPT_EFFECT_AMBIENT+i+".wav");}}
    local ent;
    for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
    {
        if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot")
        {
            local plr = ent;
            if (plr.ValidateScriptScope())
            {
                local sc = plr.GetScriptScope();
                if ( "soloact" in sc )
                    sc.soloact <- false;
            }
        }
    }
};

IsAlive <- function (user)
{
    try
    {
        if (user.GetTeam() != 1 && user.GetHealth() > 0 && user.IsValid())
            return true;
        else
            return false;
    }
    catch (e)
    {
        errorpass = true;
        printl("an error has occurred. please check the console");
        printl(e.tostring());
        __DumpScope(3, e);
        return false;
    }
};
DelWPN <- function (){local ent;while ((ent = Entities.FindByClassname(ent, "*")) != null){if (ent.GetClassname().find("weapon") != null)
{if (ent.GetMoveParent() == null)ent.Destroy();}}};
GetItem <- function (user){local ne = [];local eq = Entities.CreateByClassname("game_player_equip");eq.__KeyValueFromInt("spawnflags", 3);
SCRIPT_SET_PLAYER_WEAPON != "" ? (ne.push(SCRIPT_SET_PLAYER_WEAPON),eq.__KeyValueFromInt(SCRIPT_SET_PLAYER_WEAPON, 1)) : null;SCRIPT_SET_PLAYER_WEAPON2 != "" ? (ne.push(SCRIPT_SET_PLAYER_WEAPON2),eq.__KeyValueFromInt(SCRIPT_SET_PLAYER_WEAPON2, 1)) : null;
SCRIPT_SET_PLAYER_WEAPON3 != "" ? (ne.push(SCRIPT_SET_PLAYER_WEAPON3),eq.__KeyValueFromInt(SCRIPT_SET_PLAYER_WEAPON3, 1)) : null;
DoEntFire("!self", "Use", "", 0.00, user, eq);DoEntFire("!self", "Kill", "", 0.00, null, eq);
for (local i = 0;i < ne.len(); i++){if (ne[i].find("fists") != null){EntFire("weapon_fists", "AddOutput", "classname weapon_knifegg");break;}}};
CreateEffect <- function (start,end){local spr = Entities.CreateByClassname("env_sprite");
spr.__KeyValueFromInt("spawnflags", 1);spr.__KeyValueFromInt("rendermode", 8);spr.__KeyValueFromInt("renderamt", 30);spr.__KeyValueFromString("rendercolor", "255 255 255");
spr.__KeyValueFromString("model", "");spr.__KeyValueFromInt("GlowProxySize", 64);spr.PrecacheModel(SCRIPT_PLAYER_DEATH_EFFECT);spr.SetModel(SCRIPT_PLAYER_DEATH_EFFECT);
start.z -= 32;spr.SetOrigin(start);
local dist = start.z - end.z;
local delay = 0.00;for (local i = 0; i < abs(dist); i++){delay += 0.03;DoEntFire("!self", "AddOutput", "origin " + start.x + " " + start.y + " " + (start.z+(i+1)), delay, null, spr);}
DoEntFire("!self", "Kill", "", delay, null, spr);};
KillPlayer <- function (){local tgn = "execute";local plr;for (local i = 0; i < arena.len(); i++){if (arena[i] != null){plr = arena[i];plr.__KeyValueFromString("targetname", tgn);
EntFireByHandle(plr, "AddOutput", "targetname ", 0.30, null, null);}}
local hurt = Entities.CreateByClassname("point_hurt");
hurt.__KeyValueFromInt("DamageRadius", -1);hurt.__KeyValueFromInt("DamageType", 0);
hurt.__KeyValueFromInt("Damage", SCRIPT_KILL_PLAYER_DAMAGE);hurt.__KeyValueFromString("DamageTarget", tgn);
EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);EntFireByHandle(hurt, "Kill", "", 0.00, null, null);};

arena <- [null,null];
ts <- [];
cts <- [];
fight <- false;
Selection <- function ()
{
    if (!SCRIPT_MODE_SWITCH)
        SCRIPT_MODE_SWITCH = true;
    SECOND = 0;
    fight = true;

    ts.clear();cts.clear();
    local ent,plr;

    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {
        if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot")
        {
            plr = ent;
            if (IsAlive(plr))
            {
                if (plr.ValidateScriptScope())
                {
                    local sc = plr.GetScriptScope();
                    if (!("soloact" in sc))
                        sc.soloact <- false;
                    else
                    {
                        if (sc.soloact)
                            continue;
                    }
                }
                if (plr.GetTeam() == 2)
                    ts.push(plr);
                else
                    cts.push(plr);
                
            }
        }
    }

    local tplr,ctplr;
    if (ts.len() != 0 && arena[0] == null)
    {
        local r1 = RandomInt(0, ts.len() - 1);
        tplr = ts[r1];
        arena[0] = tplr;
        tplr.GetScriptScope().soloact <- true;
        ts.remove(r1);
    }
    arena[0] != null ? tplr = arena[0] : null;

    if (cts.len() != 0 && arena[1] == null)
    {
        local r2 = RandomInt(0, cts.len() - 1);
        ctplr = cts[r2];
        arena[1] = ctplr;
        ctplr = arena[1];
        ctplr.GetScriptScope().soloact <- true;
        cts.remove(r2);
    }
    arena[1] != null ? ctplr = arena[1] : null;

    if (tplr != null && ctplr != null){tplr.SetOrigin(SCRIPT_TERRORIST_SPAWNPOS);tplr.SetAngles(0, SCRIPT_TERRORIST_YAW, 0);
    tplr.SetMaxHealth(SCRIPT_PLAYER_HEALTH),tplr.SetHealth(SCRIPT_PLAYER_HEALTH);
    GetItem(tplr);
    ctplr.SetOrigin(SCRIPT_COUNTER_STRIKE_SPAWNPOS);ctplr.SetAngles(0, SCRIPT_COUNTER_STRIKE_YAW, 0);
    ctplr.SetMaxHealth(SCRIPT_PLAYER_HEALTH),ctplr.SetHealth(SCRIPT_PLAYER_HEALTH);GetItem(ctplr);}
};

errorpass <- false;
Think <- function ()
{
    if (!SCRIPT_MODE_SWITCH)return;
    if (fight)
        SECOND++;
    if (SECOND%(SCRIPT_SOLO_TIMELIMIT*10) == 0)
    {
        SECOND = 0;
        KillPlayer();
    }
    DelWPN();

    for (local i = 0; i < arena.len(); i++)
    {
        if (arena[i] != null)
        {
            local plr = arena[i];
            if (!IsAlive(plr))
            {
                arena[i] = null;
                local text = "";
                if (!errorpass)
                {
                    if (plr.GetTeam() == 2)
                    {
                        if (SCRIPT_TERRORIST_FAILTEXT.len() != 0)
                            text = FontColor.Blue + SCRIPT_TERRORIST_FAILTEXT[RandomInt(0, SCRIPT_TERRORIST_FAILTEXT.len() - 1)];
                        if (SCRIPT_TERRORIST_FAILSOUND.len() != 0)
                            self.EmitSound(SCRIPT_TERRORIST_FAILSOUND[RandomInt(0, SCRIPT_TERRORIST_FAILSOUND.len() - 1)]);
                    }
                    else
                    {
                        if (SCRIPT_COUNTER_STRIKE_FAILTEXT.len() != 0)
                            text = FontColor.Orange + SCRIPT_COUNTER_STRIKE_FAILTEXT[RandomInt(0, SCRIPT_COUNTER_STRIKE_FAILTEXT.len() - 1)];
                        if (SCRIPT_COUNTER_STRIKE_FAILSOUND.len() != 0)
                            self.EmitSound(SCRIPT_COUNTER_STRIKE_FAILSOUND[RandomInt(0, SCRIPT_COUNTER_STRIKE_FAILSOUND.len() - 1)]);
                    }
                    if (text != "")
                        ChatMsg(0,g_mapinfo+" "+text);
                }
                fight = false;
                DoEntFire("!self", "RunScriptCode", "Selection()", 1.00, self, self);
                if (errorpass)errorpass = false;
                try
                {
                    local sc = plr.GetScriptScope();
                    sc.soloact <- false;
                    if (SCRIPT_PLAYER_DEATH_EFFECT != "")CreateEffect(plr.GetOrigin(),plr.EyePosition());
                    local r = RandomInt(1,5);
                    //plr.EmitSound(SCRIPT_EFFECT_AMBIENT+r+".wav");
                }
                catch (e)
                {
                    printl("an error has occurred. please check the console");
                    printl(e.tostring());
                    __DumpScope(3, e);
                    return;
                }
            }
        }
    }
};

if("VS"in::getroottable()&&typeof::VS=="table"&&"MAX_COORD_FLOAT"in::getroottable()&&!::VS._reload&&::ENT_SCRIPT.IsValid())return;;local _v2=function(){}local _f=_v2.getinfos().src;_f=_f.slice(0,_f.find(".nut"));if(this!=::getroottable())return::DoIncludeScript(_f,::getroottable());;if(_f!="vs_library")::print("Loading vs_library...\n");;local PORTAL2="CPortal_Player"in::getroottable()&&"TurnOnPotatos"in::CPortal_Player&&::CPortal_Player.TurnOnPotatos.getinfos().native;local EVENTS=::Entities.FindByClassname(null,"logic_eventlistener")?true:false;::VS<-{Log={enabled=false,export=false,file_prefix="vs.log",filter="VL",L=[]},_reload=false}{local a=["split","print","_floatsize_","exp","seterrorhandler","assert","atan2","_charsize_","asin","atan","cos","PI","strip","newthread","lstrip","format","rstrip","acos","abs","_intsize_","collectgarbage","setroottable","enabledebuginfo","setdebughook","ceil","log10","RAND_MAX","rand","srand","suspend","compilestring","sqrt","floor","getstackinfos","log","fabs","dummy","getroottable","tan","array","_version_","setconsttable","sin","getconsttable","pow","type","regexp"];local b=["DispatchOnPostSpawn","self","__vname","PrecacheCallChain","OnPostSpawnCallChain","__vrefs","DispatchPrecache","OnPostSpawn","PostSpawn","Precache","PreSpawnInstance","__EntityMakerResult","__FinishSpawn","__ExecutePreSpawn"];local c=["_xa9b2dfB7ffe","VS","DoEntFireByInstanceHandle","ClearChat","Chat","ChatTeam","txt","Alert","AlertTeam","PrecacheModel","PrecacheScriptSound","delay","OnGameEvent_player_spawn","OnGameEvent_player_connect","VecToString","ENT_SCRIPT","HPlayer","Ent","Entc","max","min","clamp","MAX_COORD_FLOAT","MAX_TRACE_LENGTH","DEG2RAD","RAD2DEG","CONST","vs_library"];local d;if(!PORTAL2){d=["CHostage","Vector","ScriptIsLocalPlayerUsingController","GetDeveloperLevel","ScriptGetBestTrainingCourseTime","CSceneEntity","ScriptCoopMissionRespawnDeadPlayers","DispatchParticleEffect","CTriggerCamera","DoEntFire","RandomFloat","CBasePlayer","VSquirrel_OnReleaseScope","ScriptCoopMissionSetNextRespawnIn","ScriptCoopMissionSpawnNextWave","DoUniqueString","CBaseAnimating","ScriptPrintMessageCenterTeam","EntFireByHandle","Entities","SendToConsole","TraceLine","ScriptCoopMissionGetMissionNumber","ScriptCoopSetBotQuotaAndRefreshSpawns","ScriptPrintMessageChatTeam","IncludeScript","ScriptGetPlayerCompletedTraining","Documentation","__DumpScope","CEntities","PrintHelp","ScriptPrintMessageCenterAllWithParams","CBaseEntity","FrameTime","Time","Assert","ScriptCoopGiveC4sToCTs","DebugDrawBox","DebugDrawLine","ScriptHighlightAmmoCounter","Document","ScriptSetMiniScoreHidden","ScriptCoopCollectBonusCoin","CBaseFlex","ScriptPrintMessageCenterAll","ScriptSetRadarHidden","CGameSurvivalLogic","RecordAchievementEvent","GetFunctionSignature","ScriptIsWarmupPeriod","VSquirrel_OnCreateScope","ScriptShowFinishMsgBox","developer","CEnvEntityMaker","__ReplaceClosures","RetrieveNativeSignature","ScriptShowExitDoorMsg","SendToConsoleServer","GetMapName","EntFire","Msg","UniqueString","ScriptGetRoundsPlayed","CreateSceneEntity","ScriptGetGameType","DoIncludeScript","LateBinder","ShowMessage","LoopSinglePlayerMaps","ScriptGetValveTrainingCourseTime","CreateProp","printl","CFuncTrackTrain","CGameCoopMissionManager","ScriptSetPlayerCompletedTraining","CBaseMultiplayerPlayer","RegisterFunctionDocumentation","CPlayerVoiceListener","ScriptSetBestTrainingCourseTime","ScriptTrainingGivePlayerAmmo","ScriptCoopResetRoundStartTime","CScriptKeyValues","CCallChainer","CSimpleCallChainer","ScriptPrintMessageChatAll","ScriptGetGameMode","RandomInt","ScriptCoopMissionSpawnFirstEnemies","ScriptCoopExtendRoundDurationTime","ScriptCoopToggleEntityOutlineHighlights","ScriptMissionResetDangerZones","ScriptMissionCreateAndDetonateDangerZone","ScriptCoopMissionSetDeadPlayerRespawnEnabled"]}else{d=["__ReplaceClosures","GetDeveloperLevel","CSceneEntity","MarkMapComplete","CTriggerCamera","DoEntFire","RandomFloat","CBasePlayer","VSquirrel_OnReleaseScope","IsLevelComplete","CBaseMultiplayerPlayer","PrecacheMovie","CBaseAnimating","GetNumMapsPlayed","EntFireByHandle","Entities","SendToConsole","RegisterFunctionDocumentation","IncludeScript","SetMapAsPlayed","UpgradePlayerPortalgun","__DumpScope","CEntities","PrintHelp","RetrieveNativeSignature","ScriptSteamShowURL","UpgradePlayerPotatogun","FrameTime","Time","Assert","RequestMapRating","PlayerVoiceListener","DebugDrawBox","LoopSinglePlayerMaps","Document","GetCoopSectionIndex","SetHaveSeenDLCTubesReveal","CoopSetMapRunTime","AddGladosSpokenFlags","CoopSetCameFromLastDLCMap","IsPlayerBranchComplete","CoopGladosBlowUpBots","IsBranchComplete","NotifySpeedRunSuccess","CoopGetNumPortalsPlaced","CoopGetBranchTotalLevelCount","GetNumPlayersConnected","IsLocalSplitScreen","GetPlayerDeathCount","GetGladosSpokenFlags","GetHaveSeenDLCTubesReveal","CoopGetLevelsCompletedThisBranch","GetCameFromLastDLCMap","SaveMPStatsData","GivePlayerPortalgun","CLinkedPortalDoor","UniqueString","GetCoopBranchLevelIndex","SetDucking","CSimpleCallChainer","CCallChainer","GetPlayer","RecordAchievementEvent","IsMultiplayer","GetFunctionSignature","IsPlayerLevelComplete","VSquirrel_OnCreateScope","developer","CEnvEntityMaker","GetPlayerSilenceDuration","TryDLC1InstalledOrCatch","GetMapName","EntFire","Msg","CreateSceneEntity","player","AddCoopCreditsName","GetMapIndexInPlayOrder","GetOrangePlayerIndex","CPortal_Player","CPlayerVoiceListener","LateBinder","ShowMessage","CreateProp","TraceLine","printl","ScriptShowHudMessageAll","DebugDrawLine","GetHighestActiveBranch","Documentation","CBaseEntity","CPropLinkedPortalDoor","DoIncludeScript","CScriptKeyValues","GetBluePlayerIndex","DoUniqueString","CBaseFlex","AddBranchLevelName","RandomInt","Vector"]};;VS.slots_default<-[];VS.slots_default.extend(a);VS.slots_default.extend(b);VS.slots_default.extend(d);VS.slots_default.extend(c)}if(::print.getinfos().native)::Msg<-::print;;if(::EntFireByHandle.getinfos().native)::DoEntFireByInstanceHandle<-::EntFireByHandle;;::CONST<-getconsttable();::vs_library<-"vs_library v2.38.2";::MAX_COORD_FLOAT<-16384.0;::MAX_TRACE_LENGTH<-56755.84086241;::DEG2RAD<-0.01745329;::RAD2DEG<-57.29577951;if(!PORTAL2&&EVENTS){VS.Events<-delegate VS:{hProxy=null,flValidateTime=0.0,_SV=null}if(!("_xa9b2dfB7ffe"in getroottable()))::_xa9b2dfB7ffe<-[];if(!("OnGameEvent_player_spawn"in getroottable()))::OnGameEvent_player_spawn<-::dummy;if(!("OnGameEvent_player_connect"in getroottable()))::OnGameEvent_player_connect<-::dummy};;::collectgarbage();function VS::ForceReload():(_f){_reload=true;::print("Reloading vs_library...\n");return::DoIncludeScript(_f,::getroottable())}local _VEC=Vector();local Entities=::Entities,AddEvent=::DoEntFireByInstanceHandle,Vector=::Vector,RandomFloat=::RandomFloat,DebugDrawBox=::DebugDrawBox,DoUniqueString=::DoUniqueString,Time=::Time,format=::format,sin=::sin,cos=::cos,floor=::floor,atan2=::atan2,exp=::exp,pow=::pow,log=::log,compile=::compilestring;::max<-function(a,b)return a>b?a:b;::min<-function(a,b)return a<b?a:b;::clamp<-function(v,i,x){if(x<i)return x;else if(v<i)return i;else if(v>x)return x;else return v}function VS::IsInteger(f):(floor)return floor(f)==f;function VS::IsLookingAt(S,T,D,cos){local to=T-S;to.Norm();return to.Dot(D)>=cos}function VS::PointOnLineNearestPoint(S,E,P){local v1=E-S,d=v1.Dot(P-S)/v1.LengthSqr();if(d<0.0)return S;else if(d>1.0)return E;else return S+v1*d}function VS::GetAngle(f,t):(Vector,atan2){local d=f-t,p=57.29577951*atan2(d.z,d.Length2D()),y=57.29577951*(atan2(d.y,d.x)+3.14159265);return Vector(p,y,0.0)}function VS::GetAngle2D(f,t):(atan2){local d=t-f,y=57.29577951*atan2(d.y,d.x);return y}function VS::VectorVectors(F,R,U):(Vector){if(F.x==0.0&&F.y==0.0){R.x=0.0;R.y=-1.0;R.z=0.0;U.x=-F.z;U.y=0.0;U.z=0.0}else{local R=F.Cross(Vector(0.0,0.0,1.0));R.x=R.x;R.y=R.y;R.z=R.z;R.Norm();local U=R.Cross(F);U.x=U.x;U.y=U.y;U.z=U.z;U.Norm()}}function VS::AngleVectors(A,F=_VEC,R=null,U=null):(sin,cos){local sr,cr,rr,yr=0.01745329*A.y,sy=sin(yr),cy=cos(yr),pr=0.01745329*A.x,sp=sin(pr),cp=cos(pr);if(A.z){rr=0.01745329*A.z;sr=sin(rr);cr=cos(rr)}else{sr=0.0;cr=1.0};if(F){F.x=cp*cy;F.y=cp*sy;F.z=-sp};if(R){R.x=(-1.0*sr*sp*cy+-1.0*cr*-sy);R.y=(-1.0*sr*sp*sy+-1.0*cr*cy);R.z=-1.0*sr*cp};if(U){U.x=(cr*sp*cy+-sr*-sy);U.y=(cr*sp*sy+-sr*cy);U.z=cr*cp};return F}function VS::VectorAngles(F):(Vector,atan2,sqrt){local tmp,yaw,pitch;if(F.y==0.0&&F.x==0.0){yaw=0.0;if(F.z>0.0)pitch=270.0;else pitch=90.0}else{yaw=57.29577951*atan2(F.y,F.x);if(yaw<0.0)yaw+=360.0;tmp=sqrt(F.x*F.x+F.y*F.y);pitch=57.29577951*atan2(-F.z,tmp);if(pitch<0.0)pitch+=360.0};return Vector(pitch,yaw,0.0)}function VS::VectorYawRotate(vIn,fYaw,vOut=_VEC):(sin,cos){local rad=0.01745329*fYaw,sy=sin(rad),cy=cos(rad);vOut.x=vIn.x*cy-vIn.y*sy;vOut.y=vIn.x*sy+vIn.y*cy;vOut.z=vIn.z;return vOut}function VS::YawToVector(y):(Vector,sin,cos){local a=0.01745329*y;return Vector(cos(a),sin(a),0.0)}function VS::VecToYaw(v):(atan2){if(v.y==0.0&&v.x==0.0)return 0.0;local y=57.29577951*atan2(v.y,v.x);if(y<0.0)y+=360.0;return y}function VS::VecToPitch(v):(atan2){if(v.y==0.0&&v.x==0.0){if(v.z<0.0)return 180.0;else return -180.0};return 57.29577951*atan2(-v.z,v.Length2D())}function VS::VectorIsZero(v)return v.x==0.0&&v.y==0.0&&v.z==0.0;function VS::VectorsAreEqual(a,b,t=0.0){local x=a.x-b.x;if(x<0.0)x=-x;local y=a.y-b.y;if(y<0.0)y=-y;local z=a.z-b.z;if(z<0.0)z=-z;return(x<=t&&y<=t&&z<=t)}function VS::AnglesAreEqual(a,b,t=0.0){local d=a-b;d%=360.0;if(d>180.0)d-=360.0;else if(d<(-180.0))d+=360.0;;if(d<0.0)d=-d;return d<=t}function VS::CloseEnough(a,b,e){local d=a-b;if(d<0.0)d=-d;return d<=e}function VS::Approach(tg,v,s){local dt=tg-v;if(dt>s)v+=s;else if(dt<(-s))v-=s;else v=tg;;return v}function VS::ApproachAngle(tg,v,s){tg%=360.0;if(tg>180.0)tg-=360.0;else if(tg<(-180.0))tg+=360.0;;v%=360.0;if(v>180.0)v-=360.0;else if(v<(-180.0))v+=360.0;;local dt=tg-v;dt%=360.0;if(dt>180.0)dt-=360.0;else if(dt<(-180.0))dt+=360.0;;if(s<0.0)s=-s;if(dt>s)v+=s;else if(dt<(-s))v-=s;else v=tg;;return v}function VS::AngleDiff(dst,src){local df=dst-src;df%=360.0;if(df>180.0)df-=360.0;else if(df<(-180.0))df+=360.0;;return df}function VS::AngleNormalize(A){A%=360.0;if(A>180.0)A-=360.0;else if(A<(-180.0))A+=360.0;;return A}function VS::QAngleNormalize(A){A.x%=360.0;if(A.x>180.0)A.x-=360.0;else if(A.x<(-180.0))A.x+=360.0;;A.y%=360.0;if(A.y>180.0)A.y-=360.0;else if(A.y<(-180.0))A.y+=360.0;;A.z%=360.0;if(A.z>180.0)A.z-=360.0;else if(A.z<(-180.0))A.z+=360.0;;return A}function VS::SnapDirectionToAxis(D,E){local p=1.0-E;if((D.x<0.0?-D.x:D.x)>p){if(D.x<0.0)D.x=-1.0;else D.x=1.0;D.y=0.0;D.z=0.0;return D};if((D.y<0.0?-D.y:D.y)>p){if(D.y<0.0)D.y=-1.0;else D.y=1.0;D.z=0.0;D.x=0.0;return D};if((D.z<0.0?-D.z:D.z)>p){if(D.z<0.0)D.z=-1.0;else D.z=1.0;D.x=0.0;D.y=0.0;return D}}function VS::VectorCopy(src,dst){dst.x=src.x;dst.y=src.y;dst.z=src.z;return dst}function VS::VectorMin(a,b,o=_VEC){o.x=a.x<b.x?a.x:b.x;o.y=a.y<b.y?a.y:b.y;o.z=a.z<b.z?a.z:b.z;return o}function VS::VectorMax(a,b,o=_VEC){o.x=a.x>b.x?a.x:b.x;o.y=a.y>b.y?a.y:b.y;o.z=a.z>b.z?a.z:b.z;return o}function VS::VectorAbs(v){if(v.x<0.0)v.x=-v.x;if(v.y<0.0)v.y=-v.y;if(v.z<0.0)v.z=-v.z;return v}function VS::VectorAdd(a,b,o=_VEC){o.x=a.x+b.x;o.y=a.y+b.y;o.z=a.z+b.z;return o}function VS::VectorSubtract(a,b,o=_VEC){o.x=a.x-b.x;o.y=a.y-b.y;o.z=a.z-b.z;return o}function VS::VectorMultiply(a,b,o=_VEC){o.x=a.x*b;o.y=a.y*b;o.z=a.z*b;return o}function VS::VectorMultiply2(a,b,o=_VEC){o.x=a.x*b.x;o.y=a.y*b.y;o.z=a.z*b.z;return o}function VS::VectorDivide(a,b,o=_VEC){local d=1.0/b;o.x=a.x*d;o.y=a.y*d;o.z=a.z*d;return o}function VS::VectorDivide2(a,b,o=_VEC){o.x=a.x/b.x;o.y=a.y/b.y;o.z=a.z/b.z;return o}function VS::ComputeVolume(is,xs){local dt=xs-is;return dt.Dot(dt)}function VS::RandomVector(iv=-RAND_MAX,xv=RAND_MAX):(Vector,RandomFloat)return Vector(RandomFloat(iv,xv),RandomFloat(iv,xv),RandomFloat(iv,xv));function VS::CalcSqrDistanceToAABB(mins,maxs,pt){local dt,ds=0.0;if(pt.x<mins.x){dt=(mins.x-pt.x);ds+=dt*dt}else if(pt.x>maxs.x){dt=(pt.x-maxs.x);ds+=dt*dt};;if(pt.y<mins.y){dt=(mins.y-pt.y);ds+=dt*dt}else if(pt.y>maxs.y){dt=(pt.y-maxs.y);ds+=dt*dt};;if(pt.z<mins.z){dt=(mins.z-pt.z);ds+=dt*dt}else if(pt.z>maxs.z){dt=(pt.z-maxs.z);ds+=dt*dt};;return ds}function VS::CalcClosestPointOnAABB(i,x,p,o=_VEC){o.x=(p.x<i.x)?i.x:(x.x<p.x)?x.x:p.x;o.y=(p.y<i.y)?i.y:(x.y<p.y)?x.y:p.y;o.z=(p.z<i.z)?i.z:(x.z<p.z)?x.z:p.z;return o}function VS::ExponentialDecay(dO,dT,dt):(log,exp)return exp(log(dO)/dT*dt);function VS::ExponentialDecay2(hl,dt):(exp)return exp(-0.69314718/hl*dt);function VS::ExponentialDecayIntegral(dO,dT,dt):(log,pow)return(pow(dO,dt/dT)*dT-dT)/log(dO);function VS::SimpleSpline(v){local vSqr=v*v;return(3.0*vSqr-2.0*vSqr*v)}function VS::SimpleSplineRemapVal(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);local vS=cVal*cVal;return C+(D-C)*(3.0*vS-2.0*vS*cVal)}function VS::SimpleSplineRemapValClamped(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);cVal=(cVal<0.0)?0.0:(1.0<cVal)?1.0:cVal;local vS=cVal*cVal;return C+(D-C)*(3.0*vS-2.0*vS*cVal)}function VS::RemapVal(v,A,B,C,D){if(A==B)return v>=B?D:C;return C+(D-C)*(v-A)/(B-A)}function VS::RemapValClamped(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);cVal=(cVal<0.0)?0.0:(1.0<cVal)?1.0:cVal;return C+(D-C)*cVal}function VS::Bias(x,ba):(log,pow){local la=-1.0,e=0.0;if(la!=ba)e=log(ba)*-1.4427;return pow(x,e)}function VS::Gain(x,ba){if(x<0.5)return 0.5*Bias(2.0*x,1.0-ba);else return 1.0-0.5*Bias(2.0-2.0*x,1.0-ba)}function VS::SmoothCurve(x):(cos)return(1.0-cos(x*3.14159265))*0.5;function VS::MovePeak(x,pkp){if(x<pkp)return x*0.5/pkp;else return 0.5+0.5*(x-pkp)/(1.0-pkp)}local MovePeak=::VS.MovePeak,Gain=::VS.Gain;function VS::SmoothCurve_Tweak(x,pkp,pks):(MovePeak,Gain,cos){local mp=MovePeak(x,pkp);local sh=Gain(mp,pks);return(1.0-cos(sh*3.14159265))*0.5}function VS::Lerp(A,B,f)return A+(B-A)*f;function VS::FLerp(f1,f2,i1,i2,x)return f1+(f2-f1)*(x-i1)/(i2-i1);function VS::VectorLerp(v1,v2,f,o=_VEC){o.x=v1.x+(v2.x-v1.x)*f;o.y=v1.y+(v2.y-v1.y)*f;o.z=v1.z+(v2.z-v1.z)*f;return o}function VS::IsPointInBox(v,i,x)return(v.x>=i.x&&v.x<=x.x&&v.y>=i.y&&v.y<=x.y&&v.z>=i.z&&v.z<=x.z);function VS::IsBoxIntersectingBox(i1,x1,i2,x2){if((i1.x>x2.x)||(x1.x<i2.x))return false;if((i1.y>x2.y)||(x1.y<i2.y))return false;if((i1.z>x2.z)||(x1.z<i2.z))return false;return true}::Ent<-function(s,i=null):(Entities)return Entities.FindByName(i,s);::Entc<-function(s,i=null):(Entities)return Entities.FindByClassname(i,s);::VecToString<-function(V,P="Vector(",S=",",X=")")return P+V.x+S+V.y+S+V.z+X;function VS::DrawEntityBBox(t,e,r=255,g=138,b=0,a=0):(DebugDrawBox)return DebugDrawBox(e.GetOrigin(),e.GetBoundingMins(),e.GetBoundingMaxs(),r,g,b,a,t);local Trace=::TraceLine;class::VS.TraceLine{constructor(start=null,end=null,ent=null):(Vector,Trace){if(!start){local v=Vector();startpos=v;endpos=v;hIgnore=ent;fraction=1.0;return};startpos=start;endpos=end;hIgnore=ent;fraction=Trace(startpos,endpos,hIgnore)}function _cmp(d){if(fraction<d.fraction)return -1;if(fraction>d.fraction)return 1;return 0}function _add(d){return fraction+d.fraction}function _sub(d){return fraction-d.fraction}function _mul(d){return fraction*d.fraction}function _div(d){return fraction/d.fraction}function _modulo(d){return fraction%d.fraction}function _unm(){return -fraction}function _typeof(){return"trace_t"}startpos=null;endpos=null;hIgnore=null;fraction=0.0;hitpos=null;normal=null;m_Delta=null;m_IsSwept=null;m_Extents=null;m_IsRay=null;m_StartOffset=null;m_Start=null}local CTrace=::VS.TraceLine;function VS::TraceDir(v1,d,f=::MAX_TRACE_LENGTH,e=null):(CTrace)return CTrace(v1,v1+(d*f),e);function VS::TraceLine::DidHit()return fraction<1.0;function VS::TraceLine::GetEnt(r){return GetEntByClassname("*",r)}function VS::TraceLine::GetEntByName(n,r):(Entities){if(!hitpos)GetPos();return Entities.FindByNameNearest(n,hitpos,r)}function VS::TraceLine::GetEntByClassname(n,r):(Entities){if(!hitpos)GetPos();return Entities.FindByClassnameNearest(n,hitpos,r)}function VS::TraceLine::GetPos(){if(!hitpos){if(DidHit())hitpos=startpos+(endpos-startpos)*fraction;else hitpos=endpos};return hitpos}function VS::TraceLine::GetDist()return(startpos-GetPos()).Length();function VS::TraceLine::GetDistSqr()return(startpos-GetPos()).LengthSqr();local TraceDir=::VS.TraceDir;function VS::TraceLine::GetNormal():(Vector,TraceDir){if(!normal){local u=Vector(0.0,0.0,0.5),d=endpos-startpos;d.Norm();GetPos();normal=(hitpos-TraceDir(startpos+d.Cross(u),d).GetPos()).Cross(hitpos-TraceDir(startpos+u,d).GetPos());normal.Norm()};return normal}function VS::TraceLine::Ray(mins=::Vector(),maxs=::Vector()){m_Delta=endpos-startpos;m_IsSwept=m_Delta.LengthSqr()!=0.0;m_Extents=(maxs-mins)*0.5;m_IsRay=m_Extents.LengthSqr()<1.e-6;m_StartOffset=(mins+maxs)*0.5;m_Start=startpos+m_StartOffset;m_StartOffset*=-1.0;return this}function VS::UniqueString():(DoUniqueString){local s=DoUniqueString("");return s.slice(0,s.len()-1)}function VS::arrayFind(a,l){foreach(i,v in a)if(v==l)return i}function VS::arrayApply(a,f){foreach(i,v in a)a[i]=f(v)}local array=::array;function VS::arrayMap(a,f):(array){local n=array(a.len());foreach(i,v in a)n[i]=f(v);return n}function VS::DumpScope(I,A=false,P=true,G=true,D=0){local t=function(c)for(local i=0;i<c;++i)::print("   ");if(G)::print(" ------------------------------\n");if(I){foreach(key,val in I){local d=false;if(!A){foreach(k in slots_default)if(key==k)d=true}else if(key=="VS"||key=="Documentation")d=true;;if(!d){t(D);::print(key);switch(typeof val){case"table": ::print("(TABLE) : "+val.len());if(!P)break;::print("\n");t(D);::print("{\n");DumpScope(val,A,P,false,D+1);t(D);::print("}");break;case"array": ::print("(ARRAY) : "+val.len());if(!P)break;::print("\n");t(D);::print("[\n");DumpScope(val,A,P,false,D+1);t(D);::print("]");break;case"string": ::print(" = \""+val+"\"");break;case"Vector": ::print(" = "+::VecToString(val));break;default: ::print(" = "+val)}::print("\n")}}}else ::print("null\n");if(G)::print(" ------------------------------\n")}function VS::ArrayToTable(a){local t={}foreach(i,v in a)t[v]<-i;return t}function VS::GetStackInfo(D=false,P=false){::print(" --- STACKINFO ----------------\n");local s,j=2;while(s=::getstackinfos(j++)){if(s.func=="pcall"&&s.src=="NATIVE")break;::print(" ("+(j-1)+")\n");local w,m=s.locals;if("this"in m&&typeof m["this"]=="table"){if(m["this"]==::getroottable()){w="roottable"}else{w=GetVarName(m["this"]);m[w]<-delete m["this"]}};if(w=="roottable")DumpScope(s,P,0,0);else DumpScope(s,P,D,0);if(w)::print("scope = \""+w+"\"\n")}::print(" --- STACKINFO ----------------\n")}VS.GetCaller<-compile("return(getstackinfos(3).locals[\"this\"])");VS.GetCallerFunc<-compile("return(getstackinfos(3).func)");function VS::GetTableDir(I){if(typeof I!="table")throw"Invalid input type '"+typeof I+"' ; expected: 'table'";local r=_f627f40d21a6([],I);if(r)r.append("roottable");else r=["roottable"];r.reverse();return r}function VS::_f627f40d21a6(bF,t,l=::getroottable()){foreach(v,u in l)if(typeof u=="table")if(v!="VS"&&v!="Documentation")if(u==t){bF.append(v);return bF}else{local r=_f627f40d21a6(bF,t,u);if(r){bF.append(v);return r}}}function VS::FindVarByName(S){if(typeof S!="string")throw"Invalid input type '"+typeof S+"' ; expected: 'string'";return _fb3k55Ir91t7(S)}function VS::_fb3k55Ir91t7(t,l=::getroottable()){if(t in l)return l[t];else foreach(v,u in l)if(typeof u=="table")if(v!="VS"&&v!="Documentation"){local r=_fb3k55Ir91t7(t,u);if(r)return r}}function VS::GetVarName(v){local t=typeof v;if(t=="function"||t=="native function")return v.getinfos().name;return _fb3k5S1r91t7(t,v)}function VS::_fb3k5S1r91t7(t,i,s=::getroottable()){foreach(k,v in s){if(v==i)return k;if(typeof v=="table")if(k!="VS"&&k!="Documentation"){local r=_fb3k5S1r91t7(t,i,v);if(r)return r}}}if(::ENT_SCRIPT<-::Entc("worldspawn")){::ENT_SCRIPT.ValidateScriptScope();::VS.slots_default.append(::VS.GetVarName(::ENT_SCRIPT.GetScriptScope()))}else{(::ENT_SCRIPT<-::VS.CreateEntity("soundent")).ValidateScriptScope();::VS._ENT_SCRIPT<-::ENT_SCRIPT;::Msg("ERROR: Could not find worldspawn\n")};;::delay<-function(X,T=0.0,E=::ENT_SCRIPT,A=null,C=null):(AddEvent)return AddEvent(E,"RunScriptCode",""+X,T,A,C);local flTickRate=1.0/::FrameTime();function VS::GetTickrate():(flTickRate){return flTickRate}if(!PORTAL2){function VS::IsDedicatedServer()throw"not ready";local ENT=::ENT_SCRIPT;local TIMESTART=4.0;local TIMEOUT=12.0;local _TIMEOUT=TIMEOUT+FrameTime()*4;::VS.flCanCheckForDedicatedAfterSec<-fabs(clamp(Time(),0,_TIMEOUT)-_TIMEOUT);::_VS_DS_Init<-function():(TIMESTART,TIMEOUT,ENT){if(::_VS_DS_bInitDone){::VS.flCanCheckForDedicatedAfterSec=0.0;delete::_VS_DS_Init;delete::_VS_DS_IsListen;delete::_VS_DS_bInitDone;delete::_VS_DS_bExecOnce;return};local time=::Time();if(time>TIMESTART){::SendToConsole("script _VS_DS_IsListen()");if(time>TIMEOUT){::VS.IsDedicatedServer=function()return true;::_VS_DS_bInitDone=true}};::delay("::_VS_DS_Init()",0.1,ENT)}::_VS_DS_IsListen<-function(){::VS.IsDedicatedServer=function()return false;::_VS_DS_bInitDone=true}if(!("_VS_DS_bExecOnce"in::getroottable())){::_VS_DS_bExecOnce<-true;::_VS_DS_bInitDone<-false};if(::_VS_DS_bExecOnce){local time=::Time();if(time<TIMESTART){::delay("::_VS_DS_Init()",TIMESTART-time,ENT)}else{::_VS_DS_Init()};::_VS_DS_bExecOnce=false}};;if(!PORTAL2){local Chat=::ScriptPrintMessageChatAll;local ChatTeam=::ScriptPrintMessageChatTeam;::Chat<-function(s):(Chat)return Chat(" "+s);::ChatTeam<-function(i,s):(ChatTeam)return ChatTeam(i," "+s);::Alert<-::ScriptPrintMessageCenterAll;::AlertTeam<-::ScriptPrintMessageCenterTeam;::ClearChat<-function():(Chat)for(local i=9;i--;)Chat(" ");::txt<-{invis="\x00",white="\x01",red="\x02",purple="\x03",green="\x04",lightgreen="\x05",limegreen="\x06",lightred="\x07",grey="\x08",yellow="\x09",lightblue="\x0a",blue="\x0b",darkblue="\x0c",darkgrey="\x0d",pink="\x0e",orangered="\x0f",orange="\x10"}};;::EntFireByHandle<-function(t,a,v="",d=0.0,o=null,c=null):(AddEvent)return AddEvent(t,a+"",v+"",d,o,c);::PrecacheModel<-function(s)::ENT_SCRIPT.PrecacheModel(s);::PrecacheScriptSound<-function(s)::ENT_SCRIPT.PrecacheSoundScript(s);if(!PORTAL2){function VS::MakePersistent(e)return e.__KeyValueFromString("classname","soundent")}else{::VS.MakePersistent<-::dummy};;function VS::SetParent(c,p):(AddEvent){if(p)return AddEvent(c,"SetParent","!activator",0.0,p,null);return AddEvent(c,"ClearParent","",0.0,null,null)}function VS::ShowGameText(e,t,m=null,d=0.0):(AddEvent){if(m)e.__KeyValueFromString("message",""+m);return AddEvent(e,"Display","",d,t,null)}function VS::ShowHudHint(e,t,m=null,d=0.0):(AddEvent){if(m)e.__KeyValueFromString("message",""+m);return AddEvent(e,"ShowHudHint","",d,t,null)}function VS::HideHudHint(e,t,d=0.0):(AddEvent)return AddEvent(e,"HideHudHint","",d,t,null);function VS::CreateMeasure(g,n=null,p=false,e=true,s=1.0):(AddEvent){local r=e?n?n+"":"vs.ref_"+UniqueString():n?n+"":null;if(!r||!r.len())throw"Invalid targetname";local e=CreateEntity("logic_measure_movement",{measuretype=e?1:0,measurereference="",targetreference=r,target=r,measureretarget="",targetscale=s.tofloat(),targetname=e?r:null},p);AddEvent(e,"SetMeasureReference",r,0.0,null,null);AddEvent(e,"SetMeasureTarget",g,0.0,null,null);AddEvent(e,"Enable","",0.0,null,null);return e}function VS::SetMeasure(h,s):(AddEvent)return AddEvent(h,"SetMeasureTarget",s,0.0,null,null);function VS::CreateTimer(D,I,L=null,U=null,O=false,P=false):(AddEvent){local e=CreateEntity("logic_timer",null,P);if(I){e.__KeyValueFromInt("UseRandomTime",0);e.__KeyValueFromFloat("RefireTime",I.tofloat())}else{e.__KeyValueFromFloat("LowerRandomBound",L.tofloat());e.__KeyValueFromFloat("UpperRandomBound",U.tofloat());e.__KeyValueFromInt("UseRandomTime",1);e.__KeyValueFromInt("spawnflags",O.tointeger())};AddEvent(e,D?"Disable":"Enable","",0.0,null,null);return e}function VS::Timer(D,I,F=null,s=null,E=false,P=false){if(!I){::Msg("\nERROR:\nRefire time cannot be null in VS.Timer\nUse VS.CreateTimer for randomised fire times.\n");throw"NULL REFIRE TIME"};local h=CreateTimer(D,I,null,null,null,P);OnTimer(h,F,s?s:GetCaller(),E);return h}function VS::OnTimer(e,F,s=null,E=false)return AddOutput(e,"OnTimer",F,s?s:GetCaller(),E);function VS::AddOutput(e,O,F,s=null,E=false):(compile){if(!s)s=GetCaller();if(F){if(typeof F=="string"){if(F.find("(")!=null)F=compile(F);else F=s[F]}else if(typeof F!="function")throw"Invalid function type "+typeof F}else{F=null;E=true};e.ValidateScriptScope();local r=e.GetScriptScope();r[O]<-E?F:F.bindenv(s);e.ConnectOutput(O,O);return r}function VS::AddOutput2(e,O,F,s=null,E=false):(AddEvent){if(e.GetScriptScope()||typeof F=="function")return AddOutput(e,O,F,s,E);if(typeof F!="string")throw"Invalid function type "+typeof F;if(!s)s=GetCaller();if(!E){if(!("self"in s))throw"Invalid function path. Not an entity";AddEvent(e,"AddOutput",O+" "+s.self.GetName()+",RunScriptCode,"+F,0.0,s.self,e)}else{local n=e.GetName();if(!n.len()){n=UniqueString();SetName(e,n)};AddEvent(e,"AddOutput",O+" "+n+",RunScriptCode,"+F,0.0,null,e)}}function VS::CreateEntity(s,k=null,p=false):(Entities){local e=Entities.CreateByClassname(s);if(typeof k=="table")foreach(k,v in k)SetKeyValue(e,k,v);if(p)MakePersistent(e);return e}function VS::SetKeyValue(e,k,v){switch(typeof v){case"bool":case"integer":return e.__KeyValueFromInt(k,v.tointeger());case"float":return e.__KeyValueFromFloat(k,v);case"string":return e.__KeyValueFromString(k,v);case"Vector":return e.__KeyValueFromVector(k,v);case"null":return true;default:throw"Invalid input type: "+typeof v}}function VS::SetName(e,s)return e.__KeyValueFromString("targetname",s+"");function VS::DumpEnt(I=null):(Entities){if(!I){local e;while(e=Entities.Next(e)){local s=e.GetScriptScope();if(s)::Msg(e+" :: "+s.__vname+"\n")}return};if(typeof I=="string"){local e;while(e=Entities.Next(e))if(e+""==I)I=e};if(typeof I=="instance"){if(I.IsValid()){local s=I.GetScriptScope();if(s){::Msg("--- Script dump for entity "+I+"\n");DumpScope(s,0,1,0,1);::Msg("--- End script dump\n")}else return::Msg("Entity has no script scope! "+I+"\n")}else return::Msg("Invalid entity!\n")}else if(I){local e;while(e=Entities.Next(e)){local s=e.GetScriptScope();if(s){::Msg("\n--- Script dump for entity "+e+"\n");DumpScope(s,0,1,0,1);::Msg("--- End script dump\n")}}}}if(!PORTAL2){function VS::GetPlayersAndBots():(Entities){local e,P=[],B=[];while(e=Entities.FindByClassname(e,"cs_bot"))B.append(e.weakref());e=null;while(e=Entities.FindByClassname(e,"player")){local s=e.GetScriptScope();if("networkid"in s&&s.networkid=="BOT")B.append(e.weakref());else P.append(e.weakref())}return[P,B]}function VS::GetAllPlayers():(Entities){local e,a=[];while(e=Entities.FindByClassname(e,"player"))a.append(e.weakref());e=null;while(e=Entities.FindByClassname(e,"cs_bot"))a.append(e.weakref());return a}function VS::DumpPlayers(D=false){local a=GetPlayersAndBots(),p=a[0],b=a[1];::Msg("\n=======================================\n"+p.len()+" players found\n"+b.len()+" bots found\n");local c=function(_s,_a):(D){foreach(e in _a){local s=e.GetScriptScope();if(s)s=GetVarName(s);if(!s)s="null";::Msg(_s+"- "+e+" :: "+s+"\n");if(D&&s!="null")DumpEnt(e)}}c("[BOT]    ",b);c("[PLAYER] ",p);::Msg("=======================================\n")}};;if(PORTAL2){function VS::GetLocalPlayer(){local e;if(::IsMultiplayer())e=::Entc("player");else{e=::GetPlayer();if(e!=::player)::Msg("GetLocalPlayer: Discrepancy detected!\n")};SetName(e,"localplayer");return e}}else{function VS::GetLocalPlayer(){if(GetPlayersAndBots()[0].len()>1)::Msg("GetLocalPlayer: More than 1 player detected!\n");local e=::Entc("player");if(!e)return::Msg("GetLocalPlayer: No player found!\n");if(e!=GetPlayerByIndex(1))::Msg("GetLocalPlayer: Discrepancy detected!\n");SetName(e,"localplayer");::HPlayer<-e.weakref();return e}function VS::GetPlayerByIndex(i):(Entities){local e;while(e=Entities.FindByClassname(e,"player"))if(e.entindex()==i)return e;e=null;while(e=Entities.FindByClassname(e,"cs_bot"))if(e.entindex()==i)return e}};;function VS::FindEntityByIndex(i,s="*"):(Entities){local e;while(e=Entities.FindByClassname(e,s))if(e.entindex()==i)return e}function VS::IsPointSized(h){local v=h.GetBoundingMaxs();return v.x==0.0&&v.y==0.0&&v.z==0.0}function VS::FindEntityNearestFacing(O,F,T):(Entities){local bd=T,be,e=Entities.First();while(e=Entities.Next(e)){local v=e.GetBoundingMaxs();if(v.x==0.0&&v.y==0.0&&v.z==0.0)continue;local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>bd){bd=d;be=e}}return be}function VS::FindEntityClassNearestFacing(O,F,T,C):(Entities){local bd=T,be,e;while(e=Entities.FindByClassname(e,C)){local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>bd){bd=d;be=e}}return be}function VS::FindEntityClassNearestFacingNearest(O,F,T,C,R):(Entities){local X,be,e;if(R)X=R*R;else X=3.22122e+09;while(e=Entities.FindByClassname(e,C)){local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>T){local q=(e.GetOrigin()-O).LengthSqr();if(X>q){be=e;X=q}}}return be}if(!PORTAL2){function VS::GetPlayerByUserid(i):(Entities){local e;while(e=Entities.FindByClassname(e,"player")){local s=e.GetScriptScope();if("userid"in s&&s.userid==i)return e}e=null;while(e=Entities.FindByClassname(e,"cs_bot")){local s=e.GetScriptScope();if("userid"in s&&s.userid==i)return e}}if(EVENTS){local gEventData=::_xa9b2dfB7ffe;local flTimeoutThold=::FrameTime()*2;local Time=::Time;function VS::Events::player_connect(D):(gEventData,Time,flTimeoutThold){if(D.networkid.len()){if(gEventData.len()>128){for(local i=64;i--;)gEventData.remove(0);::Msg("player_connect: ERROR!!! Player data is not being processed\n")};gEventData.append(D);return::OnGameEvent_player_connect(D)}else if(_SV){local dt=Time()-flValidateTime;if(!(dt>flTimeoutThold)){_SV.userid<-D.userid;if(!("name"in _SV))_SV.name<-"";if(!("networkid"in _SV))_SV.networkid<-""}else::Msg("player_connect: Unexpected error! "+dt+"\n");_SV=null;flValidateTime=0.0;return}}function VS::Events::player_spawn(D):(gEventData){if(gEventData.len())foreach(i,d in gEventData)if(d.userid==D.userid){local p=GetPlayerByIndex(d.index+1);if(!p||!p.ValidateScriptScope()){::Msg("player_connect: Invalid player entity\n");break};local s=p.GetScriptScope();if("networkid"in s){::Msg("player_connect: BUG!!! Something has gone wrong. ");if(s.networkid==d.networkid){::Msg("Duplicated data!\n");gEventData.remove(i)}else::Msg("Conflicting data!\n");break};if(!d.networkid.len())::Msg("player_connect: could not get event data\n");s.userid<-d.userid;s.name<-d.name;s.networkid<-d.networkid;gEventData.remove(i);break};;return::OnGameEvent_player_spawn(D)}function VS::Events::ForceValidateUserid(e):(AddEvent,Time){if(!e||!e.IsValid()||e.GetClassname()!="player")return::Msg("ForceValidateUserid: Invalid input: "+E+"\n");if(!hProxy)hProxy=CreateEntity("info_game_event_proxy",{event_name="player_connect"},true).weakref();flValidateTime=Time();e.ValidateScriptScope();_SV=e.GetScriptScope();AddEvent(hProxy,"GenerateGameEvent","",0,e,null)}function VS::Events::ValidateUseridAll(b=0){local f=::FrameTime();local d=::delay;local E=::ENT_SCRIPT;local i=0;foreach(v in GetAllPlayers())if(!("userid"in v.GetScriptScope())||b)d("::VS.Events.ForceValidateUserid(activator)",i++*f,E,v)}}};;local L=::VS.Log.L;if(PORTAL2){function VS::Log::Run(){if(!enabled)return;return _Start()}}else{function VS::Log::Run(){if(::VS.IsDedicatedServer())throw"Log unavailable on dedicated servers";if(!enabled)return;return _Start()}};;local Msg=::Msg;local flFrameTime=::FrameTime();function VS::Log::_Print(f):(Msg,L,delay,flFrameTime){local t=filter,p=Msg,L=L;if(!f)for(local i=nC;i<nN;++i)p(L[i]);else for(local i=nC;i<nN;++i)p(t+L[i]);nC+=nD;local v=nN+nD;nN=(v<0)?0:(nL<v)?nL:v;if(nC>=nN){if(f)_Stop();nL=null;nD=null;nC=null;nN=null;return};return delay("::VS.Log._Print("+f+")",flFrameTime)}function VS::Log::_Start():(flFrameTime){nL<-L.len();nD<-2000;nC<-0;nN<-::clamp(nD,0,nL);if(export){local file=file_prefix[0]==58?file_prefix.slice(1):file_prefix+"_"+::VS.UniqueString();_d<-::developer();::SendToConsole("developer 0;con_filter_enable 1;con_filter_text_out\""+filter+"\";con_filter_text\"\";con_logfile\""+file+".log\";script delay(\"::VS.Log._Print(1)\","+flFrameTime*4.0+")");return file}else{_Print(0)}}function VS::Log::_Stop()::SendToConsole("con_logfile\"\";con_filter_text_out\"\";con_filter_text\"\";con_filter_enable 0;developer "+_d);function VS::Log::Add(s):(L)L.append(s);function VS::Log::Clear():(L)L.clear();