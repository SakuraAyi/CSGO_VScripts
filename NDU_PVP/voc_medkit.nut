//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

life <- -1;
second <- 0;

heal <- 500;

owner <- null;

function OnPostSpawn () 
{

    //ScriptPrintMessageChatAll("Item_Spawn");

    local data,p,sc,ang,voc,skin;

    foreach (key, value in Player) 
    {

        data = value;

        if (data[0] != null) 
        {

            p = data[0];

            if (p.IsValid()) 
            {

                //ScriptPrintMessageChatAll("Found_Player");

                sc = p.GetScriptScope();
                voc = sc._class;
                ang = p.GetAngles();

                if (voc == career.doctor) 
                {

                    //ScriptPrintMessageChatAll("Class_Confirm");

                    local r = RandomInt(0,2);
                    self.__KeyValueFromInt("skin",r);

                    self.SetOrigin(sc._deploy),self.SetAngles(-90,ang.y,0);

                    //ScriptPrintMessageChatAll("Item_Move");

                    //if (sc._deploycount > sc._deploymax-1)
                    //ScriptPrintMessageChatAll("Maximum");

                    //ScriptPrintMessageChatAll("Check_Item_Num..");

                    //if (sc._deployed[sc._deploycount] != null)
                    //sc._deployed[sc._deploycount].Destroy();
                    sc._deployed[sc._deploycount] = self;
                    sc._deploycount++;
                    sc._carry--;

                    owner = p;

                    //ScriptPrintMessageChatAll("Complete");

                    //ScriptPrintMessageChatAll("medkit_ready!");

                    return;

                }
            }
        }
    }
    self.Destroy();
}

::Think <- function () 
{

    local data,p,sc,currentHP,voc,pos,dist,total;

    second++;

    if (second%2 == 0) 
    {

        //ScriptPrintMessageChatAll("1");

        foreach (key, value in Player)
        {

            data = value;

            if (data[0] != null) 
            {

                p = data[0];

                if (p.IsValid()) 
                {

                    if ( p.GetTeam() == 3 && p.GetHealth() > 0 ) 
                    {

                        try {

                            sc = p.GetScriptScope(),voc = sc._class;
                            pos = p.GetOrigin(),dist = self.GetOrigin(),dist -= pos;
                            total = dist.LengthSqr();
                            currentHP = p.GetHealth();

                            if (total < 1024 && currentHP < Player_Health[key] && voc != career.doctor) {

                                self.EmitSound("HealthShot.Pickup");
                                Remove();

                                if (currentHP+heal > Player_Health[key])

                                p.SetHealth(Player_Health[key]);

                                else

                                p.SetHealth(currentHP+heal);

                                local fade = Entities.CreateByClassname("env_fade");

                                fade.__KeyValueFromString("spawnflags", "5");
                                fade.__KeyValueFromString("duration", "0.2");
                                fade.__KeyValueFromString("ReverseFadeDuration", "0.2");
                                fade.__KeyValueFromString("holdtime", "0");
                                fade.__KeyValueFromString("renderamt", "10");
                                fade.__KeyValueFromString("rendercolor", "128 255 0");
        
                                EntFireByHandle(fade, "Fade", "", 0.00, p, null);
                                EntFireByHandle(fade, "Kill", "", 0.01, null, null);
                            }
                        }
                        catch (e) 
                        {

                            ScriptPrintMessageChatAll(e.tostring());

                        }
                    } 
                }
            }
        }
    }
    if (life > 0) 
    {

        life--;

        if (life == 0) 
        {

            Remove();

        }
    }
    if (second == 10) 
    {

		second = 0;

    }
}

::Remove <- function () 
{

    //ScriptPrintMessageChatAll("Remove");

    local removed = false;

    local sc = owner.GetScriptScope();

    for (local i = 0 ; i < sc._deployed.len(); i++) 
    {

        //ScriptPrintMessageChatAll("Find..");

        try 
        {

            if (!removed) 
            {

                //ScriptPrintMessageChatAll("try");

                if (sc._deployed[i] == self) 
                {
        
                    self.Destroy();
                    sc._deployed[i] = null;
                    sc._deploycount--;
                    removed = true;
                    i--;

                    //ScriptPrintMessageChatAll("Del");

                    //break;

                }
            }
            else 
            {

                if (i < sc._deploymax) 
                {
                    
                    sc._deployed[i] = sc._deployed[i+1];

                }

                else 
                {

                    sc._deployed[i] = null;
                    
                }
            }
        }
        catch (e) 
        {

            ScriptPrintMessageChatAll(e.tostring());

        }
    }
}

function Precache () 
{

    self.PrecacheScriptSound("HealthShot.Pickup");
    
}
