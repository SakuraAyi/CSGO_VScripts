//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::ent_work <- true;
::gamescore <- [0,0];

::map_snd <- [
    "11/nazi/round/mx_splash_screen.mp3", // 0
    "11/nazi/round/chalk_v2.mp3", // 1
    "11/nazi/round/round_start.mp3", // 2
    "11/nazi/pre_spawn.mp3", // 3
    "11/nazi/strikes_00.mp3", // 4
    "11/nazi//round/lottery_laugh.mp3", // 5
    "11/nazi/round/Dog_Start_R.mp3", // 6
    "11/nazi/nemesis2.wav", // 7
    "11/nazi/survivor1.wav", // 8
    "11/nazi/survivor2.wav", // 9
    "11/nazi/thumper_hit.mp3", // 10
    "11/nazi/prop/chimes.mp3", // 11
    "11/nazi/prop/explode3.mp3", // 12
    "11/nazi/prop/explode5.mp3", // 13
    "doors/wood_gate_open_01.wav", //14
    "weapons/c4/c4_explode1.mp3", //15
    "11/nazi/round/mus_roundstart_intro.mp3",//16
    "11/nazi/round/mus_round_start_v5_00_mas.mp3",//17
    "11/nazi/round/mus_round_start_v5_01_mas.mp3", //18
    "11/nazi/round/mx_intro_stg.mp3", //19
    "11/nazi/round/mx_dark_sting.mp3", //20
    "11/nazi/round/vox_zmba_event_dogstart_0.mp3", //21
    "11/nazi/round/mus_doground_end.mp3", //22
    "11/nazi/zombies/explode_close_00.mp3",//23
    "11/nazi/zombies/explode_close_02.mp3",//24
    "11/nazi/amb/air_raid_mp.mp3",//25
    "11/nazi/amb/hit1.mp3",//26
    "11/nazi/hellhound/howl_01.mp3",//27
    "11/nazi/hellhound/howl_02.mp3",//28
    "11/nazi/hellhound/howl_03.mp3",//29
    "11/nazi/hellhound/howl_04.mp3",//30
    "11/nazi/round/_9235e02.mp3",//31
    "11/nazi/port_suckin1.mp3",//32
    "ambient/animal/crow.wav",//33
    "ambient/animal/crow_1.wav",//34
    "ambient/animal/crow_1.wav",//35
    "ambient/animal/crow_1.wav",//36
    "11/nazi/amb/crow/alert1.mp3",//37
    "11/nazi/prop/teddy_bear_laugh.mp3"

];

::music_loop <- false;
::music_delay <- 0;
::Background_music <- [
    "11/mx_atcamp_loop.mp3", // 0
    "11/Combat mix.mp3", // 1
    "11/mx_atcamp_loop.mp3", // 2
    "11/Fake Meat Must Die.mp3", // 3
    "11/nazi/round/GameOver.mp3", // 4
    "11/damned.mp3",
    "11/Suspense.mp3",
    "11/MX_SBowl.mp3",
    "11/RoundStartMontage.mp3",
    "11/Nightmare.mp3",
    "11/skinonourteeth_l4d1.mp3",
    "11/themonsterswithin_l4d1.mp3"
];

::event_msg <- [
    ["你终止了维修木板","You stopped repairing the plank"],
    ["木板已在修复当中...","The plank is already being repaired..."],
    ["已补充木板","Plank repaired!"],
    ["你的点数不足！","You don't have enough points!"],
    [" \x0A 购买了\x01 \x03 超星新霰弹枪"," \x0A bought a \x01 \x03 Nova Pump-Action Shotgun"], //4
    [" \x0A 购买了\x01 \x03 TEC-9冲锋枪"," \x0A bought an \x01 \x03 Intratec TEC-9"], //5
    [" \x0A 购买了\x01 \x03 XM1014半自动战斗霰弹枪"," \x0A bought a \x01 \x03 Benelli M4 Super 90"], //6
    [" \x0A 购买了\x01 \x03 MAC-10冲锋枪"," \x0A bought an \x01 \x03 Ingram MAC-10"], //7
    [" \x0A 购买了\x01 \x03 Famas制式突击步枪"," \x0A bought a \x01 \x03 FAMAS"], //8
    [" \x0A 购买了\x01 \x03 短管霰弹枪"," \x0A bought a \x01 \x03 Sawed-Off Shotgun"], //9
    [" \x0A 购买了\x01 \x03 斯太尔SSG08狙击步枪"," \x0A bought a \x01 \x03 Steyr SSG 08"], //10
    [" \x0A 购买了\x01 \x03 M67破片手雷"," \x0A bought a \x01 \x03 M67 Grenade"], //11
    [" \x0A 购买了\x01 \x03 医疗针"," \x0A bought 2 \x01 \x03 Medi-Shots"], //12
    ["\x01 \x03 打开了随机武器箱"," \x01 \x03 opened a Random Weapons Box"], //13
    ["\x01 \x02 打开了门","\x01 \x02 opened the door"], // 14
    ["\x01 \x02 移动了沙发","\x01 \x02 removed the sofa"], // 15
    [" \x0A 捡起了\x01 \x09 双倍报酬"," \x0A picked up the \x01 \x09 [DOUBLE REWARDS]"], // 16
    [" \x0A 捡起了\x01 \x09 瞬间恢复"," \x0A picked up the \x01 \x09 [Self-Revive Kits]"], // 17
    [" \x0A 捡起了\x01 \x09 快速补充"," \x0A picked up the \x01 \x09 [Ammo Pack]"], // 18
    [" \x0A 捡起了\x01 \x09 钱袋"," \x0A picked up the \x01 \x09 [Cash]"], // 19
    [" \x0A 捡起了\x01 \x09 原子弹"," \x0A picked up the \x01 \x09 [Nuclear Bomb]"], // 20
    [" \x0A 捡起了\x01 \x09 自动修复"," \x0A picked up the \x01 \x09 [Automatic Repair]"], // 21
    ["\x01 \x09 》》》》》奖励点数(全体)《《《《《  --","\x01 \x09 > > > > >Points Bonus(All players)< < < < <  --"], // 22
    [" \x0A 购买了\x01 \x03 护甲"," \x0A bought an \x01 \x03 armour"], // 23
    [" \x0A 购买了\x01 \x03 弹药"," \x0A bought some\x01 \x03 ammo"], // 24
    [" \x0A \x01\x07已陷入危机！"," \x0A \x01\x07 is in grave danger!"], // 25
    [" \x0A \x01\x07倒下了！"," \x0A \x01\x07 is down!"], // 26
    [" \x0A \x01\x02已部署！"," \x0A \x01\x02 has been deployed!"], // 27
    ["你已停止救助队友！","You stopped reviving teammate!"], // 28
    ["你已救起队友！","You've revived teammate!"], // 29
    [" \x0A 救起了"," \x0A revived "], // 30
    [" \x0A \x01\x07死亡！"," \x0A \x01\x07 is dead!"], // 31
    ["你正在流血！距离死亡剩余: ","You're bleeding! You'll die in: "], //32
    ["失血过多已死亡","You died of bleeding."], //33
    ["剩余存活玩家: ","Alive players remaining: "], //34
    ["已有玩家进入守卫区域","Someone players have entered the guard area"], //35
    ["守卫区域玩家离开（无人站点） ","All players have left the guard area."], //36
    ["守卫区域生命值百分比 > ","Guard area's HP -> "], //37
    ["成功守住区域！给予奖励（全体） >>> ","Guard area defense succeeded! Points Bonus(all) >>>"], //38
    ["区域防守失败！扣除点数（全体） >>> ","Guard area defense failed! Points Penalty(all) >>>"], //39
    ["指定防守区域已部署！请立即前往！","Guard area found! Go to defend immediately!"], //40
    [" \x01 安放了阔剑地雷"," \x01 deployed a Claymore mine."], //41
    ["你已在脚下放置好阔剑！","Claymore mine has been deployed!"], //42
    ["你的阔剑安放数量已到达上限！(6颗)","You can only deploy up to 6 Claymore mines!"], //43
    ["你必须站在地上才可以安放！","You have to stand on the ground to deploy!"], //44
    [" \x0A 购买了\x01 \x03 阔剑地雷","\x0A bought a \x01 \x03 Claymore mine."], //45
    ["\x01 \x02 某个区域已被安置炸弹！请尽快拆除！\x01","\x01 \x02 Bomb has been planted in some area! Defuse quickly! \x01"], //46
    ["\x01 \x02 炸弹爆炸了！\x01","\x01 \x02 Bomb exploded！\x01"], //47
    ["\x01 \x07 炸弹拆除中！请做好掩护！\x01","\x01 \x07 Bomb is being defused!\x01"], //48
    ["\x01 \x05 炸弹已被拆除\x01","\x01 \x05 Bomb has been defused!\x01"], //49
    ["\x01 \x07 拆除被中止！\x01","\x01 \x07 Bomb-defusing aborted!\x01"], //50
    ["\x01 \x09 拆除炸弹奖励点数（全体） >>>  \x0b","\x01 \x09 Bomb-defusing succeeded! Points Bonus(all) >>>  \x0b"], //51
    ["\x01 \x07 距离炸弹爆炸剩余 \x01 ","\x01 \x07 Bomb will explode in \x01 "], //52
    ["\x01 \x07 秒！","\x01 \x07 second(s)!"],//53
    [" \x0A 捡起了\x01 \x09 死亡机器"," \x0A picked up the \x01 \x09 [Death Machine]"], //54
    [" \x0A 购买了\x01 \x03 位置标记手雷"," \x0A bought 6 \x01 \x03 TA grenades!"], //55
    ["防卫区域距离守护完成还有","To finish the defense you have to hold on for "],//56
    ["进度"," second(s)"],//57
    [" \x0A 购买了\x01 \x03 厚血饮料"," \x0A bought a \x01 \x03 Juggernog"], //58
    ["你已经喝过了！","You've drunk it!"], //59
    ["你的投掷物携带已达到上限！","You can't carry more grenades!"], //60
    ["用完之前不能购买！","You can't buy it before use out!"], //61
    ["你已处于技能激活状态，请等待时间结束！","Your skill has been activated, please wait for the end of skill time."],//62
    [" \x0A 购买了\x01 \x03 双伤饮料"," \x0A bought a \x01 \x03 Double Damage Root Beer."], //63
    [" \x0A 购买了\x01 \x03 耐力饮料"," \x0A bought a \x01 \x03 Stamin-Up Soda."], //64
    [" \x0A 购买了\x01 \x03 复活饮料"," \x0A bought a \x01 \x03 Quick Revive."], //65
    ["注意:BOSS接近中（倒地复活受限）","Attention：Boss is approaching! Revival is limited!"],//66
    ["\x01 \x07 请不要使用穿墙！这里会进行检查！","\x01 \x07 PLEASE DO NOT USE NOCLIP!"], //67
    ["\x01 \x07 由于玩家人数过低！人类血量现已提高","\x01 \x07 The number of players is too low! Human Health has increased"], //68
    ["\x01 \x07 请不要使用无敌！这里会进行检查！", "\x01 \x07 PLEASE DO NOT USE GOD!"]
];

::end_msg <- [
    ["地图名：亡者之夜","Map Name：Nacht der Untoten"],//0
    ["原作 - 使命召唤5：世界大战 \n 纳粹僵尸模式","Original Work - Call of Duty：World at War \n Nazi Zombies"],//1
    ["当前状态：已通关","Current status：MISSION COMPLETE"],//2
    ["作者：11(Alice♪) \n 地图翻译：Dazai Nerau","Map by 11(Alice♪) \n English translation by Dazai Nerau"],//3
    ["--参与测试人员名单--","-- Playtesting --"],//4
    ["uuz","uuz"],//5
    ["ŽΣĎ|xxx","ŽΣĎ|xxx"],//6
    ["ŽΣĎ|Fordz","ŽΣĎ|Fordz"],//7
    ["ŽΣĎ|Es ","ŽΣĎ|Es "],//8
    ["ŽΣĎ|Dollars","ŽΣĎ|Dollars"],//9
    ["ŽΣĎ|Ayachinene","ŽΣĎ|Ayachinene"],//10
    ["Dazai Nerau","Dazai Nerau"],//11
    ["ECHO","ECHO"],//12
    ["金钱","金钱"],//13
    ["泠音祸にんぎょう","泠音祸にんぎょう"],//14
    ["雪風","雪風"],//15
    ["xiao jia huo","xiao jia huo"],//16
    ["阳子","阳子"],//17
    ["su3","su3"],//18
    ["--BGM列表--","-- Background musics --"],//19
    ["115","115"],//20
    ["Dark Hall","Dark Hall"],//21
    ["Antigravity","Antigravity"],//22
    ["Fire to My Soul","Fire to My Soul"],//23
    ["Irradiate And DeadWalking","Irradiate And DeadWalking"],//24
    ["Lullaby Of A Deadman","Lullaby Of A Deadman"],//25
    ["Murderer","Murderer"],//26
    ["mx_atcamp_loop","mx_atcamp_loop"],//27
    ["mx_brave_soldat","mx_brave_soldat"],//28
    ["MX_SBowl","MX_SBowl"],//29
    ["Samantha_Lullaby","Samantha_Lullaby"],//30
    ["Shepherd of Fire","Shepherd of Fire"],//31
    ["timor_battle","timor_battle"],//32
    ["Underworld","Underworld"],//33
    ["Undone","Undone"],//34
    ["mus_safehouse_underscore","mus_safehouse_underscore"],//35
    ["Black tar","Black tar"],//36
    ["damned_malu_v12","damned_malu_v12"], //37
    ["--资源来源--","-- Resources are extracted from --"],//38
    ["使命召唤","Call of Duty"],//39
    ["死亡空间","Dead Space"],//40
    ["杀戮间","Killing Floor"],//41
    ["半条命","Half-Life"],//42
    ["耻辱之日","Day of Infamy"],//43
    ["死宅之路","Left 4 Dead 2"],//44
    ["内容全部由“11” 一人制作","This map was made entirely by 11(Alice♪) alone, all rights reserved!"],//45
    ["制作不易，喜欢的话点个赞","Don't forget to give me a thumbs up if you like this map."],//46
    ["B站求个关注 → uid：2601958","You can visit https：//space.bilibili.com/2601958/ for more details."],//47
    ["下次再见！","To be continued."]//48
];

::Event_Snd <- [
    "survival/info_tips_01.wav",
    "11/nazi/objective_begin.mp3",
    "ui/beep22.wav",
    "error.wav",
    "common/warning.wav",
];

::ShowPlayerEventHudMsg <- function (id,n) {
    local p = null;
    p = Player[id][0];
    local ent = null;
    local name = "player_hint_id_"+id;
    local text = event_msg[n][m_lang];
    ent = Entities.FindByName(null, name);
    if (ent == null && p != null) {
    ent = Entities.CreateByClassname("env_hudhint");
    ent.__KeyValueFromString("targetname",name);
    ent.SetOwner(p);
    }
    ent.__KeyValueFromString("message",text);
    EntFireByHandle(ent, "ShowHudhint", "", 0.00, p, null);
}

::PlayMusic <- function (n,vol) 
{
    if ( n == 10)
    {
        //::skinonourteeth = true;
        ::music_delay = 0;
        ::music_loop = false;
    }
    if ( ::skinonourteeth && n < 10 )
        return;
    local Egg_Main = Entities.FindByName(null, "Script_Eggs").GetScriptScope();
    if ( !Egg_Main.eggMusic )
    {
        local snd = null;
        local file = null;
        snd = Entities.FindByName(null, "Music");//music
        if (snd != null && Waveing || end || n == 5 || ::skinonourteeth ) 
        {
            EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
            EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
            file = Background_music[n];
            //snd.__KeyValueFromString("message", file);
            EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
            EntFireByHandle(snd, "PlaySound", "", 0.00, null, null);
            EntFireByHandle(snd, "Volume", ""+vol, 0.00, null, null);
        }
    }
};

music_sec <- 0;
::music_timer <- 0;
::PlayMusic_loop <- function (n,vol,sec)
{
    if ( isOver )
        return;
    EntFire("Script", "RunScriptCode", "PlayMusic_loop("+n+","+vol+","+sec+")", 1.00);

    if ( music_sec == 0 )
        music_sec = sec;
    if ( music_timer <= music_sec )
    {
        if ( music_timer == music_sec || music_timer == 0 )
        {
            PlayMusic(n,vol);
            music_timer = 0;
        }
        music_timer++;
    }
}

::StopMusic <- function () 
{
    local Egg_Main = Entities.FindByName(null, "Script_Eggs").GetScriptScope();
    if ( !Egg_Main.eggMusic )
    {
        local snd = null;
        snd = Entities.FindByName(null, "Music");
        if (snd != null) 
        {
            EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
            EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        }
    }
}

::PlaySound <- function (n,vol) {
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "Global_Sound");
    if (snd != null) {
        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file = map_snd[n];
        //snd.__KeyValueFromString("message", file);
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.01, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
        EntFireByHandle(snd, "Volume", ""+vol, 0.03, null, null);
    }
}

map_ent_preset <- function () {
    local tog,tg;
    CreateSpeedTri();
    brushtext(0);
    EntFire("servercommand", "command", "bot_kick");
    EntFire("heli_final_wall", "Disable");
    EntFire("laser_target_light", "TurnOff");
    EntFire("laser_smokestack", "TurnOff");
    EntFire("laser_smokestack", "SetParent", "laser_target");
    EntFire("laser_sprite", "SetParent", "laser_target");
    EntFire("laser_spark", "SetParent", "laser_target"); 
    EntFire("game_countdown", "SetDisplayText", "Standby");
    EntFire("game_countdown", "AddOutput", "textcolor 255 255 255");
    EntFire("vgui_text_id_0", "SetLocalOrigin", "8286 425 103.5");
    EntFire("vgui_text_id_1", "SetLocalOrigin", "8242 425 103.5");
    EntFire("vgui_text_id_2", "SetLocalOrigin", "8330 425 103.5");;
    EntFire("vgui_text_id_3", "SetLocalOrigin", "8199 425 103.5");
    EntFire("vgui_text_id_4", "SetLocalOrigin", "8374 425 103.5");
    EntFire("character_particle", "Start");
    EntFire("character_readysmokestack", "TurnOn");
    EntFire("blackhawk_rope*", "SetLocalOrigin", "7654,-145,125");
    //EntFire("character_tips_id_*", "Disable");
    //EntFire("vote", "Disable");
    Character_Model_adjust();
    for (local i=0;i<5;i++) {
        tg = "character_bursh_id_"+i
        tog = Entities.CreateByClassname("env_texturetoggle");
        tog.__KeyValueFromString("target", tg);
        EntFireByHandle(tog, "SetTextureIndex", "0", 0.00, null, null);
        EntFireByHandle(tog, "Kill", "", 0.01, null, null);

        local ent = Entities.FindByName(null, "character_fream_a_id_"+i);
        local vgui = Entities.FindByName(null, "character_explain_id_"+i);
        local pos = ent.GetOrigin();
        pos.x -= 182.3;pos.z += 52;pos.y -= 8.5;
        vgui.SetOrigin(pos);
    }
    CheckNoClip();
    //ScreenEffect();
    //EntFire("ScreenEffect", "SwitchOverlay", "1", 0.01);
    //cdc();
}

::game_ent_start <- function () {
    EntFire("map_fire", "StartFire");
    EntFire("map_fire_grain", "TurnOn");
    EntFire("map_spark", "StartSpark");
    EntFire("map_particle", "Start");
    EntFire("map_particle_2", "Start");
    EntFire("bonfire_pfx", "Start");
    EntFire("bonfire_fire", "StartFire");
    EntFire("candle_single_pfx", "Start");
    //EntFire("zombie_nav_*", "BlockNav");
    //Map_Spark_Effect();
    //Map_Spark_Effect_2();
    map_lighting();
    brush_reset();
}

::brush_reset <- function () {
   //EntFire("d2_NoEntry", "Enable");
    //EntFire("d3_NoEntry", "Enable");
    EntFire("couch_wall", "Enable");
    EntFire("couch_2_wall", "Enable");
    //EntFire("BLOCK_LOS_1", "Enable");
    //EntFire("BLOCK_LOS_2", "Enable");
}

::Map_Spark_Effect <- function () {
    local r = RandomFloat(0.3,4.6);
    EntFire("map_spark_light", "TurnOn");
    //EntFire("map_spark_Twinkle", "StartSpark");
    //DispatchParticleEffect("env_sparks_k", Vector(559,20,117), Vector(0,0,0));
    DispatchParticleEffect("env_sparks_directional_a", Vector(559,20,117), Vector(0,0,0));
    EntFire("map_spark_light", "TurnOff", "", 0.30);
    //EntFire("map_spark_Twinkle", "StopSpark", "", 0.01);

    EntFire("Script", "RunScriptCode", "Map_Spark_Effect()", r);
}

/*::Map_Spark_Effect_2 <- function () {
    local r = RandomFloat(0.4,6.7);
    EntFire("map_spark_light_2", "TurnOn");
    //DispatchParticleEffect("env_sparks_k", Vector(82,459,121), Vector(0,0,0));
    DispatchParticleEffect("env_sparks_directional_a", Vector(82,459,121), Vector(0,0,0));
    //EntFire("map_spark_Twinkle_2", "StartSpark");
    EntFire("map_spark_light_2", "TurnOff", "", 0.30);
    //EntFire("map_spark_Twinkle_2", "StopSpark", "", 0.01);
    EntFire("Script", "RunScriptCode", "Map_Spark_Effect_2()", r);
}*/

/*
::Createblackblur <- function () {
    local ent = null;
    local name = "ScreenEffect";
    local texture = "EFFECTS/blackblur";

    local nazi = "nazi/nazizombies";
    local hint1 = "EFFECTS/hint_1";
    local hint2 = "EFFECTS/hint_2";
    local wave1 = "EFFECTS/wave/0";
    local wave1_b = "EFFECTS/wave/1";
    local wave2 = "EFFECTS/wave/2";
    local wave3 = "EFFECTS/wave/3";
    local wave4 = "EFFECTS/wave/4";
    local wave5 = "EFFECTS/wave/5";
    local wave6 = "EFFECTS/wave/6";
    ent = Entities.CreateByClassname("env_screenoverlay");
    ent.__KeyValueFromString("targetname", name);
    ent.__KeyValueFromString("OverlayName1", texture);
    ent.__KeyValueFromInt("OverlayTime1", -1);
    ent.__KeyValueFromString("OverlayName2", hint1);
    ent.__KeyValueFromInt("OverlayTime2", -1);
    ent.__KeyValueFromString("OverlayName3", hint2);
    ent.__KeyValueFromInt("OverlayTime3", -1);
}

::SetScreen <- function (leve) {
    local ent = null;
    local name = "ScreenEffect";
    ent = Entities.FindByName(null, name);
    if (ent != null) {
        EntFire(name, "StopOverlays");
        EntFire(name, "Kill", "", 0.01);
        printl("del_oldscreen");
        EntFire("Script", "RunScriptCode", "SetScreen_delay("+leve+")", 0.2);
    }
}

::SetScreen_delay <- function (leve) {
    local ent = null;
    local name = "ScreenEffect";
    local texture = "EFFECTS/blackblur";
    local hint1 = "EFFECTS/hint_1";
    local hint2 = "EFFECTS/hint_2";
    local hint3 = "EFFECTS/hint_3";
    local wave7 = "EFFECTS/wave/7";
    local wave8 = "EFFECTS/wave/8";
    local wave9 = "EFFECTS/wave/9";
    local wave10 = "EFFECTS/wave/10";
    local wave11 = "EFFECTS/wave/11";
    local wave12 = "EFFECTS/wave/12";
    local wave13 = "EFFECTS/wave/13";
    local wave14 = "EFFECTS/wave/14";
    local wave15 = "EFFECTS/wave/15";
    local wave16 = "EFFECTS/wave/16";
    local wave17 = "EFFECTS/wave/17";
    local wave18 = "EFFECTS/wave/18";
    local wave19 = "EFFECTS/wave/19";
    local wave20 = "EFFECTS/wave/20";
    local wave21 = "EFFECTS/wave/21";
    local wave22 = "EFFECTS/wave/22";
    local wave23 = "EFFECTS/wave/23";
    local wave24 = "EFFECTS/wave/24";
    local wave25 = "EFFECTS/wave/25";
    local wave26 = "EFFECTS/wave/26";
    local wave27 = "EFFECTS/wave/27";
    local wave28 = "EFFECTS/wave/28";
    local wave29 = "EFFECTS/wave/29";
    local wave30 = "EFFECTS/wave/30";
    ent = Entities.CreateByClassname("env_screenoverlay");
    ent.__KeyValueFromString("targetname", name);
    ent.__KeyValueFromString("OverlayName1", texture);
    ent.__KeyValueFromInt("OverlayTime1", -1);
    ent.__KeyValueFromString("OverlayName2", hint1);
    ent.__KeyValueFromInt("OverlayTime2", -1);
    ent.__KeyValueFromString("OverlayName3", hint2);
    ent.__KeyValueFromInt("OverlayTime3", -1);
    ent.__KeyValueFromString("OverlayName4", hint3);
    ent.__KeyValueFromInt("OverlayTime4", -1);
    EntFire(name, "StartOverlays");
    EntFire(name, "SwitchOverlays", "1", 0.01);
    if (leve==1) {
    ent.__KeyValueFromString("OverlayName5", wave7);
    ent.__KeyValueFromInt("OverlayTime5", -1);
    ent.__KeyValueFromString("OverlayName6", wave8);
    ent.__KeyValueFromInt("OverlayTime6", -1);
    ent.__KeyValueFromString("OverlayName7", wave9);
    ent.__KeyValueFromInt("OverlayTime7", -1);
    ent.__KeyValueFromString("OverlayName8", wave10);
    ent.__KeyValueFromInt("OverlayTime8", -1);
    ent.__KeyValueFromString("OverlayName9", wave11);
    ent.__KeyValueFromInt("OverlayTime9", -1);
    ent.__KeyValueFromString("OverlayName10", wave12);
    ent.__KeyValueFromInt("OverlayTime10", -1);
    }
    else if (leve==2) {
    ent.__KeyValueFromString("OverlayName5", wave13);
    ent.__KeyValueFromInt("OverlayTime5", -1);
    ent.__KeyValueFromString("OverlayName6", wave14);
    ent.__KeyValueFromInt("OverlayTime6", -1);
    ent.__KeyValueFromString("OverlayName7", wave15);
    ent.__KeyValueFromInt("OverlayTime7", -1);
    ent.__KeyValueFromString("OverlayName8", wave16);
    ent.__KeyValueFromInt("OverlayTime8", -1);
    ent.__KeyValueFromString("OverlayName9", wave17);
    ent.__KeyValueFromInt("OverlayTime9", -1);
    ent.__KeyValueFromString("OverlayName10", wave18);
    ent.__KeyValueFromInt("OverlayTime10", -1);
    }
    else if (leve==3) {;
    ent.__KeyValueFromString("OverlayName5", wave19);
    ent.__KeyValueFromInt("OverlayTime5", -1);
    ent.__KeyValueFromString("OverlayName6", wave20);
    ent.__KeyValueFromInt("OverlayTime6", -1);
    ent.__KeyValueFromString("OverlayName7", wave21);
    ent.__KeyValueFromInt("OverlayTime7", -1);
    ent.__KeyValueFromString("OverlayName8", wave22);
    ent.__KeyValueFromInt("OverlayTime8", -1);
    ent.__KeyValueFromString("OverlayName9", wave23);
    ent.__KeyValueFromInt("OverlayTime9", -1);
    ent.__KeyValueFromString("OverlayName10", wave24);
    ent.__KeyValueFromInt("OverlayTime10", -1);
    }
    else if (leve==4) {
    ent.__KeyValueFromString("OverlayName5", wave25);
    ent.__KeyValueFromInt("OverlayTime5", -1);
    ent.__KeyValueFromString("OverlayName6", wave26);
    ent.__KeyValueFromInt("OverlayTime6", -1);
    ent.__KeyValueFromString("OverlayName7", wave27);
    ent.__KeyValueFromInt("OverlayTime7", -1);
    ent.__KeyValueFromString("OverlayName8", wave28);
    ent.__KeyValueFromInt("OverlayTime8", -1);
    ent.__KeyValueFromString("OverlayName9", wave29);
    ent.__KeyValueFromInt("OverlayTime9", -1);
    ent.__KeyValueFromString("OverlayName10", wave30);
    ent.__KeyValueFromInt("OverlayTime10", -1);
    }
    printl("set..complete");
}

::ScreenEffect <- function () {
    if (ent_work) {
    EntFire("ScreenEffect", "StartOverlays");
    EntFire("Script", "RunScriptCode", "ScreenEffect()", 1.00);
    }
}*/

::game_start_tri <- function () {
    //EntFire("start_button", "Lock");
    //EntFire("ghost_screenglow_loop", "Start");
    //EntFire("reg_bot_tri", "Enable");
    for ( local i = 0; i < ::CamArray.len(); i++ ) 
    {
        if ( ::CamArray[i] != null ) 
        {
            local view = ::CamArray[i];
            local ent = Entities.FindByName(null, "ui_t_"+i);
            EntFireByHandle(ent, "Deactivate", "", 0.00, null, null);
            EntFireByHandle(ent, "Kill", "", 0.00, null, null);
            EntFireByHandle(view, "Disable", "", 0.00, null, null);
            if ( i < 5 )
                EntFireByHandle(view, "Kill", "", 0.00, null, null);
        }
    };
    EntFire("Script", "RunScriptCode", "gameStart_zmView(0)", 0.00);
    EntFire("character_particle", "Stop");
    EntFire("character_readysmokestack", "TurnOff");
    StopMusic();
    if (!vote_complete) {
        EntFire("Script", "RunScriptCode", "Loading_Ani()", 0.10);
    }
    else {
        EntFire("Script", "RunScriptCode", "Survival_Start()", 0.09);
    }
}

::start_params <- function () {
    EntFire("colorcorrection_main", "Enable");
    //EntFire("sky_day01_09_ldr", "Trigger");
    EntFire("clouds", "Enable");
    EntFire("Script", "RunScriptCode", "Playerfaced_Tri()", 0.01);
    //EntFire("Script", "RunScriptCode", "ScreenEffect()", 0.01);
    //EntFire("ScreenEffect", "SwitchOverlay", "1", 0.02);
}

::prototype_positions <- [
    Vector(-4845,2783,32),
    Vector(-4793,3019,42),
    Vector(-4937,2715,34),
    Vector(-4899,2944,37),
    Vector(-5131,2804,27),
    Vector(-5221,2898,39),
    Vector(-4681,2818,27)
];

::SpawnZombieModel <- function (num,body,pos) {
    local ent = null;
    local tg = null;
    local name = "move_target";
    tg = Entities.FindByName(null, "move_target");
    if (tg==null) {
        tg = Entities.CreateByClassname("info_target");
        tg.__KeyValueFromString("targetname", name);
        tg.SetOrigin(Vector(-4780,2884,58));
    }
    local model = "models/player/11/nazi/zombies/nazizombie_"+num+".mdl"
    local r = RandomInt(0,11);
/*    ent = Entities.CreateByClassname("prop_dynamic");
    ent.__KeyValueFromString("model", model);*/
    ent = CreateProp("prop_dynamic", prototype_positions[pos], model, 0);
    if(pos != 4 || pos != 5) {
    ent.__KeyValueFromInt("fademindist",700);
    ent.__KeyValueFromInt("fademaxdist",800);
    }
    else {
    ent.__KeyValueFromInt("fademindist",800);
    ent.__KeyValueFromInt("fademaxdist",900);
    }
    EntFireByHandle(ent, "AddOutput", "targetname prototype_zombies", 0.01, null, null);
    EntFireByHandle(ent, "SetBodyGroup", ""+body, 0.01, null, null);
    EntFireByHandle(ent, "Skin", ""+r, 0.01, null, null);
    EntFireByHandle(ent, "SetAnimation", "walk_lower", 0.01, null, null);
    EntFireByHandle(ent, "SetParent", "move_target", 0.01, null, null);

}

::SpawnZombieModelB <- function () {
    local ent = null;
    local model = "models/player/11/nazi/zombies/nazizombie_18.mdl"
    local r = RandomInt(0,11);
/*    ent = Entities.CreateByClassname("prop_dynamic");
    ent.__KeyValueFromString("model", model);*/
    ent = CreateProp("prop_dynamic", prototype_positions[6], model, 0);
    ent.__KeyValueFromInt("fademindist",600);
    ent.__KeyValueFromInt("fademaxdist",800);
    EntFireByHandle(ent, "AddOutput", "targetname prototype_zombie_run", 0.01, null, null);
    EntFireByHandle(ent, "SetBodyGroup", "0", 0.01, null, null);
    EntFireByHandle(ent, "Skin", ""+r, 0.01, null, null);
    EntFireByHandle(ent, "SetAnimation", "walk_lower", 0.01, null, null);

}

::vote_allow <- false;
::vote_complete <- false;
::vote_num <- 0;
::vote_player <- 0;
::skip_vote <- function () {
    vote_allow = true;
    /*local ent = null;
    local name = "ScreenEffect_Vote";

    local five = "nazi/ui/skip/1";
    local four = "nazi/ui/skip/2";
    local three = "nazi/ui/skip/3";
    local tow = "nazi/ui/skip/4";
    local one = "nazi/ui/skip/5";
    local done = "nazi/ui/skip/6";
    ent = Entities.CreateByClassname("env_screenoverlay");
    ent.__KeyValueFromString("targetname", name);
    ent.__KeyValueFromString("OverlayName1", five);
    ent.__KeyValueFromInt("OverlayTime1", -1);
    ent.__KeyValueFromString("OverlayName2", four);
    ent.__KeyValueFromInt("OverlayTime2", -1);
    ent.__KeyValueFromString("OverlayName3", three);
    ent.__KeyValueFromInt("OverlayTime3", -1);
    ent.__KeyValueFromString("OverlayName4", tow);
    ent.__KeyValueFromInt("OverlayTime4", -1);
    ent.__KeyValueFromString("OverlayName5", one);
    ent.__KeyValueFromInt("OverlayTime5", -1);
    ent.__KeyValueFromString("OverlayName6", done);
    ent.__KeyValueFromInt("OverlayTime6", -1);*/
    local tog,name,tg;
    name = "vote_toggle"
    tg = "vote";
    tog = Entities.CreateByClassname("env_texturetoggle");
    tog.__KeyValueFromString("targetname", name);
    tog.__KeyValueFromString("target", tg);
    EntFire("Script", "RunScriptCode", "vote_close()", 10.00);
    local ui = null;
    local ui_name = "vote_ui_"
    local p,id;
    vote_player = 0;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            p = Player[i][0];
            if (p.IsValid()) {
                vote_player += 1;
                id = i;
                ui = Entities.CreateByClassname("game_ui");
                ui.__KeyValueFromString("targetname", ui_name+id);
                ui.__KeyValueFromInt("spawnflags", 96);
                ui.__KeyValueFromInt("FieldOfView", -1);
                ui.SetOwner(p);
                EntFireByHandle(ui, "Activate", "", 0.30, p, null);
                EntIO(ui, "PressedBack", "Script", "RunScriptCode", "p_vote()", "0.00", "1");
                EntIO(ui, "PressedBack", ui_name+id, "Deactivate", "", "0.00", "1");
                EntIO(ui, "PressedBack", ui_name+id, "Kill", "", "0.01", "1");
            }
        }
    }
    vote_open();
}

::vote_open <- function () {
    EntFire("vote", "Enable", "" 0.50);
        EntFire("vote_toggle", "SetTextureIndex", vote_player.tostring(), 0.01);
        vote_num = vote_player;
}

::vote_close <- function () {
    vote_allow = false;
    //EntFire("ScreenEffect_Vote", "StopOverlays");
    //EntFire("ScreenEffect_Vote", "Kill", "", 0.10);
    EntFire("vote", "Disable");
    EntFire("vote_toggle", "Kill");
    EntFire("vote_ui_*", "Deactivate");
    EntFire("vote_ui_*", "Kill", "", 0.01);
}

::p_vote <- function () {
    vote_num -= 1;
    EntFire("vote_toggle", "SetTextureIndex", vote_num.tostring());
    if (vote_num == 0) {
        self.EmitSound(::ATC_SND[3]);
        vote_complete = true;
        EntFire("vote_toggle", "SetTextureIndex", "0", 0.01);
        EntFire("vote_toggle", "Kill", "", 0.01);
        //EntFire("ScreenEffect_Vote", "SwitchOverlay", "6");
        //EntFire("ScreenEffect_Vote", "StopOverlays", "", 0.10);
        //EntFire("ScreenEffect_Vote", "Kill", "", 0.20);
        //StopMusic();
        start_params();
        game_start_tri();
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] != null) {
                EntFireByHandle(Player[i][0], "SetHUDVisibility", "1", 1.00, null, null);
            }
        }
    }
}

::Loading_Ani <- function () {
    if (!isStart || !vote_complete) {
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            //EntFireByHandle(Player[i][0], "SetHUDVisibility", "0", 0.00, null, null);
            EntFireByHandle(Player[i][0], "SetHUDVisibility", "1", 27.00, null, null);
            SetPlayerScreen();
        }
    }
    //EntFire("danger_zone_screen_eyeball", "Start");
    SpawnZombieModel(4,3,0);
    SpawnZombieModel(3,16661,1);
    SpawnZombieModel(1,2325,2);
    SpawnZombieModel(5,512,3);
    SpawnZombieModel(5,41,4);
    SpawnZombieModel(2,131353,5);
    prototype_zmbmove();
    local ent = null;
    local entB = null;
    local entC = null;
    local zombie = Entities.FindByName(null, "prototype_zombie_run");
    local texture = null;
    ent = Entities.CreateByClassname("env_fade");
    ent.__KeyValueFromInt("spawnflags",0);
    ent.__KeyValueFromString("rendercolor","0 0 0");
    ent.__KeyValueFromInt("duration",2);
    ent.__KeyValueFromFloat("holdtime",0.20);
    ent.__KeyValueFromInt("ReverseFadeDuration",2);
    //
    entB = Entities.CreateByClassname("env_fade");
    entB.__KeyValueFromInt("spawnflags",1);
    entB.__KeyValueFromString("rendercolor","0 0 0");
    entB.__KeyValueFromInt("duration",2);
    entB.__KeyValueFromFloat("holdtime",0.20);
    entB.__KeyValueFromInt("ReverseFadeDuration",2);
    //
    entC = Entities.CreateByClassname("env_fade");
    entC.__KeyValueFromInt("spawnflags",0);
    entC.__KeyValueFromString("rendercolor","0 0 0");
    entC.__KeyValueFromFloat("duration",0.1);
    entC.__KeyValueFromInt("holdtime",4);
    entC.__KeyValueFromFloat("ReverseFadeDuration",0.1);
    //
    local snd = "11/nazi/nazi_zombie_prototype_load.mp3"
    self.PrecacheScriptSound(snd);
    self.EmitSound(snd);

    EntFire("plane_fire", "StartFire", "");
    EntFire("plane_particle", "Start", "");
//    EntFire("spooky", "playsound", "");
    EntFire("viewcontrol_multiplayer", "setparent", "cam");
    EntFire("viewcontrol_multiplayer", "setparentattachment", "camera");
    EntFire("cam", "setanimation", "cam_14");
    EntFire("viewcontrol_multiplayer", "enable", "",0.01);

    EntFireByHandle(ent, "Fade", "", 0.00, null, null);
    EntFireByHandle(entB, "Fade", "", 2.00, null, null);
    EntFireByHandle(ent, "Fade", "", 4.00, null, null);
    EntFireByHandle(entB, "Fade", "", 6.00, null, null);
    EntFireByHandle(ent, "Fade", "", 9.00, null, null);
    EntFireByHandle(entB, "Fade", "", 11.00, null, null);
    EntFireByHandle(ent, "Fade", "", 12.00, null, null);
    EntFireByHandle(entB, "Fade", "", 14.00, null, null);
    EntFire("Script", "RunScriptCode", "SpawnZombieModelB()", 11.00);
    EntFire("Script", "RunScriptCode", "prototype_zmbmoveB()", 12.00);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.00);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.11);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.12);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.23);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.24);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.35);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.36);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.47);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.48);
    EntFire("Script", "RunScriptCode", "prototype_zmbBSetpos()", 16.59);
    EntFireByHandle(entC, "Fade", "", 23.00, null, null);
    //EntFire("ScreenEffect", "AddOutput", "OverlayName2 nazi/nazizombies", 16.89);
    texture = Entities.CreateByClassname("env_texturetoggle");
    local tg = "nazizombies";
    texture.__KeyValueFromString("target", tg);
    EntFireByHandle(texture, "SetTextureIndex", "0", 0.00, null, null);
    local num = null;
    num = 16.90;
    EntFire("viewcontrol_multiplayer", "ClearParent", "", 16.89);
    EntFire("viewcontrol_multiplayer", "AddOutput", "origin -6066 256 32", 16.90);
    EntFire("viewcontrol_multiplayer", "AddOutput", "angles 0 0 0", 16.90);
    EntFire("viewcontrol_multiplayer", "Disable", "", 27.00);
    EntFire("Script", "RunScriptCode", "Survival_Start()", 27.00);
    for (local i=1;i<=75;i++) {
        num+=0.08;
    EntFireByHandle(texture, "SetTextureIndex", i.tostring(), num, null, null);
    }
    local zombie_move = Entities.FindByName(null, "move_target");
    EntFire("prototype_zombie*", "Kill", "", 17.00);
    EntFireByHandle(zombie_move, "KillHierarchy", "", 17.01, null, null);
    EntFire("plane_fire", "Extinguish", "1", 17.00);
    EntFire("plane_particle", "Stop", "", 17.00);
    EntFire("plane_fire", "Kill", "", 17.10);
    EntFire("plane_particle", "Kill", "", 17.10);
    //EntFire("danger_zone_screen_eyeball", "Stop", 16.90);
    start_params();
    }
}


::Del_Before_start_ent <- function () {
    local ent = null;
    for (local i=0;i<Player.len();i++) {
        for (local c=0;c<10;c++) {
            ent = Entities.FindByName(null, "m18mine_"+i+"_"+c);
            if (ent != null) {
                ent.Destroy();
            }
            if (c==9) {
                break;
            }
        }
    }
}

::prototype_zmbmove <- function () {
    local zombie = Entities.FindByName(null, "move_target");
    if (zombie != null && zombie.IsValid()) {
    local ori = zombie.GetOrigin();
    zombie.SetOrigin(Vector(ori.x+3.2,ori.y,ori.z));
    EntFire("Script", "RunScriptCode", "prototype_zmbmove()", 0.10);
    }
}

::prototype_zmbmoveB <- function () {
    local zombie = Entities.FindByName(null, "prototype_zombie_run");
    if (zombie != null && zombie.IsValid()) {
    local ori = zombie.GetOrigin();
    zombie.SetOrigin(Vector(ori.x+13,ori.y,ori.z));
    EntFire("Script", "RunScriptCode", "prototype_zmbmoveB()", 0.10);
    }
}

::prototype_zmbBSetpos <- function () {
    local zombie = Entities.FindByName(null, "prototype_zombie_run");
    if (zombie != null && zombie.IsValid()) {
    local ori = zombie.GetOrigin();
    zombie.SetOrigin(Vector(ori.x,ori.y,ori.z-2));
    }
}

::map_amb <- function () {
    EntFire("spooky", "PlaySound");
    EntFire("Script", "RunScriptCode", "map_amb()", 114.00);
}

::lighting_Ori <- [
    Vector(-916,529,842),
    Vector(-29,1030,842),
    Vector(720,869,842),
    Vector(-277,455,842),
    Vector(-202,109,842),
    Vector(224,426,842),
    Vector(668,207,842),
    Vector(219,-588,842),
    Vector(645,-242,842),
    Vector(1128,265,842)
];

::lighting_snd <- [
    "ambient/ambience/rainscapes/thunder_close01.wav",
    "ambient/ambience/rainscapes/thunder_close02.wav",
    "ambient/ambience/rainscapes/thunder_close03.wav",
    "ambient/ambience/rainscapes/thunder_close04.wav",
    "ambient/playonce/weather/thunder_distant_01.wav",
    "ambient/playonce/weather/thunder_distant_02.wav",
    "ambient/playonce/weather/thunder_distant_06.wav"
];
::map_lighting <- function () {
    local r = RandomInt(0,9);
    local ttime = RandomInt(4,12);
    DispatchParticleEffect("storm_lightning_01",lighting_Ori[r], Vector(0,0,0));
    EntFire("Script", "RunScriptCode", "lighting_snd_delay()", 0.75);
    //EntFire("lighting__", "TurnOn");
    //EntFire("lighting__", "TurnOff", "", 1.00);
    EntFire("Script", "RunScriptCode", "map_lighting()", ttime);
}

::lighting_snd_delay <- function () {
    local r = RandomInt(0,6);
    self.EmitSound(lighting_snd[r]);
}

::isStart <- false;
::Survival_Start <- function () {

    isStart = true;
    //EntFire("This_Is_Halloween", "PlaySound", "", 5.00);
    //EntFire("reg_tri", "Enable");
    EntFire("env_tonemap_controller", "SetAutoExposureMax", "2.5")
    EntFire("env_tonemap_controller", "SetBloomScale", "5")

    vocskill_confirm();

    local p,sc;
    local steamid = null;
    local fade = null;
    local ent = null;
    local snd = null;

    fade = Entities.CreateByClassname("env_fade");
    fade.__KeyValueFromInt("spawnflags", 1);
    fade.__KeyValueFromInt("duration", 2);
    fade.__KeyValueFromInt("ReverseFadeDuration", 2);
    fade.__KeyValueFromInt("holdtime", 0.5);
    fade.__KeyValueFromInt("renderamt", 255);
    fade.__KeyValueFromString("rendercolor","0 0 0");

    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
    EntFireByHandle(fade, "Kill", "", 1.00, null, null);

    ent = Entities.FindByName(null, "Global_Sound");
    snd = map_snd[0]; //0
    ent.__KeyValueFromString("message", snd);

    for (local i=0;i<Player.len();i++) {

        if (Player[i][0] != null) {

            p = Player[i][0];
            sc = p.GetScriptScope();
            local r = RandomInt(0, PlayerPositions.len()-1);
            local r2 = RandomInt(0, 360);
            p.SetOrigin(PlayerPositions[r]);
            if ( r == 1 )
               r2 = 90;
            else if ( r == 5 )
                r2 = 180;
            p.SetAngles(0,r2,0);

        }
        else {

            continue;

        }
    }

    Player_Start_Equip();
    ShowPlayerPoint();
    game_ent_start();
    EntFireByHandle(ent, "PlaySound", "", 0.10, null, null);
    EntFire("Script", "RunScriptCode", "map_amb()", 1.00);
    EntFire("Script", "RunScriptCode", "CheckBOTValid()",2.00);
    EntFire("Script", "RunScriptCode", "Wave_Start(0)",3.00);
    CheckSurvival();
    //Player_State();
    CostTips();
    barrCheckZMB_Tri();
    crow_sound();
    SetZMHand();
    //EntFire("Script", "RunScriptCode", "NewTipsAdd()", 10.00);
    ScriptPrintMessageChatAll("\x01 \x0b You can type \x01 \x10!lang\x01 \x0b to the chat to change language.");

}

::CheckPlayerNumberSetHP <- function () {
    local p = activator;
    if (Player_Valid_number < 4) {
        p.SetHealth(Player_Health_LOWPLAYER);
        for (local i=0;i<2;i++) {
             ScriptPrintMessageChatAll(event_msg[68][m_lang]);
        }
    }
    else {
        p.SetHealth(Player_Health);
    }
}

::CheckEntityNumber <- function () {
    local ent = null;
    local num = 0;
    EntFire("Script", "RunScriptCode", "CheckEntityNumber()", 0.01);
    while ((ent = Entities.FindByClassname(ent, "*")) != null) {
        num+=1;
    }
    ScriptPrintMessageChatAll("\x01 \x09 Entity_Num> \x02"+num);
}

allownoclip <- false;
noclipspace <- [];
CheckNoClip <- function () {
    local ent,p,sc,id;
    if (!allownoclip) {
    EntFire("Script", "RunScriptCode", "CheckNoClip()", 0.10);
    }
    while ((ent = Entities.FindByClassname(ent, "*")) != null) {
        if (ent.GetClassname() == "player") {
            p = ent;
            if (p.IsValid() && p.GetHealth() > 0) {
                if ( p.IsNoclipping() ) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == p) {
                            id = i;
                            break;
                        }
                    }
                    sc = p.GetScriptScope();
                    /*p.SetTeam(1);
                    Player[id][26] = false;
                    Player[id][29] = false;
                    Player[id][30] = false;
                    Player[id][31] = false;
                    Player[id][32] = false;
                    Player_Missile[id] = 0;
                    SetPlayerScreen(id,15);
                    EntFire("revive_view_id_"+id, "ClearParent");
                    EntFire("revive_view_id_"+id, "Disable");*/

                    local allowreg = false;
                    
                    if ( noclipspace.len() > 0 )
                    {

                        for ( local i = 0; i < noclipspace.len(); i++ )
                        {

                            if ( !allowreg && noclipspace[i] == p )
                            {

                                break;

                            }

                            if ( !allowreg && i == noclipspace.len()-1 )
                            {

                                allowreg = true;

                                i = -1;

                                continue;

                            }

                            if ( allowreg )
                            {

                                if ( noclipspace[i] == null )
                                {

                                    noclipspace[i] = p;

                                    allowreg = false;

                                    break;

                                }
                            }
                        }
                    }

                    else 

                        noclipspace.push(p);


                    if ( allowreg )
                        noclipspace.push(p);
                    
                    EntFire( "Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
                    //for (local i=0;i<3;i++) {
                        ScriptPrintMessageChatAll("\x01 \x09 "+GetNameByUserid(sc.userid) + " " + event_msg[67][m_lang]);
                    //}
                    CheckPlayersSpace();
                }

                else
                {

                    for ( local i = 0; i < noclipspace.len(); i++ )
                    {

                        if ( noclipspace[i] == p )
                        {

                            noclipspace[i] = null;
                            EntFire( "Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
                            break;
                                
                        }
                    }
                }
            }
        }
    }
}

::allowgod <- false;
::Player_SAVECHECKHP <- [null,null,null,null,null];
::CheckGOD <- function () {
    local ent,p,id,hp;
    if (!allowgod) {
        while ((ent = Entities.FindByClassname(ent, "*")) != null) {
            if (ent.GetClassname() == "player") {
                p = ent;
                if (p.IsValid()) {
                    if (p.GetTeam() == 3 && p.GetHealth() > 100) {
                        for (local i=0;i<Player.len();i++) {
                            if (Player[i][0] == p) {
                                id = i;
                                break;
                            }
                        }
                        local ready = Player[id][26];
                        hp = (p.GetHealth()+1);
                        if (ready) {
                        p.SetHealth(hp);
                        if (Player_SAVECHECKHP[id] == null) {
                            Player_SAVECHECKHP[id] = hp;
                        }
                        local hurt = null;

                        local tg = null;

                        tg = "Player_ID"+id;

                        hurt = Entities.CreateByClassname("point_hurt");

                        hurt.__KeyValueFromFloat("DamageDelay", 0.1);

                        hurt.__KeyValueFromInt("DamageRadius", 32);

                        hurt.__KeyValueFromInt("DamageType", 1);

                        hurt.__KeyValueFromInt("Damage", 1);

                        hurt.__KeyValueFromString("DamageTarget", tg);

                        EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                        EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
                        EntFire("Script", "RunScriptCode", "CheckGOD2("+id+")", 0.01);
                        }
                    }
                }
            }
        }
    }
}

::CheckGOD2 <- function (id) {
    local ent,p,sc,hp;
    if (!allowgod) {
        p = Player[id][0];
        if (p.IsValid()) {
            hp = p.GetHealth();
            if (hp == Player_SAVECHECKHP[id] && !viewgod[id]) {
                sc = p.GetScriptScope();
                p.SetTeam(1);
                Player[id][26] = false;
                Player[id][29] = false;
                Player[id][30] = false;
                Player[id][31] = false;
                Player[id][32] = false;
                Player_Missile[id] = 0;
                EntFire("revive_view_id_"+id, "ClearParent");
                EntFire("revive_view_id_"+id, "Disable");
                for (local i=0;i<3;i++) {
                    ScriptPrintMessageChatAll("\x01 \x09 "+GetNameByUserid(sc.userid) + " " + event_msg[69][m_lang]);
                }
            }
            Player_SAVECHECKHP[id] = null;
            CheckPlayersSpace();
        }
    }
}

::NoCommand <- function () {
    EntFire("servercommand", "command", "sv_infinite_ammo 0");
    EntFire("servercommand", "command", "mp_death_drop_gun 0");
    EntFire("Script", "RunScriptCode", "NoCommand()", 1.00);
}

::Player_Body_Pos <- Vector(-6,258,9313);
::Player_Down <- function (id) {
    self.EmitSound(Event_Snd[2]);
    local p = null,p_ori = null,p_ori_b = null,p_back_ori,p_forward_ori,p_left_ori,p_back_ori_b;
    local view = null;
    local name = "View_ID_"+id;
    local tg = "Player_Model_ID_"+id;
    local mandown = null;
    local Liftup = null;
    local ent = null;
    local n,b;
    local ang = null;
    local button,button_2;
    local tl = null,tl_2 = null,tl_3 = null,tl_4 = null,tl_5 = null,tl_6 = null,tl_7 = null;
    local sndent = null;
    local snd_2 = null;
    local file = null;
    p = Player[id][0];
    mandown = Player[id][25];
    Liftup = Player[id][27];
    local revive = Player[id][32];
    local sc = p.GetScriptScope();
    //local relay = null;
    //local relay_name = "player_death_count_relay_id_"+id;
    p_ori = p.EyePosition();
    p_ori_b = p.GetOrigin();
    p_back_ori = p_ori_b + p.GetForwardVector() * -40;
    p_forward_ori = p_ori_b + p.GetForwardVector() * 40;
    p_left_ori = p_ori_b + p.GetLeftVector() * 40;
    ang = p.GetAngles();
    if (p != null) {
        Player_Down_Number[id] += 1;
        Player[id][29] = false;
        Player[id][30] = false;
        Player[id][31] = false;
        //Player[id][32] = false;
        Player[id][34] = "egg2"
        if (revive) {
            SetPlayerScreen(id,14);
        }
        else {
            SetPlayerScreen(id,17);
        }
        EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
        if (Player_Valid_number < 4) {
            p.SetMaxHealth(Player_Health_LOWPLAYER);
        }
        else {
            p.SetMaxHealth(Player_Health);
        }
        local drink = null;
        drink = Entities.FindByName(null, "drink_model_id_"+id);
        if (drink != null) {
            drink.Destroy();
        }
        if (!isboss_wave) {
        //Player[id][25] = true;
        tl = TraceLine(p_ori,Vector(p_ori.x+40,p_ori.y,p_ori.z),p);
        tl_2 = TraceLine(p_ori,Vector(p_ori.x-40,p_ori.y,p_ori.z),p);
        tl_3 = TraceLine(p_ori,Vector(p_ori.x,p_ori.y+40,p_ori.z),p);
        tl_4 = TraceLine(p_ori,Vector(p_ori.x,p_ori.y-40,p_ori.z),p);
        tl_5 = TraceLine(p_ori,Vector(p_back_ori.x,p_back_ori.y,p_back_ori.z),p);
        tl_6 = TraceLine(p_ori,Vector(p_forward_ori.x,p_forward_ori.y,p_forward_ori.z),p);
        tl_7 = TraceLine(p_ori,Vector(p_left_ori.x,p_left_ori.y,p_left_ori.z),p);
        sndent = Entities.FindByName(null, "Player_Voice_"+id);
        EntFireByHandle(sndent, "Volume", "0", 0.02, null, null);
        EntFireByHandle(sndent, "StopSound", "", 0.02, null, null);
        local egg = Player[id][28];
        n = 0;
        b = 0;
        if (p.GetModelName() == Player_Model[0]) {
            n=1;
        }
        else if (p.GetModelName() == Player_Model[2]) {
            n=3;
        }
        else if (p.GetModelName() == Player_Model[4]) {
            n=5;
        }
        else if (p.GetModelName() ) {
            n=6;
            if (egg == "hibiki") {
                b = 2;
            }
            else if (egg == "verniy") {
                b = 3;
            }
            else if (egg == "akatsuki") {
                b = 0;
            }
            else if (egg == "ikazuchi") {
                b = 4;
            }
            else if (egg == "inazuma") {
                b = 6;
            }
        }
        ent = CreateProp("prop_dynamic_glow", p_ori_b, Player_Model[n], 2);
        EntFireByHandle(ent, "SetBodyGroup", b.tostring(), 0.00, null, null);
        ent.__KeyValueFromString("targetname", tg);
        //ent.SetAngles(ang.x,ang.y,ang.z);
        ent.__KeyValueFromInt("glowdits", 768);
        ent.__KeyValueFromInt("glowenabled", 1);
        ent.__KeyValueFromInt("glowstyle", 0);
        ent.__KeyValueFromString("glowcolor", "255 128 0");
        if (n!=6) {
            EntFireByHandle(ent, "SetAnimation", "Death", 0.00, null, null);
            //if (!Lift_Up) {
            EntFireByHandle(ent, "SetAnimation", "idle_incap", 1.60, null, null);//3.4
            p_back_ori_b = p_ori_b + p.GetForwardVector() * -32;
        }
        else {
            EntFireByHandle(ent, "SetAnimation", "Down", 0.00, null, null);
            p_back_ori_b = p_ori_b;
        }
        //}
        button = Entities.FindByName(null, "revive_button_id_"+id);
        button_2 = Entities.FindByName(null, "revive_button_parent_id_"+id);
        button_2.SetOrigin(Vector(p_back_ori_b.x,p_back_ori_b.y,p_back_ori_b.z+8));
        EntFireByHandle(button, "Lock","", 0.00, null, null);
        EntFireByHandle(button, "UnLock","", 1.70, null, null);
        /*view = Entities.CreateByClassname("point_viewcontrol");
        view.__KeyValueFromString("targetname", name);
        view.__KeyValueFromInt("spawnflags", 12);
        view.__KeyValueFromString("target", tg);
        view.__KeyValueFromInt("trackspeed", 40);
        view.__KeyValueFromInt("speed", 0)
        view.__KeyValueFromInt("fov", 90)
        view.__KeyValueFromInt("fov_rate", 1)
        view.__KeyValueFromInt("acceleration", 500)
        view.__KeyValueFromInt("deceleration", 500)
        view.__KeyValueFromInt("wait", 10);*/
        //view.SetOwner(p);
        view = Entities.FindByName(null, "revive_view_id_"+id);
        view.SetAngles(-90,0,0);
        if (tl==1.0) {
            view.SetOrigin(Vector(p_ori.x+40,p_ori.y,p_ori.z+24));
        }
        else if (tl_2==1.0) {
            view.SetOrigin(Vector(p_ori.x-40,p_ori.y,p_ori.z+24));
        }
        else if (tl_3==1.0) {
            view.SetOrigin(Vector(p_ori.x,p_ori.y+40,p_ori.z+24));
        }
        else if (tl_4==1.0) {
            view.SetOrigin(Vector(p_ori.x,p_ori.y-40,p_ori.z+24));
        }
        else {
            view.SetOrigin(Vector(p_ori.x,p_ori.y,p_ori.z+24));
        }
        if (tl_5==1.0) {
            ent.SetAngles(ang.x,ang.y,ang.z);
        }
        else if (tl_6==1.0){
            ent.SetAngles(ang.x,ang.y+180,ang.z);
        }
        else if (tl_7==1.0){
            ent.SetAngles(ang.x,ang.y+90,ang.z);
        }
        else {
            ent.SetAngles(ang.x,ang.y-90,ang.z);
        }
        EntFireByHandle(view, "Enable", "", 0.01, p, null);
        viewgod[id] = true;
        p.SetOrigin(Player_Body_Pos);
        local r = 0;
        if (id==0) {
            r = RandomInt(0,4);
        }
        else if (id==1) {
            r = RandomInt(5,9);
        }
        else if (id==2) {
            r = RandomInt(10,14);
        }
        else if (id==3) {
            r = RandomInt(15,19);
        }
        else if (id==4) {
             r = RandomInt(20,24);
        }
        if (p.GetModelName()) {
        snd_2 = Entities.FindByName(null, "Player_Voice_"+id);//map_world_player_sound_
        snd_2.SetOrigin(p_ori_b);
        file = Player_Down_Voice[r];
        EntFireByHandle(snd_2, "AddOutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd_2, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd_2, "Volume", "8", 0.02, null, null);
        }
        //relay = Entities.CreateByClassname("logic_relay");
        //relay.__KeyValueFromString("targetname", relay_name);
        //EntIO(relay, "OnTrigger", "Script", "RunScriptCode", "Down_Time_limit("+id+")", "40.00", "-1");
        //EntIO(relay, "OnTrigger", relay_name, "Trigger", "", "10.00", "-1");
        //EntFireByHandle(relay, "Trigger", "", 0.02, null, null);
        if (!revive) {
            EntFire("Script", "RunScriptCode", "Player_Say_Help("+id+")", 5.00);
            EntFire("revive_icon_template", "ForceSpawn");
            EntFire("Script", "RunScriptCode", "Revive_icon_delay("+id+")", 0.01);
            death_count_tir(id);
        }
        else {
            EntFire("Script", "RunScriptCode", "revive_player("+id+")", 3.00, p);
        }
        ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[26][m_lang]);
        }
        else {
            Hurt_Delay(id,0);
        }
    }
}

::Revive_icon_delay <- function (id) {
    local p = null
    p = Player[id][0];
    local ori = null;
    local ent = null;
    local model = null;
    model = "Player_Model_ID_"+id;
    ent = Entities.FindByName(null, "player_revive_icon_");
    if (ent != null) {
        ori = Entities.FindByName(null, model).GetOrigin();
        ent.__KeyValueFromString("targetname", ent.GetName()+id);
        ent.__KeyValueFromString("rendercolor", "251 185 64");
        if (p.GetModelName()) {
            ent.SetOrigin(Vector(ori.x,ori.y,ori.z+52));
        }
        else {
            ent.SetOrigin(Vector(ori.x,ori.y,ori.z+84));
        }
        EntFireByHandle(ent, "ShowSprite", "", 0.01, null, null);
    }
}

::Player_Say_Help <- function (id) {
    local p = null;
    local model = null;
    local ori = null;
    local sc = null;
    local ent = null;
    local file = null;
    local r = null;
    local n = null;
    local mandown = null;
    local liftup = null;
    p = Player[id][0];
    if (p != null && p.GetHealth() > 0) {
        if (p.GetModelName()) {
        model = Entities.FindByName(null, "Player_Model_ID_"+id);
        if (model != null) {
        ori = model.GetOrigin();
        sc = p.GetScriptScope();
        mandown = Player[id][25];
        liftup = Player[id][27];
        ent = Entities.FindByName(null, "map_world_player_sound_"+id);
        EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
        EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
        ent.SetOrigin(ori);
        if (mandown) {
            if (id==0) {
                r = RandomInt(0,4);
            }
            else if (id==1) {
                r = RandomInt(5,9);
            }
            else if (id==2) {
                r = RandomInt(10,14);
            }
            else if (id==3) {
                r = RandomInt(15,19);
            }
            else if (id==4) {
                r = RandomInt(20,24);
            }
            else if (id==5) {
                r = RandomInt(25,29);
            }
            n = r+262;
            file = Player_Help_Voice[r];
            EntFireByHandle(ent, "AddOutput", "message "+file, 0.01, null, null);
            if (!liftup) {
                EntFireByHandle(ent, "PlaySound", "", 0.02, null, null);
                ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A: "+PlayerMsg[n][m_lang]);
            }
        }
        else {
            return;
        }
        EntFire("Script", "RunScriptCode", "Player_Say_Help("+id+")", 6.00);
        }
    }
    }
}

::death_count_tir <- function (id) {
    //self.EmitSound(Event_Snd[2]);
    if (!isOver) {
    local p = null;
    local mandown = null;
    local Liftup = null;
    local num = null;
    local ttime = 40;
    local ent = null;
    local name = "count_tips_hud_id_"+id;
    local text = null;
    p = Player[id][0];
    mandown = Player[id][25];
    Liftup = Player[id][27];
    num = death_count[id];
    if (mandown && !Liftup) {
        ent = Entities.FindByName(null, name);
        if (ent == null) {
            ent = Entities.CreateByClassname("env_message");
            ent.__KeyValueFromString("targetname", name);
            //ent.__KeyValueFromString("message", text);
            ent.SetOwner(p);
        }
        if (num != 0) {
            num -= 1;
            death_count[id] = num;
            text = event_msg[32][m_lang]+death_count[id];
            ent.__KeyValueFromString("message", text);
            EntFireByHandle(ent, "ShowMessage", "", 0.00, p, null);
            //printl("Pass...("+death_count[id]);
        }
        if (num == 0) {
            Down_Time_limit(id);
            text = event_msg[33][m_lang];
            ent.__KeyValueFromString("message", text);
            EntFireByHandle(ent, "ShowMessage", "", 0.00, p, null);
            death_count[id] = ttime;
            return;
        }
        //if (num == 24) {
        //    EntFire("clientcommand", "command", "Play 11/nazi/player/deathsong_v1_mas.mp3", 0.00, p);
        //}
    }
    else if (!mandown) {
        death_count[id] = ttime;
        return;
    }
    else {
        printl("suspend...");
    }
    EntFire("Script", "RunScriptCode", "death_count_tir("+id+")", 1.00);
    }
}

::Down_Time_limit <- function (id) {
    self.EmitSound(Event_Snd[2]);
    //local mandown = Player[id][25];
    //local Liftup = Player[id][27];
    //if (mandown && !Liftup) {
    local p = Player[id][0];
    local view = null;
    local hurt = null;
    local model = null;
    local tg = "Player_ID"+id;
    local tg_b = "Player_Model_ID_"+id;
    local name_set = "Player_Model_ID_Die_"+id;
    local button,button_2;
    view = Entities.FindByName(null, "revive_view_id_"+id);
    EntFireByHandle(view, "Disable", "", 0.00, p, null);
    viewgod[id] = false;
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromInt("DamageRadius", 50);
    hurt.__KeyValueFromInt("DamageType", 0);
    hurt.__KeyValueFromInt("Damage", 99999);
    hurt.__KeyValueFromString("DamageTarget", tg);
    hurt.__KeyValueFromFloat("DamageDelay", 0.1);
    EntFireByHandle(hurt, "Hurt", "", 0.01, null, null);
    EntFireByHandle(hurt, "Kill", "", 0.02, null, null);
    local ent = null;
    ent = Entities.FindByName(null, "player_revive_icon_"+id);
    EntFireByHandle(ent, "Kill", "", 0.00, null, null);
    //local relay_name = "player_death_count_relay_id_"+id;
    //EntFire(relay_name, "Kill", "", 0.01);
    model = Entities.FindByName(null, "Player_Model_ID_"+id);
    if (model != null) {
        model.__KeyValueFromString("targetname", name_set);
    }
    if (model.GetModelName()) {
    EntFire(name_set, "SetAnimation", "Die_Incap");
    }
    button = Entities.FindByName(null, "revive_button_id_"+id);
    button_2 = Entities.FindByName(null, "revive_button_parent_id_"+id);
    button_2.SetOrigin(Player_Body_Pos);
    EntFireByHandle(button, "Lock","", 0.10, null, null);
    //}
}

::revive_activator_space <- [null,null,null,null,null,null];
::revive_player <- function (id_2) {
    printl("Rescue...");
    if (::revive_activator_space[id_2] != activator || ::revive_activator_space[id_2] == null) {
    ::revive_activator_space[id_2] = activator;
    }
    else {
        return;
    }
    EntFire("revive_button_id_"+id_2, "Lock");
    local ent = null;
    local p_1 = null;
    local p_2 = null;
    local id = null;
    local model,model2;
    local tg = "Player_Model_ID_"+id_2;
    local mandown = null;
    local Liftup = null;
    local revive = null;
    local sndent = null;
    local file = null;
    local sc = null;
    p_1 = activator;
    p_2 = Player[id_2][0];
    mandown = Player[id_2][25];
    Liftup = Player[id_2][27];
    revive = Player[id_2][32];
    if (p_1.GetTeam() == 3) {
        if (mandown && !revive || revive && p_1 == p_2) {
            for (local i=0;i<Player.len();i++) {
                if (Player[i][0] == p_1) {
                    id = i;
                    break;
                }
            }
            sc = p_1.GetScriptScope();
            local name = "revive_hint_id_"+id;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("targetname",name);
            ent.__KeyValueFromString("message","");
            ent.SetOwner(p_1);
            sndent = Entities.FindByName(null, "Player_Voice_"+id);
            EntFireByHandle(sndent, "Volume", "0", 0.00, null, null);
            EntFireByHandle(sndent, "StopSound", "", 0.00, null, null);
            local r = 0;
            local n = 0
            if (id==0) {
                r = RandomInt(0,5);
            }
            else if (id==1) {
                r = RandomInt(6,11);
            }
            else if (id==2) {
                r = RandomInt(12,17);
            }
            else if (id==3) {
                r = RandomInt(18,22);
            }
            else if (id==4) {
                r = RandomInt(23,27);
            }
            else if (id==5) {
                r = RandomInt(28,32);
            }
            n = r+228;
            file = Player_Revive_Voice[r];
            EntFireByHandle(sndent, "AddOutput", "message "+file, 0.01, null, null);
            model = Entities.FindByName(null, "Player_ID"+id);
            model2 = Entities.FindByName(null, tg);
            Player[id_2][27] = true;
            revive_progress(id,id_2,0);
            if (model.GetModelName()) {
                if (!revive) {
                    EntFireByHandle(sndent, "PlaySound", "", 0.10, null, null);
                }
            }
            if (model2.GetModelName()) {
                EntFire(tg, "SetAnimation", "GetUpFrom_Incap");
            }
            if (!revive) {
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A: "+PlayerMsg[n][m_lang]);
            }
        }
        else {
            printl("No rescue needed");
        }
    }
}

::revive_progress <- function (id,id_2,prog) {
    local p_1 = null;
    local p_2 = null;
    p_1 = Player[id][0];
    p_2 = Player[id_2][0];
    local tb = getconsttable();
    local sc = p_1.GetScriptScope();
    local sc_2 = p_2.GetScriptScope();
    local blank = "□";
    local fill = "■";
    local Progress = 15;
    local maxspeedlimit = 64;
    local text = "";
    local ent = null,ori = null;
    local tg = "Player_Model_ID_"+id_2;
    local model = null;
    local tg_ori = null;
    local revive,revive_id1;
    local mandown = null;
    local Liftup = null;
    local button,button_2;
    local sndent = null;
    local file = null;
    local stamin = Player[id][31];
    mandown = Player[id_2][25];
    Liftup = Player[id_2][27];
    revive = Player[id_2][32];
    revive_id1 = Player[id][32];
    model = Entities.FindByName(null, tg);
    EntFire("Player_SpeedMod", "ModifySpeed", "0.5", 0.00, p_1);
    if (p_1.GetVelocity().x > maxspeedlimit || p_1.GetVelocity().y > maxspeedlimit || p_1.GetVelocity().x < -maxspeedlimit || p_1.GetVelocity().y < -maxspeedlimit || p_1.GetVelocity().z > 0) {
        EntFire("revive_hint_id_"+id, "AddOutput", "message "+event_msg[28][m_lang]);
        EntFire("revive_hint_id_"+id, "ShowHudHint", "", 0.01, p_1);
        EntFire("revive_hint_id_"+id, "kill", "", 0.02);
        EntFire("revive_button_id_"+id_2, "Unlock");
        sndent = Entities.FindByName(null, "Player_Voice_"+id);
        EntFireByHandle(sndent, "Volume", "0", 0.00, null, null);
        EntFireByHandle(sndent, "StopSound", "", 0.00, null, null);
        if (model.GetModelName()) {
        EntFire(tg, "SetAnimation", "Idle_Incap", 0.01);
        }
        Player[id_2][27] = false;
        if (!stamin) {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p_1);
        }
        else {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p_1);
        }
        ::revive_activator_space[id_2] = null;
        return;
    }
    if (prog==0) {
        for (local i=0;i<Progress;i++) {
        text += blank;
        }
    }
    else {
        for (local i=0;i<=prog;i++) {
                    text += fill;
        }
        for (local i=0;i<(Progress-prog);i++) {
                    text += blank;
        }
    }
    EntFire("revive_hint_id_"+id, "AddOutput", "message "+text);
    EntFire("revive_hint_id_"+id, "ShowHudHint", "", 0.01, p_1);
    if (p_2.GetHealth() <= 0) {
        if (!stamin) {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p_1);
        }
        else {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p_1);
        }
        return;
    }
    if (prog<=Progress) {
        if (!revive_id1) {
            EntFire("Script", "RunScriptCode", "revive_progress("+id+" "+id_2+" "+(prog+1)+")", 0.30);
        }
        else {
            EntFire("Script", "RunScriptCode", "revive_progress("+id+" "+id_2+" "+(prog+1)+")", 0.05);
        }
    }
    else {
        Player[id_2][25] = false;
        Player[id_2][27] = false;
        viewgod[id_2] = false;
        local ent = null;
        ent = Entities.FindByName(null, "player_revive_icon_"+id_2);
        EntFireByHandle(ent, "Kill", "", 0.00, null, null);
        //local relay_name = "player_death_count_relay_id_"+id_2;
        //EntFire(relay_name, "CancelPending");
        //EntFire(relay_name, "Kill", "", 0.10);
        PointChange(id,200,1);
        EntFire("revive_hint_id_"+id, "AddOutput", "message "+event_msg[29][m_lang]);
        EntFire("revive_hint_id_"+id, "ShowHudHint", "", 0.01, p_1);
        EntFire("revive_hint_id_"+id, "kill", "", 0.02);
        ent = Entities.FindByName(null, tg);
        tg_ori = ent.GetAngles();
        button = Entities.FindByName(null, "revive_button_id_"+id_2);
        button_2 = Entities.FindByName(null, "revive_button_parent_id_"+id);
        button_2.SetOrigin(Player_Body_Pos);
        //EntFireByHandle(button, "UnLock", "", 0.00, null, null);
        ori = ent.GetOrigin();
        p_2.SetOrigin(ori);
        p_2.SetAngles(30,tg_ori.y,0);
        ent.Destroy();
        if (Player_Valid_number < 4) {
            p_2.SetHealth(Player_down_Revive_HP_LOWPLAYER);
        }
        else {
            p_2.SetHealth(Player_down_Revive_HP);
        }
        if (!stamin) {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p_1);
        }
        else {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p_1);
        }
        ::Player_Revive_friendly_Number[id] += 1;
        ::revive_activator_space[id_2] = null;
        ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[30][m_lang]+"\x01 \x04 "+GetNameByUserid(sc_2.userid));
        sndent = Entities.FindByName(null, "Player_Voice_"+id_2);
        EntFireByHandle(sndent, "Volume", "0", 0.00, null, null);
        EntFireByHandle(sndent, "StopSound", "", 0.00, null, null);
        local r = 0;
            if (id_2==0) {
                r = RandomInt(0,4);
            }
            else if (id_2==1) {
                r = RandomInt(5,9);
            }
            else if (id_2==2) {
                r = RandomInt(10,14);
            }
            else if (id_2==3) {
                r = RandomInt(15,19);
            }
            else if (id_2==4) {
                r = RandomInt(20,24);
            }
            else if (id_2==5) {
                r = RandomInt(25,29);
            }
            file = Player_THX_Voice[r];
            EntFireByHandle(sndent, "AddOutput", "message "+file, 0.01, null, null);
            if (p_2.GetModelName() && !revive) {
            EntFireByHandle(sndent, "PlaySound", "", 0.15, null, null);
            }
            Player[id_2][32] = false;
            SetPlayerScreen(id_2,15);
            if (!revive) {
                ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc_2.userid)+"\x0A: "+PlayerMsg[261][m_lang]);
            }
        return;
    }
}

::EndViewPos <- [
    Vector(360,471,89),
    Vector(-520,471,89),

    Vector(495,-285,86),
    Vector(495,430,86),

    Vector(580,545,232),
    Vector(580,-281,232)
];
::isOver <- false;
::AllDead <- function () 
{
    //local view = null;
    if ( isStart && !isOver && !end ) 
    {
        //view = Entities.FindByName(null, "viewcontrol_multiplayer");
        local ent = Entities.FindByName(null, "Script_heli_final").GetScriptScope();
        if ( Player_Alive_number == 0 && ent.NumberOfEvacuees < 1 ) 
        {
            isOver = true;
            ent_work = false;
            music_loop = false;

            ScriptPrintMessageChatAll("\x01 \x07 "+::GameMsg[0][::m_lang]);
            EntFire("Script", "RunScriptCode", "MissionFail(3)", 3.00);
            printl("game_end");
            /*if (view != null) {
                view.SetOrigin(EndViewPos[0]);
                view.SetAngles(0,180,0);
                local fade = null;
                fade = Entities.CreateByClassname("env_fade");
                fade.__KeyValueFromInt("spawnflags", 1);
                fade.__KeyValueFromInt("duration", 3);
                fade.__KeyValueFromInt("ReverseFadeDuration", 3);
                fade.__KeyValueFromInt("holdtime", 0.5);
                fade.__KeyValueFromInt("renderamt", 255);
                fade.__KeyValueFromString("rendercolor","0 0 0");
                EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                EntFireByHandle(view, "Enable", "", 0.01, null, null);
                PlayMusic(4,5);
                EntFire("Script", "RunScriptCode", "ViewMove(1)", 0.10);
                local slot = null;
                for (local i=0;i<isWave.len();i++) {
                    if (isWave[i] == true) {
                        slot = i;
                        break;
                    }
                }
                EntFire("ScreenEffect", "StopOverlays");
                EntFire("ScreenEffect", "Kill", "", 0.01);
                EntFire("player_view_tg_*", "kill");
                EntFire("player_revive_icon_*", "Kill");
                EntFire("c4_*", "Kill");
                c4_timer = 0;
                guard_health = 0;
                EntFire("Script", "RunScriptCode", "Show_Data_Statistics(0)", 2.00);
                EntFire("Script", "RunScriptCode", "Show_Data_Statistics(2)", 2.00);
                EntFire("Script", "RunScriptCode", "Show_Data_Statistics(4)", 2.00);
                ScriptPrintMessageChatTeam(3, Wave_Msg[2][m_lang]+" \x0A "+(slot+1)+" \x01 \x07" + (m_lang == 0 ? "波" : "WAVE(S)"));
            }*/
        }
    }
}

::Hurt_Delay <- function (id,type) {
    local hurt = null;
    local tg = null;
    tg = "Player_ID"+id;
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromFloat("DamageDelay", 0.1);
    hurt.__KeyValueFromInt("DamageRadius", 32);
    hurt.__KeyValueFromInt("DamageType", type);
    hurt.__KeyValueFromInt("Damage", 99999);
    hurt.__KeyValueFromString("DamageTarget", tg);
    EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
    EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
}

::Hurt_Delay2 <- function (id,type) {
    local hurt = null;
    local tg = null;
    tg = "Player_ID"+id;
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromFloat("DamageDelay", 0.1);
    hurt.__KeyValueFromInt("DamageRadius", 50);
    hurt.__KeyValueFromInt("DamageType", type);
    hurt.__KeyValueFromInt("Damage", 10000);
    hurt.__KeyValueFromString("DamageTarget", tg);
    EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
    EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
}

::Show_Data_Statistics <- function (id) {
    local p_1,p_2;
    p_1 = Player[id][0];
    if (id!=4) {
    p_2 = Player[id+1][0];
    }
    local ent = null;
    //local name = "Statistics";
    local msg_1,msg_2;
    if (p_1 != null && p_1.IsValid()) {
        local sc_1 = p_1.GetScriptScope();
        msg_1 = GetNameByUserid(sc_1.userid) + " " + Data_Text[0][m_lang] + " " + Player_Kill_Zombie_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[1][m_lang] + " " + Player_Assister_Zombie_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[2][m_lang] + " " + Player_Revive_friendly_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[3][m_lang] + " " + Player_friendlyFire_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[4][m_lang] + " " + Player_Down_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[5][m_lang] + " " + Player_Death_Number[id] + "\n " + 
        GetNameByUserid(sc_1.userid) + " " + Data_Text[6][m_lang] + " " + Points[id];
    }
    if (p_2 != null && p_2.IsValid()) {
    local sc_2 = p_2.GetScriptScope();
    msg_2 = GetNameByUserid(sc_2.userid) + " " + Data_Text[0][m_lang] + " " + Player_Kill_Zombie_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[1][m_lang] + " " + Player_Assister_Zombie_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[2][m_lang] + " " + Player_Revive_friendly_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[3][m_lang] + " " + Player_friendlyFire_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[4][m_lang] + " " + Player_Down_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[5][m_lang] + " " + Player_Death_Number[id+1] + "\n " + 
    GetNameByUserid(sc_2.userid) + " " + Data_Text[6][m_lang] + " " + Points[id+1];
    }

    //ent = Entities.FindByName(null,name);
    //if (ent==null) {
        ent = Entities.CreateByClassname("game_text");
        //ent.__KeyValueFromString("targetname",name);
        ent.__KeyValueFromInt("spawnflags",1);
        ent.__KeyValueFromInt("fadein",1);
        ent.__KeyValueFromInt("fadeout",1);
        ent.__KeyValueFromInt("holdtime",60);
        ent.__KeyValueFromInt("effect",0);
    //}
    if (id==0) {
        ent.__KeyValueFromString("color","0 255 255");
        ent.__KeyValueFromFloat("x",-0.55);
        ent.__KeyValueFromFloat("y",0.16);
        ent.__KeyValueFromInt("channel",2);
    }
    else if (id==2) {
        ent.__KeyValueFromString("color","255 128 192");
        ent.__KeyValueFromFloat("x",-0.29);
        ent.__KeyValueFromFloat("y",0.16);
        ent.__KeyValueFromInt("channel",3);
    }
    if (id==4) {
        ent.__KeyValueFromString("color","0 128 255");
        ent.__KeyValueFromFloat("x",-0.43);
        ent.__KeyValueFromFloat("y",0.60);
        ent.__KeyValueFromInt("channel",4);
    }
    if (id!=4) {
    ent.__KeyValueFromString("message", msg_1 + "\n \n" + msg_2);
    }
    else {
        ent.__KeyValueFromString("message", ""+msg_1);
    }
    EntFireByHandle(ent, "DisPlay", "", 0.00, null, null);
    EntFireByHandle(ent, "Kill", "", 0.10, null, null);
}

::ViewMove <- function (n) {
    local view = null;
    local ori = null;
    local end = EndViewPos[n];
    view = Entities.FindByName(null, "viewcontrol_multiplayer");
    if (view != null) {
        ori = view.GetOrigin();
        if (n==1 && ori.x > end.x) {
            view.SetOrigin(Vector(ori.x-0.75,ori.y,ori.z));
        }
        else if (n==3 && ori.y < end.y) {
            view.SetOrigin(Vector(ori.x,(ori.y+0.75),ori.z));
        }
         else if (n==5 && ori.y > end.y) {
            view.SetOrigin(Vector(ori.x,(ori.y-0.75),ori.z));
        }
        else {
            if (n==1) {
                view.SetOrigin(EndViewPos[2]);
                view.SetAngles(0,90,0);
                local fade = null;
                fade = Entities.CreateByClassname("env_fade");
                fade.__KeyValueFromInt("spawnflags", 1);
                fade.__KeyValueFromInt("duration", 1);
                fade.__KeyValueFromInt("ReverseFadeDuration", 1);
                fade.__KeyValueFromFloat("holdtime", 0.1);
                fade.__KeyValueFromInt("renderamt", 255);
                fade.__KeyValueFromString("rendercolor","0 0 0");
                EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                EntFire("Script", "RunScriptCode", "ViewMove(3)", 0.10);
            }
            else if (n==3) {
                view.SetOrigin(EndViewPos[4]);
                view.SetAngles(0,-90,0);
                local fade = null;
                fade = Entities.CreateByClassname("env_fade");
                fade.__KeyValueFromInt("spawnflags", 1);
                fade.__KeyValueFromInt("duration", 1);
                fade.__KeyValueFromInt("ReverseFadeDuration", 1);
                fade.__KeyValueFromFloat("holdtime", 5);
                fade.__KeyValueFromInt("renderamt", 255);
                fade.__KeyValueFromString("rendercolor","0 0 0");
                EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                //EntFire("Script", "RunScriptCode", "ViewMove(5)", 0.10);
                local snd = null;;
                snd = Entities.FindByName(null, "Global_Sound");
                EntFireByHandle(snd, "StopSound", "", 0.01, null, null);
                EntFireByHandle(snd, "Volume", "0", 0.02, null, null);
                EntFire("servercommand", "command", "mp_restartgame 1");
                return;
                //EntFire("game_round_end", "EndRound_TerroristsWin", "1", 1.00);
            }
            else if (n==5) {
                local fade = null;
                fade = Entities.CreateByClassname("env_fade");
                fade.__KeyValueFromInt("spawnflags", 1);
                fade.__KeyValueFromFloat("duration", 0.1);
                fade.__KeyValueFromFloat("ReverseFadeDuration", 0.1);
                fade.__KeyValueFromInt("holdtime", 5);
                fade.__KeyValueFromInt("renderamt", 255);
                fade.__KeyValueFromString("rendercolor","0 0 0");
                EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                local snd = null;;
                snd = Entities.FindByName(null, "Global_Sound");
                EntFireByHandle(snd, "StopSound", "", 0.01, null, null);
                EntFireByHandle(snd, "Volume", "0", 0.02, null, null);
                EntFire("game_round_end", "EndRound_TerroristsWin", "1", 1.00);
            }
            return;
        }
        EntFire("Script", "RunScriptCode", "ViewMove("+n+")", 0.01);
    }
}


::ShowEventMsg <- function (n) {
    local p = activator;
    local ent = null;
    ent = Entities.CreateByClassname("env_hudhint");
    ent.__KeyValueFromString("message",event_msg[n][m_lang]);
    ent.SetOwner(P);
    EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
    EntFireByHandle(ent, "Kill", "", 0.01, null, null);
}


::barricade_A <- ["none",true,true,true,true,true,true,true,true,true,true,true,true];
::barricade_B <- ["none",true,true,true,true,true,true,true,true,true,true,true,true];
::barricade_C <- ["none",true,true,true,true,true,true,true,true,true,true,true,true];

::barrbreak <- function (num,umd) {
//    local umd = null;
//    umd = RandomInt(1,3);
    if (umd==1) {
        if (barricade_A[num]) {
            umd = "upper";
            barricade_A[num] = false;
        }
        //else {
        //    barrbreak(num);
        //}
    }
    else if (umd==2) {
        if (barricade_B[num]) {
            umd = "middle";
            barricade_B[num] = false;
        }
        //else {
        //    barrbreak(num);
        //}
    }
    else if (umd==3) {
        if (barricade_C[num]) {
            umd = "lower";
            barricade_C[num] = false;
        }
        //else {
        //    barrbreak(num);
        //}
    }
        EntFire("barr_"+num+"_"+umd, "SetAnimationNoReset", "brake");
}

::barrCheckZMB_Tri <- function () {
    for (local i=1;i<=12;i++) {
        barrbreakForTowZMB(i);
    }
}
::barrbreakForTowZMB <- function (n) {
    local space = [null];
    local pos = null;
    pos = Entities.FindByName(null, "barr_"+n+"_button").GetOrigin();
    local within = null;
    local slot = 0;
    local barr_1 = Entities.FindByName(null, "barr_"+n+"_breakable_A");
    local barr_2 = Entities.FindByName(null, "barr_"+n+"_breakable_B");
    local barr_3 = Entities.FindByName(null, "barr_"+n+"_breakable_C");
    while ((within = Entities.FindByClassnameWithin(within,"player",pos,42)) != null) {
        if (within.GetTeam() == 2 && within.GetHealth() > 0) {
            if (within.GetModelName() == ::zombie_model[23]) {
                if (barr_1 != null) {
                EntFire("barr_"+n+"_breakable_A", "SetHealth", ""+(barr_1.GetHealth()-50));
                }
                if (barr_2 != null) {
                EntFire("barr_"+n+"_breakable_B", "SetHealth", ""+(barr_2.GetHealth()-50));
                }
                if (barr_3 != null) {
                EntFire("barr_"+n+"_breakable_C", "SetHealth", ""+(barr_3.GetHealth()-50));
                }
                break;
            }
            for (local i=0;i<space.len();i++) {
                if (space[i] == within) {
                    slot = i;
                    break;
                }
            }
            if (space[slot] != within) {
                space.push(within);
            }
            if ((space.len()-1) == 1) {
                if (barr_1 != null) {
                EntFire("barr_"+n+"_breakable_A", "SetHealth", ""+(barr_1.GetHealth()-2));
                }
                if (barr_2 != null) {
                EntFire("barr_"+n+"_breakable_B", "SetHealth", ""+(barr_2.GetHealth()-3));
                }
                if (barr_3 != null) {
                EntFire("barr_"+n+"_breakable_C", "SetHealth", ""+(barr_3.GetHealth()-4));
                }
                continue;
            }
            else if ((space.len()-1) >= 2) {
                if (barr_1 != null) {
                EntFire("barr_"+n+"_breakable_A", "SetHealth", ""+(barr_1.GetHealth()-10));
                }
                if (barr_2 != null) {
                EntFire("barr_"+n+"_breakable_B", "SetHealth", ""+(barr_2.GetHealth()-12));
                }
                if (barr_3 != null) {
                EntFire("barr_"+n+"_breakable_C", "SetHealth", ""+(barr_3.GetHealth()-14));
                }
                break;
            }
        }
    }
    space = [null];
    EntFire("Script", "RunScriptCode", "barrbreakForTowZMB("+n+")", 0.25);
}

::fix_tri <- function (num) {
    local p = activator;
    local within = null;
    for (local o=0;o<Player.len();o++) {
    within = Entities.FindByClassnameWithin(within,"player",caller.GetOrigin(),128);
    if (within != null && within.GetTeam() == 3) {
        if (within == p) {
            local ent = null;
            local name = null;
            local id = 0;
            for (local i=0;i<Player.len();i++) {
                if (Player[i][0] == p) {
                    name = "progress_pid"+i;
                    id = i;
                    break;
                }
            }
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("targetname",name);
            ent.__KeyValueFromString("message","");
            ent.SetOwner(p);
            if (!barricade_A[num] || !barricade_B[num] || !barricade_C[num]) {
                EntFire("barr_"+num+"_button", "Lock");
                Player[id][20] = true;
                progress(id,0,num);
            }
        }
        else {
            continue;
        }
        return;
    }
    }
}

::progress <- function (id,prog,num) {
    if (Player[id][20]) {
    local p = Player[id][0];
    local text = "";//"fixing... \n ";
    local blank = "□";
    local fill = "■";
    local Progress = 15;
    local maxspeedlimit = 130;
    if (p.GetVelocity().x > maxspeedlimit || p.GetVelocity().y > maxspeedlimit || p.GetVelocity().x < -maxspeedlimit || p.GetVelocity().y < -maxspeedlimit || p.GetVelocity().z > 0) {
        EntFire("progress_pid"+id, "AddOutput", "message "+event_msg[0][m_lang]);
        EntFire("progress_pid"+id, "ShowHudHint", "", 0.01, p);
        EntFire("Script", "RunScriptCode", "progress_stop("+id+" "+num+")", 0.02);
        return;
    }
    if (prog==0) {
        for (local i=0;i<Progress;i++) {
        text += blank;
        }
    }
    else {
        for (local i=0;i<=prog;i++) {
            text += fill;
        }
        for (local i=0;i<(Progress-prog);i++) {
            text += blank;
        }
    }
    EntFire("progress_pid"+id, "AddOutput", "message "+text);
    EntFire("progress_pid"+id, "ShowHudHint", "", 0.01, p);
    if (prog<=Progress) {
        EntFire("Script", "RunScriptCode", "progress("+id+" "+(prog+1)+" "+num+")", 0.02);
    }
    else {
        PointChange(id,20,1);
        EntFire("progress_pid"+id, "AddOutput", "message "+event_msg[2][m_lang]);
        EntFire("progress_pid"+id, "ShowHudHint", "", 0.01, p);
        EntFire("Script", "RunScriptCode", "progress_stop("+id+" "+num+")", 0.02);
        fixbarr(num);
        return;
    }
    }
}

::fixbarr <- function (num) {
    local r = RandomInt(0,2);
    local snd = item_snd[r];
    local ent = null;
        ent = Entities.FindByName(null, "barr_"+num+"_sound");
        ent.__KeyValueFromString("message",snd);
        EntFireByHandle(ent, "PlaySound", "", 0.30, null, null);
        EntFire("Script", "RunScriptCode", "fixdonesnd("+num+")", 1.00);
        if (!barricade_A[num]) {
            EntFire("barr_"+num+"_upper", "SetAnimationNoReset", "fix");
            EntFire("barr_"+num+"_a_template", "ForceSpawn", "", 0.90);
            barricade_A[num] = true;
        }
        else if (!barricade_B[num]) {
            EntFire("barr_"+num+"_middle", "SetAnimationNoReset", "fix");
            EntFire("barr_"+num+"_b_template", "ForceSpawn", "", 0.90);
            barricade_B[num] = true;
        }
        else if (!barricade_C[num]) {
            EntFire("barr_"+num+"_lower", "SetAnimationNoReset", "fix");
            EntFire("barr_"+num+"_c_template", "ForceSpawn", "", 0.90);
            barricade_C[num] = true;
        }
}

::fixdonesnd <- function (num) {
    local ent = null;
    local snd = item_snd[RandomInt(3,4)];
    ent = Entities.FindByName(null, "barr_"+num+"_sound");
    ent.__KeyValueFromString("message",snd);
    EntFireByHandle(ent, "PlaySound", "", 0.01, null, null);
}

::progress_stop <- function (id,num) {
    Player[id][20] = false;
    EntFire("progress_pid"+id, "Kill");
    EntFire("barr_"+num+"_button", "UnLock");
}

::MusicList <- [
    
];

::MusicSwitch <- false;
::JukeBoxPlay <- function () {
    local ent = null;
    local snd = null;
    local r = null;
    for (local i=0;i<2;i++) {
        r = RandomInt(0,MusicList.len()-1);
    }
    ent = Entities.FindByName(null,"jukebox");
    snd = Entities.FindByName(null, "Music");
    if (!MusicSwitch) {
        MusicSwitch = true;
        EntFire("jukebox_button", "Lock");
        EntFire("jukebox_button", "UnLock", "",8.00);
        snd.__KeyValueFromString("message",MusicList[r]);
        EntFireByHandle(ent, "SetAnimationNoReset", "replace", 0.00, null, null);
        EntFireByHandle(ent, "SetAnimation", "diskspin", 6.00, null, null);
        EntFire("Music", "PlaySound", "", 6.00);
        EntFire("JukeBox_Light", "Color", "0 255 0");
    }
    else {
        MusicSwitch = false;
        EntFireByHandle(ent, "SetAnimation", "idle", 0.00, null, null);
        EntFire("Music", "StopSound");
        EntFire("Music", "Volume", "0");
        EntFire("JukeBox_Light", "Color", "255 0 0");
    }
}

::DoorisOut <- false;
::DoorCost <- function () {
    if (!DoorisOut) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "DoorCost"
    local text = item_text[14][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "door_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                //if (tl==1.0) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == p) {
                            id = i;
                            break;
                        }
                    }
                    entb = Entities.FindByName(null, name);
                    if (entb == null) {
                        entb = Entities.CreateByClassname("game_text");
                        entb.__KeyValueFromString("targetname",name);
                        entb.__KeyValueFromInt("spawnflags",0);
                        entb.__KeyValueFromString("message",text);
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    if (eye_see_space[id][0] != null) {
                        if (eye_see_space[id][0] == ent) {
                            if (p.GetHealth() > 0) {
                                entb.SetOwner(p);
                                EntFireByHandle(entb, "Display", "", 0.00, p, null);
                                //EntFireByHandle(entb, "Kill", "", 0.01, null, null);
                            }
                        }
                    }
                //}
            }
        }
    }
    EntFire("Script", "RunScriptCode", "DoorCost()", 0.15);
    }
}

::DoorOpen <- function () {
    local p = activator;
    local ent = null;
    local within = null;
    local button = null;
    local id = null;
    local cost = 1000;
    local sc = p.GetScriptScope();
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        ent = Entities.FindByName(null, "door_main");
        button = Entities.FindByName(null, "door_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            PointChange(id,cost,0);
            EntFireByHandle(ent, "Unlock", "", 0.00, null, null);
            EntFireByHandle(ent, "Open", "", 0.01, null, null);
            EntFire("d2_NoEntry", "Disable");
            //EntFire("zombie_teleport_4", "Kill");
            //EntFire("zombie_teleport_5", "Kill"); 
            EntFire("zombie_nav_2", "UnblockNav");
            button.Destroy();
            DoorisOut = true;
            if (!d1_d2_d3) {
            d1 = false;
            if (!d1_d3) {
                d1_d2 = true;
            }
            else if (d1_d3) {
                d1_d3 = false;
                d1_d2_d3 = true;
            }
            }
            local snd = null;
            local file = null;
            local ori = ent.GetOrigin();
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = item_snd[15];
                snd.__KeyValueFromString("message", file);
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[14][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[3][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            }
            return;
        }
        else {
            continue;
        }
        }
    }
}
::alpha <- [255,255];
::CouchisOut <- false;
::CouchCost <- function () {
    if (!CouchisOut) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "CouchCost"
    local text = item_text[15][m_lang];
    //local tl = null;
    ent = Entities.FindByName(null, "couch_button");
    local pos = ent.GetOrigin();
    while ((within = Entities.FindByClassnameWithin(within,"player",Vector(pos.x,pos.y,pos.z+5),42)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                //tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                //if (tl==1.0) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == p) {
                            id = i;
                            break;
                        }
                    }
                    entb = Entities.FindByName(null, name);
                    if (entb == null) {
                        entb = Entities.CreateByClassname("game_text");
                        entb.__KeyValueFromString("targetname",name);
                        entb.__KeyValueFromInt("spawnflags",0);
                        entb.__KeyValueFromString("message",text);
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    //if (eye_see_space[id][0] != null) {
                        //if (eye_see_space[id][0] == ent) {
                            if (p.GetHealth() > 0) {
                                entb.SetOwner(p);
                                EntFireByHandle(entb, "Display", "", 0.00, p, null);
                                //EntFireByHandle(entb, "Kill", "", 0.01, null, null);
                            }
                        //}
                   //}
                //}
            }
        }
    }
    EntFire("Script", "RunScriptCode", "CouchCost()", 0.15);
    }
}

::CouchDestroy <- function () {
    local p = activator;
    local ent = null;
    local within = null;
    local button = null;
    local id = null;
    local cost = 1000;
    local sc = p.GetScriptScope();
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        ent = Entities.FindByName(null, "couch");
        button = Entities.FindByName(null, "couch_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),64);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            PointChange(id,cost,0);
            button.Destroy();
            CouchisOut = true;
            CouchMove();
            //EntFire("d3_NoEntry", "Disable");
            EntFire("couch_button", "Kill");
            EntFire("couch_wall", "Disable", "", 1.50);
            //EntFire("BLOCK_LOS_1", "Disable");
            //EntFire("zombie_teleport_1", "Kill");
            EntFire("zombie_nav_1", "UnblockNav");
            EntFire("zombie_nav_4", "UnblockNav");
            if (!d1_d2_d3) {
            d1 = false;
            if (!d1_d2) {
                d1_d3 = true;
            }
            else if (d1_d2) {
                d1_d2 = false;
                d1_d2_d3 = true;
            }
            }
            local snd = null;
            local file = null;
            local ori = ent.GetOrigin();
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = item_snd[15];
                snd.__KeyValueFromString("message", file);
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[15][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[3][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            }
            return;
        }
        else {
            continue;
        }
        }
    }
}

::CouchMove <- function () {
    local ent = null;
    ent = Entities.FindByName(null, "couch");
    local pos = ent.GetOrigin();
    ent.SetOrigin(Vector(pos.x,pos.y,pos.z+2));
    if (pos.z < 322) {
    EntFire("Script", "RunScriptCode", "CouchMove()", 0.02);
    if (alpha[0] > 2) {
    alpha[0] -= 2;
    }
    ent.__KeyValueFromInt("renderamt",alpha[0]);
    }
    else {
        ent.Destroy();
    }
}

::Couch_2_isOut <- false;
::Couch_2_Cost <- function () {
    if (!Couch_2_isOut) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "Couch_2_Cost"
    local text = item_text[15][m_lang];
    //local tl = null;
    ent = Entities.FindByName(null, "couch_2_button");
    local pos = ent.GetOrigin();
    while ((within = Entities.FindByClassnameWithin(within,"player",Vector(pos.x,pos.y,pos.z-32),64)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                //tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                //if (tl==1.0) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == p) {
                            id = i;
                            break;
                        }
                    }
                    entb = Entities.FindByName(null, name);
                    if (entb == null) {
                        entb = Entities.CreateByClassname("game_text");
                        entb.__KeyValueFromString("targetname",name);
                        entb.__KeyValueFromInt("spawnflags",0);
                        entb.__KeyValueFromString("message",text);
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    //if (eye_see_space[id][0] != null) {
                        //if (eye_see_space[id][0] == ent) {
                            if (p.GetHealth() > 0) {
                                entb.SetOwner(p);
                                EntFireByHandle(entb, "Display", "", 0.00, p, null);
                                //EntFireByHandle(entb, "Kill", "", 0.01, null, null);
                            }
                        //}
                    //}
                //}
            }
        }
    }
    EntFire("Script", "RunScriptCode", "Couch_2_Cost()", 0.15);
    }
}

::Couch_2_Destroy <- function () {
    local p = activator;
    local ent = null;
    local within = null;
    local button = null;
    local id = null;
    local cost = 1000;
    local sc = p.GetScriptScope();
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        ent = Entities.FindByName(null, "couch_2");
        button = Entities.FindByName(null, "couch_2_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),64);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            PointChange(id,cost,0);
            button.Destroy();
            Couch_2_isOut = true;
            Couch_2_Move();
            EntFire("d3_NoEntry", "Disable");
            EntFire("couch_2_button", "Kill");
            EntFire("couch_2_wall", "Disable", "", 1.50);
            //EntFire("BLOCK_LOS_2", "Disable");
            //EntFire("zombie_teleport_2", "Kill");
            //EntFire("zombie_teleport_3", "Kill");
            EntFire("zombie_nav_3", "UnblockNav");
            d1 = false;
            d1_d2 = false;
            d1_d3 = false;
            d1_d2_d3 = true;
            local snd = null;
            local file = null;
            local ori = ent.GetOrigin();
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = item_snd[15];
                snd.__KeyValueFromString("message", file);
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[15][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[3][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            }
            return;
        }
        else {
            continue;
        }
        }
    }
}

::Couch_2_Move <- function () {
    local ent = null;
    ent = Entities.FindByName(null, "couch_2");
    local pos = ent.GetOrigin();
    ent.SetOrigin(Vector(pos.x,pos.y,pos.z+2));
    if (pos.z < 322) {
    EntFire("Script", "RunScriptCode", "Couch_2_Move()", 0.02);
    if (alpha[1] > 2) {
    alpha[1] -= 2;
    }
    ent.__KeyValueFromInt("renderamt",alpha[1]);
    }
    else {
        ent.Destroy();
    }
}


::ClearAndSpawnPlayerVoiceEnt <- function () {
    /*local ent = null;
    for (local i=0;i<Player.len();i++) {
        ent = Entities.FindByName(null, "Player_Voice_"+i);
        if (ent != null) {
            ent.Destroy();
        }
        if (i==(Player.len()-1)) {
            EntFire("PlayerVoice_template", "ForceSpawn", "", 0.10);
            return;
        }
    }*/
    EntFire("Player_Voice_*", "Kill");
    EntFire("PlayerVoice_template", "ForceSpawn");
}

::ClearAndSpawnZombieVoiceEnt <- function () {
    /*local ent = null;
    for (local i=0;i<12;i++) {
        ent = Entities.FindByName(null, "zombie_snd_id"+i);
        if (ent != null) {
            ent.Destroy();
        }
        else {
            continue;
        }
    }*/
    EntFire("zombie_snd_id*", "Kill");
    EntFire("zombie_snd_template", "ForceSpawn");
}

/*::ZombieDropSkill_ON <- function () {
    local p = activator;
    if (p != null) {
        for (local i=0;i<BOT.len();i++) {
            if (p.GetHealth() > 0 && p.GetTeam() == 2) {
                if (BOT[i][0] == p) {
                BOT[i][9] = true;
                }
            }
        }
    }
}

::ZombieDropSkill_OFF <- function () {
    local p = activator;
    if (p != null) {
        for (local i=0;i<BOT.len();i++) {
            if (p.GetHealth() > 0 && p.GetTeam() == 2) {
                if (BOT[i][0] == p) {
                BOT[i][9] = false;
                }
            }
        }
    }
}*/

::zombie_teleport <- function (pos) {
    local p = activator;
    local id = null;
    local zb = null;
    if (p.GetTeam() == 2) {
        for (local i=0;i<BOT.len();i++) {
            if (BOT[i][0] == p) {
                id = i;
                break;
            }
        }
        zb = BOT[id][8];
        if (zb) {
            if (pos==0) {
                p.SetOrigin(Vector(-832,-133,9)); 
            }
            else if (pos==1) {
                if (d1_d2_d3) {
                p.SetOrigin(Vector(1556,533,182));
                }
                else {
                   p.SetOrigin(Vector(477,-1113,8)); 
                }
            }
            else if (pos==2) {
                if (d1_d2_d3) {
                p.SetOrigin(Vector(477,-1113,8)); 
                }
                else {
                   p.SetOrigin(Vector(1556,533,182)); 
                }
            }
            else if (pos==3) {
                p.SetOrigin(Vector(-498,800,7)); 
            }
            else if (pos==4) {
                p.SetOrigin(Vector(662,-1081,8)); 
            }
        }
    }
}

::PlayRadio <- function (n) {
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "map_world_sound");
    if (snd != null) {
        file = map_snd[n]; //7 8
        snd.__KeyValueFromString("message", file);
        snd.SetOrigin(Vector(561,649,42));
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFire("radio_button", "Kill");
    }
}

::cdc <- function () {
    local ent = null;
    local name = "cdc_weapon";
    //ent = CreateProp("prop_dynamic", Vector(0,0,0), CaseList[9], 0);
    //ent.__KeyValueFromString("targetname", name);
    EntFire("cdc_weapon", "SetParent", "cdc");
    EntFire("cdc_weapon", "SetParentAttachmentMaintainOffset", "weapon_hand_R", 0.01);
}

::blackwhite_in <- function () {
    local ent = null;
    local file = "materials/correction/ww2color.raw";
    local name = "ww2color";
    ent = Entities.FindByName(null, name);
    if (ent == null) {
        ent = Entities.CreateByClassname("color_correction");
        ent.__KeyValueFromString("targetname", name);
        ent.__KeyValueFromInt("minfalloff", -1);
        ent.__KeyValueFromInt("maxfalloff", -1);
        ent.__KeyValueFromInt("fadeInDuration", 2);
        ent.__KeyValueFromInt("fadeOutDuration", 2);
        ent.__KeyValueFromString("filename", file);
    }
    EntFire("colorcorrection_main", "Disable");
    EntFire("ww2color", "Enable");
    //printl("correction_ww2color_enable");
}

::blackwhite_out <- function () {
    EntFire("ww2color", "Disable");
    EntFire("colorcorrection_main", "Enable");
}


::endzmpos <- [
    Vector(157,647,145),//0
    Vector(138,600,145),//1
    Vector(244,573,145),//2
    Vector(322,407,150),//3
    Vector(230,482,150),//4
    Vector(181,464,150),//5
    Vector(173,382,150),//6
    Vector(133,355,150),//7
    Vector(77,323,149),//8
    Vector(31,318,149),//9
    Vector(45,367,149),//10
    Vector(85,380,152),//11
    Vector(0,392 ,145), //12 L
    Vector(-5,439,148),//13 ELEC
    Vector(-33,451,145),//14
    Vector(64,431,150),//15
    Vector(99,477,154), //16 L
    Vector(102,521,154),//17
    Vector(119,440,152),//18
];


::Ending <- function () {
    ::end = true;
    local p,view,pos,model,fade;
    local ori = Vector(2,569,152);
    local m_targetVector = null;
    local m_sentryOrigin = null;
    local m_dir = null;
    local UCSX = null;
    local pitch = null;
    local yaw = null;
    local ang = null;
    local group = [0,256,512,524800,2304,8448,16640,3,259,515,524803,16643,33027,2307, 21,277,1301,2325,4373,8469,16661,33045,65813,131349,262421,524565,
389,1413,2437,4485,8581,16773,33157,524677,262789,262725,262693, 41,281, 1305,2329,4377,8473,16665,33049,65817,131353,262425,524825];
    for (local i=0;i<19;i++) {
        local r = RandomInt(1,10);
        local body = RandomInt(0,group.len()-1);
        local skin = RandomInt(0,11);
        model = CreateProp("prop_dynamic", endzmpos[i], ::zombie_model[0], 0);
        model.__KeyValueFromInt("solid", 0);
        model.__KeyValueFromInt("fademindist", 512);
        model.__KeyValueFromInt("fademaxdist", 1024);
        m_targetVector = ori;
        m_sentryOrigin = model.GetOrigin();
        m_dir = m_targetVector - m_sentryOrigin;
        UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
        pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
        yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;
        if(m_dir.x < 0) {
            yaw = 180 - yaw;
        }
        model.SetAngles(0,yaw,0);
        if (i==1) {
        EntFireByHandle(model, "Skin", "10", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose4", 0.00, null, null);
        } 
        else if (i==8) {
        EntFireByHandle(model, "Skin", "0", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose3", 0.00, null, null);
        }
        else if (i==9) {
        EntFireByHandle(model, "Skin", "6", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose7", 0.00, null, null);
        } 
        else if (i==10) {
        EntFireByHandle(model, "Skin", "8", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose9", 0.00, null, null);
        } 
        else if (i==11) {
        EntFireByHandle(model, "Skin", "7", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose2", 0.00, null, null);
        }
        else if (i==12) {
        EntFireByHandle(model, "Skin", "7", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "512" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose1", 0.00, null, null);
        }
        else if (i==13) {
        EntFireByHandle(model, "Skin", "0", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "16643" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose11", 0.00, null, null);
        }
        else if (i==14) {
        EntFireByHandle(model, "Skin", "11", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "0" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose1", 0.00, null, null);
        }
        else if (i==15) {
        EntFireByHandle(model, "Skin", "3", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "524677" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose10", 0.00, null, null);
        }
        else if (i==16) {
        EntFireByHandle(model, "Skin", "8", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "512" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose4", 0.00, null, null);
        }
        else if (i==17) {
        EntFireByHandle(model, "Skin", "1", 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", "256" 0.01, null, null);
        EntFireByHandle(model, "SetAnimation", "pose3", 0.00, null, null);
        }
        else {
        EntFireByHandle(model, "SetAnimation", "pose"+r, 0.00, null, null);
        EntFireByHandle(model, "Skin", ""+skin, 0.01, null, null);
        EntFireByHandle(model, "SetBodyGroup", ""+group[body], 0.01, null, null);
        }
    }
    EntFire("clouds", "color", "100 100 100");
    EntFire("fogexteriorcontroller", "SetColor", "33 33 33");
    EntFire("fogexteriorcontroller", "SetSatrtDist", "128");
    EntFire("fogexteriorcontroller", "SetEndDist", "768");
    EntFire("crow*", "Kill");
    fade = Entities.CreateByClassname("env_fade");
    fade.__KeyValueFromInt("spawnflags", 1);
    fade.__KeyValueFromInt("duration", 4);
    fade.__KeyValueFromInt("ReverseFadeDuration", 4);
    fade.__KeyValueFromFloat("holdtime", 0.10);
    fade.__KeyValueFromInt("renderamt", 255);
    fade.__KeyValueFromString("rendercolor","0 0 0");
    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
    pos = Vector(56,382,180);
    view = Entities.FindByName(null, "viewcontrol_multiplayer");
    view.SetOrigin(pos);
    view.SetAngles(0,278.5,0);
    EntFireByHandle(view, "Enable", "", 0.00, p, null);
    EntFire("portal_template", "ForceSpawn");
    EntFire("Script", "RunScriptCode", "CreatePortal()", 0.01);
    EntFire("Script", "RunScriptCode", "endview()", 0.01);
    EntFire("servercommand", "command", "bot_kick");
    PlayMusic(10,10);

    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            p = Player[i][0];
            EntFireByHandle(p, "SetHUDVisibility", "0", 0.00, null, null);
            //view = Entities.FindByName(null, "character_view_id_"+i);
            //view.SetOrigin(pos);
            //view.SetAngles(0,278.5,0);
            //EntFireByHandle(view, "Enable", "", 0.00, p, null);
            //EntFire("Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
            SetPlayerScreen(i,15);
            if (i==0) {
                p.SetOrigin(Vector(41,596,152));
                p.SetAngles(0,-30,0);
            }
            else if (i==1) {
                p.SetOrigin(Vector(-42,525,152));
                p.SetAngles(0,-45,0);
            }
            else if (i==2) {
                p.SetOrigin(Vector(-92,520,152));
                p.SetAngles(0,-35,0);
            }
            else if (i==3) {
                p.SetOrigin(Vector(40,648,152));
                p.SetAngles(0,0,0);
            }
            else if (i==4) {
                p.SetOrigin(Vector(-91,600,152));
                p.SetAngles(0,-20,0);
            }
            EntFire("clientcommand", "command", "slot1", 0.00, p)
        }
    }
}

::CreatePortal <- function () {
    local ent = null;
    ent = Entities.FindByName(null, "portal");
    ent.SetOrigin(Vector(21,508,200));
    EntFire("portal", "ShowSprite");
    EntFire("portal_glow", "ShowSprite");
    EntFire("portal_light", "TurnOn");
}

::endviewordersw <- true;
::endviewordersw2 <- false;
::endviewordersw3 <- false;
::endview <- function () {
    local view,pos,pos2,pos3,pos4,ang,fade;
    view = Entities.FindByName(null, "viewcontrol_multiplayer");
    //for (local i=0;i<Player.len();i++) {
        //if (Player[i][0] != null) {
            //view = Entities.FindByName(null, "character_view_id_"+i);
            pos = view.GetOrigin(),pos2 = Vector(21,514.5,194),pos3 = Vector(1,607,194),
            pos4 = Vector(-34,710,217);
            ang = view.GetAngles();
            if (endviewordersw) {
                if (pos.x > pos2.x) {
                    pos.x -= 0.04;
                }
                if (pos.y < pos2.y) {
                    pos.y += 0.15;
                }
                if (pos.x <= pos2.x && pos.y >= pos2.y) {
                    endviewordersw = false;
                    endviewordersw2 = true;
                    fade = Entities.CreateByClassname("env_fade");
                    fade.__KeyValueFromInt("spawnflags", 1);
                    fade.__KeyValueFromInt("duration", 2);
                    fade.__KeyValueFromInt("ReverseFadeDuration", 2);
                    fade.__KeyValueFromFloat("holdtime", 0.2);
                    fade.__KeyValueFromInt("renderamt", 255);
                    fade.__KeyValueFromString("rendercolor","0 232 232");
                    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                    self.EmitSound(map_snd[32]);
                    //ScriptPrintMessageChatTeam(3, "switch");
                }
            }
            if (endviewordersw2) {
                if (pos.x > pos3.x) {
                    pos.x -= 0.03;
                }
                if (pos.y < pos3.y) {
                    pos.y += 0.1;
                }
                if (ang.x > -15) {
                    ang.x -= 0.04;
                }
                if (ang.y < 282) {
                    ang.y += 0.01;
                }
                if (pos.x <= pos3.x && pos.y >= pos3.y) {
                    endviewordersw2 = false;
                    endviewordersw3 = true;
                    fade = Entities.CreateByClassname("env_fade");
                    fade.__KeyValueFromInt("spawnflags", 1);
                    fade.__KeyValueFromInt("duration", 1);
                    fade.__KeyValueFromInt("ReverseFadeDuration", 1);
                    fade.__KeyValueFromFloat("holdtime", 0.2);
                    fade.__KeyValueFromInt("renderamt", 255);
                    fade.__KeyValueFromString("rendercolor","0 232 232");
                    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                    self.EmitSound(map_snd[32]);
                    local startdist = 0;
                    local enddist = 1024;
                    local delay = 0.00;
                    local w = 1;
                    EntFire("clouds", "Disable");
                    //EntFire("sky_csgo_night02c", "Trigger");
                    EntFire("fogexteriorcontroller", "SetColor", "0 0 0");
                    EntFire("map_particle", "Stop");
                    EntFire("map_fire", "ExtinguishTemporary", "1", 10.00);
                    while (w==1) {
                        delay += 0.02;
                        if (enddist != 32) {
                            enddist -= 1;
                        }
                        EntFire("fogexteriorcontroller", "SetStartDist", startdist.tostring(), delay);
                        EntFire("fogexteriorcontroller", "SetEndDist", enddist.tostring(), delay);
                        if (startdist == 0 && enddist == 32) {
                            w=0;
                            break;
                        }
                    }
                    //ScriptPrintMessageChatTeam(3, "switch");
                }
            }
            if (endviewordersw3) {
                if (pos.x > pos4.x) {
                    pos.x -= 0.08;
                }
                if (pos.y < pos4.y) {
                    pos.y += 0.1;
                }
                if (pos.z < pos4.z) {
                    pos.z += 0.05;
                }
                if (ang.y < 285) {
                    ang.y += 0.01;
                }
                if (ang.x < 30) {
                    ang.x += 0.04;
                }
                if (pos.x <= pos4.x && pos.y >= pos4.y  && pos.z >= pos4.z && ang.x >= 30) {
                    endviewordersw3 = false;
                    fade = Entities.CreateByClassname("env_fade");
                    fade.__KeyValueFromInt("spawnflags", 0);
                    fade.__KeyValueFromInt("duration", 3);
                    fade.__KeyValueFromInt("ReverseFadeDuration", 3);
                    fade.__KeyValueFromFloat("holdtime", 5);
                    fade.__KeyValueFromInt("renderamt", 255);
                    fade.__KeyValueFromString("rendercolor","200 200 200");
                    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                    EntFire("Script", "RunScriptCode", "end_List()", 7.00);
                    return;
                }
            }
            view.SetOrigin(pos);
            view.SetAngles(ang.x,ang.y,0);
        //}
    //}
    EntFire("Script", "RunScriptCode", "endview()", 0.01);
}

::end_List <- function () {
    local p,ent,fade,delay;
    local text,text2,text3,text4,text5,text6,text7,text8,text9;
    fade = Entities.CreateByClassname("env_fade");
    fade.__KeyValueFromInt("spawnflags", 1);
    fade.__KeyValueFromInt("duration", 3);
    fade.__KeyValueFromInt("ReverseFadeDuration", 3);
    fade.__KeyValueFromFloat("holdtime", 0.1);
    fade.__KeyValueFromInt("renderamt", 255);
    fade.__KeyValueFromString("rendercolor","200 200 200");
    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
    ent = Entities.CreateByClassname("game_text");
    ent.__KeyValueFromInt("spawnflags",1);
    ent.__KeyValueFromInt("fadein",3);
    ent.__KeyValueFromInt("fadeout",4);
    ent.__KeyValueFromInt("holdtime",3);
    ent.__KeyValueFromInt("x",-1);
    ent.__KeyValueFromInt("y",-1);
    ent.__KeyValueFromString("color","255 255 255");
    ent.__KeyValueFromInt("effect",0);
    ent.__KeyValueFromInt("channel",2);
     for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            p = Player[i][0];
            EntFireByHandle(p, "SetHUDVisibility", "1", 0.10, null, null);
            //EntFire("clientcommand", "command", "cl_draw_only_deathnotices 1", 0.00, p);
            EntFire("Script", "RunScriptCode", "Delete_Player_Weapons()", 0.00, p);
        }
    }
    EntFire("Script", "RunScriptCode", "PlayMusic(17,9)", 5.00);
    EntFire("Script", "RunScriptCode", "PlayMusic(0,5)", 98.00);
    delay = 5.00;
    for (local i=0;i<4;i++) {
        text = end_msg[i][m_lang];
        EntFireByHandle(ent, "AddOutput", "message "+text, delay, null, null);
        EntFireByHandle(ent, "DisPlay", "", delay+0.01, null, null);
        delay += 10.00;
        if (i==3) {
            text = end_msg[4][m_lang]+"\n"+end_msg[5][m_lang]+"\n"+end_msg[6][m_lang]+"\n"+end_msg[7][m_lang]+"\n"+end_msg[8][m_lang]+"\n"+end_msg[9][m_lang]+"\n"+end_msg[10][m_lang];
            text2 = end_msg[4][m_lang]+"\n"+end_msg[11][m_lang]+"\n"+end_msg[12][m_lang]+"\n"+end_msg[13][m_lang]+"\n"+end_msg[14][m_lang];
            text3 = end_msg[4][m_lang]+"\n"+end_msg[15][m_lang]+"\n"+end_msg[16][m_lang]+"\n"+end_msg[17][m_lang]+"\n"+end_msg[18][m_lang];
            text4 = end_msg[19][m_lang]+"\n"+end_msg[20][m_lang]+"\n"+end_msg[21][m_lang]+"\n"+end_msg[22][m_lang]+"\n"+end_msg[23][m_lang];
            text5 = end_msg[19][m_lang]+"\n"+end_msg[24][m_lang]+"\n"+end_msg[25][m_lang]+"\n"+end_msg[26][m_lang]+"\n"+end_msg[27][m_lang];
            text6 = end_msg[19][m_lang]+"\n"+end_msg[28][m_lang]+"\n"+end_msg[29][m_lang]+"\n"+end_msg[30][m_lang]+"\n"+end_msg[31][m_lang];
            text7 = end_msg[19][m_lang]+"\n"+end_msg[32][m_lang]+"\n"+end_msg[33][m_lang]+"\n"+end_msg[34][m_lang]+"\n"+end_msg[35][m_lang];
            text8 = end_msg[19][m_lang]+"\n"+end_msg[36][m_lang]+"\n"+end_msg[37][m_lang];
            text9 = end_msg[38][m_lang]+"\n"+end_msg[39][m_lang]+"\n"+end_msg[40][m_lang]+"\n"+end_msg[41][m_lang]+"\n"+end_msg[42][m_lang]+"\n"+end_msg[43][m_lang]+"\n"+end_msg[44][m_lang];
            EntFireByHandle(ent, "AddOutput", "message "+text, delay, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+0.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text2, delay+10.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+10.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text3, delay+20.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+20.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text4, delay+30.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+30.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text5, delay+40.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+40.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text6, delay+50.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+50.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text7, delay+60.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+60.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text8, delay+70.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+70.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+text9, delay+80.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+80.01, null, null);

            EntFireByHandle(ent, "AddOutput", "message "+end_msg[45][m_lang], delay+90.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+90.01, null, null);
            EntFireByHandle(ent, "AddOutput", "message "+end_msg[46][m_lang], delay+100.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+100.01, null, null);
            EntFireByHandle(ent, "AddOutput", "message "+end_msg[47][m_lang], delay+110.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+110.01, null, null);
            EntFireByHandle(ent, "AddOutput", "message "+end_msg[48][m_lang], delay+120.00, null, null);
            EntFireByHandle(ent, "DisPlay", "", delay+120.01, null, null);

            delay += 130;
            EntFire("Script", "RunScriptCode", "Show_Data_Statistics_END(0)", delay);
            EntFire("Script", "RunScriptCode", "Show_Data_Statistics_END(1)", delay+12.00);
            EntFire("Script", "RunScriptCode", "Show_Data_Statistics_END(2)", delay+24.00);
            EntFire("Script", "RunScriptCode", "Show_Data_Statistics_END(3)", delay+36.00);
            EntFire("Script", "RunScriptCode", "Show_Data_Statistics_END(4)", delay+48.00);
            if (Player_Valid_number==1) {
                EntFire("game_round_end", "EndRound_CounterTerroristsWin", "1", delay+12);
            }
            else if (Player_Valid_number==2) {
                EntFire("game_round_end", "EndRound_CounterTerroristsWin", "1", delay+24);
            }
            else if (Player_Valid_number==3) {
                EntFire("game_round_end", "EndRound_CounterTerroristsWin", "1", delay+36);
            }
            else if (Player_Valid_number==4) {
                EntFire("game_round_end", "EndRound_CounterTerroristsWin", "1", delay+48);
            }
            else {
                EntFire("game_round_end", "EndRound_CounterTerroristsWin", "1", delay+60);
            }
        }
    }
}

::Show_Data_Statistics_END <- function (id) {
    local p;
    p = Player[id][0];
    local ent = null;
    local msg;
    if (p != null && p.IsValid()) {
        local sc = p.GetScriptScope();
        msg = GetNameByUserid(sc.userid) + " " + Data_Text[0][m_lang] + " " + Player_Kill_Zombie_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[1][m_lang] + " " + Player_Assister_Zombie_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[2][m_lang] + " " + Player_Revive_friendly_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[3][m_lang] + " " + Player_friendlyFire_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[4][m_lang] + " " + Player_Down_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[5][m_lang] + " " + Player_Death_Number[id] + "\n " + 
        GetNameByUserid(sc.userid) + " " + Data_Text[6][m_lang] + " " + Points[id];

        ent = Entities.CreateByClassname("game_text");
        ent.__KeyValueFromInt("spawnflags",1);
        ent.__KeyValueFromInt("fadein",1);
        ent.__KeyValueFromInt("fadeout",1);
        ent.__KeyValueFromInt("holdtime",10);
        ent.__KeyValueFromInt("effect",0);
        ent.__KeyValueFromString("color","255 255 255");
        ent.__KeyValueFromInt("x",-1);
        ent.__KeyValueFromInt("y",-1);
        ent.__KeyValueFromInt("channel",1);
        ent.__KeyValueFromString("message", ""+msg);
        EntFireByHandle(ent, "DisPlay", "", 0.00, null, null);
        EntFireByHandle(ent, "Kill", "", 0.01, null, null);
    }
}

::crow_sound <- function () {
    local snd = null;
    local file = null;
    local ori = Vector(78,432,406);
    local delay = RandomInt(3,9);
    snd = Entities.FindByName(null, "map_world_sound");
    if (snd != null) {
        local r = RandomInt(33,37)
        file = map_snd[r];
        snd.__KeyValueFromString("message", file);
        snd.SetOrigin(ori);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
    }
    local slot = null;
    for (local i=0;i<isWave.len();i++) {
        if (isWave[i] == true) {
            slot = i;
            break;
        }
    }
    if (slot < 11) {
        EntFire("Script", "RunScriptCode", "crow_sound()", delay);
    }
}

::meteorite_pos <- [
    Vector(1075,1934,1015),
    Vector(1529,1734,1015),
    Vector(944,1809,1015),
    Vector(314,1931,1015),
    Vector(137,1868,1015),
    Vector(147,1713,1015),
    Vector(524,1698,1015),
    Vector(784,1887,1015),
    //Vector(-568,1093,1015)
];

::meteorite_first <- function () {
    local view,ang,delay;
    view = Entities.FindByName(null, "viewcontrol_multiplayer");
    view.SetOrigin(Vector(-680,-406,57));
    view.SetAngles(-30,60,0);
    delay = 0.50;
    EntFireByHandle(view, "Enable", "", 0.02, null, null);
    EntFire("meteorite_template", "ForceSpawn");
    EntFire("Script", "RunScriptCode", "meteorite_launch(4)", 0.01);
    EntFire("Script", "RunScriptCode", "meteorite_spawn()", 10.00);
    ang = view.GetAngles();
    while (ang.y > -60) {
        ang.y -= 0.5;
        EntFireByHandle(view, "SetLocalAngles", "-30 "+ang.y+" 0", delay, null, null);
        delay += 0.02
        if (ang.y == -60) {
            EntFireByHandle(view, "Disable", "", delay+1.00, null, null);
            break;
        }
    }
}

::meteorite_spawn <- function () {
    local n = RandomInt(0,meteorite_pos.len()-1);
    local delay = RandomInt(5,15);
    EntFire("meteorite_template", "ForceSpawn");
    EntFire("Script", "RunScriptCode", "meteorite_launch("+n+")", 0.01);
    if (Wave_Num > 30 && !end) {
        EntFire("Script", "RunScriptCode", "meteorite_spawn()", delay);
    }
}

::meteorite_launch <- function (n) {
        local ent,ent2,ent3,ent4,name,name2,name3,name4;
        ent = Entities.FindByName(null, "meteorite1-meteorite.rotation");
        ent2 = Entities.FindByName(null, "meteorite1-meteorite.trail.pfx");
        ent3 = Entities.FindByName(null, "meteorite1-meteorite.trail.pfx2");
        ent4 = Entities.FindByName(null, "meteorite1-meteorite.light");
        name = ent.GetName()+"_"+n;
        name2 = ent2.GetName()+"_"+n;
        name3 = ent3.GetName()+"_"+n;
        name4 = ent4.GetName()+"_"+n;
        ent.__KeyValueFromString("targetname", name);
        ent2.__KeyValueFromString("targetname", name2);
        ent2.__KeyValueFromString("cpoint1", name);
        ent3.__KeyValueFromString("targetname", name3);
        ent3.__KeyValueFromString("cpoint1", name);
        ent4.__KeyValueFromString("targetname", name4);
        EntFireByHandle(ent2, "SetParent", name, 0.00, null, null);
        EntFireByHandle(ent3, "SetParent", name, 0.00, null, null);
        local pos = meteorite_pos[n];
        ent.SetOrigin(pos);
        EntFire(name2, "Start", "", 0.01);
        EntFire(name3, "Start", "", 0.01);
        EntFire("Script", "RunScriptCode", "meteorite_move("+n+")", 0.01);
}

::meteorite_move <- function (n) {
        local ent,ent2,shak;
        ent = Entities.FindByName(null, "meteorite1-meteorite.rotation_"+n);
        ent2 = Entities.FindByName(null, "meteorite1-meteorite.light_"+n);
        local pos = ent.GetOrigin();
        if (pos.z > 10) {
            ent.SetOrigin(Vector(pos.x,pos.y-13,pos.z-4));
            ent2.SetOrigin(Vector(pos.x,pos.y-13,pos.z-4))
            EntFire("Script", "RunScriptCode", "meteorite_move("+n+")", 0.01);
        }
        else {
            DispatchParticleEffect("explosion_coop_mission_c4", pos, Vector(0,0,0));
            shak = Entities.CreateByClassname("env_shake");
            shak.__KeyValueFromInt("spawnflags", 13)
            shak.__KeyValueFromInt("amplitude", 16);
            shak.__KeyValueFromInt("duration", 4);
            shak.__KeyValueFromInt("frequency", 80);
            shak.__KeyValueFromInt("radius", -1);
            shak.SetOrigin(pos);
            EntFireByHandle(shak, "StartShake", "", 0.00, null, null);
            EntFireByHandle(shak, "StopShake", "", 4.00, null, null);
            EntFireByHandle(shak, "Kill", "", 4.01, null, null);
            local r = RandomInt(38,40);
            self.EmitSound(map_snd[r]);
            EntFire("meteorite1-meteorite.rotation_"+n, "Kill");
            EntFire("meteorite1-meteorite.trail.pfx_"+n, "Kill");
            EntFire("meteorite1-meteorite.trail.pfx2_"+n, "Kill");
            EntFire("meteorite1-meteorite.light_"+n, "Kill");
        }
}

game_restart <- function () 
{
    EntFire("laser_target", "AddOutput", "Origin -553 397 6");
    EntFire("laser_smokestack", "ClearParent");
    EntFire("laser_sprite", "ClearParent");
    EntFire("laser_spark", "ClearParent"); 
    EntFire("Player_Voice_*", "Kill");
    EntFire("zombie_snd_id*", "Kill");
    EntFire("player_view_tg_*", "kill");
    EntFire("panzer*", "KillHierarchy");
    EntFire("MsRf*", "kill");

    local ent,user;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) ) 
    {
        if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
        {
            user = ent;
            ::VS.SetSpeed(user, 0, 1.0);
            EntFireByHandle(user, "SetHUDVisibility", "1", 0.00, null, null);
        }
        else if ( ent.GetClassname().find("viewcontrol", 0) != null )
        {
            EntFireByHandle(ent, "ClearParent", "", 0.00, null, null);
            EntFireByHandle(ent, "Disable", "", 0.00, null, null);
            EntFireByHandle(ent, "Kill", "", 0.00, null, null);
        }
    }
};

::CamArray <- [null,null,null,null,null,null,null,null,null,null];
::SpawnViewCam <- function ()
{
    local ent;
    for ( local i = 0; i < (::Player.len() + ::BOT.len()-5); i++ )
    {
        if ( i < 5 )
        {
            if ( ::Player[i][0] != null && ::Player[i][0].IsValid() )
            {
                if ( ::CamArray[i] == null )
                {
                    ent = Entities.CreateByClassname("point_viewcontrol");
                    ent.__KeyValueFromString("targetname", "cam_"+i);
                    ::CamArray[i] = ent;
                }
            }
        }
        else
        {
            if ( ::BOT[i][0] != null && ::BOT[i][0].IsValid() )
            {
                if ( ::CamArray[i] == null )
                {
                    ent = Entities.CreateByClassname("point_viewcontrol");
                    ent.__KeyValueFromString("targetname", "cam_"+i);
                    ::CamArray[i] = ent;
                }
            }
        }
    }
};

::GameMsg <- [
    ["僵尸歼灭了所有人类","Zombies eliminated all humans"],
    ["守点已被僵尸攻占","The fortifications have been captured by zombies"],
    ["人类救援直升机现已抵达","Rescue helicopter arrived"],
    ["人类成功撤离了！","Humans escaped successfully!"],
    ["本局结束，双方互换阵营","Teams are swapped and the game continues."],
    ["本局结束，获胜者是：","Round end, the winner is "],
    ["人类阵营","Humans"],
    ["僵尸阵营","Zombies"],
    ["////双方互换阵营////","////SWAP TEAMS////"],
];
::MissionFail <- function (team)
{
    local ent,user,sc,steamid;
    local winteam;

    ::VS.SendToServer("mp_respawn_on_death_t 0");
    ::VS.SendToServer("mp_respawn_on_death_ct 0");

    if ( team == 3 )
    {
        winteam  = ::GameMsg[7][::m_lang];
        EntFire("game_round_end", "EndRound_TerroristsWin", "10");
        //EntFire("Script_Score", "RunScriptCode", "RoundEndSetScore(1)");
    }
    else if ( team == 2 )
    {
        winteam  = ::GameMsg[6][::m_lang];
        EntFire("game_round_end", "EndRound_CounterTerroristsWin", "10");
        //EntFire("Script_Score", "RunScriptCode", "RoundEndSetScore(0)");
    }
    local text = [::GameMsg[5][::m_lang]+winteam,::GameMsg[8][::m_lang]];
    ScriptPrintMessageChatAll("\x01 \x09 "+text[0]);ScriptPrintMessageCenterAll(text[0]);
    ScriptPrintMessageChatAll("\x01 \x05 "+text[1] + " \x01 \x09 "+text[1] + " \x01 \x07 "+text[1])
    self.EmitSound(::Event_Snd[1]);

    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        if ( ent.GetClassname() == "player" && ent.GetClassname() != "cs_bot" )
        {
            user = ent;
            sc  = user.GetScriptScope();
            steamid = Get32IDByUserid(sc.userid);

            if ( steamid.tolower() != "bot" )
            {
                if ( user.GetTeam() == 3 )
                    EntFireByHandle(user, "RunScriptCode", "self.SetTeam(2)", 1.00, null, null);
                else if ( user.GetTeam() == 2 )
                    EntFireByHandle(user, "RunScriptCode", "self.SetTeam(3)", 1.00, null, null);
            }
        }
    }
};