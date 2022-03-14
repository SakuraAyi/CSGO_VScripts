//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

_name <- "";
_but <- null;

second <- 0;

damage <- 63.24555320336759;
radius <- 9.797958971132712;
_radang <- 0;
delay <- 0.3;

_msg <- null;
_hint <- "";
snd <- ["Survival.BreachChargeSetArmed", "BaseGrenade.Explode", "11/nazi/prop/explode3.mp3", "11/nazi/prop/explode5.mp3"];

toucher <- null;
owner <- null;

function OnPostSpawn () {

    //ScriptPrintMessageChatAll("Spawn");

    local data,p,sc,voc,pos,ang;

    foreach (key, value in Player) {

        data = value;

        if (data[0] != null) {

            p = data[0];

            if (p.IsValid()) {

                try {

                    sc = p.GetScriptScope();
                    voc = sc._class;
                    pos = p.GetOrigin();
                    ang = p.GetAngles().y;

                    if (voc == career.trap) {

                        self.SetOrigin(pos),self.SetAngles(0,ang,0);

                        self.__KeyValueFromInt("skin", 0);

                        sc._deployed[sc._deploycount] = self;
                        //ScriptPrintMessageChatAll("current_slot:"+sc._deploycount);
                        sc._deploycount++;
                        sc._carry--;
                        //ScriptPrintMessageChatAll("current_num:"+sc._deploycount);

                        owner = p;

                        _hint = ["已部署阔剑","Claymore deployed"];
                        ShowMsg(owner,_hint[::m_lang]);

                        PlayAud(0,pos,0);

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

Think <- function () {

    local ent,p,sc,pos,yaw,dev,dist,total;

    if (toucher == null) {

        second++;

        if (second%2 == 0) {

            while ((ent = Entities.FindByClassname(ent, "*")) != null) {

                if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot") {

                    p = ent;

                    if (p.GetTeam() == 2 && p.GetHealth() > Player_ZeroValue) {

                        pos = p.GetOrigin();
                        dist = self.GetOrigin() + self.GetForwardVector() * 39;

                        /*yaw = _radang * PI / 180;
                        dev = Vector(dist.x+(cos(yaw)*48),dist.y+(sin(yaw)*48),dist.z+5);

                        DebugDrawLine(dist,dev,255,0,0,false,2);

                        _radang += 2;*/

                        dist -= pos;
                        total = dist.LengthSqr();

                        if (total < 2304) {

                            toucher = p;
                            EntFireByHandle(self, "RunScriptCode", "Explode()", delay, null, null);

                        }
                    }
                }
            }
        }
        if (second == 10) {

            second = 0;

        }
    }
}

OnBreak <- function () {

    local p;

    p = activator;

    if (p.GetTeam() == 2 && toucher == null) {

        //ScriptPrintMessageChatAll("Under_Attack");

        toucher = "damage";
        EntFireByHandle(self, "RunScriptCode", "Explode()", delay, null, null);
        
    }
}

Explode <- function () {

    //ScriptPrintMessageChatAll("Boom");

    local exp,pos;

    exp = Entities.CreateByClassname("env_explosion");
    exp.__KeyValueFromInt("iMagnitude", pow(damage,2));
    exp.__KeyValueFromInt("iRadiusOverride", pow(radius,2));
    exp.__KeyValueFromString("classname", "prop_exploding_barrel");
    exp.SetOwner(owner);

    pos = self.GetOrigin() + self.GetForwardVector() * 39;
    exp.SetOrigin(pos);

    EntFireByHandle(exp, "Explode", "", 0.00, owner, null);

    toucher = null;

    local r = RandomInt(2,3);
    PlayAud(r,pos,0);

    Remove();

}

Remove <- function () {

    //ScriptPrintMessageChatAll("Del");

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
                    //ScriptPrintMessageChatAll("slot_clear:"+i);
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

PlayAud <- function (n,o,t) {

    local ent,pos;

    if (t==0) {

        pos = o;
        pos.z += 15;

        ent = Entities.FindByName(null, "map_world_sound");
        ent.__KeyValueFromString("message", snd[n]);

        ent.SetOrigin(pos);

        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);

    }
    else {

        EntFire("clientcommand", "command", "play "+snd[n], 0.00, owner);

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
