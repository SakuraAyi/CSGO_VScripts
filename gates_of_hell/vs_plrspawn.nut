BaseVS(self).IO("OnEventFired", self.GetName().tostring(), "RunScriptCode", "OnGameEvent_player_spawn(this.event_data)", "0.00", "-1");

RPG_Equipped <- { //After this game is equipped, it will not be equipped again unless the next game

};

OnGameEvent_player_spawn <- function (eventdata)
{
    if (!work) return;

    local plr = BaseVS(eventdata.userid).GetPlayerByUserid();
    local team = eventdata.teamnum;
    switch (team)
    {
        case 2:
        {
            break;
        }
        case 3:
        {
            DoEntFire("!self", "RunScriptCode", "ct()", 0.30, self, self);
            break;
        }
        default:
            return;
    }
};

function OnPostSpawn ()
{
    DoEntFire("!self", "RunScriptCode", "ct()", 1.00, self, self);
    any();
};


function ct ()
{
    local playerscope = script_player.GetScriptScope();
    local itemscope = script_item.GetScriptScope();

    playerscope.Trace_System()._Reg();

    local len = playerscope.Trace_System.table.arr.len();
    for (local i = 0; len != 0, i < len; i++)
    {
        local l_plr = playerscope.Trace_System.table.arr[i][0];
        local l_plrSc = l_plr.GetScriptScope();
        if (!("m_dummy" in l_plrSc) || l_plrSc.m_dummy == null || !(l_plrSc.m_dummy.IsValid()))
        {
            if (!(l_plrSc.userid.tostring() in RPG_Equipped))
            {
                playerscope.PlayerDummy(l_plr).Create();
                itemscope.RPG(l_plr).BindAT4ForBack();
                itemscope.RPG(l_plr).Operation();
                RPG_Equipped[l_plrSc.userid.tostring()] <- 1;
            }
        }
    }
};

function t ()
{
    
}

function any ()
{
    local ent;
    for (ent = Entities.First(); ent != null; ent = Entities.Next(ent))
    {
        if (BaseVS(ent).IsPlayer())
        {
            local plr = ent;
            BaseVS(plr).SetRenderAmt(0, 255);
        }
    }
};