//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

_name <- "";
_but <- null;
life <- -1;
second <- 0.00;
supply <- 5;
_usedBy <- null;
progress <- "";
_ui <- null;
_msg <- null;
delay <- 0.05;
pb_current <- 0;
pb_end <- 15;
snd <- ["HUDQuickInfo.LowAmmo", "player/ammo_pack_use.wav"];
cp <- false;
owner <- null;


function OnPostSpawn () {

    //ScriptPrintMessageChatAll("Spawn");

    local data,p,sc,ang,voc,ne;

    _name = self.GetName();

    while ((_but = Entities.FindByName(_but, "ammo_button")) != null) {

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

                sc = p.GetScriptScope();
                voc = sc._class;
                ang = p.GetAngles();

                if (voc == career.support) {

                    self.SetOrigin(sc._deploy);
                    self.SetAngles(0,ang.y,0);

                    //if (sc._deployed[sc._deploycount] != null)

                    //sc._deployed[sc._deploycount].Destroy();

                    sc._deployed[sc._deploycount] = self;
                    owner = p;
                    sc._deploycount++;
                    sc._carry--;

                    return;

                }
            }
        }
    }
    self.Destroy();
}

/*::Think <- function () {

    local data,p,sc,voc,pos,dist,total;

    //if (!pass) {

        second++;

        if (second%2 == 0) {

            foreach (key, value in Player) {

                data = value;

                if (data[0] != null) {

                    p = data[0];

                    if (p.IsValid()) {

                        if (p.GetTeam() == 3) {

                            sc = p.GetScriptScope(),voc = sc._class;
                            pos = p.GetOrigin(),dist = self.GetOrigin(),dist -= pos;
                            total = dist.LengthSqr();

                            if (total < 1024) {

                                pass = true;

                            }
                        }
                    }
                }
            }
        }
        if (life > 0) {

        life--;

        if (life == 0) {

            Remove();

        }
    }
    if (second == 10) {

        second = 0;
        
    }
        
    //}
}*/

OnUse <- function () {

    //ScriptPrintMessageChatAll("Use");

    local p;

    //if (pass) {

        p = activator;

        if (p.IsValid()) {

            if (p.GetTeam() == 3 && p.GetVelocity().z == 0) {

                _usedBy = p;

                //if (_but.GetMoveParent == self)

                if (_ui == null || !_ui.IsValid()) {

                    _ui = Entities.CreateByClassname("game_ui");
                    _ui.__KeyValueFromInt("FieldOfView", -1);
                    _ui.__KeyValueFromInt("spawnflags", 96);
                    _ui.SetOwner(_usedBy);

                    EntIO(_ui, "PlayerOff", _name, "RunScriptCode", "PlayerOff()", "0.00", "-1");

                }

                self.EmitSound(snd[1]);

                EntFireByHandle(_ui, "Activate", "", 0.00, _usedBy, null);
                EntFireByHandle(_but, "Lock", "", 0.00, null, null);

                counter();

            }
        }
    //}
}

counter <- function () {

    progress = "";

    if (_usedBy.GetHealth() > Player_ZeroValue && _usedBy.GetVelocity().z == 0) {

        if (pb_current < pb_end) {

            pb_current++;

            for (local i = 0; i < pb_current; i++) {
               progress += "■";
            }

            for (local i = pb_current; i < pb_end; i++) {
                progress += "□"
            }

            ShowMsg(_usedBy,progress);

        }
        else {

            EntFireByHandle(self, "RunScriptCode", "completed()", 0.00, null, null);

            return;

        }

        EntFireByHandle(self, "RunScriptCode", "counter()", delay, null, null);

    }
    else {

        EntFireByHandle(_ui, "Deactivate", "", 0.00, _usedBy, null);

    }
}

completed <- function () {

    //ScriptPrintMessageChatAll("Complete");

    cp = true;

    self.EmitSound(snd[0]);

    EntFireByHandle(_ui, "Deactivate", "", 0.00, _usedBy, null);
    EntFireByHandle(_ui, "Kill", "", 0.01, null, null);
    EntFireByHandle(_msg, "Kill", "", 0.01, null, null);

    //_ui = null;
    //_msg = null;

    supply--;

    EntFire("@ammo", "GiveAmmo", "", 0.00, _usedBy);

    progress = ["补充完毕","Replenishment completed"];
    ShowMsg(_usedBy,progress[::m_lang]);

    _usedBy = null;

    if (supply <= 0) {

        Remove();

    }

}

PlayerOff <- function () {

    pb_current = 0;

    EntFireByHandle(_but, "Unlock", "", 0.10, null, null);

    if (!cp) {

    progress = ["补充中断","Replenishment aborted"];
    ShowMsg(_usedBy,progress[::m_lang]);

    }

    cp = false;

}

ShowMsg <- function (user,message) {

    if (_msg == null || !_msg.IsValid())

    _msg = Entities.CreateByClassname("env_hudhint");
    _msg.__KeyValueFromString("message", message);
    _msg.SetOwner(user);

    EntFireByHandle(_msg, "ShowHudHint", "", 0.00, user, null);

}

Remove <- function () {

    local removed = false;

    local sc = owner.GetScriptScope();

    for (local i = 0 ; i < sc._deployed.len(); i++) {

        try {

            if (!removed) {

                if (sc._deployed[i] == self) {

                    self.Destroy();
                    sc._deployed[i] = null;
                    sc._deploycount--;
                    removed = true;
                    i--;
                    //ScriptPrintMessageChatAll("for:i="+i);

                }
            }
            else {

                //ScriptPrintMessageChatAll("else:i="+i);

                if (i < sc._deploymax) {

                    //ScriptPrintMessageChatAll("toggle:i="+i);

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

function Precache () {

    self.PrecacheScriptSound(snd[0]);
    self.PrecacheScriptSound(snd[1]);

}