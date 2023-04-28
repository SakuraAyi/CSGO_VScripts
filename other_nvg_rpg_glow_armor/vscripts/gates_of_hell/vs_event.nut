/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/
::script_event <- self;

ShowHudhint <- function (p, t, d = 0.00)
{
    local l_plr = p;
    local l_text = t;
    local l_hint = Entities.FindByClassname(null, "env_hudhint");
    if (l_hint == null)
        l_hint = Entities.CreateByClassname("env_hudhint");
    //BaseVS(l_hint).SetKeyValue("message", l_text);
    EntFireByHandle(l_hint, "AddOutput", "message "+l_text, d, null, null);
    EntFireByHandle(l_hint, "ShowHudHint", "", d, l_plr, l_hint);
    //EntFireByHandle(hint, "Kill", "", d, null, null);
};

::ShowGameText <- function (p, t)
{
    local plr = p;
    local text = t;
    local ent = Entities.FindByClassname(null, "game_text");
    if (ent == null)
        ent = Entities.CreateByClassname("game_text");
    BaseVS(ent).SetKeyValue("channel", 1);
    BaseVS(ent).SetKeyValue("Color", "255 128 0");
    BaseVS(ent).SetKeyValue("holdtime", 0.1);
    BaseVS(ent).SetKeyValue("x", -0.60);
    BaseVS(ent).SetKeyValue("y", -1);
    EntFireByHandle(ent, "AddOutput", "message "+text, 0.00, null, null);
    EntFireByHandle(ent, "Display", "", 0.00, plr, ent);
};

::ShowChatMsg <- function (m, t = null)
{
    local text = MapInfo + m;
    if (t != null)
        ScriptPrintMessageChatTeam(t, text);
    else
        ScriptPrintMessageChatAll(text);
};

g_speedmod <- null;
RunPlayerSpeedMod <- function (n)
{
    local ent;
    if ("g_speedmod" in script_event.GetScriptScope())
    {
        ent = Entities.CreateByClassname("player_speedmod");
        g_speedmod <- ent;
    }
    BaseVS(g_speedmod).SetKeyValue("spawnflags", n);
    return g_speedmod;
};