//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::area_num <- [false,false,false,false];

second <- 0;

::areaText <- [
    ["你需要守住这里！建筑分为4个点位，不能让僵尸们进来！","You must defend this area against zombies! There are 4 areas in this building. Don't let zombies in!"],
    ["你们需要抵挡6波的攻击","You must resist 6 waves of attacks in each round."],
    ["守住这里，救援正在赶来","Hold here! Support is on the way!"],
    ["注意阵地的生命值，如果为0，即失守。那么任务将失败","Pay attention to the strength of the fortifications, the mission will fail if the fortifications are thoroughly destroyed."],
    ["阵地受到了损坏，去外面寻找维修工具即可修复。","The damaged fortifications can be repaired by looking for repair tools outside."],
    ["是时候找维修工具包了"," It's time to find a repair kit!"],
    ["使用了维修工具，阵地+50HP","Fortifications Repaired! +50HP"],
    ["警告：阵地生命值告急！赶快寻找维修道具","Warning: our fortifications are seriously damaged, repair quickly!"],
    ["阵地失守！","We lost control of the fortifications!"],
    ["我们已失去控制！没有守下来，任务失败","Our fortifications are lost! Mission failed!"]
];

::areainfo <- function (n) 
{

    local m1,m2
    m1 = [" 安全"," Clear"];
    m2 = [" 被入侵"," in Danger"];
    if (area_num[n])
    return m2[::m_lang];
    else
    return m1[::m_lang];

}
::voice_cooldown <- [0,0,0,0, 0];
::zombie_score <- 200;//max 200;
::current_area <- "none";
crisis <- false;


intruder <- function (n) 
{

    local p,poi;
    p = activator;

    if (p.GetTeam() == 2) 
    {

        if (!area_num[n])
        area_num[n] = true;

        if (n==0) 
        poi = "a";

        else if (n==1)
        poi = "b";

        else if (n==2)
        poi = "c";

        else if (n==3)
        poi = "d";

        EntFire(poi+"2", "ShowSprite");
        EntFire(poi, "HideSprite");

    }
}

Think <- function () 
{
    if ( ::isOver || ::skinonourteeth )
        return;
    second++;

    if ( second%10 == 0 )
    {

        local ent,snd,s,poi,delay,cd2 = 8,cd = 25;

        for (local i=0;i<area_num.len();i++) {

            if (area_num[i] == true) 
            {


                if (zombie_score != 0)
                zombie_score -= 1;

                if (voice_cooldown[i] == 0) 
                {

                    ent = Entities.FindByName(null, "Global_Sound");

                    if (i==0) 
                    {

                        s = [12,16,20,24];
                        poi = "A";

                    }
                    else if (i==1) 
                    {

                        s = [13,17,21,25];
                        poi = "B";

                    }
                    else if (i==2) 
                    {

                        s = [14,18,22,26];
                        poi = "C";

                    }
                    else if (i==3) 
                    {

                        s = [15,19,23,27];
                        poi = "D";

                    }

                    snd = Wave_NG_VO[s[RandomInt(0,s.len()-1)]];
                    delay = 0.00;

                    if (voice_cooldown[4]==0) 
                    {

                        voice_cooldown[4]=cd2;
                        for (local k=0;k<cd2;k++) 
                        {

                            EntFire("Script_Area", "RunScriptCode", "voice_cooldown[4] -= 1", delay);
                            //EntFire("Script_Area", "RunScriptCode", "printl(voice_cooldown[4].tostring())", delay);
                            delay += 1.00;

                        }

                        ent.__KeyValueFromString("message", snd);

                        if  ( ::WaveVoiceDelay == 0 )
                        {
                            EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
                            EntFireByHandle(ent, "Volume", "4", 0.00, null, null);
                        }

                    }

                    local text = ["\x01 \x07 区域 \x09 "+poi+" \x07 被入侵了!","\x01 \x07 Zone \x09 "+poi+" \x07 is under invasion!"];
                    ScriptPrintMessageChatAll(text[::m_lang]);

                    voice_cooldown[i] = cd;
                    delay = 0.00;

                    for (local k=0;k<cd;k++) 
                    {

                        EntFire("Script_Area", "RunScriptCode", "voice_cooldown["+i+"] -= 1", delay);
                        //EntFire("Script_Area", "RunScriptCode", "printl(voice_cooldown["+i+"].tostring())", delay);
                        delay += 1.00

                    }
                }
            }
        }
    }

    if ( second == 20 )
    {
        second = 0;
    }

    if ( ::zombie_score < 60 )
    {
        if ( !crisis )
        {
            crisis = true;
            ::Area_infoTips(7);
        }
    }
    if ( crisis && ::zombie_score > 60 )
    {
        crisis = false;
    }

    if ( ::zombie_score == 0 )
    {
        isOver = true;
        ::Area_infoTips(8);
        ::Area_infoTips(9);
        EntFire("Script", "RunScriptCode", "MissionFail(3)", 3.00);
    }
}

clear_area <- function (n) 
{
    local p,poi;
    p = activator;

    if (p.GetTeam() == 2) 
    {
        if (area_num[n])
        area_num[n] = false;
        if (n==0)
        poi = "a";

        else if (n==1)
        poi = "b";

        else if (n==2)
        poi = "c";

        else if (n==3)
        poi = "d";

        EntFire(poi+"2", "HideSprite");
        EntFire(poi, "ShowSprite");

    }
}

::Area_infoTips <- function (n)
{
    local color = "";
    if ( n < 7 )
        color = "\x01 \x05";
    else
        color = "\x01 \x07";
    ScriptPrintMessageChatTeam(3, color + ::areaText[n][::m_lang]);
    if ( n != 6 && n != 8 )
        ScriptPrintMessageCenterTeam(3, ::areaText[n][::m_lang]);
    if ( n == 0)
    {
        EntFire("Script", "RunScriptCode", "::Area_infoTips(1)", 5.00);
        EntFire("Script", "RunScriptCode", "::Area_infoTips(2)", 9.00);
        EntFire("Script", "RunScriptCode", "::Area_infoTips(3)", 12.00);
    }
    local user;
    for ( local i = 0; i < Player.len(); i++ )
    {
        if ( Player[i][0] != null && Player[i][0].IsValid() )
        {
            user = Player[i][0];
            if ( n == 0)
                ::VS.PlayClientSnd(user,::Event_Snd[1]);
            else if ( n == 4 )
                ::VS.PlayClientSnd(user,::Event_Snd[2]);
            else if ( n == 7 )
                ::VS.PlayClientSnd(user,::Event_Snd[3]);
            else
                ::VS.PlayClientSnd(user,::Event_Snd[0]);
        }
    }
};


