/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

BaseVS(self).IO("OnEventFired", self.GetName().tostring(), "RunScriptCode", "OnGameEvent_player_say(this.event_data)", "0.00", "-1");
pass <- true;
OnGameEvent_player_say <- function (event_data)
{
    if (!work) return;
    
    local uid = event_data.userid;
    local text = event_data.text;
    local plr = BaseVS(uid).GetPlayerByUserid();
    local uid = plr.GetScriptScope().userid;
    if (BaseVS(plr).IsAlive() && plr.GetTeam() == 3)
    {
        if (pass)
        {
            if (text.tolower().tostring() == "\\glow")
                script_item.GetScriptScope().Glowstick(plr).Switch();
            if (text.tolower().tostring() == "\\rpg")
            {
                local playerscope = script_player.GetScriptScope();
                if (plr.GetScriptScope().m_dummy != null)
                    playerscope.PlayerDummy(plr).Switch();
            }
            else if (text.tolower().tostring() == "\\ibas")
                script_item.GetScriptScope().ArmorPlate(plr).Load();
            pass = false, second = 0.00;
        }
        else ShowChatMsg(Message[3][g_lang]);
    }
};

t_1s <- (1.00)*10;
second <- 0.00;
Think <- function ()
{
    second++;
    if (!pass && second%t_1s == 0)
    {
        if (!pass)
            pass = true;
    }
};