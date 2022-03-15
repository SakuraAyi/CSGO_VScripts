//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

SuperjumpTimer <- function ()
{
    if ( ::isOver )
        return;

    DoEntFire("!self", "RunScriptCode", "SuperjumpTimer()", 1.00, self, self);

    for ( local i = 5; i < BOT.len(); i++ )
    {
        if ( ::BOT[i][0] != null && ::BOT[i][0].IsValid() )
        {
            local atvr = ::BOT[i][0];
            local sec = ::BOT[i][13];
            local sw = ::BOT[i][14]
            if ( sec > 0 && !sw )
                ::BOT[i][13] -= 1;
            if ( ::BOT[i][13] == 0 && !sw && atvr.GetModelName() != ::zombie_model[31] )
            {
                ::BOT[i][14] = true;

                /*local ent = null;
                ent = Entities.FindByName(null, "superj_"+i);
                if ( ent == null )
                {
                    ent = Entities.CreateByClassname("game_ui");
                    ent.__KeyValueFromString("message", "superj_"+i);
                    ent.__KeyValueFromInt("spawnflags", 256);
                    ent.__KeyValueFromInt("FieldOfView", -1);
                    ent.SetOwner(atvr);
                    EntIO(ent, "PlayerOff", self.GetName(), "RunScriptCode", "Superjump("+i+")", "0.00", "-1");
                }
                EntFireByHandle(ent, "Activate", "", 0.00, atvr, null);*/
                local _msg = Entities.CreateByClassname("env_message");
                local _text = ["你的超级跳已就绪【按F】","SuperJump Ready[Press F]"];
                _msg.__KeyValueFromString("message", _text[m_lang]);
                EntFireByHandle(_msg, "ShowMessage", "", 0.00, atvr, null);
                EntFireByHandle(_msg, "Kill", "", 0.01, null, null);
                ::VS.PlayClientSnd(atvr, ::Event_Snd[0]);
            }
        }
    }
};

Superjump <- function (eventdata)
{
    local atvr = ::GetPlayerByUserid(eventdata.userid),id;

    if ( atvr.GetTeam() == 2 )
    {
        local pass = false;
        for ( local i = 0; i < ( ::BOT.len() + ::zombie_model.len() ); i++ )
        {
            if ( !pass && i < ::BOT.len() && ::BOT[i][0] == atvr )
            {
                id = i;
                pass = true;
                i = 0;
            }
            if ( pass )
            {
                if ( atvr.GetModelName() == ::zombie_model[i] )
                {
                    if ( i < (25+1) )
                        break;
                    else
                        return;
                }
            }
        }
        if ( ::BOT[id][14] )
        {
            local pos = atvr.GetOrigin();pos.z += 36;
            local yaw = atvr.GetAngles().y * PI / 180;
            atvr.SetVelocity(Vector(cos(yaw)*800, sin(yaw)*800, 650));
            ::BOT[id][14] = false;
            ::BOT[id][13] = 10;
            ::VS.PlayPosSnd(pos,::zombie_snd[19], 10, 0.00);
            ::VS.PlayPosSnd(pos,::zombie_snd[20], 10, 0.30);
            ::VS.PlayPosSnd(pos,::zombie_snd[18], 10, 0.60);
            ::VS.PlayClientSnd(atvr, ::zombie_snd[20]);
        }
    }
};