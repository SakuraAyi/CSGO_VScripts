//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

enum sw {
    
    open,
    close

}

_name <- "";
_but <- "";
lid <- sw.close;

_useBy <- [];

_slt <- [];
_Hierarchy <- [];
_type <- [];
_ing <- [];

_ui <- [];
_msg <- [];
g_hint <- [

    ["这里没货了！","This item does not exist"],
    ["你获取了 ","you got a new "]

];
g_mText <- [

    ["【补给箱物资列表】","[Supply List]"], //0
    ["（按移动键切换，鼠标左键确认,右键返回,按E退出)","(W/S Switch items,Mouse[left] is Confirm,Mouse[Right] is Return,Press E Quit)"], //1
    ["步枪","Rifle"], //2
    ["重型枪","Heavy"], //3
    ["微冲","SMG"], //4
    ["手枪","Pistol"], //5
    ["匕首","Knife"], //6
    ["哨兵塔：六管火神,榴弹(机械专属)","Get SentryGun(trap)"], //7
    ["补满技能道具","Get ExclusiveItem"], //8
    ["补满子弹","Get Ammo"], //9
    ["补满护甲","Get Armor"], //10

    ["注意：你已拿过主武器，同种类无法再获取","Can't take primary weapon again"],
    ["注意：你已拿过副武器，同种类无法再获取","Can't take secondary weapon again"]

];
g_wText <- [

    ["M4A1 卡宾枪","M4A1 Carbine"], //0
    ["M4A4 卡宾枪","M4A4 Carbine"], //1
    ["AK-47 突击步枪","AK-47 Assault rifle"], //2
    ["AUG 突击步枪","AUG Assault rifle"], //3
    ["SG553 突击步枪","SG553 Assault rifle"], //4
    ["L115A1 狙击步枪","AWM(Magnum)"], //5
    ["SCAR-20 半自动狙击枪","SCAR-20"], //6

    ["M249 班用机枪","M249 SAW"], //7
    ["MAG-7 霰弹枪","MAG-7"], //8

    ["FN P90 防卫武器","FN P90"], //9
    ["Bison 野牛冲锋枪","Bison"], //10

    ["沙漠之鹰","Desert Eagle"], //11
    ["伯莱塔M9 双持","BERETTA M9"], //12
    ["FN 57 半自动手枪","FiveSeven"], //13

    ["M9刺刀(小)","bayonet"], //14
    ["M9刺刀(大)","M9 bayonet"], //15
    ["熊刀","Ursus Knife"], //16
    ["求生刀","Survival Knife"], //17
    ["绳刀","Paracord Knife"], //18
    ["鲍伊猎刀","Bowie Knife"], //19
    ["爪子刀","Karambit"], //20
    ["猎杀者匕首","Huntsman Knife"], //21
    ["海豹短刀","Classic Knife"] //22

];

wpn <- [

    "m4a1_silencer",
    "m4a1",
    "ak47",
    "aug",
    "sg556",
    "awp",
    "scar20"

    "m249",
    "mag7",

    "p90",
    "bizon",

    "deagle",
    "elite",
    "fiveseven",

    "bayonet",
    "knife_m9_bayonet",
    "knife_ursus",
    "knife_canis",
    "knife_cord",
    "knife_survival_bowie",
    "knife_karambit",
    "knife_tactical",
    "knife_css"

];

prp <- [

    "weapon_smokegrenade",
    "weapon_decoy",
    "ammo",
    "item_assaultsuit",
    "weapon_flashbang"

];

snd <- [ "weapons/c4/key_press2.wav", "survival/armor_pickup_02.wav", "Survival.BriefcaseUnlockSuccess", "Doors.FullClose1" ];

_itemnum <- [];
_re <- [];
_re_n <- [];

_GatlingNum <- 1;

delay <- 0.1;
Land <- false;

function Precache ()
{

    for ( local i = 0; i < snd.len(); i++ )
    {

        self.PrecacheScriptSound(snd[i]);

    }
}

function OnPostSpawn ()
{

    local ne;

    _name <- self.GetName();

    while ( ( _but = Entities.FindByName(_but, "supplycrate_button") ) != null )
    {

        if ( _but.IsValid() )
        {
            if ( _but.GetMoveParent() == self )
            {

                ne = _but.GetName() + "_ready";

                _but.__KeyValueFromString("targetname", ne);

                break;

            }
        }
    }

    EntIO(_but, "OnPressed", _name, "RunScriptCode", "OnUse()", "0.00", "-1");

    for ( local i = 0; i < g_wText.len(); i++ )
    {

        if (i < g_wText.len()-9)
        {
            if ( i > 10 )
                _itemnum.push(2);
            else
                _itemnum.push(1);
        }

        else 

        _itemnum.push("∞");

    }

    //ScriptPrintMessageChatAll("supply_ready");

    for ( local i = 0; i < Player.len(); i++ )
    {
        _re_n.push([false,false]);
    }
}

OnUse <- function () 
{
    DoEntFire("!self", "Lock", "", 0.00, self, self);
    DoEntFire("!self", "UnLock", "", 0.15, self, self);
    local data,atv,p,num,slot,exist = false,review = false;

    atv = activator;

    //ScriptPrintMessageChatAll("Use");

    foreach ( key, value in Player ) 
    {

        data = value;

        if ( data[0] != null ) 
        {

            p = data[0];

            try {

                if ( p.IsValid() ) 
                {

                    if ( p == atv ) 
                    {

                        if ( _useBy.len() > 0 ) 
                        {

                            for ( local i = 0; i < _useBy.len(); i++ ) 
                            {

                                if ( !review )
                                {

                                    if ( _useBy[i] == p ) 
                                    {

                                        slot = i;
                                        exist = true;
                                        //return;

                                    }

                                    if ( !exist && i == _useBy.len()-1 )
                                    {

                                        review = true;
                                        i = -1;

                                        continue;

                                    }
                                }

                                else if ( review && _useBy[i] == null || review && _useBy[i] != null && !_useBy[i].IsValid() ) 
                                {

                                    _useBy[i] = p;
                                    slot = i;
                                    exist = true;

                                    if ( _ing[slot] )
                                    {
                                        _useBy[i] = null;
                                        return;
                                    }

                                    //ScriptPrintMessageChatAll("join");

                                    break;

                                }
                            }
                        }

                        if ( !exist ) 
                        {

                            _useBy.push(null);
                            _ui.push(null);
                            _ing.push(false);

                            for ( local i = 0; i < 5; i++ ) 
                            {

                                if ( i < 2 )
                                {

                                    _slt.push([]);
                                    _Hierarchy.push(false);
                                    //_re.push(false);

                                }
                            }

                            _type.push([]);
                            
                            OnUse();

                            return;

                        }

                        //ScriptPrintMessageChatAll("user_slot:"+slot);

                        if ( !_ing[slot] )
                        {

                            //ScriptPrintMessageChatAll("useing");

                            _ing[slot] = true;

                                if ( slot%2 == 0 )
                                {

                                    if ( slot > 0 ) 
                                    {

                                        num = slot+2;
                                        
                                    }

                                    else 
                                    {

                                        num = slot;

                                    }

                                }

                                else if ( slot%2 == 1 )
                                {

                                    num = slot+1;

                                }

                                //ScriptPrintMessageChatAll("user_total:"+(_useBy.len()-1));
                                //ScriptPrintMessageChatAll("slt_total:"+(_slt.len()-1));

                                if ( _ui[slot] == null || !_ui[slot].IsValid() )
                                {

                                    //ScriptPrintMessageChatAll("Create_UI");

                                    _ui[slot] = Entities.CreateByClassname("game_ui");
                                    _ui[slot].__KeyValueFromInt("spawnflags", 224);
                                    _ui[slot].__KeyValueFromInt("FieldOfView", -1);

                                    EntIO(_ui[slot], "PressedForward", _name, "RunScriptCode", "Move("+slot+" "+num+" 0)", "0.00", "-1");
                                    EntIO(_ui[slot], "PressedBack", _name, "RunScriptCode", "Move("+slot+" "+num+" 1)", "0.00", "-1");
                                    //EntIO(ui[slot], "PressedMoveLeft", self.GetName(), "RunScriptCode", "Left("+slot+","+num+")", "0.00", "-1");
                                    //EntIO(ui[slot], "PressedMoveRight", self.GetName(), "RunScriptCode", "Right("+slot+","+num+")", "0.00", "-1");

                                    EntIO(_ui[slot], "PressedAttack", _name, "RunScriptCode", "Confirm("+slot+" "+num+" 0)", "0.00", "-1");
                                    EntIO(_ui[slot], "PressedAttack2", _name, "RunScriptCode", "Confirm("+slot+" "+num+" 1)", "0.00", "-1");

                                    EntIO(_ui[slot], "PlayerOff", _name, "RunScriptCode", "PlayerOff("+slot+" "+num+")", "0.00", "-1");

                                    //_ui[slot].ConnectOutput("PlayerOff","PlayerOff("+slot+" "+num+")");

                                    _ui[slot].SetOwner(_useBy[slot]);

                                }

                                EntFireByHandle(_ui[slot], "Activate", "", 0.00, _useBy[slot], _ui[slot]);
                                EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, _useBy[slot]);

                                if (lid == sw.close)
                                {

                                    lid <- sw.open;
                                    self.__KeyValueFromInt("sequence", 2);
                                    PlayAud(slot,2,1);

                                }

                                if ( _slt[num].len() == 0 ) 
                                {

                                    for ( local i = 0; i < g_wText.len(); i++ )
                                    {

                                        if ( i < g_mText.len() )

                                        _slt[num].push(false);

                                        _slt[num+1].push(false);

                                        if ( i < 5 )

                                        _type[slot].push(false);

                                    }
                                }

                                //ScriptPrintMessageChatAll("slt_adv_total:"+(_slt[num].len()-1));

                                _slt[num][0] = true;
                                _slt[num+1][0] = true, _slt[num+1][7] = true, _slt[num+1][9] = true, 
                                _slt[num+1][11] = true, _slt[num+1][14] = true;
                                _Hierarchy[num] = true;

                                Menu(slot,num);

                                break;
                        }
                    }
                    else 
                    {

                        continue;

                    }
                }
            }

            catch ( e ) 
            {

                 ScriptPrintMessageChatAll(e.tostring());

            }
        }
    }
}

Menu <- function (k,n) 
{

    local slot = k,_length;
    local _txt,_multi,_r,_l,_color,_x,_y,_in,_out,_hold;
    local id;

    if ( lid == sw.open && _useBy[slot] != null && _useBy[slot].GetHealth() > 0 )
    {

            if ( _ui[k].IsValid() )
            {

            _multi = " X ";
            _l = "》》  ";
            _r = "  《《";
            _txt = g_mText[0][::m_lang] + "\n" + g_mText[1][::m_lang] + "\n" + "\n";

            //if ( _re[n] )
            id = _useBy[slot].GetScriptScope()._id;
            if ( _re_n[id][0] )
            _txt += g_mText[11][::m_lang] + "\n";

            //if ( _re[n+1] )
            if ( _re_n[id][1] )
            _txt += g_mText[12][::m_lang] + "\n";

            if ( _Hierarchy[n] && n%2 == 0 )
            {

                for ( local i = 0; i < g_mText.len()-4; i++ )
                {
       
                    if ( _slt[n][i] == true ) 
                    {
                        _txt += "\n" + _l;
                        if ( i != 5 )
                            _txt += g_mText[i+2][::m_lang];
                        else 
                            _txt += (g_mText[i+2][::m_lang] + _multi + _GatlingNum);
                        _txt += _r;
                    }

                    else 
                    {
                        if ( i != 5 )
                            _txt += "\n" + g_mText[i+2][::m_lang];
                        else 
                            _txt += "\n" + (g_mText[i+2][::m_lang] + _multi + _GatlingNum);
                    }
                }
            }

            else if ( _Hierarchy[n+1] && (n+1)%2 == 1 )
            {

                for ( local i = 0; i < g_wText.len(); i++ )
                {

                    if ( _type[k][0] && i < 7 || _type[k][1] && i > 6 && i < 9 || 
                    _type[k][2] && i > 8 && i < 11 || _type[k][3] && i > 10 && i < 14 || 
                    _type[k][4] && i > 13 && i < 23 )
                    {

                        if ( _slt[n+1][i] == true ) 
                        {

                            _txt += "\n" + _l;
                            _txt += g_wText[i][::m_lang] + _multi + _itemnum[i];
                            _txt += _r;

                        }

                        else 
                        {
                   
                            _txt += "\n" + g_wText[i][::m_lang] + _multi + _itemnum[i];

                        }
                    }
                }
            }

            _color = "215 177 0";
            _x = 0.1;
            _y = 0.33;
            _in = 0.1;
            _out = 0.1;
            _hold = 0.2;

            _length = _useBy.len();

            if ( _msg.len() < _length )
            {

                _length -= _msg.len();

            }

            for ( local i = 0; i < _length; i++ )
            {

               _msg.push(null);

            }

            try
            {
    
                if ( _msg[slot] == null || !_msg[slot].IsValid() ) 
                {

                    //ScriptPrintMessageChatAll("Create_Msg");

                    _msg[slot] = Entities.CreateByClassname("game_text");

                    _msg[slot].__KeyValueFromInt("channel", 2);
                    _msg[slot].__KeyValueFromString("color", _color);
                    _msg[slot].__KeyValueFromFloat("x", _x);
                    _msg[slot].__KeyValueFromFloat("y", _y);
                    _msg[slot].__KeyValueFromFloat("fadein", _in);
                    _msg[slot].__KeyValueFromFloat("fadeout", _out);
                    _msg[slot].__KeyValueFromFloat("holdtime", _hold);

                    _msg[slot].SetOwner(_useBy[slot]);

                }

                _msg[slot].__KeyValueFromString("message", _txt);

                EntFireByHandle(_msg[slot], "Display", "", 0.00, _useBy[slot], _msg[slot]);

           

                EntFireByHandle(self, "RunScriptCode", "Menu("+k+","+n+")", delay, null, null);

            }

            catch ( e ) 
            {

                ScriptPrintMessageChatAll(e.tostring());

            }
        }
    }

    else
    {

        if ( _ui[slot] != null && _ui[slot].IsValid() )

        EntFireByHandle(_ui[slot], "Deactivate", "", 0.00, null, null);

    }

}

Move <- function (k,n,a) 
{

    if (_useBy[k].IsValid()) 
    {

        local i = 0, e = _slt[n].len()-4, d = 7,v = 0;
    

        if ( _Hierarchy[n] ) 
        {

            for ( i; i < e; i++ )
            {

                if ( _slt[n][i] == true )
                {

                    if ( a == 0 && i != 0 )
                    {

                        _slt[n][i] = false;
                        _slt[n][i-1] = true;

                        break;

                    }

                    else if ( a == 1 && i != e-1 )
                    {

                        _slt[n][i] = false;
                        _slt[n][i+1] = true;

                        break;

                    }
                }
            }
        }

        if ( _Hierarchy[n+1] ) 
        {

            if ( _type[k][1] ) { i = 7, d = 9; } 
            if ( _type[k][2] ) { i = 9, d = 11; }
            if ( _type[k][3] ) { i = 11, d = 14; } 
            if ( _type[k][4] ) { i = 14, d = _slt[n+1].len(); }

            v = i;

            for ( i; i < d; i++ )
            {

                if ( _slt[n+1][i] == true )
                {

                    if ( a == 0 && i != v )
                    {


                        _slt[n+1][i] = false;
                        _slt[n+1][i-1] = true;

                        break;

                    }

                    else if ( a == 1 && i != d-1)
                    {

                        _slt[n+1][i] = false;
                        _slt[n+1][i+1] = true;
                        
                        break;

                    }
                }
            }
        }
    }
}

Confirm <- function (k,n,t)
{

    local sc,eq,slot,ed;

    sc = _useBy[k].GetScriptScope();

    PlayAud(k,0,0);

    if ( _Hierarchy[n] && t == 0)
    {

        for ( local i = 0; i < _slt[n].len(); i++ )
        {

            if ( _slt[n][i] )
            {
                EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.1", 0.00, _useBy[k]);
                EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.01, _useBy[k]);

                if ( i < 5 ) 
                {

                    _Hierarchy[n] = false;
                    _Hierarchy[n+1] = true;

                    _type[k][i] = true;

                    break;

                }

                else
                {

                    if ( i < 6 || i > 7 )
                    {

                        if ( i == 5 )
                        {

                            if ( sc._class != career.trap )

                                return;

                            else
                            {
                                if ( _GatlingNum != 0 )
                                    
                                    _GatlingNum -= 1;

                                else
                                
                                    return;

                            }

                        }

                        eq = Entities.CreateByClassname("game_player_equip");

                        eq.__KeyValueFromInt("spawnflags", 5);
                        eq.__KeyValueFromInt(prp[i-5], 1);
                        if (i==5)
                            eq.__KeyValueFromInt(prp[4], 1);

                        EntFireByHandle(eq, "Use", "", 0.00, _useBy[k], eq);
                        EntFireByHandle(eq, "Kill", "", 0.00, null, null);

                    }

                    else if ( i == 6 )

                        sc._carry <- sc._carrymax;

                    else

                        EntFire("@ammo", "GiveAmmo", "", 0.00, _useBy[k]);

                    ShowMsg(k,1,i+2,2);
                    PlayAud(k,1,0);

                    break;

                }
            }
        }
    }

    else if ( _Hierarchy[n+1] && t == 1 )
    {

        if ( !_Hierarchy[n] )
        {

            _Hierarchy[n+1] = false;
            _Hierarchy[n] = true;

        }

        for ( local i = 0; i < _type[k].len(); i++ )
        {

            if ( _type[k][i] )
            _type[k][i] = false;

        }

        EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.1", 0.00, _useBy[k]);
        EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.01, _useBy[k]);

    }

    else if ( _Hierarchy[n+1] && t == 0 )
    {
        
        for ( local i = 0; i < _type[k].len(); i++ )
        {

            if ( _type[k][i] )
            {

                slot = i;
                break;

            }

        }

        local i = 0;ed = 7;

        if ( slot == 1 ) { i = 7, ed = 9; } 
        if ( slot == 2 ) { i = 9, ed = 11; }
        if ( slot == 3 ) { i = 11, ed = 14; } 
        if ( slot == 4 ) { i = 14, ed = _slt[n+1].len(); }

        for ( i; i < ed; i++ )
        {

            if ( _slt[n+1][i] )
            {
                if ( _itemnum[i] != 0 )
                {

                    //ScriptPrintMessageChatAll("get..");

                    EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.1", 0.00, _useBy[k]);
                    EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.01, _useBy[k]);

                    if ( i < 14 )
                    {

                        if ( slot < 3 )
                        {

                            //if (!_re[n])
                            //_re[n] = true;
                            if ( !_re_n[sc._id][0] )
                            _re_n[sc._id][0] = true;
                            else
                            return;

                        }

                        else if ( slot == 3 )
                        {
                        
                            //if (!_re[n+1])
                            //_re[n+1] = true;
                            if ( !_re_n[sc._id][1] )
                            _re_n[sc._id][1] = true;
                            else
                            return;

                        }

                        if (i < g_wText.len()-9)
                        _itemnum[i] -= 1;

                        eq = Entities.CreateByClassname("game_player_equip");

                        eq.__KeyValueFromInt("spawnflags", 5);
                        eq.__KeyValueFromInt("weapon_"+wpn[i], 1);

                        EntFireByHandle(eq, "Use", "", 0.00, _useBy[k], eq);
                        EntFireByHandle(eq, "Kill", "", 0.01, null, null);

                        ShowMsg(k,1,i,0);
                        PlayAud(k,1,0);

                        //ScriptPrintMessageChatAll("done");

                        break;

                    }

                    else
                    {

                        local ent;

                        while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
                        {

                            if ( ent.GetClassname().find("knife", 0) != null )
                            {

                                if ( ent.GetOwner() == _useBy[k] )
                                {

                                    ent.Destroy();

                                    break;

                                }
                            }
                        }

                        PlayAud(k,1,0);
                
                        EntFire("knive_template", "ForceSpawn");
                        EntFireByHandle(self, "RunScriptCode", "GiveKnive("+k+" "+(i-14)+")", 0.01, null, null);

                        break;

                    }
                }

                else
                {

                    ShowMsg(k,0,0,0);

                }
            }
        }
    }
}

GiveKnive <- function (k,n) 
{

    //ScriptPrintMessageChatAll("Find_Knive");

    local ent,pos,knive;

    pos = _useBy[k].GetOrigin();

    knive = [

        "bayonet",
        "m9",
        "ursus",
        "canis",
        "cord",
        "survival",
        "karam",
        "tactical",
        "css"

    ];

    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {

        if (ent.IsValid())
        {
            //ScriptPrintMessageChatAll("Found");

            if (ent.GetModelName().find(knive[n], 0) != null)
            {

                //ScriptPrintMessageChatAll("Give");

                ent.__KeyValueFromString("classname", "weapon_knifegg");
                EntFireByHandle(ent, "addoutput", "targetname knive_", 0.00, null, null);

                ent.SetOrigin(pos);

                ShowMsg(k,1,6,1);

                break;

            }
        }
    }
}

ShowMsg <- function (k,h,n,e)
{

    local ent,text;

    text = g_hint[h][::m_lang];

    if ( h != 0 && e == 0 )
    text += g_wText[n][::m_lang];

    else if ( h != 0 && e == 1 )
    text += g_mText[n][::m_lang];

    else if ( h != 0 && e == 2 )
    {
        if ( ::m_lang == 0 )
            text += g_mText[n][::m_lang].slice(6,g_mText[n][::m_lang].len());
        else
            text += g_mText[n][::m_lang].slice(4,g_mText[n][::m_lang].len());
    }
    
    ent = Entities.CreateByClassname("env_hudhint");

    ent.__KeyValueFromString("message", text);
    ent.SetOwner(_useBy[k]);

    EntFireByHandle(ent, "ShowHudHint", "", 0.00, _useBy[k], ent);
    EntFireByHandle(ent, "Kill", "", 0.01, null, null);

}

PlayAud <- function (k,n,t)
{

    local ent,pos;

    if ( t == 1 )
    {

        pos = self.GetOrigin();

        ent = Entities.FindByName(null, "map_world_sound");
    
        ent.__KeyValueFromString("message", snd[n]);
        ent.SetOrigin(pos);

        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "10", 0.01, null, null);

    }

    else
    {

        EntFire("clientcommand", "command", "play "+snd[n], 0.00, _useBy[k]);

    }
}

PlayerOff <- function (k,n) 
{

    local aw = false;

    //ScriptPrintMessageChatAll("Off and Id is "+k);

    EntFireByHandle(self, "RunScriptCode", "_ing["+k+"] = false", 0.50, null, null);

    for ( local i = 0; i < _slt[n+1].len(); i++ )
    {

        if ( i < _slt[n].len() && _slt[n][i] )

        _slt[n][i] = false;

        if ( _slt[n+1][i] )

        _slt[n+1][i] = false;


        if ( i < 5 && _type[k][i] )

        _type[k][i] = false;
        
        
    }

    _Hierarchy[n] = false;
    _Hierarchy[n+1] = false;

    //EntFire("Player_SpeedMod_limit", "ModifySpeed", "1.0", 0.10, _useBy[k]);
    local id = _useBy[k].GetScriptScope()._id;
    ::VS.SetSpeed(_useBy[k], 0, ::Player_DefSpeed[id]);

    _useBy[k] = null;
    //DoEntFire("!self", "RunScriptCode", "_useBy["+k+"] = null", 0.10, self, self);

    for ( local i = 0; i < _useBy.len(); i++ )
    {

        if ( _useBy[i] != null && _useBy[i].IsValid() )

        break;

        if ( i == _useBy.len()-1 )

        aw = true;

    }

    if ( aw && lid == sw.open )
    {

        lid <- sw.close;
        self.__KeyValueFromInt("sequence", 3);

    }

    _ui[k].Destroy();
    _msg[k].Destroy();

    //ScriptPrintMessageChatAll("Offed");

}

Think <- function ()
{
    if ( !Land )
    {
        local pos = self.GetOrigin();
        pos.z+=22;

        local ent,user;
        while ( ( ent = Entities.FindByClassname(ent, "player") ) != null )
        {
            user = ent;
            if ( user.GetHealth() > 0 )
            {
                local targetOrigin = user.GetOrigin();
                local dist = pos - targetOrigin;
                local total = dist.LengthSqr();
                local hurt;

                if ( total <= 4624 && dist.z > 0 )
                {
                    hurt = Entities.CreateByClassname("point_hurt");
                    hurt.__KeyValueFromString("DamageTarget", user.GetName());
                    hurt.__KeyValueFromInt("DamageType", 1);
                    hurt.__KeyValueFromInt("Damage", 99999);
                    EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                    EntFireByHandle(hurt, "Kill", "", 0.00, null, null);
                }
            }
        }
    }
};
