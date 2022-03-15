//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::isWave <- [
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false,
    false,false
];
::Waveing <- false;
::Wave_Num <- 0;
::Standby_Num <- null;
::isboss_wave <- false;
::dark <- false;
::c4_timer <- 45;
::guard_health <- 100;
::guard_area_def_time <- 70;
::guard_area_radius <- 128;
::guard_area_player <- 0;
::guard_pos <- [
    Vector(-566,408,3), //
    Vector(-566,408,63),

    Vector(96,494,5), //
    Vector(96,495,65),

    Vector(526,464,3), //
    Vector(526,465,64),

    Vector(559,-71,3), //
    Vector(559,-70,64),

    Vector(372,417,147), //
    Vector(372,418,208),

    Vector(592,-236,147), //
    Vector(592,-235,208),

    Vector(22,521,147), //
    Vector(22,521,208),


 

];

::c4_pos <- [
    Vector(-695,474,511), //
    Vector(-695,474,63), //
    Vector(-695,474,6), //
    Vector(-695,474,3), //

    Vector(-126,479,511), //
    Vector(-126,479,63), //
    Vector(-126,479,6), //
    Vector(-126,479,2), //

    Vector(516,-113,511), //
    Vector(516,-113,63), //
    Vector(516,-113,6), //
    Vector(516,-113,2), //

    Vector(740,239,511), //
    Vector(740,239,63), //
    Vector(740,239,6), //
    Vector(740,239,2), //

    Vector(614,373,511), //
    Vector(614,373,206), //
    Vector(614,373,151), //
    Vector(614,373,145), //

    Vector(657,17,511), //
    Vector(657,17,206), //
    Vector(657,17,151), //
    Vector(657,17,145), //

    Vector(256,250,511), //
    Vector(256,250,206), //
    Vector(256,250,151), //
    Vector(256,250,145), //

];

::Wave_Msg <- [
    ["\x01 \x07 波开始","\x01 \x07 STARTS"], //0
    ["\x01 \x07 波结束","\x01 \x07 ENDS"],//1
    ["\x01 \x07 你只存活到了第","\x01 \x07 You survived "],//2
    ["第","WAVE"],//3
    ["波"," "],//4
    ["(BOSS)","(BOSS)"],//5
    ["（最后一波）","(LAST WAVE)"]
];

::Wave_NG_VO <- [
    "11/nazi/survival_ng/survivalbegin03.mp3",//0
    "11/nazi/survival_ng/extraction01.mp3",//1
    "11/nazi/survival_ng/extraction06.mp3",//2
    "11/nazi/survival_ng/supplydropinc01.mp3",//3
    "11/nazi/survival_ng/supplydropinc02.mp3",//4
    "11/nazi/survival_ng/supplydropinc03.mp3",//5
    "11/nazi/survival_ng/wavestart01.mp3",//6
    "11/nazi/survival_ng/wavestart02.mp3",//7
    "11/nazi/survival_ng/wavestart03.mp3",//8
    "11/nazi/survival_ng/wavestart04.mp3",//9
    "11/nazi/survival_ng/wavestart05.mp3",//10
    "11/nazi/survival_ng/wavestart06.mp3",//11
    "11/nazi/survival_ng/zoneattack_01_a.mp3",//12
    "11/nazi/survival_ng/zoneattack_01_b.mp3",//13
    "11/nazi/survival_ng/zoneattack_01_c.mp3",//14
    "11/nazi/survival_ng/zoneattack_01_d.mp3",//15
    "11/nazi/survival_ng/zoneattack_02_a.mp3",//16
    "11/nazi/survival_ng/zoneattack_02_b.mp3",//17
    "11/nazi/survival_ng/zoneattack_02_c.mp3",//18
    "11/nazi/survival_ng/zoneattack_03_d.mp3",//19
    "11/nazi/survival_ng/zoneattack_03_a.mp3",//20
    "11/nazi/survival_ng/zoneattack_03_b.mp3",//21
    "11/nazi/survival_ng/zoneattack_03_c.mp3",//22
    "11/nazi/survival_ng/zoneattack_03_d.mp3",//23
    "11/nazi/survival_ng/zoneattack_04_a.mp3",//24
    "11/nazi/survival_ng/zoneattack_04_b.mp3",//25
    "11/nazi/survival_ng/zoneattack_04_c.mp3",//26
    "11/nazi/survival_ng/zoneattack_04_d.mp3"//27
];

/*::ScreenTips <- function (slot) {
    if (Waveing) {
        if (slot<6) {
            slot+=5;
        }
        else if (slot<12){
            slot -= 1;
        }
        else if (slot<18){
            slot -= 7;
        }
        else if (slot<24){
            slot -= 13;
        }
        else if (slot<30){
            slot -= 19;
        }
        EntFire("ScreenEffect", "SwitchOverlay", ""+slot);
    }
}*/

::c4_spawn <- function () {
    ::c4_timer = 60;
    if (Waveing) {
    EntFire("c4_template", "ForceSpawn");
    EntFire("Script", "RunScriptCode", "c4_bomb()", 0.01);
    }
}

::isPlanted <- false;
::c4_bomb <- function () {
    isPlanted = true;
    self.EmitSound(Event_Snd[1]);
    //EntFire("ScreenEffect", "SwitchOverlay", "3");
    local slot;
    for (local i=0;i<isWave.len();i++) {
        if (isWave[i]) {
            slot = i;
            break;
        }
    }
    //EntFire("Script", "RunScriptCode", "ScreenTips("+slot+")", 5.00);
    local ent,ent_b,ent_c,ent_d,ent_e;
    local name = "c4_ready";
    local pos,pos_b,pos_c,pos_d;
    local n = 0;
    if (d1) {
        n = RandomInt(0,1);
    }
    else if (d1_d2) {
        n = RandomInt(0,3);
    }
    else if (d1_d3) {
        while (n != null) {
            n = RandomInt(0,6);
            if (n >= 0 && n < 2 || n > 3) {
                break;
            }
            else {
                continue;
            }
        }
    }
    else if (d1_d2_d3) {
        n = RandomInt(0,6);
    }
    local ang = RandomInt(0,240);
    ent = Entities.FindByName(null, "c4_");
    ent.__KeyValueFromString("targetname", name);
    ent_b = Entities.FindByName(null, "beam_start");
    ent_c = Entities.FindByName(null, "laser_target_light");
    ent_d = Entities.FindByName(null, "laser_target");
    ent_e = Entities.FindByName(null, "laser_spark");
    if (n==0) {
        pos = c4_pos[0];
        pos_b = c4_pos[1];
        pos_c = c4_pos[2];
        pos_d = c4_pos[3];
    }
    else if (n==1) {
        pos = c4_pos[4];
        pos_b = c4_pos[5];
        pos_c = c4_pos[6];
        pos_d = c4_pos[7];
    }
    else if (n==2) {
        pos = c4_pos[8];
        pos_b = c4_pos[9];
        pos_c = c4_pos[10];
        pos_d = c4_pos[11];
    }
    else if (n==3) {
        pos = c4_pos[12];
        pos_b = c4_pos[13];
        pos_c = c4_pos[14];
        pos_d = c4_pos[15];
    }
    else if (n==4) {
        pos = c4_pos[16];
        pos_b = c4_pos[17];
        pos_c = c4_pos[18];
        pos_d = c4_pos[19];
    }
    else if (n==5) {
        pos = c4_pos[20];
        pos_b = c4_pos[21];
        pos_c = c4_pos[22];
        pos_d = c4_pos[23];
    }
    else if (n==6) {
        pos = c4_pos[24];
        pos_b = c4_pos[25];
        pos_c = c4_pos[26];
        pos_d = c4_pos[27];
    }
    ent_b.SetOrigin(pos);
    ent_c.SetOrigin(pos_b);
    ent_d.SetOrigin(pos_c);
    //ent_e.SetOrigin(pos_d);
    EntFire("beam_start", "strikeonce");
    EntFire("laser_target_light", "TurnOn");
    EntFire("laser_sprite", "ShowSprite");
    EntFire("laser_smokestack", "TurnOn");
    EntFire("laser_target_light", "TurnOff", "", 1.50);
    EntFire("laser_sprite", "HideSprite", "", 1.50);
    EntFire("laser_smokestack", "TurnOff", "", 1.50);
    EntFire("laser_spark", "StartSpark");
    EntFire("laser_spark", "StopSpark", "", 1.50);
    EntFire("beam_start", "FireUser1");
    local snd = null;
    local file = map_snd[3];
    local file_2 = map_snd[4];
    snd = Entities.FindByName(null, "map_world_sound");
    snd.SetOrigin(pos_c);
    EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
    EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
    EntFireByHandle(snd, "AddOutput", "message "+file_2, 0.03, null, null);
    EntFireByHandle(snd, "PlaySound", "", 0.04, null, null);
    if (n < 4) {
        ent.SetOrigin(Vector(pos.x,pos.y,2));
    }
    else if (n < 7) {
        ent.SetOrigin(Vector(pos.x,pos.y,146));
    }
    ent.SetAngles(0,ang,0);
    EntFireByHandle(ent, "ActivateSetTimerLength", c4_timer.tostring(), 1.00, null, null);
    ScriptPrintMessageChatTeam(3, event_msg[46][m_lang]);
    ScriptPrintMessageChatTeam(3, event_msg[46][m_lang]);
    ScriptPrintMessageChatTeam(3, event_msg[46][m_lang]);
    ScriptPrintMessageCenterTeam(3, event_msg[46][m_lang]);
    c4_timer_show();
}

::c4_timer_show <- function () {
    if (c4_timer == 60) {
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    ::c4_timer -= 1;
    if (c4_timer == 50) {
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    if (c4_timer == 40) {
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    else if (c4_timer == 30) {
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    else if (c4_timer == 20) {
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    else if (c4_timer == 10) {
        self.EmitSound(Event_Snd[0]);
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    else if (c4_timer <= 5) {
        self.EmitSound(Event_Snd[0]);
        ScriptPrintMessageChatTeam(3, event_msg[52][m_lang]+c4_timer+event_msg[53][m_lang]);
    }
    //if (c4_timer == 3) {
    //    for (local i=0;i<3;i++) {
    //        Player_Voice_Event(i,4);
    //    }
    //}
    if (c4_timer != 1 && isPlanted && !isOver) {
    EntFire("Script", "RunScriptCode", "c4_timer_show()", 1.00);
    }
}

::temporarily_pos <- Vector(0,0,0);
::c4_exp <- function () {
    isPlanted = false;
    local ent,shak;
    local name = "c4_ready";
    local exp,pos;
    ent = Entities.FindByName(null, name);
    pos = ent.GetOrigin();
    temporarily_pos = pos;
    //ent.EmitSound(EXPLOSION_SOUND);		
    PlaySound(15,10);			
	DispatchParticleEffect("explosion_c4_500", pos, Vector(0,0,0));
    shak = Entities.CreateByClassname("env_shake");
    shak.__KeyValueFromInt("spawnflags", 12)
    shak.__KeyValueFromInt("amplitude", 14);
    shak.__KeyValueFromInt("duration", 4);
    shak.__KeyValueFromInt("frequency", 40);
    shak.__KeyValueFromInt("radius", 2048);
    shak.SetOrigin(pos);
    EntFireByHandle(shak, "StartShake", "", 0.00, null, null);
    EntFireByHandle(shak, "StopShake", "", 4.00, null, null);
    EntFireByHandle(shak, "Kill", "", 4.01, null, null);
    /*exp = Entities.CreateByClassname("env_explosion");
    exp.__KeyValueFromInt("spawnflags", 18300);
	exp.__KeyValueFromInt("iMagnitude", 5000);
    exp.__KeyValueFromInt("iRadiusOverride", 2048);
	exp.SetOrigin(pos);
	EntFireByHandle(exp, "Explode", "", 0.1, null,null);
    exp = Entities.CreateByClassname("point_hurt");
    exp.__KeyValueFromInt("Damage",2000);
    exp.__KeyValueFromInt("DamageRadius",2048);
    exp.__KeyValueFromInt("DamageType",64);
    exp.__KeyValueFromInt("DamageDelay",1);
    exp.SetOrigin(pos);
    local ttime = null;
            for (local i=0;i<Player.len();i++) {
                if (Player[i][0] != null) {
                    ttime = 0.10;
                    if (i==1) {
                        ttime += 0.11
                    }
                    if (i==2) {
                        ttime += 0.12
                    }
                    if (i==3) {
                        ttime += 0.13
                    }
                    if (i==4) {
                        ttime += 0.14
                    }
                    if (i==5) {
                        ttime += 0.15
                    }
                    EntFire("Script", "RunScriptCode", "Hurt_Delay("+i+" 64)", ttime);
                }
            }
    EntFireByHandle(exp, "Hurt", "", 0.1, null,null);
    EntFireByHandle(exp, "Kill", "", 0.2, null,null);*/
    KillRadiusPlayer();
    ScriptPrintMessageChatTeam(3, event_msg[47][m_lang]);
}

::KillRadiusPlayer <- function () {
    local p,id,pos,delay;
    local exp = null;
    pos = temporarily_pos;
    delay = 0.10;
    while((exp = Entities.FindByClassnameWithin(exp, "player", pos, 800)) != null) {
        if (exp.GetTeam() == 3) {
            p = exp;
            for (local i=0;i<Player.len();i++) {
                if (Player[i][0] == p) {
                    id = i;
                    delay += 0.01;
                }
            }
            EntFire("Script", "RunScriptCode", "Hurt_Delay2("+id+" 64)", delay);
        }
    }
}

::c4_begin_defuse <- function () {
    ScriptPrintMessageChatTeam(3, event_msg[48][m_lang]);
}

::c4_defused_aborted <- function () {
    ScriptPrintMessageChatTeam(3, event_msg[50][m_lang]);
}

::c4_defused <- function () {
    isPlanted = false;
    local ent;
    local name = "c4_ready";
    ent = Entities.FindByName(null, name);
    ent.Destroy();
    ScriptPrintMessageChatTeam(3, event_msg[49][m_lang]);
    local reward = 500;
    ScriptPrintMessageChatTeam(3, event_msg[51][m_lang]+reward);
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            PointChange(i,reward,1);
        }
    }
}


::guard_ent_spawn <- function () {
    ::guard_health = 100;
    ::guard_area_def_time = 70;
    if (Waveing) {
    EntFire("guard_template", "ForceSpawn");
    EntFire("Script", "RunScriptCode", "guard_area()", 0.01);
    }
}

::isintact <- false;
::guard_area <- function () {
    isintact = true;
    self.EmitSound(Event_Snd[1]);
    //EntFire("ScreenEffect", "SwitchOverlay", "2");
    local slot;
    for (local i=0;i<isWave.len();i++) {
        if (isWave[i]) {
            slot = i;
            break;
        }
    }
    //EntFire("Script", "RunScriptCode", "ScreenTips("+slot+")", 5.00);
    local ent = null,ent_b = null,ent_c = null;
    local name,name_b,name_c;
    local n = 0;
    if (d1) {
        n = RandomInt(0,1);
    }
    else if (d1_d2) {
        n = RandomInt(0,3);
    }
    else if (d1_d3) {
        while (n != null) {
            n = RandomInt(0,6);
            if (n >= 0 && n < 2 || n > 3) {
                break;
            }
            else {
                continue;
            }
        }
    }
    else if (d1_d2_d3) {
        n = RandomInt(0,6);
    }
    ent = Entities.FindByName(null, "guard_");
    ent_b = Entities.FindByName(null, "guard_sprite_");
    ent_c = Entities.FindByName(null, "guard_light_wall_");
    name = ent.GetName()+n;
    name_b = ent_b.GetName()+n;
    name_c = ent_c.GetName()+n;
    //if (ent != null && ent_b != null && ent_c != null) {
        ent.__KeyValueFromString("targetname", name);
        ent_b.__KeyValueFromString("targetname", name_b);
        ent_c.__KeyValueFromString("targetname", name_c);
        if (n==0) {
            ent.SetOrigin(guard_pos[n]);
            ent_b.SetOrigin(guard_pos[n]);
            ent_c.SetOrigin(guard_pos[n+1]);
            CheckGuradArea(n);
        }
        else if (n==1) {
            ent.SetOrigin(guard_pos[2]);
            ent_b.SetOrigin(guard_pos[2]);
            ent_c.SetOrigin(guard_pos[3]);
            CheckGuradArea(2);
        }
        else if (n==2) {
            ent.SetOrigin(guard_pos[4]);
            ent_b.SetOrigin(guard_pos[4]);
            ent_c.SetOrigin(guard_pos[5]);
            CheckGuradArea(4);
        }
        else if (n==3) {
            ent.SetOrigin(guard_pos[6]);
            ent_b.SetOrigin(guard_pos[6]);
            ent_c.SetOrigin(guard_pos[7]);
            CheckGuradArea(6);
        }
        else if (n==4) {
            ent.SetOrigin(guard_pos[8]);
            ent_b.SetOrigin(guard_pos[8]);
            ent_c.SetOrigin(guard_pos[9]);
            CheckGuradArea(8);
        }
        else if (n==5) {
            ent.SetOrigin(guard_pos[10]);
            ent_b.SetOrigin(guard_pos[10]);
            ent_c.SetOrigin(guard_pos[11]);
            CheckGuradArea(10);
        }
        else if (n==6) {
            ent.SetOrigin(guard_pos[12]);
            ent_b.SetOrigin(guard_pos[12]);
            ent_c.SetOrigin(guard_pos[13]);
            CheckGuradArea(12);
        }
        EntFire("guard_light_"+n, "TurnOn");
    //}
    isOccupy = false;
    guard_area_decay(n);
    guard_area_checkhold(n);
    ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[40][m_lang]);
    ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[40][m_lang]);
    ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[40][m_lang]);
    ScriptPrintMessageCenterTeam(3, event_msg[40][m_lang]);
    printl("guard_area_complete!");
}

::guard_area_decay <- function (n) {
    local hp = null;
    hp = guard_health;
    if (!isOccupy && Waveing) {
        if (hp != 0) {
            guard_health -= 1;
        }
        if (guard_health == 90) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x06 "+guard_health+"%");
        }
        else if (guard_health == 80) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x06 "+guard_health+"%");
        }
        else if (guard_health == 70) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x06 "+guard_health+"%");
        }
        else if (guard_health == 60) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x05 "+guard_health+"%");
        }
        else if (guard_health == 50) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x05 "+guard_health+"%");
        }
        else if (guard_health == 40) {
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x05 "+guard_health+"%");
        }
        else if (guard_health == 30) {
            self.EmitSound(Event_Snd[0]);
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x09 "+guard_health+"%");
        }
        else if (guard_health == 20) {
            self.EmitSound(Event_Snd[0]);
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x09 "+guard_health+"%");
        }
        else if (guard_health == 10) {
            self.EmitSound(Event_Snd[0]);
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x07 "+guard_health+"%");
            //for (local i=0;i<3;i++) {
            //    Player_Voice_Event(i,4);
            //}
        }
        else if (guard_health == 0) {
            self.EmitSound(Event_Snd[2]);
            ScriptPrintMessageChatTeam(3, "\x01 \x02 "+event_msg[37][m_lang]+"\x01 \x07 "+guard_health+"%");
            isintact = false;
            guard_area_player = 0;
            EntFire("guard_"+n, "Kill");
            EntFire("guard_light_wall_"+n, "Kill");
            EntFire("guard_sprite_"+n, "Kill");
            EntFire("guard_light_"+n, "TurnOff");
            local punish = 500;
            local snd = null;
            local file = item_snd[16];
            snd = Entities.FindByName(null, "Global_Sound");
            snd.__KeyValueFromString("message",file);
            ScriptPrintMessageChatTeam(3,"\x01 \x07 "+event_msg[39][m_lang]+"\x01 \x0b "+punish);
            EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
            EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
            for (local i=0;i<Player.len();i++) {
                if (Player[i][0] != null) {
                    PointChange(i,punish,0);
                }
            }
            return;
        }
    }
    if (isintact) {
        EntFire("Script", "RunScriptCode", "guard_area_decay("+n+")", 0.5);
    }
}

::guard_area_checkhold <- function (n) {
    if (isOccupy) {
        if (guard_area_def_time == 70) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        if (guard_area_def_time != 0) {
           guard_area_def_time -= 1;
        }
        if (guard_area_def_time == 65) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 60) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 55) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 50) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 45) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 40) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 35) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 30) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 25) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 20) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 15) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 10) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 5) {
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[56][m_lang]+"\x01 "+guard_area_def_time+" \x05"+event_msg[57][m_lang]);
        }
        else if (guard_area_def_time == 0){
            EntFire("Script", "RunScriptCode", "area_gurad_complete("+n+")", 1.00);
        }
    }
    if (!isintact) {
        return;
    }
    if (guard_area_player > 3) {
        EntFire("Script", "RunScriptCode", "guard_area_checkhold("+n+")", 0.25);
    }
    else if (guard_area_player == 3) {
        EntFire("Script", "RunScriptCode", "guard_area_checkhold("+n+")", 0.50);
    }
    else if (guard_area_player == 2) {
        EntFire("Script", "RunScriptCode", "guard_area_checkhold("+n+")", 0.75);
    }
    else {
        EntFire("Script", "RunScriptCode", "guard_area_checkhold("+n+")", 1.00);
    }
}

::isOccupy <- false;
::CheckGuradArea <- function (v) {
    local pos = guard_pos[v];
    local ent = null;
    local p = null;
    local allow = isOccupy; 
    local num = null;
    num = 0;
    while ((ent = Entities.FindByClassnameWithin(ent, "*", Vector(pos.x,pos.y,pos.z+40), 96)) != null) {
        if (ent.GetClassname() == "player") {
            p = ent;
            if (p.GetTeam() == 3 && p.GetHealth() > Player_ZeroValue) {
                num += 1;
                //break;
            }
            else {
                continue;
            }
        }
    }
    ::guard_area_player = num;
    //printl("num>"+num);
    if (!allow && guard_area_player != 0) {
            ::isOccupy = true;
            ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[35][m_lang]);
            printl("area_player_fist_join");
    }
    if (allow && guard_area_player == 0 ) {
        guard_area_player = null;
        ::isOccupy = false;
        ScriptPrintMessageChatTeam(3, "\x01 \x05 "+event_msg[36][m_lang]);
        printl("area_player_all_leave");

    }
    //printl("area_player_number>"+guard_area_player);
    if (!isintact) {
        return;
    }
    EntFire("Script", "RunScriptCode", "CheckGuradArea("+v+")", 0.10);
}

::area_gurad_complete <- function (n) {
    if (isintact) {
    isintact = false;
    self.EmitSound(Event_Snd[0]);
    guard_area_player = 0;
    EntFire("guard_"+n, "Kill");
    EntFire("guard_light_wall_"+n, "Kill");
    EntFire("guard_sprite_"+n, "Kill");
    EntFire("guard_light_"+n, "TurnOff");
    local reward = 1000;
    local snd = null;
    local file = item_snd[9];
    snd = Entities.FindByName(null, "Global_Sound");
    snd.__KeyValueFromString("message",file);
    ScriptPrintMessageChatTeam(3,"\x01 \x09 "+event_msg[38][m_lang]+"\x01 \x0b "+reward);
    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
    EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            PointChange(i,reward,1);
        }
        }
    }
}

::dark_storm <- function () {
    dark = true;
    local startdist = 256;
    local enddist = 1024;
    local delay = 0.00;
    local w = 1;
    self.EmitSound(map_snd[25]);
    EntFire("Script", "RunScriptCode", "PlaySound(26 10)",37.00);
    blackwhite_in();
    EntFire("map_particle", "Stop");
    EntFire("map_fire", "ExtinguishTemporary", "1");
    EntFire("clouds", "Disable");
    //EntFire("sky_csgo_night02c", "Trigger");
    EntFire("fogexteriorcontroller", "SetColor", "25 25 25");
    while (w==1) {
        delay += 0.04;
        if (startdist != 0) {
            startdist -= 1;
        }
        if (enddist != 200) {
            enddist -= 1;
        }
        EntFire("fogexteriorcontroller", "SetStartDist", startdist.tostring(), delay);
        EntFire("fogexteriorcontroller", "SetEndDist", enddist.tostring(), delay);
        if (startdist == 0 && enddist == 200) {
            w=0;
            break;
        }
    }
}

::dark_out <- function () {
    dark = false;
    local startdist = 0;
    local enddist = 200;
    local delay = 0.00;
    local w = 1;
    blackwhite_out();
    EntFire("map_particle", "Start");
    EntFire("map_fire", "StartFire", "");
    EntFire("clouds", "Enable", "", 3.00);
    //EntFire("sky_day01_09_ldr", "Trigger", "", 3.00);
    EntFire("fogexteriorcontroller", "SetColor", "44 44 44", 3.00);
    while (w==1) {
        delay += 0.02;
        if (startdist != 256) {
            startdist += 1;
        }
        if (enddist != 768) {
            enddist += 1;
        }
        EntFire("fogexteriorcontroller", "SetStartDist", startdist.tostring(), delay);
        EntFire("fogexteriorcontroller", "SetEndDist", enddist.tostring(), delay);
        if (startdist == 256 && enddist == 768) {
            w=0;
            break;
        }
    }
}

::BOSS_Tips <- function (slot) {
    self.EmitSound(Event_Snd[1]);
    ScriptPrintMessageCenterTeam(3, event_msg[66][m_lang]);
}

::Wave_Reinforcements <- function () 
{
    printl("checkstandbyspace..");
    local p,id = -1,sc,steamid;
    local slot = null;
    for (local i=0;i<isWave.len();i++) 
    {
        if (isWave[i] == true) 
        {
            slot = i;
            break;
        }
    }
    //if (slot>1) {
        p = activator;
        if (p.GetTeam() == 2) 
        {
            local pass = false;
            local num = 0;
            for ( local i = 0; i < BOT.len(); i++ ) 
            {
                if ( BOT[i][0] == p ) 
                    id = i;
                if ( BOT[i][8] )
                {
                    if ( id != i )
                        num++;
                    if ( !pass )
                    {
                        if ( id == i )
                            pass = true;
                    }
                }
            }
            sc = p.GetScriptScope();
            steamid = Get32IDByUserid(sc.userid);
            if ( pass )
            {
                if ( ( Wave_Num - num ) > 0 ) 
                {
                    local r =  null;
                    local r_b = null;
                    if (slot == 0) 
                    {
                        if (steamid.tolower() == "bot")
                        r = RandomInt(0,1),r_b = 0;
                        else
                        r = 2,r_b = 1;
                    }
                    if (slot == 1) 
                    {
                        if (steamid.tolower() == "bot")
                        r = RandomInt(0,1),r_b = 1;
                        else
                        r = 2,r_b = 3;
                    }
                    if (slot == 2) 
                    {
                        if (steamid.tolower() == "bot")
                        r = 1,r_b = 2;
                        else
                        r = 2,r_b = 4;
                    }
                    else if (slot == 3) 
                    {
                        if (steamid.tolower() == "bot")
                        r = 3,r_b = 0;
                        else
                        r = 2,r_b = 6;
                    }
                    else if (slot == 4) 
                    {
                        if (steamid.tolower() == "bot")
                        {
                            local pct = RandomInt(0,99);
                            if ( pct < 25)
                                r = 3,r_b = 0;
                            else
                                r = 2,r_b = 2;
                        }
                        else
                        r = 2,r_b = 6;
                    }
                    else if (slot == 5) 
                    {
                        if (steamid.tolower() == "bot")
                        r = 2,r_b = 2;
                        else
                        r = 2,r_b = 5;
                    }
                    if ( p.GetModelName() != ::zombie_model[31] )
                         EntFire("Script", "RunScriptCode", "SpawnZombie("+id+" "+r+" "+r_b+" "+slot+")", 2.00);
                    else
                    {
                        r = RandomInt(0,2);
                        EntFire("Script", "RunScriptCode", "SpawnATC("+id+" "+r+" "+slot+")", 2.00);
                    }
                }
                else
                    ::VS.SendToServer("mp_respawn_on_death_t 0");
            }
        }
    //}
}

::ng_vo <- function (n) {
    local ent,snd;
    snd = Wave_NG_VO[n];
    ent = Entities.FindByName(null, "Global_Sound");
    ent.__KeyValueFromString("message", snd);
    EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
    EntFireByHandle(ent, "Volume", "4", 0.00, null, null)
}



::WaveVoiceDelay <- 12;
::WaveVoiceDelayTir <- function ()
{
    if ( WaveVoiceDelay != 0 )
    {
        WaveVoiceDelay -= 1;
        if ( WaveVoiceDelay == 0 )
        {
            return;
        }
        EntFire("Script", "RunScriptCode", "WaveVoiceDelayTir()", 1.00);
    }
};
::lastwave <- false;
::nonuke <- false;
::end <- false;
::Wave_Start <- function (n) {
    local ent,snd = null;
    local slot = 0;
    local r,r_2;
    local delay = 1.00;
    local delay2 = 0.10;
    isWave[n] = true;
    Waveing = true;
    slot = n;
    /*if (slot<6) {
        EntFire("ScreenEffect", "SwitchOverlay", ""+(slot+5));
    }
    else if (slot<12){
        slot -= 1;
        EntFire("ScreenEffect", "SwitchOverlay", ""+slot);
    }
    else if (slot<18){
        slot -= 7;
        EntFire("ScreenEffect", "SwitchOverlay", ""+slot);
    }
    else if (slot<24){
        slot -= 13;
        EntFire("ScreenEffect", "SwitchOverlay", ""+slot);
    }
    else if (slot<30){
        slot -= 19;
        EntFire("ScreenEffect", "SwitchOverlay", ""+slot);
    }*/
    ent = Entities.FindByName(null, "Global_Sound");
    //EntFire("Script", "RunScriptCode", "Player_Voice_Event(0,0)", 5.00);
    //EntFire("Script", "RunScriptCode", "Player_Voice_Event(1,0)", 5.00);
    ScriptPrintMessageChatTeam(3,"\x01 \x07 "+Wave_Msg[3][m_lang]+"\x0A "+(n+1)+Wave_Msg[0][m_lang]);
    ScriptPrintMessageCenterTeam(3, ""+Wave_Msg[3][m_lang]+" "+(n+1)+Wave_Msg[0][m_lang]);
    if (n < 4) {
        EntFire("Script", "RunScriptCode", "WaveingCheckZombie("+n+")", 10.00);
    }
    else {
        EntFire("Script", "RunScriptCode", "WaveingCheckZombie("+n+")", 30.00);
    }
    ::VS.SendToServer("mp_respawn_on_death_t 1");
    if (n==0) {
        EntFire("Script", "RunScriptCode", "ng_vo(0)", 2.00);
        ::WaveVoiceDelay = 19;
        ::WaveVoiceDelayTir();
        Wave_Num = 15;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 0,0 ,"+n+")", delay);
        }
        delay = 12;
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2,1 ,"+n+")", delay);
        }
        EntFire("Script", "RunScriptCode", "PlaySound(8,10)", 25.00);
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(7 5 38 "+n+")", 3.00);

        EntFire("Script", "RunScriptCode", "::Area_infoTips(0)", 7.00);
        EntFire("Script", "RunScriptCode", "ShowZombieHUD()", 14.00);
        EntFire("inspect_eventlistener", "RunScriptCode", "SuperjumpTimer()", 16.00);

        ::Kill_W_WPS();
    }
    else if (n==1) {
        snd = map_snd[19];
        EntFire("Script", "RunScriptCode", "ng_vo(6)", 2.00);
        ::WaveVoiceDelay = 12;
        ::WaveVoiceDelayTir();
        Wave_Num = 20;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            r = RandomInt(0,1);
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", "+r+" 1, "+n+")", delay);
        }
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 3, "+n+")", delay);
        }
        EntFire("Script", "RunScriptCode", "PlaySound(7,10)", 20.00);
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(6 5 247 "+n+")", 3.00);
    }
    else if (n==2) {
        snd = map_snd[2];
        EntFire("Script", "RunScriptCode", "ng_vo(7)", 2.00);
        ::WaveVoiceDelay = 12;
        ::WaveVoiceDelayTir();
        Wave_Num = 25;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 1, 2, "+n+")", delay);
        }
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 4, "+n+")", delay);
        }
        EntFire("Script", "RunScriptCode", "PlaySound(9,10)", 25.00);
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(6 5 247 "+n+")", 3.00);
    }
    else if (n==3) {
        snd = map_snd[2];
        EntFire("Script", "RunScriptCode", "ng_vo(8)", 2.00);
        ::WaveVoiceDelay = 12;
        ::WaveVoiceDelayTir();
        Wave_Num = 30;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 3, 0, "+n+")", delay);
            PlaySound(6,10);
        }
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 5, "+n+")", delay);
        }
        PlaySound(6,5);
        EntFire("Script", "RunScriptCode", "PlaySound(20,5)", 2.00);
        EntFire("Script", "RunScriptCode", "PlaySound(21,5)", 4.00);
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(0 5 127 "+n+")", 3.00);
    }
    else if (n==4) {
        snd = map_snd[2];
        EntFire("Script", "RunScriptCode", "ng_vo(9)", 2.00);
        ::WaveVoiceDelay = 12;
        ::WaveVoiceDelayTir();
        Wave_Num = 40;
        for (local i=0;i<BOT.len()-5;i++) 
        {
            delay += 0.50;
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 3, "+n+")", delay);
            PlaySound(6,10);
        }
        /*local a = [];
        for ( local i = 5; i < BOT.len(); i++ ) 
        {
            if ( BOT[i][0] != null && BOT[i][0].IsValid() )
            {
                a.push(i);
            }
        }
        if ( a.len() != 0 )
        {
            r = RandomInt(0,a.len()-1);
            EntFire("Script", "RunScriptCode", "SpawnBOSS("+a[r]+", 1, "+n+")", delay);
        }*/
        r = 0;

        for (local i=5;i<BOT.len();i++) 
        {
            delay += 0.25
            if ( i != r )
            {
                EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 6, "+n+")", delay);
            }
        }
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(1 5 204 "+n+")", 3.00);
    }
    else if (n==5) {
        self.EmitSound(::ATC_SND[0]);
        delay = 18;
        EntFire("Script", "RunScriptCode", "ng_vo(10)", 18.00);
        ::WaveVoiceDelay = 31;
        ::WaveVoiceDelayTir();
        Wave_Num = 50;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            r = RandomInt(0,2);
            EntFire("Script", "RunScriptCode", "SpawnATC("+i+", "+r+", "+n+")", delay);
        }
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnATC("+i+", "+r+", "+n+")", delay);
        }
        lastwave = true;
        //EntFire("Script", "RunScriptCode", "::PlayMusic(3,10)", 3.00);
        ::music_delay = 0;
        ::music_loop = true;
        EntFire("Script", "RunScriptCode", "atcamp_loop(3 10 180 "+n+")", 18.00);
        EntFire("Script", "RunScriptCode", "Wave6Radio(1)", 35.00);

        local shak = Entities.CreateByClassname("env_shake");
        shak.__KeyValueFromInt("spawnflags", 5);
        shak.__KeyValueFromInt("amplitude", 6);
        shak.__KeyValueFromFloat("duration", 8);
        shak.__KeyValueFromInt("frequency", 40);
        EntFireByHandle(shak, "StartShake", "", 10.00, null, null);
        EntFireByHandle(shak, "StopShake", "", 18.00, null, null);
        EntFireByHandle(shak, "Kill", "", 18.00, null, null);


    }
    else if (n==6) 
    {
        snd = map_snd[2];
        Wave_Num = 100;
        for (local i=0;i<BOT.len()-5;i++) {
            delay += 0.50;
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 1, 4, "+n+")", delay);
        }
        for (local i=5;i<BOT.len();i++) {
            delay += 0.25
            EntFire("Script", "RunScriptCode", "SpawnZombie("+i+", 2, 6, "+n+")", delay);
        }
    }
    if ( n > 0 && n != 6 )
    {
        restTime_ZmView();
    }
    if (snd==null) {
        return;
    }
    ent.__KeyValueFromString("message", snd);
    EntFireByHandle(ent, "PlaySound", "", delay2, null, null);
    EntFireByHandle(ent, "Volume", "10", delay2, null, null);
    //EntFire("Script", "RunScriptCode", "CheckGOD()", 0.00);
}


atcamp_loop <- function (n,v,d,s) 
{
    if ( ::skinonourteeth )
        return;

    local Egg_Main = Entities.FindByName(null, "Script_Eggs").GetScriptScope();
    if ( !Egg_Main.eggMusic )
    {
        local slot = s;
        if ( ::music_loop && ::Waveing && ::isWave[slot] ) 
        {
            if ( ::music_delay == d || ::music_delay==0 ) 
            {
                ::music_delay = 0;
                EntFire("Script", "RunScriptCode", "PlayMusic("+n+" "+v+")", 0.00);
            }
            ::music_delay += 1;
        }
        else 
            return;
        EntFire("Script", "RunScriptCode", "atcamp_loop("+n+" "+v+" "+d+" "+s+")", 1.00);
    }
};


::Wave_Msg_Show <- function (n) {
    ScriptPrintMessageChatTeam(3,"\x01 \x07 "+Wave_Msg[3][m_lang]+"\x0A "+n+""+Wave_Msg[1][m_lang]);
}
::Wave_Check <- function () {
    if (Wave_Num==0 && Waveing && !isOver) {
        Waveing = false;
        EntFire("Script", "RunScriptCode", "Player_Redeploy()", 2.00);
        printl("wave_over");
        local slot = null;
        local ent = null;
        local snd = null;
        ent = Entities.FindByName(null, "Global_Sound");
        snd = map_snd[1];
        //ent.__KeyValueFromString("message", snd);
        EntFireByHandle(ent, "Addoutput", "message "+snd, 1.99, null, null);
        EntFireByHandle(ent, "PlaySound", "", 2.00, null, null);
        EntFireByHandle(ent, "Volume", "5", 2.00, null, null);
        local ent_b = null;
        for (local i=0;i<7;i++) {
            ent_b = Entities.FindByName(null, "guard_"+i);
            if (ent_b != null && ent_b.IsValid()) {
                EntFire("Script", "RunScriptCode", "area_gurad_complete("+i+")", 1.00);
                break;
            }
            else {
                continue;
            }
        }
        EntFire("Script", "RunScriptCode", "Nukeflase_Delay()", 11.99);
        for (local i=0;i<isWave.len();i++) {
            if (isWave[i]) {
                slot = i;
                break;
            }
        }
        if (isWave[slot]) {
            isWave[slot] = false;
            //EntFire("ScreenEffect", "SwitchOverlay", "1");
            music_loop = false;
            EntFire("Script", "RunScriptCode", "StopMusic()", 2.00);
            if (!lastwave) 
            {
                if ( slot == 0 )
                   EntFire("Script", "RunScriptCode", "::Area_infoTips(4)", 7.00);
                else if  ( slot == 1 )
                   EntFire("Script", "RunScriptCode", "::Area_infoTips(5)", 6.00);

                if ( slot != 2 && slot != 4 )
                    EntFire("Script", "RunScriptCode", "Wave_Start("+(slot+1)+")", 20);
                else
                {
                    EntFire("heli_template", "ForceSpawn", "", 10.00);
                    if ( slot == 4 )
                    {
                        ::VS.SendToServer("bot_difficulty 0");
                        ::VS.SendToServer("bot_kick");
                        local heli_Main = Entities.FindByName(null, "Script_heli").GetScriptScope();
                        heli_Main.pathB = true;
                    }
                    EntFire("script_heli", "RunScriptCode", "helidelay(0,0)", 10.00);
                }
                EntFire("Script", "RunScriptCode", "restTime_ZmView()", 1.00);
            }
            else
            {
                local heli_final_main = Entities.FindByName(null, "Script_heli_final").GetScriptScope();
                heli_final_main.OnSpawn();
            }

            local supply = Entities.FindByName(null, "supplycrate");
            if ( supply != null )
            {
                local sc = supply.GetScriptScope();
                if ( sc._ui.len() > 0 || sc._msg.len() > 0 )
                {
                    for ( local i = 0; i < ( sc._ui.len() + sc._msg.len() ); i++ )
                    {
                        if ( i < sc._ui.len() )
                         {
                            if ( sc._ui[i] != null && sc._ui[i].IsValid() )
                            {
                                 EntFireByHandle(sc._ui[i], "Deactivate", "", 0.00, null, null);
                                 EntFireByHandle(sc._ui[i], "Kill", "",  0.00, null, null);
                             }
                          }
                         if ( i < sc._msg.len() )
                         {
                             if ( sc._msg[i] != null && sc._msg[i].IsValid() )
                             {
                                 EntFireByHandle(sc._msg[i], "Kill", "", 0.00, null, null);
                             }
                         }
                    }
                 }
                EntFireByHandle(supply, "KillHierarchy", "", 0.10, null, null);
            }

            EntFire("Script", "RunScriptCode", "Wave_Msg_Show("+(slot+1)+")", 2.00);
            EntFire("Script", "RunScriptCode", "::GetArmorToRook()", 5.00);
            KillAllZombies();

            //fixbag
            for ( local i = 0; i < 5; i ++ )
            {
                EntFire("dufflebag_template", "ForceSpawn");
            }
            EntFire("laser_target_light", "TurnOff");
        }
        //EntFire("Script", "RunScriptCode", "Player_Voice_Event(0 3)", 5.00);
        //EntFire("Script", "RunScriptCode", "Player_Voice_Event(1 3)", 5.00);
        //EntFire("Script", "RunScriptCode", "Player_Voice_Event(2 3)", 5.00);
        EntFire("Script", "RunScriptCode", "ShowAllPoints()", 3.00);
        //EntFire("Script", "RunScriptCode", "CheckGOD()", 0.00);
    }
}

::Nukeflase_Delay <- function () {
    isNuke = false;
}

::WaveingCheckZombie <- function (n)
{
    if ( Waveing && isWave[n] ) 
    {
        EntFire("Script", "RunScriptCode", "WaveingCheckZombie("+n+")", 2.00);
        local ent,p,id,zm;
        while ( ( ent = Entities.FindByClassname(ent, "*") ) != null ) 
        {
            if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" ) 
            {
                p = ent;
                if ( p.GetTeam() == 2 ) {
                    for ( local i = 0; i < BOT.len(); i++ ) 
                    {
                        if ( BOT[i][0] == p )
                        {
                            id = i;
                            break;
                        }
                    }
                    zm = BOT[id][8];
                    if ( zm ) 
                        return;
                    else
                        continue;
                }
            }
        }
        ::Wave_Num = 0;
        EntFire("Script", "RunScriptCode", "Wave_Check()", 0.01);
        //ScriptPrintMessageChatAll("no zombie");
    }
};

::reward <- function (money) {
    local reward = money;
    local snd = null;
    local file = item_snd[9];
    snd = Entities.FindByName(null, "Global_Sound");
    snd.__KeyValueFromString("message",file);
    ScriptPrintMessageChatTeam(3,"\x01 \x09 "+event_msg[22][m_lang]+"\x01 \x0b "+reward);
    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
    EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            PointChange(i,reward,1);
        }
    }
}

::Player_Redeploy <- function () {
    if (!isOver) {
    TelePortSwitch = true;
    EntFire("servercommand", "command", "mp_respawn_on_death_ct 1");
    EntFire("servercommand", "command", "mp_respawn_on_death_ct 0", 3.00);
    EntFire("Script", "RunScriptCode", "Redeploy_TelePort()", 0.10);
    EntFire("Script", "RunScriptCode", "TelePort_OFF()", 5.00);
    }
}

::TelePortSwitch <- false;
::TelePort_OFF <- function () {
    TelePortSwitch = false;
    printl("TelePort_close");
}
::Redeploy_TelePort <- function () {
    local ent = null;
    local p = null;
    local id = null;
    local sc = null;
    local tg_ori = Vector(10006,-389,-322);
    local ready = null;
    local model,egg;
    local index = 0;
    if (TelePortSwitch) {
        while ((ent = Entities.FindByClassnameWithin(ent, "player", tg_ori, 1024)) != null) {
            if (ent != null && ent.IsValid()) {
                //if (ent.GetClassname() == "player") {
                    p = ent;
                    if (p.GetTeam() == 3) {
                        for (local i=0;i<Player.len();i++) {
                            if (Player[i][0] == p) {
                                id = i;
                                break;
                            }
                            if (i==Player.len()-1) {
                                EntFire("Script", "RunScriptCode", "Redeploy_TelePort()", 0.10);
                                return;
                            }
                        }
                        model = Entities.FindByName(null, "character_model_id_"+id);
                        ready = Player[id][26];
                        if (p.GetHealth() > 0 && ready) {
                            sc = p.GetScriptScope();
                            p.SetOrigin(PlayerPositions[0]);
                            p.SetAngles(0,90,0);
                            if ( sc._class != -1 )
                            {
                                EntFire("Script", "RunScriptCode", "vocskill_confirm()", 0.00);
                            }
                            //EntFire("@equip", "Use", "", 0.00, p);
                            //EntFire("@equip", "TriggerForActivatedPlayer", "weapon_usp_silencer", 0.00, p);
                            local equip = Entities.CreateByClassname("game_player_equip");
                            equip.__KeyValueFromInt("spawnflags", 5);
                            equip.__KeyValueFromInt("weapon_knife", 1);
                            equip.__KeyValueFromInt("weapon_usp_silencer", 1);
                            EntFireByHandle(equip, "Use", "", 0.00, p, null);
                            EntFireByHandle(equip, "Kill", "", 0.00, null, null);
                            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A: "+event_msg[27][m_lang]);
                        }
                    }
                //}
            }
        }
        //printl("test..");
        EntFire("Script", "RunScriptCode", "Redeploy_TelePort()", 0.10);
    }
    else {
        printl("TelePort_Over");
    }
}

::wolf_howl <- function () {
    if (Waveing) {
        local r = RandomInt(27,30);
        local delay = RandomInt(4,9);
        self.EmitSound(map_snd[r]);
        EntFire("Script", "RunScriptCode", "wolf_howl()", delay);
    }
}

ZmView_SW <- false;
ZmViewEnt <- null;
restTime_ZmView <- function ()
{
    if ( ZmViewEnt == null )
    {
        ZmViewEnt = Entities.CreateByClassname("point_viewcontrol_multiplayer");
        ZmViewEnt.__KeyValueFromInt("target_team", 2);
    }
    ZmViewEnt.SetOrigin(Vector(-1277,-623,547));
    ZmViewEnt.SetAngles(19,43,0);
    if ( !ZmView_SW )
    {
        ZmView_SW = true;
        EntFireByHandle(ZmViewEnt, "Enable", "", 0.00, null, null);
    }
    else
    {
        ZmView_SW = false;
        EntFireByHandle(ZmViewEnt, "Disable", "", 0.00, null, null);
    }
}

KillAllZombies <- function ()
{
    local ent,user;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
        {
            user = ent;
            if ( user.GetTeam() == 2 )
            {
                local m_hurt = Entities.CreateByClassname("point_hurt");
                m_hurt.__KeyValueFromString("DamageTarget", user.GetName());
                m_hurt.__KeyValueFromInt("Damage", 99999);

                EntFireByHandle(m_hurt, "Hurt", "", 0.00, null, null);
                EntFireByHandle(m_hurt, "Kill", "", 0.00, null, null);
            }
        }
    }
};

Wave6Radio <- function (n)
{
    local ent = Entities.FindByName(null, "Global_Sound");
    if ( n < 10 )
    {
        //self.EmitSound(::ATC_SND[12]+"0"+n+".mp3");
        ent.__KeyValueFromString("message", ::ATC_SND[12]+"0"+n+".mp3");
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
    }
    else
    {
        //self.EmitSound(::ATC_SND[12]+n+".mp3");
        ent.__KeyValueFromString("message", ::ATC_SND[12]+n+".mp3");
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
    }

    if ( n == 20 )
        return;
    EntFire("Script", "RunScriptCode", "Wave6Radio("+(n+1)+")", 30);
};
