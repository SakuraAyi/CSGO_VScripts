BaseVS(self).IO("OnEventFired", self.GetName(), "RunScriptCode", "Reset()", "0.00", "-1");

Reset <- function ()
{
    ::work <- false;
    
    local ent;
    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {
        if (ent.GetClassname().find("viewcontrol") > 0)
        {
            local l_view = ent;
            if (l_view.GetName().find("global") == null)
            {
                EntFireByHandle(l_view, "Disable" ,"", 0.00, null, null);
                EntFireByHandle(l_view, "Kill" ,"", 0.00, null, null);
            }
        }
    }
};