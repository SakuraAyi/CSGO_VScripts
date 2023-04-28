BaseVS(self).IO("OnEventFired", self.GetName(), "RunScriptCode", "OnGameEvent_Inspect(this.event_data)", "0.00", "-1");

OnGameEvent_Inspect <- function (eventdata)
{
    local plr = BaseVS(eventdata.userid).GetPlayerByUserid();
    local plrSc = plr.GetScriptScope();
    if (plr.GetTeam() == 3)
    {
        if (plrSc.vm_isKnife)
            script_item.GetScriptScope().NVG(plr).on_off();
    }
};