class Properties
{
    Vector = null;
    Angles = null;
    ID = null;
    constructor (id, vector = null)
    {
        this.ID = id;
        this.Vector = vector;
    }

    _self = null;
    name = "armorplate";
};

class ArmorPlate extends Properties
{
    function ready ()
    {
        _self.SetOrigin(Vector);
        //_self.SetAngles(Angles.x, Angles.y, Angles.z);
        DoEntFire("!self", "Wake", "", 0.00, _self, _self);
    }

    function OnUse ()
    {
        local plr = BaseVS(ID).GetPlayerByUserid();
        local plrSc = plr.GetScriptScope();
        local itemSc = script_item.GetScriptScope();
        local text;
        if (plrSc.armor_number < itemSc.ArmorPlate.default_num)
        {
            plrSc.armor_number++;
            _self.Destroy();
            BaseVS(plr).PlaySndForClient(SoundList[21]);
            text = PlayerHint[6][g_lang];
            
        }
        else
            text = PlayerHint[7][g_lang];
        text += " / " + PlayerHint[4][g_lang] + plrSc.armor_number;
        BaseVS(plr).ShowhintForClient(0, text);
    }
};

ArmorPlate._self <- self;

function OnPostSpawn ()
{
    local template = items_template.GetScriptScope();
    local arrlen = template.ArmorPlate_Vector.len();
    if (arrlen < 1)
    {
        _self.Destroy();
        return;
    }

    local r = RandomInt(0, arrlen-1);
    local pos = template.ArmorPlate_Vector[r];

    pos.z+=9;
    ArmorPlate(null, pos).ready();
    template.ArmorPlate_Vector.remove(r);
};