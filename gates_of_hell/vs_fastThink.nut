/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

Think <- function ()
{
    DoEntFire("!self", "RunScriptCode", "Think()", 0.01, self, self);
    if (!work) return;
    
    //try 
    //{
        items.Think();
        script_item.GetScriptScope().items.FindGibs();
    //} 
    //catch (e)
    //    printl(e)

    local ent;
    for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
    {
        if (BaseVS(ent).IsPlayer())
        {
            local plr = ent;
            if (plr.GetTeam() == 3)
            {
                if (BaseVS(plr).IsAlive())
                {
                    local l_plrSc = plr.GetScriptScope();
                    if ("m_dummy" in l_plrSc && l_plrSc.m_dummy != null && l_plrSc.m_dummy.IsValid())
                    {
                        local l_dummy = l_plrSc.m_dummy;
                        local l_dummySc = l_dummy.GetScriptScope();

                        local l_plrPos = plr.GetOrigin();
                        local l_traceAng = l_plrSc.trace.GetAngles();
                        BaseVS(l_dummy).SetKeyValue("origin", l_plrPos);
                        BaseVS(l_dummy).SetKeyValue("angles", "0 " + l_traceAng.y + " 0");

                        l_dummySc.Think();
                    }
                }
            }
        }
    }
};

function OnPostSpawn ()
{
    Think();
};