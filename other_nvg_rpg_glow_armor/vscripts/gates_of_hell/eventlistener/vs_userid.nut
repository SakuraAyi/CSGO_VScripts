/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

const label = "userid";
::Players <- {};
g_target <- null;

function OnPostSpawn ()
{
    g_proxy <- Entities.CreateByClassname("info_game_event_proxy");
    //proxy.__KeyValueFromString("targetname", "event_proxy-use");
    g_proxy.__KeyValueFromString("event_name", "player_use");
    g_proxy.__KeyValueFromInt("range", -1);
    BaseVS(self).IO("OnEventFired", self.GetName(), "RunScriptCode", "OnGameEvent_player_use(this.event_data)", "0.00", "-1");
};

OnGameEvent_player_use <- function (event_data)
{
    if (g_target != null)
    {
        local l_param = event_data.userid;
        try
            if (g_target.IsValid()) null;
        catch (e)
        {
            printl(e.tostring());
            g_target <- null;
            return;
        }
        g_target.GetScriptScope().userid <- l_param;
        g_target.__KeyValueFromString("targetname", "Player-"+l_param);
        //reg();

        local l_constTable = getconsttable();
        try if (l_constTable[l_param.tostring()] != null) null;
        catch (e) { l_constTable[l_param.tostring()] <- ["Unknown", "Unknown"]; printl(e); }
        g_target <- null;
    }
    UseItem(event_data);
};

Think <- function ()
{
    local l_ent;
    for (l_ent = Entities.First(); l_ent != null; l_ent = Entities.Next(l_ent))
    {
        if (l_ent.GetClassname() == "player" || l_ent.GetClassname() == "cs_bot")
        {
            local l_plr = l_ent;
            if (l_plr.IsValid() && BaseVS(l_plr).IsAlive())
            {
                local l_sc, l_n = "-1";
                if (l_plr.ValidateScriptScope())
                    l_sc = l_plr.GetScriptScope();
                if (!(label in l_sc) || l_sc.userid == l_n.tointeger())
                {
                    if (!("g_target" in this) || g_target == null)
                    {
                        g_target <- l_plr;
                        g_target.GetScriptScope().userid <- l_n.tointeger();
                        EntFireByHandle(g_proxy, "GenerateGameEvent", "", 0.00, l_plr, g_proxy);
                    }
                }

                if ("skin" in l_sc)
                    null;//Set(l_plr, l_sc.skin);
                else
                    reg(l_plr);
            }
        }
    }
};

reg <- function (h) {local sc = h.GetScriptScope(); if (h.GetTeam() == 3){local l_skin = RandomInt(0,2); sc.skin <- l_skin; }};
Set <- function (h, n) { if (h.GetTeam() != 3 || h.GetModelName().find("usef") > 0) return; switch (n) { case 0: { h.SetModel(ModelList[11]); break; } case 1: { h.SetModel(ModelList[12]); break; } case 2: { h.SetModel(ModelList[13]); break; } default: return; } local bodyindex = 5; h.GetScriptScope().body_idx <- bodyindex; BaseVS(h).SetBodyGroup(bodyindex); };

UseItem <- function (params)
{
    local player = BaseVS(params.userid).GetPlayerByUserid();
    local entity = BaseVS(params.entity).GetEntityByIndex();
    if (entity.GetClassname().find("physics") > 0)
    {
        local l_phyItem =  entity;
        local l_sc; 

        if (l_phyItem.ValidateScriptScope())
            l_sc = l_phyItem.GetScriptScope();

        if (l_sc.Properties.name.tolower() == "battery")
            l_sc.Battery(player).OnUse();
        else if (l_sc.Properties.name.tolower() == "armorplate")
            l_sc.ArmorPlate(params.userid).OnUse();
    }
};