::script_playerdeath <- self;

eventlistener <- {previous = null, run_number = 0, eventdata = {}};

function eventlistener::OnGameEvent_player_death (event_data)
{
    run_number++;
    if (run_number == 1)
        DoEntFire("!self", "RunScriptCode", "eventlistener.run_number <- 0", 0.03, script_playerdeath, script_playerdeath);

    local _max = 3;
    if (run_number == _max)
        return;

    if (previous == event_data)
    {
        local plr;
        local delay = 0.00;
        while ((plr = Entities.FindByClassname(plr, "player")) != null)
        {
            local sc = plr.GetScriptScope();
            if ("confirm_death" in sc)
            {
                if (!BaseVS(plr).IsAlive())
                {
                    if (!sc.confirm_death)
                    {
                        eventdata.userid <- sc.userid;
                        eventdata.attacker <- event_data.attacker;
                        eventdata.assister <- event_data.assister;
                        eventdata.headshot <- event_data.headshot;
                        DoEntFire("!self", "RunScriptCode", "eventlistener.OnGameEvent_player_death(eventlistener.eventdata)", delay, script_playerdeath, script_playerdeath);
                        delay += 0.01;
                        continue;
                    }
                }
            }
        }
        previous = null;
        return;
    }
    previous = event_data;

    local vic = BaseVS(event_data.userid).GetPlayerByUserid();
    if (!("userid" in vic.GetScriptScope())) return;

    local atk = BaseVS(event_data.attacker).GetPlayerByUserid();
    local ast = BaseVS(event_data.assister).GetPlayerByUserid();
    local headshot = event_data.headshot;

    local table = getconsttable();
    local nullText = "󠀡 󠀡 ";

    if (vic != null && vic.IsValid())
    {
        local vic_sc = vic.GetScriptScope();
        if (vic_sc.confirm_death)
            return;
        else
            vic_sc.confirm_death <- true;

        switch (vic.GetTeam())
        {
            case 1:
            {
                break;
            }
            case 2:
            {
                break;
            }
            case 3:
            {
                //printl("\nplayer_death trigger! idname = "+vic.GetName());
                //printl("attacker = "+atk);
                local l_cc = Entities.FindByName(null, script_item.GetScriptScope().NVG.ccname+event_data.userid);
                EntFireByHandle(l_cc, "Disable", "", 0.00, null, null);
                script_item.GetScriptScope().NVG.arr[event_data.userid.tostring()] <- -1;
                BaseVS(vic).SetBodyGroup(0);
                local l_text = FontColor.Blue + Message[0][g_lang] + nullText + FontColor.Green + table[event_data.userid.tostring()][1] + nullText + FontColor.Red + Message[1][g_lang];
                if (atk != null)
                {
                    if (atk.GetTeam() == vic.GetTeam() && atk != vic)
                        l_text += FontColor.White + "," + nullText + FontColor.Purple + Message[2][g_lang] + nullText + FontColor.LightRed + table[event_data.attacker.tostring()][1];
                }
                ShowChatMsg(l_text, 3); 

                items.ClearEquip(vic);

                break;
            }
            default :
                break;
        }
    }
};

