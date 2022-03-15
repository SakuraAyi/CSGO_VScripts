/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

::script_player <- self;

class Data
{
    Hammer_Maxd = 46341.0;
    Hit = Vector(0, 0, 0);
    Dist = 0;

    table = {
        arr = []
    };
};

class Trace_System extends Data
{
    handle = null;
    constructor (handle = null)
    {
        this.handle = handle;
    }
    TraceModel = ModelList[0];

    function _Reg ()
    {
        local ent;
        for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
        {
            if (BaseVS(ent).IsPlayer())
            {
                local l_plr = ent;
                if (BaseVS(l_plr).IsAlive() && l_plr.GetTeam() == 3)
                {
                    local l_sc;
                    if (l_plr.ValidateScriptScope())
                        l_sc = l_plr.GetScriptScope();
                    //local l_aim = "aim";
                    //if (!(l_aim in l_sc))
                    if (!(l_sc.userid.tostring() in table))
                    {
                        table[l_sc.userid.tostring()] <- 1;
                        local l_pn = l_plr.GetName();
                        local l_prefix = "trace-";
                        local measure = Entities.CreateByClassname("logic_measure_movement");
                        local ms_tg = CreateProp("prop_dynamic", Vector(0, 0, 0), TraceModel, 0);

                        ms_tg.__KeyValueFromInt("rendermode", 10);
                        ms_tg.__KeyValueFromString("targetname", l_prefix+"traceorig_"+l_sc.userid);
                        measure.__KeyValueFromString("Target", ms_tg.GetName());
                        measure.__KeyValueFromInt("MeasureType", 1);
                        measure.__KeyValueFromInt("TargetScale", 1);

                        EntFireByHandle(measure, "SetMeasureTarget", l_pn, 0.00, null, null);
                        EntFireByHandle(measure, "SetMeasureReference", l_pn, 0.00, null, null);
                        EntFireByHandle(measure, "SetTargetReference", l_pn, 0.00, null, null);
                        EntFireByHandle(measure, "Enable", "", 0.00, null, null);

                        this.table.arr.push([l_plr, ms_tg]);
                        l_sc.trace <- ms_tg;
                    }
                }
            }
        }
    }
};

class PlayerDummy
{
    handle = null;
    sc = null;
    sw = {};
    constructor (handle = null)
    {
        this.handle = handle;
        if (handle != null)
            sc = this.handle.GetScriptScope();
    }

    function Create ()
    {
        local dummy = CreateProp("prop_dynamic", handle.GetOrigin(), handle.GetModelName(), 0);
        BaseVS(dummy).SetKeyValue("targetname", "dummy-"+sc.userid);
        //BaseVS(m_dummy).SetParent(handle);
        if (dummy.ValidateScriptScope())
        {
            local l_sc = dummy.GetScriptScope();
            l_sc.Owner <- handle;
            l_sc.DoIncludeScript("gates_of_hell/vs_dummy.nut", l_sc);
        }
        //BaseVS(dummy).SetRenderAmt(10, 0);
        EntFireByHandle(dummy, "Disable", "", 0.00, dummy, dummy);
        sc.m_dummy <- dummy;
        this.sw[sc.userid.tostring()] <- 0;
    }
    
    function Switch ()
    {
        local dummy = sc.m_dummy;
        local dummySc = dummy.GetScriptScope();
        local animerunning = script_item.GetScriptScope().c_viewevent[sc.userid.tostring()];

        if (this.sw[sc.userid.tostring()] < 1)
        {
            if (animerunning._run) return;
            animerunning._run <- true;

            BaseVS(handle).SetKeyValue("disableflashlight", 1);
            BaseVS(handle).SetKeyValue("disablereceiveshadows", 1);
            BaseVS(handle).SetKeyValue("disableshadowdepth", 1);
            BaseVS(handle).SetKeyValue("disableshadows", 1);
            BaseVS(handle).SetRenderAmt(10, 0);
            EntFireByHandle(dummy, "Enable", "", 0.00, dummy, dummy);
            BaseVS(dummy).SetBodyGroup(sc.body_idx);
            script_item.GetScriptScope().RPG(handle).Use(1);
            BaseVS(handle).SetPlayerSpeed(4, 0.9);
            dummySc.activate <- 1;
            dummySc.Useing <- true;

            this.sw[sc.userid.tostring()]  <- 1;
            
        }
        else
        {
            local l_yaw = handle.GetAngles().y;
            handle.SetAngles(0, l_yaw, 0);
            BaseVS(handle).SetRenderAmt(0, 255);
            BaseVS(handle).SetKeyValue("disableflashlight", 0);
            BaseVS(handle).SetKeyValue("disablereceiveshadows", 0);
            BaseVS(handle).SetKeyValue("disableshadowdepth", 0);
            BaseVS(handle).SetKeyValue("disableshadows", 0);
            EntFireByHandle(dummy, "Disable", "", 0.00, dummy, dummy);
            script_item.GetScriptScope().RPG(handle).Use(0);
            BaseVS(handle).SetPlayerSpeed(4, 1.0);
            dummySc.activate <- 0;
            dummySc.Useing <- false;
    
            //dummySc.movement.moving = false;
            dummySc.movement.aiming = false;
            dummySc.movement.shooting = false;
            dummySc.movement.crouch = false;

            this.sw[sc.userid.tostring()]  <- 0;
            animerunning._run <- false;
        }
    }
};

Think <- function ()
{
    try TraceSysRun() catch (e) null;

    local plr;
    while ((plr = Entities.FindByClassname(plr, "player")) != null)
    {
        local sc = plr.GetScriptScope();
        if ("userid" in sc)
        {
            if (!("confirm_death" in sc))
                sc.confirm_death <- true;
            else
            {
                if (BaseVS(plr).IsAlive())
                {
                    // VitalSigns
                    if (sc.confirm_death)
                        sc.confirm_death <- false;
                    //
                }
            }
        }
    }
};

second <- -1.00;
TraceSysRun <- function ()
{
    if (!work) return;
    
    //second++;
    local len = Trace_System().table.arr.len();
    for (local i = 0; (len != 0, i < len); i++)
    {
        if (Trace_System().table.arr[i][0] == null || !Trace_System().table.arr[i][0].IsValid())
        {
            Trace_System().table.arr.remove(i),i--,len--;
            continue;
        }
        local l_plr = Trace_System().table.arr[i][0];
        local l_plrSc = l_plr.GetScriptScope();
        local l_TraceOrig = Trace_System().table.arr[i][1];
        if (l_plr != null && l_plr.IsValid())
        {
            if (l_TraceOrig != null)
            {
                local _start = l_plr.EyePosition();
                local Hit = script_main.GetScriptScope().TraceDir(_start, l_TraceOrig.GetForwardVector(), Trace_System().Hammer_Maxd, l_plr).Hit;
                //BaseVS(l_plr).GetHitPosition(Hit);

                //player_info_hud
                local len = (_start - Hit).Length();
                local limit = 128;
                len > limit ? len = limit : null;

                local l_radius = 64;
                local l_tops = 72;
                local dev = 8;
                local l_target = null;
                for (local k = 0; k < len; k+=dev)
                {
                    local l_wayrOri = _start + l_TraceOrig.GetForwardVector() * k;
                    l_target = Entities.FindByClassnameNearest("player", l_wayrOri, l_radius)

                    try
                    {
                        if (l_target != null && l_target.IsValid() && l_target != l_plr && BaseVS(l_target).IsAlive())
                        {
                            local l_targetVector = l_target.EyePosition();
                            local l_dist = l_targetVector - l_wayrOri;
                            if (abs(l_dist.x) <= dev && abs(l_dist.y) <= dev && l_wayrOri.z <= l_targetVector.z && abs(l_dist.z) <= l_tops)
                            {
                                local l_targetUid = l_target.GetScriptScope().userid;
                                local l_text = CharacterInfo[0][g_lang] + "\n\n" + CharacterInfo[2][g_lang] + l_targetUid + "\n" +
                                CharacterInfo[1][g_lang] + BaseVS(l_targetUid).GetIDByUserid(1) + "\n";

                                if (l_target.GetModelName().find("usef") > 0)
                                {
                                    l_text += CharacterInfo[3][g_lang] + CharacterInfo[8][g_lang] + "\n" + 
                                    CharacterInfo[4][g_lang] + CharacterInfo[9][g_lang] + "\n" + 
                                    CharacterInfo[5][g_lang] + CharacterInfo[10][g_lang] + "\n" +
                                    CharacterInfo[6][g_lang] + CharacterInfo[17][g_lang]+ "\n";
                                }
                                else if (l_target.GetModelName().find("usarmy") > 0)
                                {
                                    l_text += CharacterInfo[3][g_lang] + CharacterInfo[11][g_lang] + "\n" + 
                                    CharacterInfo[4][g_lang] + CharacterInfo[14][g_lang] + "\n" + 
                                    CharacterInfo[5][g_lang] + CharacterInfo[15][g_lang] + "\n";
                                }
                                l_text += "\n" + CharacterInfo[7][g_lang] + l_target.GetHealth() + "\n";
                                
                                //humanplayerinfo

                                if (BaseVS(l_targetUid).GetIDByUserid(0) == (STEAMID_PREFIX + CREATED_STEAMID))
                                {
                                    l_text += "\n" + SpecialInfo[0][g_lang] + "\n";

                                    //SpecialInfo[1][g_lang] + "\n" + 
                                    //SpecialInfo[2][g_lang] + "\n" + 
                                    //SpecialInfo[3][g_lang];
                                }

                                ShowGameText(l_plr, l_text);
                                //BaseVS(l_plr).GetHitPosition(l_wayrOri);
                                break;
                            }
                        }
                    }
                    catch (e)
                    {
                        printl(e);
                        break;
                    }
                }
            }
        }
    }
};


