//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

_name <- "";
_but <- null;

sup <- 5;
body <- 0;

pb_current <-0;
pb_end <- 15;
delay <- 0.05;

_msg <- null;
_prog <- "";

_ui <- null;

snd <- ["survival/armor_pickup_01.wav", "Hostage.PickUp", "ui/beepclear.wav"];

_cp <- false;

owner <- null;
_usedBy <- null;
_pickup <- [];

function OnPostSpawn () {

    //ScriptPrintMessageChatAll("Spawn");

    local data,p,sc,voc,ang,ne;

    _name = self.GetName();

    while ((_but = Entities.FindByName(_but, "vestbag_button")) != null) {

        if (_but.GetMoveParent() == self) {

            ne = _but.GetName() + "_ready";

            _but.__KeyValueFromString("targetname", ne);

            break;

        }
    }

    EntIO(_but, "OnPressed", _name, "RunScriptCode", "OnUse()", "0.00", "-1");

    foreach (key, value in Player) {

        data = value;

        if (data[0] != null) {

            p = data[0];

            if (p.IsValid()) {
                
                try {

                    sc = p.GetScriptScope();
                    voc = sc._class;
                    ang = p.GetAngles().y;

                    if (voc == career.rook) {

                        self.SetOrigin(sc._deploy);
                        self.SetAngles(0,ang+90,0);

                        sc._deployed[sc._deploycount] = self;
                        sc._deploycount++;
                        sc._carry--;

                        owner = p;

                        return;
                    }
                }
                catch (e) {

                    ScriptPrintMessageChatAll(e.tostring());

                }
            }
        }
    }
    self.Destroy();
}

OnUse <- function () {

    //ScriptPrintMessageChatAll("Use");

    local p,pos;

    p = activator;

    if (p.GetTeam() == 3 && p.GetVelocity().z == 0) {

        if (_pickup.len() > 0) {

            for (local i = 0; i < _pickup.len(); i++) {

                if (_pickup[i] == p) {

                    PlayAud(2,null,1,p);

                    _prog = ["你已经拿取过了","You've already taken one."];
                    ShowMsg(p,_prog[::m_lang]);

                    return;

                }
            }
        }

        _usedBy = p;
        pos = self.GetOrigin();

        if (_ui == null || !_ui.IsValid()) {

            _ui = Entities.CreateByClassname("game_ui");
            _ui.__KeyValueFromInt("FieldOfView", -1);
            _ui.__KeyValueFromInt("spawnflags", 96);

            EntIO(_ui, "PlayerOff", _name, "RunScriptCode", "PlayerOff()", "0.00", "-1");

        }
        _ui.SetOwner(_usedBy);

        PlayAud(1,pos,0,null);

        EntFireByHandle(_ui, "Activate", "", 0.00, _usedBy, null);
        EntFireByHandle(_but, "Lock", "", 0.00, null, null);

        counter();

    }
}

counter <- function () {

    _prog = "";

    if (_usedBy.GetHealth() > Player_ZeroValue && _usedBy.GetVelocity().z == 0) {

        if (pb_current < pb_end) {

            pb_current++;

            for (local i = 0; i < pb_current; i++) {

                _prog += "■";

            }

            for (local i = pb_current; i < pb_end; i++) {

                _prog += "□";

            }

            ShowMsg(_usedBy,_prog);

        }

        else {

            completed();

            return;
        }

        EntFireByHandle(self, "RunScriptCode", "counter()", delay, null, null);

    }
    else {

        EntFireByHandle(_ui, "Deactivate", "", 0.00, _usedBy, null);

    }
}

completed <- function () {

    //ScriptPrintMessageChatAll("complete");

    _cp = true;

    PlayAud(0,null,1,null);

    EntFireByHandle(_ui, "Deactivate", "", 0.00, _usedBy, null);
    EntFireByHandle(_ui, "Kill", "", 0.01, null, null);
    EntFireByHandle(_msg, "Kill", "", 0.01, null, null);

    sup--;
    _pickup.push(_usedBy);

    if (body != 4)
    self.__KeyValueFromInt("body", (body+=1));

    Giveitem();

    _prog = ["已获取护甲","Got new armor."];
    ShowMsg(_usedBy,_prog[::m_lang]);

    if (sup==0) {

        Remove();

    }

}

PlayerOff <- function () {

    pb_current = 0;

    EntFireByHandle(_but, "Unlock", "", 0.00, null, null);

    if (!_cp) {

        _prog = ["获取中断","Obtainment aborted"];
        ShowMsg(_usedBy,_prog[::m_lang]);

    }

    _usedBy = null;
    _cp = false;

}

Remove <- function () {

    local removed = false;
    local sc = owner.GetScriptScope();

    for (local i = 0; i < sc._deployed.len(); i++) {

        try {

            if (!removed) {

                if (sc._deployed[i] == self) {

                    self.Destroy();
                    sc._deployed[i] = null;
                    sc._deploycount--;
                    removed = true;
                    i--;      

                }
            }
            else {

                if (i < sc._deploymax) {

                    sc._deployed[i] = sc._deployed[i+1];

                }
                else {

                    sc._deployed[i] = null;

                }
            }
        }
        catch (e) {

            ScriptPrintMessageChatAll(e.tostring());

        }
    }
}

Giveitem <- function () {

    local ent,it;

    it = "item_assaultsuit";

    ent = Entities.CreateByClassname("game_player_equip");
    ent.__KeyValueFromInt("spawnflags", 5);

    ent.__KeyValueFromInt(it, 1);

    EntFireByHandle(ent, "Use", "", 0.00, _usedBy, null);

}

PlayAud <- function (n,o,t,a) {

    local p,ent,pos;

    p = _usedBy;

    if (p == null)
    p = a;

    if (t==0) {

        pos = o;
        pos.z += 15;

        ent = Entities.FindByName(null, "map_world_sound");
        ent.__KeyValueFromString("message", snd[n]);

        ent.SetOrigin(pos);

        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);

    }
    else {

        EntFire("clientcommand", "command", "play "+snd[n], 0.00, p);

    }
    
}

ShowMsg <- function (user,message) {

    if (_msg == null || !_msg.IsValid())

    _msg = Entities.CreateByClassname("env_hudhint");
    _msg.__KeyValueFromString("message", message);
    _msg.SetOwner(user);

    EntFireByHandle(_msg, "ShowHudHint", "", 0.00, user, null);

}

function Precache () {

    for (local i = 0; i < snd.len(); i++) {

        self.PrecacheScriptSound(snd[i]);

    }
}
