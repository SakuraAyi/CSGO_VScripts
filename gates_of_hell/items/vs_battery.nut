class Properties
{
    name = "Battery";
    _self = null;
    handle = null;
    Vector = null;
    constructor (handle, vector = null)
    {
        this.handle = handle;
        this.Vector = vector;
    }

    capacity = 100;
    fullpickup = false;
    glow = true;
};

class Battery extends Properties
{
    function go_to_pos ()
    {
        this._self.SetOrigin(Vector);
        EntFireByHandle(_self, "Wake", "", 0.00, _self, _self);
    }

    function OnUse ()
    {
        local items_scope = script_item.GetScriptScope();
        local plr_sc = handle.GetScriptScope();
        local uid = plr_sc.userid;
        local nvg = BaseVS(plr_sc.ent_nvg).GetEntityByIndex();
        local nvg_sc = nvg.GetScriptScope();
        try
        {
            if ("electric" in nvg_sc)
            {
                if (nvg_sc.electric+capacity <= items_scope.NVG.electric)
                    nvg_sc.electric += capacity;
                else
                    nvg_sc.electric = items_scope.NVG.electric;
                BaseVS(handle).PlaySndForClient("items/battery_pickup.wav");
                local l_text = PlayerHint[2][g_lang];
                BaseVS(handle).ShowhintForClient(0, l_text);
                this._self.Destroy();
            }
        }
        catch (e)
        {
            printl(e);
            return;
        }
    }
};

Battery._self <- self;

function OnPostSpawn () 
{
    local items_scope = items_template.GetScriptScope();
    local len = items_scope.Battery_Vector.len();
    if (len < 1)
    {
        self.Destroy();
        return;
    }
    local r = RandomInt(0, len-1);
    local ori = items_scope.Battery_Vector[r];
    Battery(null, ori).go_to_pos();
    items_scope.Battery_Vector.remove(r);
};