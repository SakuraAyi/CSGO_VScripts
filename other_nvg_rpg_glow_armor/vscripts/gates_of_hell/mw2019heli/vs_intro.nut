/*enum squad
{
    unknown,

    Alpha,
    Bravo,
    Charlie,
    Delta,
    Echo,
    Foxtrot
};*/
::script_intro <- self;
class configure
{
    g_member_limit = 3;
    g_heli_frame_length = 36;
    g_ropecutoff_frame_length = 15;
    g_pilot_frame_length = 15;
    g_marine_frame_length = 11.8;
    g_marine_frame_superposition = 1.50;

    g_name = "pre-"+"intro_dropanim_";
    g_heli_attach = "body";
    g_member_attach = "Camera";
    g_run = "spawn";

    g_nvg = true;
    g_interior_lights = false;
    g_searchlight = false;

    g_model_heli = ModelList[3];g_model_rope = ModelList[4];g_model_pilot = ModelList[9];g_model_marine = ModelList[10];
    g_anim_pilot = ModelList[5];g_anim_guy = [ModelList[6], ModelList[7], ModelList[8]];
};

class helicopter extends configure
{
    vector = null;
    angles = null;
    constructor (pos, ang)
    {
        if ((typeof pos).tolower() == "vector" && (typeof ang).tolower() == "vector")
        {
            this.vector = pos;
            ang.y -= 180;
            this.angles = ang;
        }
        else
            return;
    };

    arr = [];
    droped  = {};

    team = {
        num = 0,
        function squad (temp=null)
        {
            local value = num;
            if (temp != null)
                value = temp;
            switch (value)
            {
                case 1  : return "alpha";
                case 2  : return "bravo";
                case 3  : return "charlie";
                case 4  : return "delta";
                case 5  : return "echo";
                case 6  : return "foxtrot";
                default : return "squad_"+num;
            }
        }
    };

    function spawn()
    {
        printl("\nexecute_copter_script..");

        this.arr.clear();

        local allow = false;
        local num = 0;
        local ent;
        for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
        {
            if (BaseVS(ent).IsPlayer())
            {
                local l_plr = ent, l_uid;
                if (l_plr.IsValid() && BaseVS(l_plr).IsAlive() && l_plr.GetTeam() == 3)
                {
                    if (l_plr.ValidateScriptScope())
                    {
                        try { l_uid = l_plr.GetScriptScope().userid.tointeger(); }
                        catch (e)
                        {
                            Msg("\n"+e);
                            return;
                        }
                    }
                    if (!(l_uid.tostring() in this.droped))
                    {
                        this.arr.push(l_plr);
                        this.droped[l_uid.tostring()] <- 1;
                        num++;
                        printl("GetPlayerFromArray.. Name = "+l_plr.GetName());
                        !allow ? allow = true : null;
                    }
                    else
                        continue;
                    if (num==g_member_limit)
                        break;
                }
            }
        }
        printl("arr_len > "+this.arr.len().tostring());
        if (!allow) return "No member";
        printl("run...\n");

        this.arr = BaseVS(null).RandomNotRepeat(arr);
        this.team.num += 1;
        local l_squad = team.squad();
        if (l_squad == null) 
        {
            printl("it's used up");
            return
        };

        local m_heli = CreateProp("prop_dynamic", vector, g_model_heli, 0);
        BaseVS(m_heli).SetKeyValue("angles", angles);

        local m_pilot = CreateProp("prop_dynamic_ornament", vector, g_model_pilot, 0);
        local a_pilot = CreateProp("prop_dynamic", vector, g_anim_pilot, 0);
        BaseVS(a_pilot).SetKeyValue("angles", angles);

        local ma_guy = [];

        BaseVS(m_heli).SetKeyValue("targetname", g_name+"heli_"+l_squad);
        BaseVS(m_heli).SetBodyGroup(16);
        BaseVS(a_pilot).SetKeyValue("targetname", g_name+"chiefl_"+l_squad);
        BaseVS(a_pilot).IO("OnAnimationDone", "!self", "SetParent", m_heli.GetName(), "0.00", "1");
        BaseVS(a_pilot).IO("OnAnimationDone", "!self", "SetParentAttachmentMaintainOffset", g_heli_attach, "0.01", "1");
        BaseVS(m_pilot).SetAttached(a_pilot);

        BaseVS(m_heli).SetAnim(g_run, 0.00);
        BaseVS(m_heli).SetBodyGroup(24, g_ropecutoff_frame_length+0.25);
        BaseVS(a_pilot).SetAnim(g_run, 0.00);
        BaseVS(m_heli).Kill(g_heli_frame_length);
        //BaseVS(sign_heli).Kill(g_heli_frame_length);
        BaseVS(m_pilot).Kill(g_heli_frame_length);
        //BaseVS(a_pilot).Kill(g_heli_frame_length);

        script_snd_template.GetScriptScope().Spawn(0);
        local delay = 0.00,delay2 = 0.00;
        for (local i = 0; i < this.arr.len(); i++)
        {
            ma_guy.append([null, null]);
            ma_guy[i][0] = CreateProp("prop_dynamic_ornament", vector, g_model_marine, 0);
            BaseVS(ma_guy[i][0]).SetKeyValue("skin", arr[i].GetScriptScope().skin);
            ma_guy[i][1] = CreateProp("prop_dynamic", vector, g_anim_guy[i], 0);
            BaseVS(ma_guy[i][1]).SetKeyValue("angles", angles);

            local l_uid = arr[i].GetScriptScope().userid;
            BaseVS(ma_guy[i][1]).SetKeyValue("targetname", g_name+"guy_"+l_squad+"_uid_"+l_uid);
            BaseVS(ma_guy[i][1]).SetAnim(g_run, 0.00);
            BaseVS(ma_guy[i][0]).SetAttached(ma_guy[i][1]);

            local l_cam = Entities.CreateByClassname("point_viewcontrol");
            BaseVS(l_cam).SetKeyValue("targetname", g_name+"cam_"+l_squad+"_uid_"+l_uid)
            BaseVS(l_cam).SetKeyValue("spawnflags", 168);
            BaseVS(l_cam).SetKeyValue("fov", 90);
            BaseVS(l_cam).SetKeyValue("fov_rate", 1);
            BaseVS(l_cam).SetParentAttachment(ma_guy[i][1], g_member_attach);
            EntFireByHandle(l_cam, "Enable", "", 0.03, arr[i], l_cam);
            EntFireByHandle(l_cam, "Disable", "", g_marine_frame_length+delay, arr[i], l_cam);BaseVS(l_cam).Kill(g_marine_frame_length+delay);

            BaseVS(ma_guy[i][0]).Kill(g_marine_frame_length+delay);BaseVS(ma_guy[i][1]).Kill(g_marine_frame_length+delay);
            DoEntFire("!self", "RunScriptCode", "Land("+l_uid+" "+team.num+")", g_marine_frame_length+delay-0.03, script_intro, script_intro);

            delay2 += 0.01;
            EntFireByHandle(script_snd_template, "RunScriptCode", "Spawn("+(i+1)+" "+team.num+" "+l_uid+")", delay2, null, null);

            if (i==(2-1))
                delay -= 0.15
            delay += g_marine_frame_superposition;
        }

        local sign_heli = Entities.CreateByClassname("info_target");
        BaseVS(sign_heli).SetKeyValue("targetname", g_name+"sign_"+l_squad);
        BaseVS(sign_heli).SetParentAttachment(m_heli, g_heli_attach);
        //ScriptPrintMessageChatAll("test");
    }
};

Land <- function (uid, squad)
{
    local guy = Entities.FindByName(null, helicopter.g_name+"guy_"+helicopter.team.squad(squad.tointeger())+"_uid_"+uid);
    if (uid.tostring() in helicopter.droped)
    {
        local l_attachid = guy.LookupAttachment(helicopter.g_member_attach);
        local l_pos = guy.GetAttachmentOrigin(l_attachid) + guy.GetForwardVector() * abs(-16);
        local l_ang = guy.GetAngles();
        local l_plr;
        while ((l_plr = Entities.FindByClassname(l_plr, "player")) != null)
        {
            if (BaseVS(l_plr).IsAlive() && l_plr.GetTeam() == 3)
            {
                local l_sc = l_plr.GetScriptScope();
                if ("userid" in l_sc)
                {
                    if (uid == l_sc.userid)
                    {
                        local l_measureVector = Vector(l_pos.x, l_pos.y, l_pos.z);
                        l_measureVector.z -= 72;
                        local l_fraction = TraceLine(l_pos, l_measureVector, null);
                        local l_hit = l_pos + (l_measureVector - l_pos) * l_fraction;
                        /*DebugDrawLine( l_hit - Vector(10, 0, 0), l_hit + Vector(10, 0, 0), 255, 0, 0, true, 5 );
                        DebugDrawLine( l_hit - Vector(0, 10, 0), l_hit + Vector(0, 10, 0), 0, 255, 0, true, 5 );
                        DebugDrawLine( l_hit - Vector(0, 0, 10), l_hit + Vector(0, 0, 10), 0, 0, 255, true, 5 );*/
                        l_plr.SetOrigin(l_hit);
                        l_plr.SetAngles(l_ang.x, l_ang.y-180, l_ang.z);
                        if (helicopter.g_nvg)
                        {
                            script_item.GetScriptScope().g_allow_use_nvg <- true;
                            script_item.GetScriptScope().NVG(l_plr).on_off();
                        }
                        BaseVS(l_plr).GetItem("weapon_galilar", 0.50);
                        break;
                    }
                }
            }
        }
    }
};
