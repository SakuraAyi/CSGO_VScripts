//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::BOT <- [
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null], // BOT,MODEL,act:0=walk,1=run,2=sprint,KEY...,AttackMode(melee or long),iszombie?,DropSkill,is attacking,ismove?,12=fire
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null],
    [null,null,0,"key","key","key","key",false,false,false,false,false, false, 10,false, false, null]
];

::maxd <- 46341;
::Hit <- Vector(0,0,0);
class TraceInfo 
{
	constructor(h,d)
	{
		Hit = h;
		Dist = d;
	}

	Hit = null;
	Dist = null;
}

function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0) { return TraceInfo(orig+(dir*maxd),0.0);}
	return TraceInfo(orig+(dir*(maxd*frac)),maxd*frac);
}


::zombie_hp_leve <- [300,600,800,1000,2000,3000,4000];
::zombie_heavy_aromor_hp <- 7500;
::zombie_walk <- [0.33,0.31,0.32,0.33,0.34,0.40,0.41];
::zombie_run <- [0.60,0.65,0.60,0.64,0.61];
::zombie_sprint <- [0.80,0.82,0.83,0.85,0.82,0.83,0.83];
::zombie_super_hp <- 275;
::zombie_super_speed <- 3;
::zombie_bomb_hp <- 100;
::zombie_bomb_sprint <- 0.81
::dog_hp <- 300;
::dog_run <- [1.1,1.2];
::panzer_hp <- 15000;
::panzer_speed <- [0.4,0.8,1.2];
::raz_hp <- 17000;
::raz_speed <- 1.2;
::birkin2_hp <- 10000;
::birkin2_speed <- 1.1;
::siren_hp <- 1000;
::siren_walk <- 0.50

::zombie_model <- [
    "models/player/11/nazi/zombies/nazizombie_1.mdl", // 0
    "models/player/11/nazi/zombies/nazizombie_2.mdl", // 1
    "models/player/11/nazi/zombies/nazizombie_3.mdl", // 2
    "models/player/11/nazi/zombies/nazizombie_4.mdl", // 3
    "models/player/11/nazi/zombies/nazizombie_5.mdl", // 4
    "models/player/11/nazi/zombies/nazizombie_6.mdl", // 5
    "models/player/11/nazi/zombies/nazizombie_7.mdl", // 6
    "models/player/11/nazi/zombies/nazizombie_8.mdl", // 7
    "models/player/11/nazi/zombies/nazizombie_9.mdl", // 8
    "models/player/11/nazi/zombies/nazizombie_10.mdl", // 9
    "models/player/11/nazi/zombies/nazizombie_11.mdl", // 10
    "models/player/11/nazi/zombies/nazizombie_12.mdl", // 11
    "models/player/11/nazi/zombies/nazizombie_13.mdl", // 12
    "models/player/11/nazi/zombies/nazizombie_14.mdl", // 13
    "models/player/11/nazi/zombies/nazizombie_15.mdl", // 14
    "models/player/11/nazi/zombies/nazizombie_16.mdl", // 15
    "models/player/11/nazi/zombies/nazizombie_17.mdl", // 16
    "models/player/11/nazi/zombies/nazizombie_18.mdl", // 17
    "models/player/11/nazi/zombies/nazizombie_19.mdl", // 18

    "models/player/11/nazi/zombies/nazizombie_13_player.mdl", // 19
    "models/player/11/nazi/zombies/nazizombie_14_player.mdl", // 20
    "models/player/11/nazi/zombies/nazizombie_15_player.mdl", // 21
    "models/player/11/nazi/zombies/nazizombie_16_player.mdl", // 22
    "models/player/11/nazi/zombies/nazizombie_17_player.mdl", // 23
    "models/player/11/nazi/zombies/nazizombie_18_player.mdl", // 24
    "models/player/11/nazi/zombies/nazizombie_19_player.mdl", // 25

    "models/player/11/nazi/zombies/panzer.mdl", // 26
    "models/player/blank.mdl", // 27
    "models/player/blank2.mdl", // 28
    //"models/player/11/nazi/zombies/hellhound.mdl", // 29
    "models/player/11/nazi/zombies/hellhound2.mdl", // 29
    "models/weapons/11/nazi/zombies/v_nzombie.mdl",// 30
    "models/player/custom_player/11/fear3/soldier/replica.mdl",//31
    "models/player/zombie_ghost.mdl"//32
];

::zombie_snd <- [
    "11/nazi/zombies/ambient/ambient_",//0
    "11/nazi/zombies/sprint/sprint_",//1
    "11/nazi/zombies/sprint2/zmb_vocals_sprint_",//2
    "11/nazi/zombies/death/death_",//3
    "11/nazi/hellhound/move_",//4
    "11/nazi/hellhound/attack_",//5
    "11/nazi/hellhound/death_",//6
    "11/nazi/hellhound/exp_hellhound_",//7
    "11/nazi/hellhound/exp_hellhound_spirit_",//8
    "none",//9
    "11/nazi/hellhound/on_fire.wav",//10
    "11/nazi/zombies/phy_metal_hard_00.mp3",//11
    "11/nazi/zombies/phy_metal_hard_01.mp3",//12
    "11/nazi/zombies/phy_metal_hard_02.mp3",//13
    "11/nazi/zombies/phy_metal_hard_03.mp3",//14
    "11/nazi/zombies/phy_metal_hard_04.mp3",//15
    "11/nazi/zombies/phy_metal_hard_05.mp3",//16
    "11/nazi/zombies/phy_metal_hard_06.mp3",//17
    "11/nazi/zombies/Ejection01.mp3", //18
    "11/nazi/zombies/Ejection02.mp3", //19
    "11/nazi/zombies/Ejection03.mp3", //20
    "11/nazi/siren/exp1.mp3", //21
    "11/nazi/siren/exp2.mp3", //22
    "11/nazi/zombies/zombi_swing_1.wav", // 23
    "11/nazi/zombies/zombi_swing_2.wav", // 24
    "11/nazi/zombies/zombi_swing_3.wav", // 25
    "11/nazi/zombies/zombi_attack_1.wav", // 26
    "11/nazi/zombies/zombi_attack_2.wav", // 27
    "11/nazi/zombies/zombi_attack_3.wav", // 28
];

::panzer_snd_list <- [
    "11/nazi/panzer/ambient_00.mp3",
    "11/nazi/panzer/ambient_01.mp3",
    "11/nazi/panzer/ambient_02.mp3",
    "11/nazi/panzer/ambient_03.mp3",
    "11/nazi/panzer/ambient_04.mp3",
    "11/nazi/panzer/swing_00.mp3",//5
    "11/nazi/panzer/swing_01.mp3",
    "11/nazi/panzer/swing_02.mp3",
    "11/nazi/panzer/swing_03.mp3",
    "11/nazi/panzer/swing_04.mp3",
    "11/nazi/panzer/death_00.mp3",//10
    "11/nazi/panzer/anim_decepticon_lg_run_01.mp3",//11
    "11/nazi/panzer/anim_decepticon_lg_run_02.mp3",
    "11/nazi/panzer/anim_decepticon_lg_run_03.mp3",
    "11/nazi/panzer/anim_decepticon_lg_run_04.mp3",//14
    "11/nazi/panzer/wpn_grenade_fire_mechz.mp3",//15
    "11/nazi/panzer/exp_electrical_01.mp3",
    "11/nazi/panzer/exp_electrical_02.mp3",
    "11/nazi/panzer/exp_electrical_03.mp3",
    "11/nazi/panzer/exp_electrical_04.mp3", //19
    "11/nazi/panzer/land_00.mp3", //20
    "11/nazi/panzer/land_01.mp3", //21
    "11/nazi/panzer/land_02.mp3", //22
    "11/nazi/panzer/explode.mp3", //23
    "11/nazi/panzer/stop.mp3", //24
    "weapons/molotov/fire_ignite_1.wav",//25
    "weapons/molotov/fire_ignite_2.wav",//26
    "weapons/molotov/fire_ignite_4.wav",//27
    "weapons/molotov/fire_ignite_5.wav",//28
    "11/nazi/panzer/exp_firey_00.mp3",//29
    "11/nazi/panzer/exp_firey_01.mp3",//30
    "11/nazi/panzer/exp_firey_02.mp3",//31
];

::raz_snd_list <- [
    "11/nazi/raz/bowie_swing_0.mp3",//0
    "11/nazi/raz/bowie_swing_1.mp3",//1
    "11/nazi/raz/bowie_swing_2.mp3",//2
    "11/nazi/raz/vox_plr_1_exert_charge_00.mp3",//3
    "11/nazi/raz/vox_plr_1_exert_charge_01.mp3",//4
    "11/nazi/raz/vox_plr_1_exert_charge_02.mp3",//5
    "11/nazi/raz/vox_plr_1_exert_charge_03.mp3",//6
    "11/nazi/raz/vox_plr_1_exert_charge_04.mp3",//7
    "11/nazi/raz/vox_stal_mang_mangler_taunt_0.mp3",//8
    "11/nazi/raz/vox_stal_mang_mangler_taunt_1.mp3",//9
    "11/nazi/raz/vox_stal_mang_mangler_taunt_2.mp3",//10
    "11/nazi/raz/vox_stal_mang_mangler_taunt_3.mp3",//11
    "11/nazi/raz/vox_stal_mang_mangler_taunt_4.mp3",//12
    "11/nazi/raz/vox_stal_mang_mangler_taunt_5.mp3",//13
    "11/nazi/raz/vox_stal_mang_mangler_taunt_6.mp3",//14
    "11/nazi/raz/vox_stal_mang_mangler_taunt_7.mp3",//15
    "11/nazi/raz/vox_stal_mang_mangler_taunt_8.mp3",//16
    "11/nazi/raz/vox_stal_mang_mangler_taunt_9.mp3",//17
    "11/nazi/raz/vox_stal_mang_mangler_taunt_10.mp3",//18
    "11/nazi/raz/vox_stal_mang_mangler_taunt_11.mp3",//19
    "11/nazi/raz/vox_stal_mang_mangler_taunt_12.mp3",//20
    "11/nazi/raz/vox_stal_mang_mangler_taunt_13.mp3",//21
    "11/nazi/raz/vox_plr_1_exert_laugh_05.mp3",//22
    "11/nazi/raz/melee_start.mp3",//23
    "11/nazi/raz/vox_plr_1_exert_melee_00.mp3",//24
    "11/nazi/raz/vox_plr_1_exert_melee_01.mp3",//25
    "11/nazi/raz/vox_plr_1_exert_melee_02.mp3",//26
    "11/nazi/raz/vox_plr_1_exert_melee_03.mp3",//27
    "11/nazi/raz/vox_plr_1_exert_melee_04.mp3",//28
    "11/nazi/raz/raz_gun_charge.mp3",//29
    "11/nazi/raz/fire_00.mp3",//30
    "11/nazi/raz/fire_01.mp3",//31
    "11/nazi/raz/fire_02.mp3",//32
    "11/nazi/raz/fire_03.mp3",//33
    "11/nazi/raz/step_00.mp3",//34
    "11/nazi/raz/step_01.mp3",//35
    "11/nazi/raz/step_02.mp3",//36
    "11/nazi/raz/step_03.mp3",//37
    "11/nazi/raz/step_04.mp3",//38
    "11/nazi/raz/step_05.mp3"//39

];

::ATC_SND <- [
    "11/fear3/wavestart.mp3",
    "11/fear3/count/",
    "11/fear3/count/over.mp3",
    "11/fear3/count/ready.mp3",
    "11/fear3/amb/laugh.mp3",
    "11/fear3/idle",
    "11/fear3/alert",
    "11/fear3/reload",
    "11/fear3/imhit",
    "11/fear3/grenade",
    "11/fear3/grenadeout",
    "11/fear3/mandown",
    "11/fear3/radio/English_"
];


::Positions <- [
    Vector(680,1123,12), // 0
    Vector(203,1098,14), //1
    Vector(162,1294,21), //2
    Vector(-258,1308,20), //3
    Vector(-700,1322,9), //4
    Vector(-898,1093,10), //5
    Vector(-389,878,10), //6
    Vector(-1191,703,4), //7
    Vector(-1146,106,1), //8
    Vector(-1270,59,-3), //9
    Vector(-855,-138,9), //10
    Vector(-1258,-112,24), //11
    Vector(-1222,-370,1), //12

    Vector(44,87,4), // 13
    Vector(44,87,4), // 14
    Vector(-234,-432,1), // 15
    Vector(-173,-509,-1), // 16
    Vector(-85,-530,9), // 17
    Vector(345,-1154,22), // 18
    Vector(462,-1135,16), // 19
    Vector(660,-1022,16), // 20
    Vector(643,-1114,16), // 21
    Vector(580,-1149,16), // 22

    Vector(-592,-568,12), // 23
    Vector(-624,-1060,14), // 24
    Vector(-1208,-595,6), // 25
    Vector(-900,-825,10), // 26
    Vector(1115,-900,171), // 27
    Vector(1601,-1119,182), // 28
    Vector(1599,-561,182), // 29
    Vector(1605,-158,182), // 30
    Vector(1592,271,182), // 31
    Vector(1612,764,182), // 32
    Vector(1540,1333,182), // 33
    Vector(1099,761,150), // 34

    Vector(773,-229,8), // 35 1楼破洞
    Vector(773,-229,8), // 36 1楼破洞
    Vector(773,-229,8), // 37 1楼破洞

//////////////////////////////
    Vector(-553,397,6), // 38 birkin2_pos
    Vector(-61,1256,15), // 39 panzer_boss_pos
    Vector(0,0,0), // 40
/////////////////////////////
    Vector(233,479,9), //41 dog_d1
    Vector(192,617,8), //42
    Vector(16,316,8), //43 
    Vector(-6,473,8), // 44
    Vector(-253,529,8), // 45
    Vector(-397,408,9), // 46
    Vector(-700,523,3), // 47

    Vector(558,529,8), // 48 dog_d2
    Vector(455,392,8), // 49
    Vector(651,293,9), // 50
    Vector(659,131,8), // 51
    Vector(477,76,11), // 52
    Vector(626,-70,8), // 53
    Vector(477,-139,8), // 54
    Vector(579,-327,8), // 55

    Vector(-170,536,170), // 56 dog_d3
    Vector(-39,593,170), // 57
    Vector(12,406,170), // 58
    Vector(325,431,170), // 59
    Vector(84,260,170), // 60
    Vector(220,453,170), //61
    Vector(318,328,170), //62
    Vector(651,635,170), //63
    Vector(588,358,170), //65
    Vector(698,218,170), //66
    Vector(430,249,170), //67
    Vector(732,28,170), //68
    Vector(607,3,170), //69
    Vector(461,-35,170), //70
    Vector(743,-205,170), //71
    Vector(524,-105,170), //72
////////////////////////
    Vector(-591,412,6), //73 zombie_bomb
    Vector(-508,345,7), //74
    Vector(-653,347,12), //75
    Vector(-680,497,4), //76
    Vector(-391,416,9), //77
    Vector(-379,527,5), //78

    Vector(537,325,9), //79
    Vector(528,227,11), //80
    Vector(749,292,14), //81
    Vector(662,213,10), //82
    Vector(660,54,8), //83
    Vector(451,120,8), //84
    Vector(516,12,8), // 85
    Vector(637,-65,8) // 86

    Vector(748,-213,152), //87
    Vector(658,-240,154), //88
    Vector(479,-198,153), //89
    Vector(753,245,152), //90
    Vector(454,27,152), ///91

];

::Kill_W_WPS <- function () {
    local p = null;
    local entity = null;
    EntFire("script", "RunScriptCode", "Kill_W_WPS()", 0.50);
    for (local i=0;i<BOT.len();i++) {
        if (BOT[i][0] != null && BOT[i][0].IsValid()) {
            p = BOT[i][0];
        }
        for (entity = Entities.First();entity != null;entity = Entities.Next(entity)) {
//        print(""+entity);
            if(entity.GetModelName().find("w_", 0) != null && entity.GetClassname() == "weaponworldmodel" ) {        
                if (entity.GetMoveParent() == p && p.GetModelName() != zombie_model[31] ) {
                entity.Destroy();
                break;
                }
            }
        }
        continue;
    }
}

::SetZMHand <- function () {
    local model = zombie_model[30],mtype = "predicted_viewmodel";
    local p,ent;
    //printl("execute....");
    for (local i=0;i<BOT.len();i++) {
        if (BOT[i][0] != null) {
            p = BOT[i][0];
            if (p.IsValid()) {
                while ((ent = Entities.FindByClassname(ent, mtype)) != null) {
                    //printl("while..");
                    if (ent.IsValid()) {
                        //printl("Confirm..");
                        if ( ent.GetMoveParent() == p && p.GetModelName() != zombie_model[27] && p.GetModelName() != zombie_model[28] && p.GetModelName() != zombie_model[31] ) {
                            if (ent.GetModelName().find("knife",0) != null ) 
                            {
                                ent.SetModel(model);
                                //printl("complete");
                            }
                            else
                            EntFire("clientcommand", "command", "slot3", 0.03, p);
                        }
                    }
                }
            }
        }
    }
    EntFire("script", "runscriptcode", "SetZMHand()", 0.03, p);
}


::SpawnZombie <- function (ai,type,lv,misn) {
        if (isWave[misn] && !BOT[ai][8]) {
    local p,p_b,z,sc;
    local bodyGroup = [0,1,2,5,8,11];
    local randBody = RandomInt(0,1);
    local skin = RandomInt(0,7);
    local rd = RandomInt(0,37);

    if (BOT[ai][0] != null && BOT[ai][0].IsValid()) {
        if (BOT[ai][0].GetHealth() > 0) {
        p = BOT[ai][0];
        sc = p.GetScriptScope();
        //BOT[ai][8] = true;
        DoEntFire("!self", "RunScriptCode", "BOT["+ai+"][8]=true", 0.00, self, self);
        //EntFire("@equip_zombie", "TriggerForActivatedPlayer", "weapon_glock", 0.00, p);
        //EntFire("@equip_zombie", "Use", "", 0.01, p);
        //EntFire("clientcommand", "command", "slot3", 0.02, p);

        switch (type) {
            case 0: {
                local r = RandomInt(0,6)
                p.SetModel(zombie_model[r]);
                ::VS.SetSpeed(p, 2, zombie_walk[r]);
                EntFire("script", "RunScriptCode", "zombie_vo("+ai+" 0)", 0.02);
                break;
            }
            case 1: {
                local r = RandomInt(7,11);
                p.SetModel(zombie_model[r]);
                ::VS.SetSpeed(p, 2, zombie_run[r-7]);
                local sr = RandomInt(0,1);
                EntFire("script", "RunScriptCode", "zombie_vo("+ai+" "+sr+")", 0.02);
                break;
            }
            case 2: {
                local r,subtraction;
                r = RandomInt(12,18);
                subtraction = 12;
                p.SetModel(zombie_model[r]);
                ::VS.SetSpeed(p, 2, zombie_sprint[r-subtraction]);
                local sr = RandomInt(1,2);
                EntFire("script", "RunScriptCode", "zombie_vo("+ai+" "+sr+")", 0.02);
                break;
            }
            case 3: {
                //local r = RandomInt(25,26);
                rd = RandomInt(41,72);
                local pos = Positions[rd];
                p.SetModel(zombie_model[29]);
                local r_2 = RandomInt(0,1);
                EntFireByHandle(p, "SetBodyGroup", ""+r_2, 0.01, null, null);
                local ent = Entities.FindByName(null, "beam_start");
                local ent_b = Entities.FindByName(null, "laser_target_light");
                local ent_c = Entities.FindByName(null, "laser_target");
                //local ent_d = Entities.FindByName(null, "laser_sprite");
                //local ent_e = Entities.FindByName(null, "laser_smokestack");
                //local ent_f = Entities.FindByName(null, "laser_spark");
                ent.SetOrigin(Vector(pos.x,pos.y,834));
                ent_b.SetOrigin(Vector(pos.x,pos.y,pos.z+57));
                ent_c.SetOrigin(Vector(pos.x,pos.y,pos.z-2));
                //ent_d.SetOrigin(Vector(pos.x,pos.y,pos.z+14));
                //ent_e.SetOrigin(Vector(pos.x,pos.y,pos.z-2));
                //ent_f.SetOrigin(Vector(pos.x,pos.y,pos.z-3));
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
                snd.SetOrigin(pos);
                EntFireByHandle(snd, "AddOutput", "message "+file, 0.00, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                EntFireByHandle(snd, "AddOutput", "message "+file_2, 0.02, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.03, null, null);
                ::VS.SetSpeed(p, 2, dog_run[1]);
                p.SetMaxHealth(dog_hp);
                p.SetHealth(dog_hp);
                //EntFireByHandle(p, "Ignite", "", 0.10, null, null);
                EntFire("script", "RunScriptCode", "dog_body_fire("+ai+")", 0.02);
                EntFire("script", "RunScriptCode", "dog_vo("+ai+")", 0.02);
                EntFire("script", "RunScriptCode", "SpawnZombie_delay("+ai+" "+rd+")", 1.00);
                break;
            }
            default: 
            {
                break;
            }
        }
        GiveWpnFromZM(p);
        if ( type!=3 ) 
        {
            EntFireByHandle(p, "Skin", ""+skin, 0.00, null, null);
            EntFireByHandle(p, "SetBodyGroup", ""+randBody, 0.00, null, null);
            p.SetMaxHealth(zombie_hp_leve[lv]);
            p.SetHealth(zombie_hp_leve[lv]);
            p.SetOrigin(Positions[rd]);
            
            EntFire("tesla_temp", "ForceSpawn");
            EntFire("script", "RunScriptCode", "SpawnEffect("+ai+")");

            if ( ai < 5 )
            {
                if ( sc.glow == 0 )
                {
                    EntFire("zombie_eye_glow_temp", "ForceSpawn");
                    if ( ZmEyeGlowArray[ai][0] != null && ZmEyeGlowArray[ai][1] != null )
                    {
                        ZmEyeGlowArray[ai][0].Destroy();
                        ZmEyeGlowArray[ai][0] = null;
                        ZmEyeGlowArray[ai][1].Destroy();
                        ZmEyeGlowArray[ai][1] = null;
                    }
                }
                EntFire("Script", "RunScriptCode", "zombieEyeG("+ai+")");
            }
        }

        local r = RandomInt(0,360);
        if ( rd < 35 )
            p.SetAngles(0,r,0);
        else
            p.SetAngles(0,90,0);

        if ( ai > 4 )
        {
            if ( sc.nvg == 0 )
            {
                EntFire("zombieintro_temp", "ForceSpawn");
                if ( ZmNvgArray[ai-5] != null )
                {
                    ZmNvgArray[ai-5].Destroy();
                    ZmNvgArray[ai-5] = null;
                }
            }
            EntFire("Script", "RunScriptCode", "ZombiesNvg("+ai+")");
            randBody = RandomInt(2,bodyGroup.len()-1);
            EntFireByHandle(p, "SetBodyGroup", bodyGroup[randBody].tostring(), 0.00, null, null);
        }

        p.__KeyValueFromInt("renderamt",0);

        }
        else {
            for (local i=0;i<BOT.len();i++) {
                p_b = BOT[i][0];
                z = BOT[i][8];
                if (p_b != null && p_b.IsValid()) {
                    if (p_b.GetHealth() > 0 && !z) {
                        SpawnZombie(i,type,lv,misn);
                        return;
                    }
                    else {
                        continue;
                    }
                }
            }
        }
    }
    else {
        EntFire("script", "RunScriptCode", "SpawnZombie("+ai+" "+type+" "+lv+" "+misn+")", 2.00);
    }
}
}

GiveWpnFromZM <- function (_player,equipent = null)
{
    local sc = _player.GetScriptScope();
    local steamid = Get32IDByUserid(sc.userid);
    if ( steamid.tolower() != "bot" )
    {
        equipent = Entities.CreateByClassname("game_player_equip");
        equipent.__KeyValueFromInt("spawnflags", 3);
        equipent.__KeyValueFromInt("weapon_knife", 1);
        equipent.__KeyValueFromInt("weapon_glock", 1);
        EntFireByHandle(equipent, "Use", "", 0.00, _player, null);
        EntFireByHandle(equipent, "Kill", "", 0.00, null, null);
    }
};

::lasershake <- function () {
    local shak,tg,pos;
    tg = Entities.FindByName(null, "laser_target");
    pos = tg.GetOrigin();
    shak = Entities.CreateByClassname("env_shake");
    shak.__KeyValueFromInt("spawnflags", 12)
    shak.__KeyValueFromInt("amplitude", 4);
    shak.__KeyValueFromFloat("duration", 1.5);
    shak.__KeyValueFromInt("frequency", 40);
    shak.__KeyValueFromInt("radius", 128);
    shak.SetOrigin(pos);
    EntFireByHandle(shak, "StartShake", "", 0.00, null, null);
    EntFireByHandle(shak, "StopShake", "", 1.50, null, null);
    EntFireByHandle(shak, "Kill", "", 1.51, null, null);
}

::SpawnZombie_delay <- function (id,ori) {
    local p,pos;
    p = BOT[id][0];
    pos = Positions[ori];
    p.SetOrigin(pos);
}

::sirenmodel <- function (id) {
    local p = BOT[id][0];
    local pos = p.GetOrigin(),ang = p.GetAngles();
    local ent,ent_b,ent_c,ent_d,ent_e;
    ent = CreateProp("prop_dynamic", pos, zombie_model[28], 0);
    ent.__KeyValueFromString("targetname", "siren_"+id);
    ent.__KeyValueFromInt("solid", 0);
    ent.SetAngles(0,ang.y,0);
    ent_b = CreateProp("prop_dynamic", pos, zombie_model[29], 0);
    ent_b.__KeyValueFromString("targetname", "sirenmodel_b_"+id);
    ent_b.__KeyValueFromInt("solid", 0);
    ent_c = CreateProp("prop_dynamic", pos, zombie_model[29], 0);
    ent_c.__KeyValueFromString("targetname", "sirenmodel_c_"+id);
    ent_c.__KeyValueFromInt("solid", 0);
    ent_d = Entities.FindByName(null, "siren_effect_");
    ent_d.__KeyValueFromString("targetname", "siren_effect_"+id);
    ent_d.SetOrigin(Vector(pos.x,pos.y,pos.z+60));
    ent_e = Entities.FindByName(null, "siren_red_");
    ent_e.__KeyValueFromString("targetname", "siren_red_"+id);
    ent_e.SetOrigin(Vector(pos.x,pos.y,pos.z+64));
    local hurt = null;
    /*local filter = "filter_ct";
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromString("targetname", "siren_hurt_"+id);
    hurt.__KeyValueFromInt("DamageRadius", 128);
    hurt.__KeyValueFromInt("DamageType", 0);
    hurt.__KeyValueFromInt("Damage", 10);
    //hurt.__KeyValueFromString("DamageTarget", "Player_ID*");
    hurt.__KeyValueFromString("filtername",filter);
    hurt.__KeyValueFromFloat("DamageDelay", 0.2);
    hurt.SetOrigin(Vector(pos.x,pos.y,pos.z+64));
    hurt.SetOwner(p);*/
    hurt = Entities.FindByName(null, "siren_hurt_");
    hurt.__KeyValueFromString("targetname", "siren_hurt_"+id);
    hurt.SetOrigin(Vector(pos.x,pos.y,pos.z+64));
    hurt.SetOwner(p);
    

    EntFireByHandle(ent, "SetParent", "BOT_ID"+id, 0.00, null, null);
    EntFireByHandle(ent, "SetAnimation", "s_walk_hard", 0.01, null, null);
    EntFireByHandle(ent, "SetDefaultAnimation", "s_idle", 0.00, null, null);
    EntFireByHandle(ent_b, "SetParent", "BOT_ID"+id, 0.00, null, null);
    EntFireByHandle(ent_b, "AddOutput", "modelscale 2.5", 0.10, null, null);
    EntFireByHandle(ent_b, "Disable", "", 0.00, null, null);
    EntFireByHandle(ent_c, "SetParent", "BOT_ID"+id, 0.00, null, null);
    EntFireByHandle(ent_c, "AddOutput", "modelscale 3.5", 0.10, null, null);
    EntFireByHandle(ent_c, "Disable", "", 0.00, null, null);
    EntFireByHandle(ent_d, "SetParent", "BOT_ID"+id, 0.00, null, null);
    EntFireByHandle(ent_d, "HideSprite", "", 0.00, null, null);
    EntFireByHandle(hurt, "SetParent", "BOT_ID"+id, 0.00, null, null);
    //EntFireByHandle(ent_e, "SetParent", "BOT_ID"+id, 0.00, null, null);

    local ui,ui_name = "siren_control_id_"+id;
    ui = Entities.CreateByClassname("game_ui");
    ui.__KeyValueFromString("targetname", ui_name);
    ui.__KeyValueFromString("FieldOfView", "-1");
    ui.__KeyValueFromString("spawnflags", "64");
    ui.SetOwner(p);
    EntFireByHandle(ui, "Activate", "", 0.10, p, null);
    EntIO(ui,"PressedForward","script", "RunScriptCode", "SirenAni("+id+" 0)", "0.00", "-1");
    EntIO(ui,"PressedBack","script", "RunScriptCode", "SirenAni("+id+" 1)", "0.00", "-1");
    EntIO(ui,"PressedMoveLeft","script", "RunScriptCode", "SirenAni("+id+" 2)", "0.00", "-1");
    EntIO(ui,"PressedMoveRight","script", "RunScriptCode", "SirenAni("+id+" 3)", "0.00", "-1");
    EntIO(ui,"UnPressedForward","script", "RunScriptCode", "SirenAni("+id+" 4)", "0.00", "-1");
    EntIO(ui,"UnPressedBack","script", "RunScriptCode", "SirenAni("+id+" 5)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveLeft","script", "RunScriptCode", "SirenAni("+id+" 6)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveRight","script", "RunScriptCode", "SirenAni("+id+" 7)", "0.00", "-1");
    EntFire("script", "RunScriptCode", "siren_tri("+id+")", 1.00);
}

::SirenAni <- function (id,direction) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "siren_"+id);
    local move_mode = BOT[id][2];
    local atking = BOT[id][10];
    local move = BOT[id][11];
    local param = null;
    if (direction==0) {
        BOT[id][3] = "typing";
    }
    else if (direction==1) {
        BOT[id][4] = "typing";
    }
    else if (direction==2) {
        BOT[id][5] = "typing";
    }
    else if (direction==3) {
        BOT[id][6] = "typing";
    }
    else if (direction==4) {
        BOT[id][3] = "key";
    }
    else if (direction==5) {
        BOT[id][4] = "key";
    }
    else if (direction==6) {
        BOT[id][5] = "key";
    }
    else if (direction==7) {
        BOT[id][6] = "key";
    }
    local w = BOT[id][3],s = BOT[id][4],a = BOT[id][5],d = BOT[id][6];
    for  (local i=0;i<8;i++) {
        if (direction==i) {
            param = i;
        }
        if (!atking) {
            if (param < 4) {
                if (!move) {
                    move = BOT[id][11] = true;
                    EntFireByHandle(model, "SetAnimation", "s_walk_hard", 0.00, null, null);
                }
            }
            else if (param > 3) {
                if (w == "key" && s == "key" && a == "key" && d == "key") {
                EntFireByHandle(model, "SetAnimation", "s_idle", 0.00, null, null);
                BOT[id][11] = false;
                }
            }
        }
        else {
            if (param < 4) {
                if (!move) {
                    move = BOT[id][11] = true;
                    EntFireByHandle(model, "SetAnimation", "s_walk_fire", 0.00, null, null);
                }
            }
            else if (param > 3) {
                if (w == "key" && s == "key" && a == "key" && d == "key") {
                EntFireByHandle(model, "SetAnimation", "s_stand_fire", 0.00, null, null);
                BOT[id][11] = false;
                }
            }
        }
    }
}

::siren_tri <- function (id) {
    local p,zm,move,pos,exp,shak,delay;
    local ent,p_2;
    local snd_ent,file,snd_r;
    p = BOT[id][0];
    zm = BOT[id][8];
    move = BOT[id][11];
    if (p.IsValid()) {
        if (p.GetHealth() > 0 && zm) {
            if (p.GetModelName() == zombie_model[24]) {
                pos = p.EyePosition();
                while (ent = Entities.FindByClassnameWithin(ent, "*", Vector(pos.x,pos.y,pos.z-64), 125)) {
                    if (ent.GetClassname() == "player") {
                        p_2 = ent;
                        if (p_2.GetTeam() == 3) {
                            BOT[id][10] = true;
                            if (move) {
                                EntFire("siren_"+id, "SetAnimation", "s_walk_fire");
                            }
                            else {
                                EntFire("siren_"+id, "SetAnimation", "s_stand_fire");
                            }
                            EntFire("sirenmodel_b_"+id, "Enable");
                            EntFire("sirenmodel_c_"+id, "Enable");
                            EntFire("siren_effect_"+id, "ShowSprite");
                            delay = 0.00;
                            for (local i=0;i<60;i++) {
                                EntFire("script", "RunScriptCode", "sirencorrection("+id+")", delay);
                                delay += 0.10;
                            }
                            EntFire("siren_red_"+id, "Enable");
                            EntFire("sirenmodel_b_"+id, "Disable", "", 6.00);
                            EntFire("sirenmodel_c_"+id, "Disable", "", 6.00);
                            EntFire("siren_effect_"+id, "HideSprite", "", 6.00);
                            EntFire("siren_red_"+id, "Disable", "", 6.00);
                            shak = Entities.CreateByClassname("env_shake");
                            shak.__KeyValueFromInt("spawnflags", 12)
                            shak.__KeyValueFromInt("amplitude", 4);
                            shak.__KeyValueFromInt("duration", 6);
                            shak.__KeyValueFromInt("frequency", 40);
                            shak.__KeyValueFromInt("radius", 400);
                            shak.SetOrigin(pos);
                            EntFireByHandle(shak, "StartShake", "", 0.00, null, null);
                            EntFireByHandle(shak, "StopShake", "", 6.00, null, null);
                            EntFireByHandle(shak, "Kill", "", 6.01, null, null);
                
                            EntFire("siren_hurt_"+id, "Enable", "", 0.01, p);
                            EntFire("siren_hurt_"+id, "Disable", "", 6.00);

                            EntFire("script", "RunScriptCode", "siren_attackover("+id+")", 6.00);
                            local snd = null;
                            local file = null;
                            snd = Entities.FindByName(null, "zombie_snd_id"+id);
                            EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
                            EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
                            file = zombie_snd[19];
                            EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                            EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                            EntFireByHandle(snd, "PlaySound", "", 3.01, null, null);
                            EntFire("script", "RunScriptCode", "siren_tri("+id+")", 6.00);
                            return;
                        }
                    }
                }
                EntFire("script", "RunScriptCode", "siren_tri("+id+")", 0.10);
            }
            else {
                return;
            }
        }
    }
}

::siren_attackover <- function (id) {
    BOT[id][10] = false;
}

::sirencorrection <- function (id) {
    local p,zm,pos;
    p = BOT[id][0];
    zm = BOT[id][8];
    if (p.GetHealth() > 0 && zm) {
    pos = p.EyePosition();
    local color = Entities.FindByName(null, "siren_red_"+id);
    EntFireByHandle(color, "SetLocalOrigin", ""+pos.x+" "+pos.y+" "+pos.z, 0.00, null, null);
    }
}

::zombie_vo <- function (id,type) {
    local p = BOT[id][0];
    local zm = BOT[id][8];
    local model = null;
    if (zm && p.GetHealth() > 0) {
        for (local i=0;i<zombie_model.len();i++) {
            if (p.GetModelName() == zombie_model[i]) {
                model = i;
                break;
            }
        }
        if ( model < (25+1) ) {
        local ent = null;
        local snd = null;
        local r = 0;
        local tritime = null;
        ent = Entities.FindByName(null, "zombie_snd_id"+id);
        EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
        if (type==0) {
            r = RandomInt(0,20);
            snd = zombie_snd[0]+r+".mp3";
            tritime = RandomInt(2,7);
        }
        else if (type==1) {
            r = RandomInt(0,13);
            snd = zombie_snd[1]+r+".mp3";
            tritime = RandomInt(3,7);
        }
        else if (type==2) {
            r = RandomInt(0,27);
           snd = zombie_snd[2]+r+".mp3";
           tritime = RandomInt(8,15);
        }
        //ent.__KeyValueFromString("message",snd);
        EntFireByHandle(ent, "AddOutput", "message "+snd, 0.01, null, null);
        EntFireByHandle(ent, "PlaySound", "", 0.02, null, null);
        EntFire("script", "RunScriptCode", "zombie_vo("+id+" "+type+")", tritime);
        }
    }
}

::zombie_bomb_gear_run <- function (id) {
    local p,zm,pos;
    local ent,p_2;
    local snd_ent,file,r;
    p = BOT[id][0];
    zm = BOT[id][8];
    if (p.IsValid()) {
        if (p.GetHealth() > 0 && zm) {
            if (p.GetModelName() == zombie_model[27]) {
                pos = p.GetOrigin();
                snd_ent = Entities.FindByName(null, "map_world_zombie_sound_"+id);
                if (snd_ent != null) {
                r = RandomInt(11,17);
                file = zombie_snd[r];
                snd_ent.__KeyValueFromString("message", file);
                snd_ent.SetOrigin(pos);
                EntFireByHandle(snd_ent, "PlaySound", "", 0.00, null, null);
                EntFireByHandle(snd_ent, "Volume", "2", 0.01, null, null);
                }
                EntFire("script", "RunScriptCode", "zombie_bomb_gear_run("+id+")", 0.44);
            }
        }
    }
}

::dog_vo <- function (id) {
    local p = BOT[id][0];
    local zm = BOT[id][8];
    local model = null;
    if (zm && p.GetHealth() > 0) {
        for (local i=0;i<zombie_model.len();i++) {
            if (p.GetModelName() == zombie_model[i]) {
                model = i;
                break;
            }
        }
        if (model == 29) {
        local ent = null;
        local snd = null;
        local r = 0;
        local tritime = RandomInt(2,7);
        ent = Entities.FindByName(null, "zombie_snd_id"+id);
        EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
        r = RandomInt(0,11);
        snd = zombie_snd[4]+r+".mp3";
        EntFireByHandle(ent, "AddOutput", "message "+snd, 0.00, null, null);
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "5", 0.00, null, null);
        EntFire("script", "RunScriptCode", "dog_vo("+id+")", tritime);
        }
    }
}

::dog_vo_attack <- function (id) {
    local p = BOT[id][0];
    local zm = BOT[id][8];
    local model = null;
    if (zm && p.GetHealth() > 0) {
        for (local i=0;i<zombie_model.len();i++) {
            if (p.GetModelName() == zombie_model[i]) {
                model = i;
                break;
            }
        }
        if (model == 29) {
        local ent = null;
        local snd = null;
        local r = 0;
        ent = Entities.FindByName(null, "zombie_snd_id"+id);
        EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
        r = RandomInt(0,6);
        snd = zombie_snd[5]+r+".mp3";
        EntFireByHandle(ent, "AddOutput", "message "+snd, 0.00, null, null);
        EntFireByHandle(ent, "PlaySound", "", 0.01, null, null);
        }
    }
}

::siren_vo <- function (id) {
    local p = BOT[id][0];
    local zm = BOT[id][8];
    local model = null;
    if (zm && p.GetHealth() > 0) {
        for (local i=0;i<zombie_model.len();i++) {
            if (p.GetModelName() == zombie_model[i]) {
                model = i;
                break;
            }
        }
        if (model == 24 && BOT[id][1] == "siren") {
        local ent = null;
        local snd = null;
        local tritime = RandomFloat(7,8);
        ent = Entities.FindByName(null, "zombie_snd_id"+id);
        snd = zombie_snd[18]
        EntFireByHandle(ent, "AddOutput", "message "+snd, 0.00, null, null);
        EntFireByHandle(ent, "PlaySound", "", 0.01, null, null);
        EntFire("script", "RunScriptCode", "siren_vo("+id+")", tritime);
        }
    }
}

::zombie_snd_play <- function (id,type) {
    //type:0==slash
    local p = null;
    p = BOT[id][0];
    local zm = BOT[id][8];
    local snd = null;
    local file = null;
    local r = null;
    local delay = null;
    snd = Entities.FindByName(null, "zombie_snd_id"+id);
    EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
    EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
    if (snd != null) {
        if (p.GetHealth() > 0 && zm) {
            if (type==0) {
                r = 4;
            }
            file = zombie_snd[r];
            EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
            if (p.GetHealth() > 0) {
            EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
            }
        }
    }
}
 

::dog_body_fire <- function (id) {
    local p,zm;
    p = BOT[id][0];
    zm = BOT[id][8]
    if (p.GetHealth() > 0 && zm) {
        if (p.GetModelName() == zombie_model[29]) {
            EntFireByHandle(p, "IgniteLifetime", "1", 0.10, null, null);
            EntFire("script", "RunScriptCode", "dog_body_fire("+id+")", 2.00);
        }
    }
}

::zm_body_fire <- function (id) {
    local p,zm,fire;
    p = BOT[id][0];
    zm = BOT[id][8];
    fire = BOT[id][12];
    if (p.GetHealth() > 0 && zm && fire) {
        EntFireByHandle(p, "IgniteLifetime", "1", 0.10, null, null);
        EntFire("script", "RunScriptCode", "zm_body_fire("+id+")", 2.00);
    }
}

::zombie_bomb_tri <- function (id) {
    local p,zm,pos,exp;
    local ent,p_2;
    local snd_ent,file,snd_r;
    p = BOT[id][0];
    zm = BOT[id][8];
    if (p.IsValid()) {
        if (p.GetHealth() > 0 && zm) {
            if (p.GetModelName() == zombie_model[27]) {
                pos = p.EyePosition();
                while (ent = Entities.FindByClassnameWithin(ent, "*", Vector(pos.x,pos.y,pos.z-32), 80)) {
                    if (ent.GetClassname() == "player") {
                        p_2 = ent;
                        if (p_2.GetTeam() == 3) {
                            zombie_bomb_exp(id);
                        }
                    }
                }
                EntFire("script", "RunScriptCode", "zombie_bomb_tri("+id+")", 0.10);
            }
        }
    }
}

::zombie_bomb_exp <- function (id) {
    local p,pos,exp;
    local snd_ent,file,snd_r;
    p = BOT[id][0];
    pos = p.EyePosition();
    exp = Entities.CreateByClassname("env_explosion");
    exp.__KeyValueFromInt("iMagnitude",300);
    exp.__KeyValueFromInt("iRadiusOverride", 155);
    exp.SetOrigin(pos);
    exp.SetOwner(p);
    EntFireByHandle(exp, "Explode", "", 0.00, p, p);
    DispatchParticleEffect("explosion_molotov_air", pos, Vector(0,0,0));
    DispatchParticleEffect("explosion_hegrenade_dirt", pos, Vector(0,0,0));
    //DispatchParticleEffect("explosion_child_core06a", pos, Vector(0,0,0));
    snd_ent = Entities.FindByName(null, "map_world_sound");
    if (snd_ent != null) {
    snd_r = RandomInt(23,24);
    file = map_snd[snd_r];
    snd_ent.__KeyValueFromString("message", file);
    snd_ent.SetOrigin(pos);
    EntFireByHandle(snd_ent, "PlaySound", "", 0.00, null, null);
    EntFireByHandle(snd_ent, "Volume", "10", 0.01, null, null);
    EntFire("script", "RunScriptCode", "exp_shake()", 0.00, p);
    }
}

::SpawnBOSS <- function (id,type,misn) {
    local p = null;
    local ent = null;
    p = BOT[id][0];
    if (isWave[misn]) {
    if (p != null && p.IsValid() && p.GetTeam() == 2) {
        BOT[id][8] = true;

        switch (type) {

            case 0: {
                printl("birkin");
                local hurt = null;
                local hurt_name = "birkin_2_hurt_"+id;
                //local punch = null;
                //local punch_name = "birkin_2_punch_"+id;
                local sprite_name = "zombie_slash_"+id;
                local ent_ori = p.EyePosition() + p.GetForwardVector() * 64;
                local control = null;
                local pos = Positions[38];
                EntFire("Player_SpeedMod_limit_2", "ModifySpeed", ""+birkin2_speed, 0.00, p);
                hurt = Entities.CreateByClassname("point_hurt");
                hurt.__KeyValueFromString("targetname", hurt_name);
                hurt.__KeyValueFromInt("DamageRadius", 50);
                hurt.__KeyValueFromInt("DamageType", 4);
                hurt.__KeyValueFromInt("Damage", 25);
                hurt.__KeyValueFromString("DamageTarget", "");
                hurt.__KeyValueFromFloat("DamageDelay", 0.1);
                hurt.SetOwner(p);
                hurt.SetOrigin(Vector(ent_ori.x,ent_ori.y,ent_ori.z-6));
                EntFireByHandle(hurt, "SetParent", "BOT_ID"+id, 0.01, null, null);
                
                /*punch = Entities.CreateByClassname("env_viewpunch");
                punch.__KeyValueFromString("targetname", punch_name);
                punch.__KeyValueFromInt("spawnflags", 2);
                punch.__KeyValueFromString("punchangle", "-60 -35 0");
                punch.__KeyValueFromFloat("radius", 50);
                punch.SetOrigin(Vector(ent_ori.x,ent_ori.y,ent_ori.z-41));
                EntFireByHandle(punch, "SetParent", "BOT_ID"+id, 0.01, null, null);*/

                EntFire("zombie_effects_template", "ForceSpawn", "");
                EntFire("script", "RunScriptCode", "BOSS_Sprite_Dealy("+id+")", 0.01);

                control = Entities.CreateByClassname("game_ui");
                control.__KeyValueFromString("targetname", "bot_control_"+id);
                control.__KeyValueFromInt("spawnflags", 0);
                control.__KeyValueFromFloat("FieldOfView", -1.0);
                control.SetOwner(p);
                EntFireByHandle(control, "Activate", "", 0.01, p, null);

                EntIO(control, "PressedAttack", hurt_name, "Hurt", "<none>", "0.00", "-1");
                //EntIO(control, "PressedAttack", punch_name, "ViewPunch", "<none>", "0.00", "-1");
                EntIO(control, "PressedAttack", sprite_name, "ShowSprite", "<none>", "0.00", "-1");
                EntIO(control, "PressedAttack", "script", "RunScriptCode", "zombie_snd_play("+id+" 0)", "0.00", "-1");
                EntIO(control, "UnPressedAttack", sprite_name, "HideSprite", "<none>", "0.00", "-1");

                EntIO(control, "PressedAttack2", hurt_name, "Hurt", "<none>", "0.00", "-1");
                //EntIO(control, "PressedAttack2", punch_name, "ViewPunch", "<none>", "0.00", "-1");
                EntIO(control, "PressedAttack2", sprite_name, "ShowSprite", "<none>", "0.00", "-1");
                EntIO(control, "PressedAttack2", "script", "RunScriptCode", "zombie_snd_play("+id+" 0)", "0.00", "-1");
                EntIO(control, "UnPressedAttack2", sprite_name, "HideSprite", "<none>", "0.00", "-1");

                p.SetModel(zombie_model[24]);
                p.SetMaxHealth(birkin2_hp);
                p.SetHealth(birkin2_hp);
                p.__KeyValueFromInt("fademindist",625);
                p.__KeyValueFromInt("fademaxdist",768);
                p.__KeyValueFromInt("rendermode",0);
                p.__KeyValueFromInt("renderamt",255);
                p.__KeyValueFromInt("disableflashlight",0);
                p.__KeyValueFromInt("disableshadows",0);
                p.__KeyValueFromInt("disableshadowdepth",0);
                p.__KeyValueFromInt("disablereceiveshadows",0);
                //p.SetOrigin(pos);
                EntFireByHandle(p, "AddOutput", "Origin "+pos.x+" "+pos.y+" "+pos.z,  0.50, p, null);
                local ent_b = Entities.FindByName(null, "beam_start");
                local ent_c = Entities.FindByName(null, "laser_target_light");
                local ent_d = Entities.FindByName(null, "laser_target");
                local ent_e = Entities.FindByName(null, "laser_spark");
                ent_b.SetOrigin(Vector(-553,398,511));
                ent_c.SetOrigin(Vector(-553,398,63));
                ent_d.SetOrigin(Vector(-553,398,6));
                //ent_e.SetOrigin(Vector(-553,398,2));
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
                snd.SetOrigin(pos);
                EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
                EntFireByHandle(snd, "AddOutput", "message "+file_2, 0.03, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.04, null, null);
                EntFire("script", "RunScriptCode", "BOSSLeap()", 3.00);
                break;
            }

            case 1: {
                printl("panzer");
                p.__KeyValueFromInt("rendermode",10);
                p.__KeyValueFromInt("renderamt",0);
                p.__KeyValueFromInt("disableflashlight",1);
                p.__KeyValueFromInt("disableshadows",1);
                p.__KeyValueFromInt("disableshadowdepth",1);
                p.__KeyValueFromInt("disablereceiveshadows",1);
                //p.SetModel(zombie_model[27]);
                p.SetMaxHealth(10000);
                p.SetHealth(10000);
                p.SetOrigin(Positions[39]);
                local model = CreateProp("prop_dynamic", Vector(0,0,0), zombie_model[26], 0);
                model.__KeyValueFromString("targetname", "panzer_"+id);
                EntFireByHandle(model, "RunScriptFile", "nazi/panzer.nut", 0.00, null, null);
                EntFireByHandle(model, "RunScriptCode", "OnPostSpawn()", 0.00, null, null);
                EntFireByHandle(model, "RunScriptCode", "OnUse("+id+")", 0.10, null, null);
                ::VS.SetSpeed(p, 1, 1.1);
                break;
            }
            case 2: {
                printl("raz");
                local model_name = "raz_"+id;
                local pos = Positions[38],p_pos = p.GetOrigin();
                local ang = p.GetAngles();//Vector(0,0,0);
                ent = CreateProp("prop_dynamic", p_pos, zombie_model[26], 0);
                ent.SetAngles(ang.x,ang.y,ang.z);
                ent.__KeyValueFromString("targetname",model_name);
                ent.__KeyValueFromInt("solid", 0);
                EntFireByHandle(ent, "SetAnimation", "idle_1", 0.00, null, null);
                EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
                p.__KeyValueFromInt("rendermode",1);
                p.__KeyValueFromInt("renderamt",0);
                p.__KeyValueFromInt("disableflashlight",1);
                p.__KeyValueFromInt("disableshadows",1);
                p.__KeyValueFromInt("disableshadowdepth",1);
                p.__KeyValueFromInt("disablereceiveshadows",1);
                p.SetModel(zombie_model[23]);
                p.SetMaxHealth(raz_hp);
                p.SetHealth(raz_hp);
                //p.SetOrigin(pos);
                //p.SetAngles(ang.x,ang.y,ang.z);
                EntFire("script", "RunScriptCode", "Create_Raz_BOSS("+id+")", 0.10);
                //EntFire("script", "RunScriptCode", "model_act_2_control("+id+")", 0.11);
                local ent = Entities.FindByName(null, "beam_start");
                local ent_b = Entities.FindByName(null, "laser_target_light");
                local ent_c = Entities.FindByName(null, "laser_target");
                ent.SetOrigin(Vector(pos.x,pos.y,511));
                ent_b.SetOrigin(Vector(pos.x,pos.y,pos.z+57));
                ent_c.SetOrigin(Vector(pos.x,pos.y,pos.z-2));
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
                snd.SetOrigin(pos);
                EntFireByHandle(snd, "AddOutput", "message "+file, 0.00, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                EntFireByHandle(snd, "AddOutput", "message "+file_2, 0.02, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.03, null, null);
                EntFire("script", "RunScriptCode", "SpawnZombie_delay("+id+" "+38+")", 1.00);
                break;
            }
            default :{
                break;
            }
        }
    }
    }
}

::zmbomb_delay <- 0;
::zmbomb_leap <- function (id) {
	local p = null;
    local zm,model,eye,top,tl;
    local delay = null;
    model = zombie_model[27];
    p = BOT[id][0];
    zm = BOT[id][8];
    eye = p.EyePosition();
    top = Vector(eye.x,eye.y,eye.z+15);
    tl = TraceLine(eye,top,p);
    delay = 5;//RandomInt(3,5);
    if (zmbomb_delay == delay && tl == 1.0) {
        zmbomb_delay = 0;
        local zpos = p.GetOrigin();
	    local ang = p.GetAngles();
	    local yaw = (ang.y)*PI/180.0;	
	    local zpos2 = Vector(zpos.x,zpos.y,zpos.z+0.5);
        if (zm && p.GetHealth() > 0) {
            if (p.GetModelName() == model) {
                p.SetOrigin(zpos2);
			    p.SetVelocity(Vector(cos(yaw)*475,sin(yaw)*475,200));
            }
        }
        if (!zm || p.GetModelName() != model) {
            return;
        }
    }
    if (zmbomb_delay != delay) {
        zmbomb_delay += 1;
    }
    EntFire("script", "RunScriptCode", "zmbomb_leap("+id+")", 1.00);
}

function BOSSLeap() {

	local zomb = null;
    local id = null;
    local Time = null;
    while ((zomb = Entities.FindByClassname(zomb, "*")) != null) {
	    if(zomb.GetClassname() == "player") {
            if (zomb.GetTeam() == 2) {
                local zpos = zomb.GetOrigin();
	            local ang = zomb.GetAngles();
	            local yaw = (ang.y)*PI/180.0;	
	            local zpos2 = Vector(zpos.x,zpos.y,zpos.z+1);
                for (local i=0;i<BOT.len();i++) {
                    if (BOT[i][0] == zomb) {
                        id = i;
                        break;
                    }
                }
                local move = BOT[id][11];
                if (zomb.GetHealth() > 0) {
                    if (zomb.GetModelName() == zombie_model[24]) {
                        Time = RandomInt(4,6);
                        zomb.SetOrigin(zpos2);
			            zomb.SetVelocity(Vector(cos(yaw)*600,sin(yaw)*600,200));
                        EntFire("script", "RunScriptCode", "BOSSLeap()", Time);
                    }
                    else if (zomb.GetModelName() == zombie_model[23]) {
                        Time = RandomInt(8,12);
                        if (move) {
                        zomb.SetOrigin(zpos2);
			            zomb.SetVelocity(Vector(cos(yaw)*400,sin(yaw)*400,300));
                        }
                        EntFire("script", "RunScriptCode", "BOSSLeap()", Time);
                    }
                }
            }
        }
    }
}

::BOSS_Sprite_Dealy <- function (id) {
    local p = BOT[id][0];
    local ent_ori = p.EyePosition() + p.GetForwardVector() * 40;
    local sprite = null;
    sprite = Entities.FindByName(null, "zombie_slash_");
    sprite.__KeyValueFromString("targetname", "zombie_slash_"+id);
    sprite.SetOrigin(Vector(ent_ori.x,ent_ori.y,ent_ori.z-8));
    EntFireByHandle(sprite, "SetParent", "BOT_ID"+id, 0.01, null, null);
} 

::Panzer_come_particle_delay <- function () {
    local pos = Positions[39];
    DispatchParticleEffect("explosion_hegrenade_brief", pos, Vector(0,0,0));
}

::Create_Panzer_BOSS <- function (id) {
    local p = null;
    p = BOT[id][0];
    local ori = p.GetOrigin(),ang = p.GetAngles();
    local ent = null;
    local ui = null;
    local name = null;
    name = p.GetName();
    local model_name = "panzer_"+id,holder = "panzerb_"+id;

    /*p.__KeyValueFromInt("rendermode",1);
    p.__KeyValueFromInt("renderamt",0);
    //p.__KeyValueFromInt("solid",0);
    p.__KeyValueFromInt("disableflashlight",0);
    p.__KeyValueFromInt("disableshadows",0);
    p.__KeyValueFromInt("disableshadowdepth",0);
    p.__KeyValueFromInt("disablereceiveshadows",0);*/
    //ent = CreateProp("prop_dynamic", ori,zombie_model[22],0);
    ent = Entities.FindByName(null, model_name);
    //ent.__KeyValueFromString("targetname",model_name);
    //ent.__KeyValueFromInt("solid",0);
    //p.SetOrigin(Positions[32]);
    //p.SetAngles(0,-90,0);
    ent.SetAngles(0,ang.y,0);
    EntFireByHandle(ent, "SetParent", name, 0.00, null, null);
    //EntFireByHandle(ent, "SetParentAttachmentMaintainOffset", "root", 0.01, null, null);
    //BOT[id][1] = ent;

    local ui_name = "model_control_id"+id;
    ui = Entities.CreateByClassname("game_ui");
    ui.__KeyValueFromString("targetname", ""+ui_name);
    ui.__KeyValueFromString("FieldOfView", "-1");
    ui.__KeyValueFromString("spawnflags", "64");
    ui.SetOwner(p);
    EntFireByHandle(ui, "Activate", "", 0.10, p, null);
    EntIO(ui,"PressedForward","script", "RunScriptCode", "PanzerAni("+id+" 0)", "0.00", "-1");
    EntIO(ui,"PressedBack","script", "RunScriptCode", "PanzerAni("+id+" 1)", "0.00", "-1");
    EntIO(ui,"PressedMoveLeft","script", "RunScriptCode", "PanzerAni("+id+" 2)", "0.00", "-1");
    EntIO(ui,"PressedMoveRight","script", "RunScriptCode", "PanzerAni("+id+" 3)", "0.00", "-1");
    EntIO(ui,"UnPressedForward","script", "RunScriptCode", "PanzerAni("+id+" 4)", "0.00", "-1");
    EntIO(ui,"UnPressedBack","script", "RunScriptCode", "PanzerAni("+id+" 5)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveLeft","script", "RunScriptCode", "PanzerAni("+id+" 6)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveRight","script", "RunScriptCode", "PanzerAni("+id+" 7)", "0.00", "-1");

    local hurt = null;
    local hurt_name = "melee_hurt_"+id;
    local filter = "filter_ct";
    local hurt_ori = p.EyePosition();
    //local punch = null;
    //local punch_name = "panzer_punch_"+id;
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromString("targetname",hurt_name);
    hurt.__KeyValueFromInt("Damage",400);
    hurt.__KeyValueFromInt("DamageRadius",128);
    hurt.__KeyValueFromInt("DamageType",4);
    hurt.__KeyValueFromInt("DamageDelay",1);
    hurt.__KeyValueFromString("filtername",filter);
    hurt.SetOwner(p);
    hurt.SetOrigin(hurt_ori);
    EntFireByHandle(hurt, "SetParent", model_name, 0.01, null, null);
    //EntFireByHandle(hurt, "SetParentAttachment", "GunBarrel_1", 0.02, null, null);
    //punch = Entities.CreateByClassname("env_viewpunch");
    //punch.__KeyValueFromString("targetname", punch_name);
    //punch.__KeyValueFromInt("spawnflags", 2);
    //punch.__KeyValueFromString("punchangle", "-70 -45 0");
    //punch.__KeyValueFromFloat("radius", 42);
    //punch.SetOrigin(Vector(hurt_ori.x,hurt_ori.y,hurt_ori.z-42));
    //EntFireByHandle(punch, "SetParent", "BOT_ID"+id, 0.01, null, null);
    
    local hurt_2 = null;
    local hurt_2_name = "fire_hurt_"+id;
    local hurt_2_ori = p.EyePosition() + p.GetForwardVector() * 90;
    hurt_2 = Entities.CreateByClassname("point_hurt");
    hurt_2.__KeyValueFromString("targetname",hurt_2_name);
    hurt_2.__KeyValueFromInt("Damage",200);
    hurt_2.__KeyValueFromInt("DamageRadius",75);
    hurt_2.__KeyValueFromInt("DamageType",8);
    hurt_2.__KeyValueFromFloat("DamageDelay",0.2);
    hurt_2.__KeyValueFromString("filtername",filter);
    hurt_2.SetOwner(p);
    hurt_2.SetOrigin(hurt_2_ori);
    EntFireByHandle(hurt_2, "SetParent", model_name, 0.01, null, null);
//    EntFireByHandle(hurt_2, "SetParentAttachment", "FlameBarrel_1", 0.02, null, null);

    local hurt_3 = null;
    local hurt_3_name = "gun_hurt_"+id;
    hurt_3 = Entities.CreateByClassname("point_hurt");
    hurt_3.__KeyValueFromString("targetname",hurt_3_name);
    hurt_3.__KeyValueFromInt("Damage",500);
    hurt_3.__KeyValueFromInt("DamageRadius",50);
    hurt_3.__KeyValueFromInt("DamageType",2);
    hurt_3.__KeyValueFromFloat("DamageDelay",0.54);
    hurt_3.__KeyValueFromString("filtername",filter);
    hurt_3.SetOwner(p);

    local laser = Entities.FindByName(null, "wplaser_"+id);
//    laser.__KeyValueFromString("LaserTarget",target_name);
/*    local texture = "sprites/laserbeam.spr";
    laser = Entities.CreateByClassname("env_laser");
    laser.__KeyValueFromString("targetname",laser_name);
    laser.__KeyValueFromString("LaserTarget",target_name);
    laser.__KeyValueFromString("texture",texture);
    laser.__KeyValueFromInt("renderfx", 0);
    laser.__KeyValueFromInt("renderamt", 255);
    laser.__KeyValueFromString("rendercolor", "255 255 0");
    laser.__KeyValueFromInt("framestart", 0);
    laser.__KeyValueFromInt("NoiseAmplitude", 0);
    laser.__KeyValueFromInt("TextureScroll", 50);
    laser.__KeyValueFromInt("width", 2);
    laser.__KeyValueFromInt("spawnflags", 49);
    laser.__KeyValueFromInt("dissolvetype", 0);
    laser.__KeyValueFromInt("damage", 250);*/
    laser.SetOwner(p);
    local model = Entities.FindByName(null, model_name);
    local gunori = model.GetAttachmentOrigin(4);
    laser.SetOrigin(gunori);



//    EntFireByHandle(laser, "SetParent", model_name, 0.01, null, null);
//    EntFireByHandle(laser, "SetParentAttachment", "GunBarrel_2", 0.02, null, null);
    EntFire("script", "RunScriptCode", "panzer_fire_blastout("+id+")", 1.00);
    EntFireByHandle(model_name, "SetAnimation", "walk", 0.00, null, null);
    EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[0], 0.00, p);
    EntFire("script", "RunScriptCode", "CheckPanzerHP()");
    panzer_snd(id,0,0);
    //EntFire("script", "RunScriptCode", "BOSSLeap()", 3.00);

}
::Panzer_move_mode <- "walk";
::CheckPanzerHP <- function () {
    local p = null;
    local model = null;
    local id = null;
    while ((model = Entities.FindByClassname(model, "*")) != null) {
        if (model.GetClassname() == "prop_dynamic") {
            if (model.GetModelName() == zombie_model[22]) {
                if (model.GetMoveParent() != null) {
                    p = model.GetMoveParent();
                    for (local i=0;i<BOT.len();i++) {
                        if (BOT[i][0] == p) {
                            id = i;
                        }
                    }
                    if (p.GetHealth() < 13000 && p.GetHealth() > 8000) {
                        if (Panzer_move_mode != "run") {
                            Panzer_move_mode = "run";
                            EntFireByHandle(model, "SetAnimation", "Run", 0.00, null, null);
                        }
                        PanzerSpeed_Toggle(id,1);
                        break;
                    }
                    else if (p.GetHealth() < 6000 && p.GetHealth() > 0) {
                        if (Panzer_move_mode != "sprint") {
                            Panzer_move_mode = "sprint";
                            EntFireByHandle(model, "SetAnimation", "Sprint", 0.00, null, null);
                        }
                        PanzerSpeed_Toggle(id,2);
                        break;
                    }
                }
            }
        }
    }
    EntFire("script", "RunScriptCode", "CheckPanzerHP()", 1.00);
}

::PanzerSpeed_Toggle <- function (id,mode) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);
    local move = BOT[id][11];
    local atking = BOT[id][10];
    if (move && !atking && mode==0) {
        BOT[id][2] = 0;
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[0], 0.00, p);
    }
    else if (move && !atking && mode==1) {
        BOT[id][2] = 1;
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[1], 0.00, p);
    }
    else if (move && !atking && mode==2) {
        BOT[id][2] = 2;
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[2], 0.00, p);
    }
}

::PanzerAni <- function (id,direction) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);
    local move_mode = BOT[id][2];
    local atking = BOT[id][10];
    local move = BOT[id][11];
    local param = null;
    if (direction==0) {
        BOT[id][3] = "typing";
    }
    else if (direction==1) {
        BOT[id][4] = "typing";
    }
    else if (direction==2) {
        BOT[id][5] = "typing";
    }
    else if (direction==3) {
        BOT[id][6] = "typing";
    }
    else if (direction==4) {
        BOT[id][3] = "key";
    }
    else if (direction==5) {
        BOT[id][4] = "key";
    }
    else if (direction==6) {
        BOT[id][5] = "key";
    }
    else if (direction==7) {
        BOT[id][6] = "key";
    }
    local w = BOT[id][3],s = BOT[id][4],a = BOT[id][5],d = BOT[id][6];
    for  (local i=0;i<8;i++) {
        if (direction==i) {
            param = i;
        }
        if (!atking) {
            if (param < 4) {
                if (!move) {
                    move = BOT[id][11] = true;
                    if (move_mode==0) {
                        EntFireByHandle(model, "SetAnimation", "Walk", 0.00, null, null);
                        if (move) {
                            panzer_snd(id,1,0);
                        }
                    }
                    else if (move_mode==1) {
                        EntFireByHandle(model, "SetAnimation", "Run", 0.00, null, null);
                        if (move) {
                            panzer_snd(id,1,1);
                        }
                    }
                    else if (move_mode==2) {
                        EntFireByHandle(model, "SetAnimation", "Sprint", 0.00, null, null);
                        if (move) {
                            panzer_snd(id,1,2);
                        }
                    }
                }
            }
            else if (param > 3) {
                if (w == "key" && s == "key" && a == "key" && d == "key") {
                EntFireByHandle(model, "SetAnimation", "idle", 0.00, null, null);
                EntFireByHandle(model, "SetDefaultAnimation", "idle", 0.00, null, null);
                BOT[id][11] = false;
                }
            }
        }
    }
}



::panzer_snd <- function (id,type,act) {
    //type:0==amb,1==step,2==swing,3==gunfire,4==land,5==exp,6==stop,7==fire
    local p = null;
    p = BOT[id][0];
    local zm = BOT[id][8];
    local model = BOT[id][1];
    local atking = BOT[id][10];
    local move = BOT[id][11];
    local snd = null;
    local file = null;
    local r = null;
    local delay = null;
    snd = Entities.FindByName(null, "zombie_snd_id"+id);
//    EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
//    EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
    if (snd != null) {
        if (p.GetHealth() > 0 && zm) {
        if (type==0) {
            delay = RandomInt(5,7);
            r = RandomInt(0,4);
            EntFire("script", "RunScriptCode", "panzer_snd("+id+" "+type+" 0)", delay);
            EntFireByHandle(snd, "Volume", "5", 0.03, null, null);
        }
        else if (type==1) {
            r = RandomInt(11,14);
            if (move) {
                if (act==0) {
                    EntFire("script", "RunScriptCode", "panzer_snd("+id+" "+type+" "+act+")", 1.00);
                }
                else if (act==1) {
                    EntFire("script", "RunScriptCode", "panzer_snd("+id+" "+type+" "+act+")", 0.60);
                }
                else if (act==2) {
                    EntFire("script", "RunScriptCode", "panzer_snd("+id+" "+type+" "+act+")", 0.40);
                }
                EntFireByHandle(snd, "Volume", "2", 0.03, null, null);
            }
        }
        else if (type==2) {
            r = RandomInt(5,9);
        }

        else if (type==3) {
            r = 15;
        }

        else if (type==4) {
            r = RandomInt(20,22);
        }
        else if (type==5) {
            r = 23;
        }
        else if (type==6) {
            r = 24;
        }
        else if (type==7) {
            r = RandomInt(25,28);
            if (atking) {
                 EntFire("script", "RunScriptCode", "panzer_snd("+id+" "+type+" "+act+")", 0.25);
            }
        }
        file = panzer_snd_list[r];
        EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
        if (p.GetHealth() > 0) {
            EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
        }
    }
    }
}

::panzergunori <- null;
::panzerfireori <- null;

::model_act_control <- function (id,act) 
{
    local atvr = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);

    if ( act == 0 ) 
    {
        //p.SetAngles(0,yaw,0); // Pending...
        EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
        melee_fire_LowSpeed(id);
        BOT[id][10] = true;
        BOT[id][11] = false;
        EntFireByHandle(model, "SetAnimation", "Attack0", 0.00, null, null);
        panzer_snd(id,2,0);
        hurt = Entities.FindByName(null, "melee_hurt_"+id);
        //EntFire(punch_name, "ViewPunch", "", 0.60);
        EntFireByHandle(hurt, "Hurt", "", 0.50, p, p);
        //EntFire("script", "RunScriptCode", "print(Player[0][0].GetHealth().tostring())", 0.60);
        //EntFireByHandle(hurt, "TurnOff", "", 1.23, p, p);
        EntFire("script", "RunScriptCode", "attack_end_switch("+id+")",1.30);
    }
    
    else if ( act == 1 ) 
    {

        EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
        BOT[id][10] = true;
        BOT[id][11] = false;
        DispatchParticleEffect("extinsguish_fire_blastout_01", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
        EntFireByHandle(model, "SetAnimation", "PreFireChainGun", 0.00, null, null);
        EntFire("shooter_"+id, "shoot");
        EntFire("script", "RunScriptCode", "shootgibexp("+id+")", 0.31);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50, null, null);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50+0.54, null, null);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50+(0.54*2), null, null);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50+(0.54*3), null, null);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50+(0.54*4), null, null);
        EntFireByHandle(model, "SetAnimation", "PostFireChainGun", 0.50+(0.54*5), null, null);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 15)",0.50, human);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 30)",0.50+0.54, human);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 45)",0.50+(0.54*2), human);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 30)",0.50+(0.54*3), human);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 15)",0.50+(0.54*4), human);
        EntFire("script", "RunScriptCode", "gunoriset("+id+" 30)",0.50+(0.54*5), human);
        //local target = Entities.FindByName(null, "wptarget_");
        //Hit = TraceDir(p.EyePosition(),p.GetForwardVector(),46341.0,p).Hit; 
        //target.SetOrigin(Hit);
        //Cast a ray from the player's eyes in the direction they are looking
        EntFire("script", "RunScriptCode", "attack_end_switch("+id+")",0.55+(0.54*6)+0.11);
        EntFire("script", "RunScriptCode", "Attacked_Reprevio_Delay("+id+")",0.55+(0.54*6)+0.20);
    }
}

::shootgibexp <- function (id) {
    local old = null;
    local ent = null;
    local num = 0;
    local particleball = "panzer_shell_num_"
    while ((ent = Entities.FindByClassname(ent, "gib")) != null) {
        if (ent.IsValid()) {
            old = Entities.FindByName(null, particleball+num);
            if (old == null) {
            ent.__KeyValueFromString("targetname", particleball+num);
            EntFire("script", "RunScriptCode", "gibexp_delay("+id+")",1.00);
            }
            num+=1;
        }
    }
}

::gibexp_delay <- function (id) {
    local p = BOT[id][0];
    local ent = null;
    local exp = null;
    local pos = null;
    local particleball = "panzer_shell_num_"
    local shak = null;
    for (local i=0;i<19;i++) {
        ent = Entities.FindByName(null, particleball+i);
        if (ent != null) {
        pos = ent.GetOrigin();
        EntFireByHandle(ent, "Kill", "", 0.00, null, null);
        DispatchParticleEffect("explosion_hegrenade_interior", pos, Vector(0,0,0));
        exp = Entities.CreateByClassname("env_explosion");
	    exp.__KeyValueFromInt("iMagnitude", 200);
        exp.__KeyValueFromInt("iRadiusOverride", 128);
	    exp.SetOrigin(pos);
        exp.SetOwner(p);
        EntFireByHandle(exp, "Explode", "", 0.0, p,p);
        //exp.SetOwner(p);
        local snd = null;
        local file = null;
        snd = Entities.FindByName(null, "map_world_sound");
        local r = RandomInt(16,19)
        file = panzer_snd_list[r];
        snd.SetOrigin(pos);
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd, "Volume", "3", 0.02, null, null);
        shak = Entities.CreateByClassname("env_shake");
        shak.__KeyValueFromInt("spawnflags", 12)
        shak.__KeyValueFromInt("amplitude", 6);
        shak.__KeyValueFromInt("duration", 1);
        shak.__KeyValueFromInt("frequency", 40);
        shak.__KeyValueFromInt("radius", 400);
        shak.SetOrigin(pos);
        EntFireByHandle(shak, "StartShake", "", 0.00, null, null);
        EntFireByHandle(shak, "StopShake", "", 1.00, null, null);
        EntFireByHandle(shak, "Kill", "", 1.01, null, null);
        }
    }
}

::melee_fire_LowSpeed <- function (id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);
    local ori = p.EyePosition();
    local ent = null;
    local human,hmid;
    DispatchParticleEffect("extinsguish_fire_blastout_01", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    DispatchParticleEffect("explosion_smoke_disperse", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    while (ent = Entities.FindByClassnameWithin(ent, "*", Vector(ori.x,ori.y,ori.z-32), 80)) {
        if (ent.GetClassname() == "player") {
            human = ent;
            if (human.GetTeam() == 3) {
                for (local i=0;i<Player.len();i++) {
                    if (Player[i][0] == human) {
                        hmid = i;
                        break;
                    }
                }
                local stamin = Player[hmid][31];
                EntFire("Player_SpeedMod", "ModifySpeed", "0.3", 0.00, human);
                if (!stamin) {
                    EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 1.40, human);
                }
                else {
                    EntFire("Player_SpeedMod", "ModifySpeed", "1.2", 1.40, human);
                }
            }
        }
    }
}

::panzer_fire_blastout <- function (id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);
    local ori = p.EyePosition();
    local ent = null;
    local human,human_id;
    local hurt = null;
    local tg = null;
    local tl = null;
    local snd = null;
    local file = null;
    local rtime = RandomInt(6,10);
    if (model.GetMoveParent() == p) {
    snd = Entities.FindByName(null, "map_world_zombie_sound_"+id);
    if (snd != null) {
        local r = RandomInt(29,31);
        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file = panzer_snd_list[r];
        //snd.__KeyValueFromString("message", file);
        snd.SetOrigin(ori);
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    }
    DispatchParticleEffect("extinsguish_fire_blastout_01", Vector(ori.x,ori.y,ori.z-32), Vector(90,0,0));
    while (ent = Entities.FindByClassnameWithin(ent, "*", Vector(ori.x,ori.y,ori.z-32), 128)) {
        if (ent.GetClassname() == "player") {
            human = ent;
            if (human.GetTeam() == 3) {
                for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == human) {
                            human_id = i;
                            break;
                        }
                    }
                tg = "Player_ID"+human_id;
                hurt = Entities.CreateByClassname("point_hurt");
                hurt.__KeyValueFromFloat("DamageDelay", 1);
                hurt.__KeyValueFromInt("DamageRadius", 32);
                hurt.__KeyValueFromInt("DamageType", 2);
                hurt.__KeyValueFromInt("Damage", 30);
                hurt.__KeyValueFromString("DamageTarget", tg);
                EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
                player_punchview(human_id);
            }
            else {
                continue;
            }
        }
    }
    EntFire("script", "RunScriptCode", "panzer_fire_blastout("+id+")",rtime);
    }
}

::attack_end_switch <- function (id) {
    BOT[id][10] = false;
    //BOT[id][11] = true;
}

::Attacked_Reprevio_Delay <- function(id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id);
    local move_mode = BOT[id][2];
    local move = BOT[id][11];
    local param = null;
    local w = BOT[id][3],s = BOT[id][4],a = BOT[id][5],d = BOT[id][6];
    if (w == "typing" || s == "typing" || a == "typing" || d == "typing") {
        //if (!move) {
        BOT[id][11] = true;
            if (move_mode==0) {
                EntFireByHandle(model, "SetAnimation", "Walk", 0.00, null, null);
                panzer_snd(id,1,0);
            }
            else if (move_mode==1) {
                EntFireByHandle(model, "SetAnimation", "Run", 0.00, null, null);
                panzer_snd(id,1,1);
            }
            else if (move_mode==2) {
                EntFireByHandle(model, "SetAnimation", "Sprint", 0.00, null, null);
                panzer_snd(id,1,2);
            }
        //}
    }
    else if (w == "key" && s == "key" && a == "key" && d == "key") {
    EntFireByHandle(model, "SetAnimation", "idle", 0.00, null, null);
    EntFireByHandle(model, "SetDefaultAnimation", "idle", 0.00, null, null);
    BOT[id][11] = false;
    }
    if (move_mode==0) {
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[move_mode], 0.00, p);
    }
    else if (move_mode==1) {
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[move_mode], 0.00, p);
    }
    else if (move_mode==2) {
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+panzer_speed[move_mode], 0.00, p);
    }
}

::Fire_Particle <- function (id,n) {
    local p = BOT[id][0];
    local human = activator;
    local human_id = null;
    local model = Entities.FindByName(null, "panzer_"+id);
    local m_targetVector = null;
    local m_sentryOrigin = null;
    local m_dir = null;
    local UCSX = null;
    local pitch = null;
    local yaw = null;
    m_targetVector = human.EyePosition();
    m_sentryOrigin = p.GetOrigin();//model.GetOrigin();
    m_dir = m_targetVector - m_sentryOrigin;

    UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
    pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
    yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;

    if(m_dir.x < 0) {
         yaw = 180 - yaw;
    }
    //local fireaam = model.GetAttachmentOrigin(9) + model.GetForwardVector() * n;
    local fireaam = model.GetOrigin() + (model.GetForwardVector() * 50) + (model.GetLeftVector() * 10);
    DispatchParticleEffect("molotov_explosion_child_fireball3", Vector(fireaam.x,fireaam.y,fireaam.z+52), Vector(0,yaw,0));
    DispatchParticleEffect("molotov_explosion_child_fireball2", Vector(fireaam.x,fireaam.y,fireaam.z+52), Vector(0,yaw,0));
    local hurt_2_ori = p.EyePosition() + p.GetForwardVector() * 90;
    local firehuman = null;
    while ((firehuman = Entities.FindByClassnameWithin(firehuman, "player", hurt_2_ori, 70)) != null) {
        if (firehuman != null) {
            if (firehuman.GetTeam() == 3) {
                for (local i=0;i<Player.len();i++) {
                    if (Player[i][0] == firehuman) {
                        human_id = i;
                        break;
                    }
                }
                local fire = Player[human_id][24];
                if (!fire) {
                    Player[human_id][24] = true;
                    local stamin = Player[human_id][31];
                    EntFireByHandle(firehuman, "IgniteLifetime", "5.0", 0.00, null, null);
                    EntFire("Player_SpeedMod", "ModifySpeed", "0.4", 0.00, firehuman);
                    if (!stamin) {
                    EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 5.00, firehuman);
                    }
                    else {
                        EntFire("Player_SpeedMod", "ModifySpeed", "1.2", 5.00, firehuman);
                    }
                    EntFire("script", "RunScriptCode", "fireman_delay("+human_id+")", 5.00);
                }
            }
        }
    }
}

::fireman_delay <- function (id) {
    Player[id][24] = false;
}

::gunoriset <- function (id,tg) {
    local human = activator;
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "panzer_"+id),ang = model.GetAngles();
    local gunori = model.GetOrigin() + (model.GetForwardVector() * 50) + (model.GetLeftVector() * -6);//model.GetAttachmentOrigin(4);
    //if (panzergunori == null) {
    //    panzergunori = model.GetAttachmentOrigin(4);
    //}
    local laser = Entities.FindByName(null, "wplaser_"+id);
    laser.SetOrigin(Vector(gunori.x,gunori.y,gunori.z+62));
    local target = Entities.FindByName(null, "wplaser_tg_"+id);
    local hurt = null;
    local m_targetVector = null;
    local m_sentryOrigin = null;
    local m_dir = null;
    local UCSX = null;
    local pitch = null;
    local yaw = null;
    local snd = null;
    local file = null;
    local ori = p.EyePosition();
    m_targetVector = human.EyePosition();
    m_sentryOrigin = p.GetOrigin();//model.GetOrigin();
    m_dir = m_targetVector - m_sentryOrigin;

    UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
    pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
    yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;

    if(m_dir.x < 0) {
        yaw = 180 - yaw;
    }
    DispatchParticleEffect("extinguish_fire_swirl_smoke", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    Hit = TraceDir(p.EyePosition(),p.GetForwardVector(),46341.0,p).Hit;
    target.SetOrigin(Vector(Hit.x,Hit.y,Hit.z-tg));
    panzer_snd(id,3,0);
    EntFire("shooter_"+id, "shoot");
    EntFire("shooter_"+id, "addoutput", "angles 0 "+ang.y+" 0");
    EntFire("shooter_"+id, "addoutput", "gibangles 0 "+ang.y+" 0");
    EntFire("script", "RunScriptCode", "shootgibexp("+id+")", 0.31);
    EntFireByHandle(laser, "TurnOn", "", 0.00, p, p);
    EntFireByHandle(laser, "TurnOff", "", 0.24, p, p);
    hurt = Entities.FindByName(null, "gun_hurt_"+id);
    hurt.SetOrigin(Vector(gunori.x,gunori.y,gunori.z+62));//(Hit);
    //DispatchParticleEffect("explosion_hegrenade_brief", Hit, Vector(-90,yaw,0));
    //snd = Entities.FindByName(null,"panzer_sonud");
    //snd.SetOrigin(Hit);
    //file = panzer_snd_list[RandomInt(16,19)];
    //EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
    //EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
    EntFireByHandle(hurt, "TurnOn", "", 0.00, null, null);
    EntFireByHandle(hurt, "TurnOff", "", 0.24, null, null);
}

/*::Create_Raz_BOSS <- function (id) {
    local p = null;
    p = BOT[id][0];
    local ori = p.GetOrigin(),ang = p.GetAngles();
    local ent = null;
    local ui = null;
    local name = null;
    name = p.GetName();
    local model_name = "raz_"+id;
    local tg = Entities.CreateByClassname("info_target");
    tg.__KeyValueFromString("targetname", "raz_gun_tg_"+id);

    // = Entities.FindByName(null, model_name);
    //ent.__KeyValueFromInt("solid",0);
    //ent.SetAngles(0,ang.y,0);
    //EntFireByHandle(ent, "SetParent", name, 0.00, null, null);
    //BOT[id][1] = ent;

    EntFire("zombie_effects_template", "ForceSpawn");
    EntFire("script", "RunScriptCode", "Raz_effects_delay("+id+")",0.01);
    EntFire("script", "RunScriptCode", "model_act_2_control("+id+")", 0.02);

    local ui_name = "model_raz_control_id"+id;
    ui = Entities.CreateByClassname("game_ui");
    ui.__KeyValueFromString("targetname", ""+ui_name);
    ui.__KeyValueFromString("FieldOfView", "-1");
    ui.__KeyValueFromString("spawnflags", "64");
    ui.SetOwner(p);
    EntFireByHandle(ui, "Activate", "", 0.10, p, null);
    EntIO(ui,"PressedForward","script", "RunScriptCode", "RazAni("+id+" 0)", "0.00", "-1");
    EntIO(ui,"PressedBack","script", "RunScriptCode", "RazAni("+id+" 1)", "0.00", "-1");
    EntIO(ui,"PressedMoveLeft","script", "RunScriptCode", "RazAni("+id+" 2)", "0.00", "-1");
    EntIO(ui,"PressedMoveRight","script", "RunScriptCode", "RazAni("+id+" 3)", "0.00", "-1");
    EntIO(ui,"UnPressedForward","script", "RunScriptCode", "RazAni("+id+" 4)", "0.00", "-1");
    EntIO(ui,"UnPressedBack","script", "RunScriptCode", "RazAni("+id+" 5)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveLeft","script", "RunScriptCode", "RazAni("+id+" 6)", "0.00", "-1");
    EntIO(ui,"UnPressedMoveRight","script", "RunScriptCode", "RazAni("+id+" 7)", "0.00", "-1");

    //EntFireByHandle(ent, "SetAnimation", "sprint", 0.00, null, null);
    EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+raz_speed, 0.00, p);
    p.SetAngles(0,0,0);
    raz_snd(id,0);
}

::Raz_effects_delay <- function (id) {
    local p = null;
    p = BOT[id][0];
    local ent,ent_b,ent_name,ent_b_name;
    local ori = p.GetOrigin();
    local ang = p.GetAngles();
    local model,holder;
    local model_name = "raz_"+id;
    local model_parent = "razb_"+id;
    model = Entities.FindByName(null, model_name);
    //holder = Entities.FindByName(null, "razb_");
    //holder.__KeyValueFromString("targetname", model_parent);
    //EntFireByHandle(model, "SetParent", model_parent, 0.00 , null, null);
    BOT[id][1] = "raz";
    model.SetOrigin(ori);
    model.SetAngles(ang.x,ang.y,ang.z);
    EntFireByHandle(model, "SetParent", p.GetName(), 0.00, null, null);
    EntFireByHandle(model, "SetAnimation", "sprint", 0.00, null, null);
    local pos = model.GetOrigin() + model.GetForwardVector() * 30;
    ent = Entities.FindByName(null, "zombie_slash_b_");
    ent_name = ent.GetName()+id;
    ent.__KeyValueFromString("targetname", ent_name);
    ent_b = Entities.FindByName(null, "zombie_slash_c_");
    ent_b_name = ent_b.GetName()+id;
    ent_b.__KeyValueFromString("targetname", ent_b_name);
    ent.SetOrigin(Vector(pos.x,pos.y,pos.z+60));
    ent_b.SetOrigin(Vector(pos.x,pos.y,pos.z+60));
    EntFireByHandle(ent, "SetParent", model_name, 0.01, null, null);
    EntFireByHandle(ent_b, "SetParent", model_name, 0.01, null, null);
}

::RazAni <- function (id,direction) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local move_mode = BOT[id][2];
    local atking = BOT[id][10];
    local move = BOT[id][11];
    local param = null;
    if (direction==0) {
        BOT[id][3] = "typing";
    }
    else if (direction==1) {
        BOT[id][4] = "typing";
    }
    else if (direction==2) {
        BOT[id][5] = "typing";
    }
    else if (direction==3) {
        BOT[id][6] = "typing";
    }
    else if (direction==4) {
        BOT[id][3] = "key";
    }
    else if (direction==5) {
        BOT[id][4] = "key";
    }
    else if (direction==6) {
        BOT[id][5] = "key";
    }
    else if (direction==7) {
        BOT[id][6] = "key";
    }
    local w = BOT[id][3],s = BOT[id][4],a = BOT[id][5],d = BOT[id][6];
    param = direction;
        if (!atking) {
            if (param < 4) {
                if (!move) {
                    move = BOT[id][11] = true;
                    EntFireByHandle(model, "SetAnimation", "sprint", 0.00, null, null);
                    EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+raz_speed, 0.00, p);
                    if (move) {
                        raz_snd(id,1);
                    }
                }
            }
            else if (param > 3) {
                if (w == "key" && s == "key" && a == "key" && d == "key") {
                EntFireByHandle(model, "SetAnimation", "idle_1", 0.00, null, null);
                EntFireByHandle(model, "SetDefaultAnimation", "idle_1", 0.00, null, null);
                BOT[id][11] = false;
            }
        }
    }
}

::raz_snd <- function (id,type) {
    //type:0==amb,1==step
    local p = null;
    p = BOT[id][0];
    local zm = BOT[id][8];
    local model = BOT[id][1];
    local atking = BOT[id][10];
    local move = BOT[id][11];
    local snd = null;
    local file = null;
    local r = null;
    local delay = null;
    //snd = Entities.FindByName(null, "map_world_zombie_sound_"+id);
    snd = Entities.FindByName(null, "zombie_snd_id"+id);
    if (snd != null) {
        if (p.GetHealth() > 0 && zm) {
        if (type==0) {
            delay = RandomInt(5,15);
            r = RandomInt(8,22);
            EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
            EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
            EntFire("script", "RunScriptCode", "raz_snd("+id+" "+type+")", delay);
            EntFireByHandle(snd, "Volume", "5", 0.03, null, null);
        }
        else if (type==1) {
            r = RandomInt(34,39);
            if (move) {
                EntFire("script", "RunScriptCode", "raz_snd("+id+" "+type+")", 0.22);
                EntFireByHandle(snd, "Volume", "3", 0.03, null, null);
            }
        }
        file = raz_snd_list[r];
        EntFireByHandle(snd, "AddOutput", "message "+file, 0.01, null, null);
        if (p.GetHealth() > 0) {
            EntFireByHandle(snd, "PlaySound", "", 0.02, null, null);
        }
        }
    }
}

::model_act_2_control <- function (id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local act = BOT[id][2];
    local ori = p.EyePosition(),ori_2 = p.EyePosition() + p.GetForwardVector() * 512;
    local m_targetVector = null;
    local m_sentryOrigin = null;
    local m_dir = null;
    local UCSX = null;
    local pitch = null;
    local yaw = null;
    local ang = null;
    local melee_dist = null;
    local cannon_dist = null;
    local human = null;
    local ent = null
    local num = 0;
    local tri_prob = null
    local tl = null;
    tri_prob = RandomInt(1,100);
    local hurt = null;
    if (p.GetHealth() > 0 && BOT[id][1] != null){
    while ((ent = Entities.FindByClassname(ent, "*")) != null) {
        if (ent.GetClassname() == "player") {
            num += 1;
        }
    }
//    printl("Server_Player_Number>"+num);
    for (local i=0;i<32;i++) {
    melee_dist = Entities.FindByClassnameWithin(melee_dist, "player", ori, 64);
    cannon_dist = Entities.FindByClassnameWithin(cannon_dist, "player", ori_2, 256);
//    laser_dist = Entities.FindByClassnameWithin(laser_dist, "player", ori, 512);
    if (melee_dist != null && melee_dist.GetTeam() == 3 && !BOT[id][10]) {
        human = melee_dist;
        tl = TraceLine(ori,human.EyePosition(),p);
        if (human.GetHealth() > 0 && tl == 1) {
            //local punch_name = "raz_punch_"+id;
            m_targetVector = human.EyePosition();
            m_sentryOrigin = p.GetOrigin();//model.GetOrigin();
            ang = p.GetAngles();
            m_dir = m_targetVector - m_sentryOrigin;

            UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
            pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
            yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;
//            if (ang.y != yaw) {
                if(m_dir.x < 0) {
                   yaw = 180 - yaw;
//                   p.SetAngles(0,ang.y-2,0);
                }
//                else {
//                    p.SetAngles(0,ang.y+2,0);
//                }
//            }
           // p.SetAngles(0,yaw,0);
            EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
            BOT[id][10] = true;
            BOT[id][11] = false;
            EntFireByHandle(model, "SetAnimation", "Claw_melee3", 0.00, null, null);
            local snd = null;
            local file = null;
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = raz_snd_list[23];
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
            }
            EntFire("script", "RunScriptCode", "Red_Somke_LowSpeed("+id+")",0.30);
            EntFire("script", "RunScriptCode", "Raz_Melee_Hurt("+id+")",0.80);
            EntFire("script", "RunScriptCode", "Raz_Melee_Hurt("+id+")",1.35);
            local eft_name_1 = "zombie_slash_b_"+id;
            local eft_name_2 = "zombie_slash_c_"+id;
            EntFire(eft_name_1, "ShowSprite", "",0.80);
            EntFire(eft_name_1, "HideSprite", "", 1.10);
            EntFire(eft_name_2, "ShowSprite", ""1.35);
            EntFire(eft_name_2, "HideSprite", "", 1.65);

            EntFire("script", "RunScriptCode", "attack_end_switch("+id+")",2.30);
            EntFire("script", "RunScriptCode", "Raz_Attacked_Reprevio_Delay("+id+")",2.31);
            EntFire("script", "RunScriptCode", "model_act_2_control("+id+")",2.32);
            return;
        }
    }
    else if (cannon_dist != null && cannon_dist.GetTeam() == 3 && !BOT[id][10]) {
        human = cannon_dist;
        tl = TraceLine(ori,human.EyePosition(),p);
        if (human.GetHealth() > 0 && tl == 1) {
            if (tri_prob <= 20) {
            local aam_id = model.LookupAttachment("Cannon");
            local aam_ori = model.GetAttachmentOrigin(aam_id);
            local target = Entities.FindByName(null, "raz_gun_tg_"+id);
            m_targetVector = human.EyePosition();
            m_sentryOrigin = p.GetOrigin();//model.GetOrigin();
            ang = p.GetAngles();
            m_dir = m_targetVector - m_sentryOrigin;

            UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
            pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
            yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;
            if(m_dir.x < 0) {
                yaw = 180 - yaw;
            }
            //p.SetAngles(0,yaw,0);
            Hit = TraceDir(p.EyePosition(),p.GetForwardVector(),512,p).Hit;
            target.SetOrigin(Hit);
            EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
            BOT[id][10] = true;
            BOT[id][11] = false;
            local snd = null;
            local file = null;
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = raz_snd_list[29];
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
            }
            local snd_2 = null;
                local file_2 = null;
                snd_2 = Entities.FindByName(null, "zombie_snd_id"+id);
                if (snd_2 != null) {
                    local r = RandomInt(3,7);
                    file_2 = raz_snd_list[r];
                    EntFireByHandle(snd_2, "Addoutput", "message "+file_2, 0.00, null, null);
                    EntFireByHandle(snd_2, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "Volume", "10", 0.02, null, null);
                }
            //DispatchParticleEffect("impact_gas_rocket_flash", aam_ori, Vector(0,0,0));
            EntFire("script", "RunScriptCode", "raz_attack_effects_delay("+id+")",0.15);
            EntFireByHandle(model, "SetAnimation", "RangeAttack1", 0.00, null, null);
            EntFire("script", "RunScriptCode", "Raz_Cannon_Hurt("+id+")",0.87);

            EntFire("script", "RunScriptCode", "attack_end_switch("+id+")",2.30);
            EntFire("script", "RunScriptCode", "Raz_Attacked_Reprevio_Delay("+id+")",2.31);
            EntFire("script", "RunScriptCode", "model_act_2_control("+id+")",2.32);
            return;
            }
        }
    }
}
    EntFire("script", "RunScriptCode", "model_act_2_control("+id+")",0.30);
    }
}

::Red_Human_State <- [false,false,false,false,false];
::Red_Somke_LowSpeed <- function (id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local ori = p.EyePosition();
    local ent = null;
    local human,human_id;
    //DispatchParticleEffect("gas_cannister_impact_child_explosion", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    //DispatchParticleEffect("gas_cannister_impact_child_explosion", Vector(ori.x,ori.y,ori.z-32), Vector(0,90,0));
    DispatchParticleEffect("gas_cannister_impact_child_firesmoke", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    while (ent = Entities.FindByClassnameWithin(ent, "*", Vector(ori.x,ori.y,ori.z-32), 90)) {
        if (ent.GetClassname() == "player") {
            human = ent;
            if (human.GetTeam() == 3) {
                for (local i=0;i<Player.len();i++) {
                    if (Player[i][0] == human) {
                        human_id = i;
                        break;
                    }
                }
                if (!Red_Human_State[human_id]) {
                    EntFire("Player_SpeedMod", "ModifySpeed", "0.2", 0.00, human);
                    Red_Human_State[human_id] = true;
                    EntFire("script", "RunScriptCode", "Red_Somke_LowSpeed_Delay("+human_id+")", 2.00);
                }
            }
            else {
                continue;
            }
        }
    }
}

::Red_Somke_LowSpeed_Delay <- function (id) {
    local p = Player[id][0];
    local stamin = Player[id][31];
    if (Red_Human_State[id]) {
        Red_Human_State[id] = false;
        if (!stamin) {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
        }
        else {
            EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p);
        }
    }
}

::raz_attack_effects_delay <- function (id) {
    local model = Entities.FindByName(null, "raz_"+id);
    local aam_id = model.LookupAttachment("Cannon");
    local aam_ori = model.GetAttachmentOrigin(aam_id);
    DispatchParticleEffect("impact_gas_rocket_flash", aam_ori, Vector(0,0,0));
}

::Raz_Melee_Hurt <- function (id) {
    local ent = null;
    local melee_dist = null;
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local ori = p.EyePosition(),ori_2 = p.EyePosition() + p.GetForwardVector() * 40;
    local human,human_id;
    local hurt = null;
    local tg = null;
    local tl = null;
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "map_world_zombie_sound_"+id);
    if (snd != null) {
        local r = RandomInt(0,2);
        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file = raz_snd_list[r];
        //snd.__KeyValueFromString("message", file);
        snd.SetOrigin(ori);
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    }
    local snd_2 = null;
    local file_2 = null;
    snd_2 = Entities.FindByName(null, "zombie_snd_id"+id);
    if (snd_2 != null) {
        local r = RandomInt(24,28);
        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file_2 = raz_snd_list[r];
        //snd.__KeyValueFromString("message", file);
        EntFireByHandle(snd_2, "Addoutput", "message "+file_2, 0.00, null, null);
        EntFireByHandle(snd_2, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd_2, "Volume", "10", 0.02, null, null);
    }
    //DispatchParticleEffect("gas_cannister_impact_child_explosion", Vector(ori.x,ori.y,ori.z-32), Vector(0,0,0));
    while (melee_dist = Entities.FindByClassnameWithin(melee_dist, "*", ori_2, 64)) {
        if (melee_dist.GetClassname() == "player") {
            if (melee_dist != null && melee_dist.GetTeam() == 3) {
                human = melee_dist;
                tl = TraceLine(ori,human.EyePosition(),p);
                printl("Contact");
                if (tl == 1) {
                   for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == human) {
                            human_id = i;
                            break;
                        }
                    }
                    tg = "Player_ID"+human_id;
                    printl("hit!");
                    hurt = Entities.CreateByClassname("point_hurt");
                    hurt.__KeyValueFromFloat("DamageDelay", 1);
                    hurt.__KeyValueFromInt("DamageRadius", 32);
                    hurt.__KeyValueFromInt("DamageType", 2);
                    hurt.__KeyValueFromInt("Damage", 400);
                    hurt.__KeyValueFromString("DamageTarget", tg);
                    EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                    EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
                    player_punchview(human_id);
                }
            }
        }
    }
}

::Raz_Cannon_Hurt <- function (id) {
    local ent = null;
    local cannon_dist = null;
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local yaw = p.GetAngles();
    local ori = p.EyePosition(),ori_2 = p.EyePosition() + p.GetForwardVector() * 300;
    local human,human_id,human_tg;;
    local hurt = null;
    local aam_id = model.LookupAttachment("Cannon");
    local aam_ori = model.GetAttachmentOrigin(aam_id);
    local aam_ori_2 = model.GetAttachmentOrigin(aam_id) + p.GetForwardVector() * 50;
    local tg = Entities.FindByName(null, "raz_gun_tg_"+id).GetOrigin();
    local tl = null;
    hurt = Entities.CreateByClassname("point_hurt");
    hurt.__KeyValueFromFloat("DamageDelay", 1);
    hurt.__KeyValueFromInt("DamageRadius", 256);
    hurt.__KeyValueFromInt("DamageType", 64);
    hurt.__KeyValueFromInt("Damage", 300);
    while (cannon_dist = Entities.FindByClassnameWithin(cannon_dist, "*", ori_2, 512)) {
        if (cannon_dist.GetClassname() == "player") {
            if (cannon_dist != null && cannon_dist.GetTeam() == 3) {
                human = cannon_dist;
                human_tg = human.EyePosition() + human.GetForwardVector() * 30;
                tl = TraceLine(ori,human.EyePosition(),p);
                printl("Contact");
                local snd = null;
                local file = null;
                snd = Entities.FindByName(null, "map_world_zombie_sound_"+id);
                if (snd != null) {
                    local r = RandomInt(30,33)
                    file = raz_snd_list[r];
                    snd.SetOrigin(ori);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
                }
                local snd_2 = null;
                local file_2 = null;
                snd_2 = Entities.FindByName(null, "map_world_zombie_sound_"+id);

                if (tl == 1) {
                   for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == human) {
                            human_id = i;
                            break;
                        }
                    }
                    printl("Target_Lock");
                    hurt.SetOrigin(human_tg);
                    snd_2.SetOrigin(human_tg);
                    DispatchParticleEffect("gas_cannister_impact_child_explosion_sphere", human_tg, Vector(0,0,0));
                    EntFire("script", "RunScriptCode", "exp_shake()", 0.00, human);
                    player_punchview(human_id);
                }
                else {
                    printl("Lost_Target");
                    hurt.SetOrigin(tg);
                    snd_2.SetOrigin(tg);
                    DispatchParticleEffect("gas_cannister_impact_child_explosion_sphere",tg, Vector(0,0,0));
                    ent = Entities.CreateByClassname("env_shake");
                    ent.__KeyValueFromInt("spawnflags", 12)
                    ent.__KeyValueFromInt("amplitude", 6);
                    ent.__KeyValueFromInt("duration", 1);
                    ent.__KeyValueFromInt("frequency", 40);
                    ent.__KeyValueFromInt("radius", 400);
                    ent.SetOrigin(tg);
                    EntFireByHandle(ent, "StartShake", "", 0.00, null, null);
                    EntFireByHandle(ent, "StopShake", "", 1.00, null, null);
                    EntFireByHandle(ent, "Kill", "", 1.01, null, null);
                }
                if (snd_2 != null) {
                    local r = RandomInt(16,19)
                    file_2 = panzer_snd_list[r];
                    EntFireByHandle(snd_2, "Addoutput", "message "+file_2, 0.00, null, null);
                    EntFireByHandle(snd_2, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "Volume", "10", 0.02, null, null);
                }
                printl("hit!");
                DispatchParticleEffect("explosion_molotov_air_core", aam_ori_2, Vector(0,0,0));
                //hurt.__KeyValueFromString("DamageTarget", tg);
                EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                break;
            }
        }
    }
    EntFireByHandle(hurt, "Kill", "", 0.01, null, null);
    printl("cannon_hurt_kill");
}

::Raz_Attacked_Reprevio_Delay <- function(id) {
    local p = BOT[id][0];
    local model = Entities.FindByName(null, "raz_"+id);
    local move_mode = BOT[id][2];
    local move = BOT[id][11];
    local param = null;
    local w = BOT[id][3],s = BOT[id][4],a = BOT[id][5],d = BOT[id][6];
    if (w == "typing" || s == "typing" || a == "typing" || d == "typing") {
        if (!move) {
        BOT[id][11] = true;
        EntFireByHandle(model, "SetAnimation", "sprint", 0.00, null, null);
        EntFire("Player_SpeedMod_limit", "ModifySpeed", ""+raz_speed, 0.00, p);
        raz_snd(id,1);
        }
    }
    else if (w == "key" && s == "key" && a == "key" && d == "key") {
    EntFireByHandle(model, "SetAnimation", "idle_1", 0.00, null, null);
    EntFireByHandle(model, "SetDefaultAnimation", "idle_1", 0.00, null, null);
    BOT[id][11] = false;
    }
}*/


::zombie_death <- function () 
{
    local p = activator;
    if ( p.GetTeam() == 2 )
    {
        local id = "none";
        local pos = null;
        local model;
        local ent,snd,exp;

        local pass = false;
        for (local i = 0; i < (BOT.len() + zombie_model.len()); i++ ) 
        {
            if ( !pass && i < BOT.len() )
            {
                if ( BOT[i][0] == p ) 
                {
                    id = i;
                    pass = true;
                    i = 0;
                }
            }
            if ( pass && i < zombie_model.len() )
            {
                if ( pass && p.GetModelName() == zombie_model[i] ) 
                {
                    model = i;
                    break;
                }
            }
        }

        ent = Entities.FindByName(null, "zombie_snd_id"+id);
        EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", "0", 0.00, null, null);

        if ( ::BOT[id][8] ) 
        {
            pos = p.GetOrigin();
            DoEntFire("!self", "RunScriptCode", "::BOT["+id+"][8] = false", 0.10, self, self);
            if (Wave_Num != 0) 
            {
                ::Wave_Num -= 1;
                printl("Zombie_Numbers: "+Wave_Num);
            }
            EntFire("Script", "RunScriptCode", "Wave_Check()");

            if( model < 19 ) 
            {
                local r = RandomInt(0,10);
                snd = zombie_snd[3]+r+".mp3";

                local ent2,ent3;
                if ( id < 5 )
                {
                    ent2 = ZmEyeGlowArray[id][0],ent3 = ZmEyeGlowArray[id][1];
                    EntFireByHandle(ent2, "DestroyImmediately", "", 0.00, null, null);
                    EntFireByHandle(ent3, "DestroyImmediately", "", 0.00, null, null);
                }
            }
            else if( model == 29 ) 
            {
                local r = RandomInt(0,6);
                snd = zombie_snd[6]+r+".mp3";
                //DispatchParticleEffect("explosion_hegrenade_brief", Vector(pos.x,pos.y,pos.z-67), Vector(0,0,0));
                DispatchParticleEffect("explosion_molotov_air_splash01a", Vector(pos.x,pos.y,pos.z-67), Vector(0,0,0));
                DispatchParticleEffect("molotov_child_flame02a", Vector(pos.x,pos.y,pos.z-67), Vector(0,0,0));
                exp = Entities.CreateByClassname("env_explosion");
	            exp.__KeyValueFromInt("iMagnitude", 75);
                exp.__KeyValueFromInt("iRadiusOverride", 128);
	            exp.SetOrigin(pos);
                exp.SetOwner(p);
                EntFireByHandle(exp, "Explode", "", 0.0, p,p);
                //EntFireByHandle(exp, "Kill", "", 0.2, null,null);
                local snd_ent = null;
                local file,file_2;
                local snd_r,snd_r_2;
                snd_ent = Entities.FindByName(null, "map_world_sound");
                if (snd_ent != null) 
                {
                    //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
                    //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
                    snd_r = RandomInt(0,1);
                    snd_r_2 = RandomInt(0,4);
                    file = zombie_snd[7]+snd_r+".mp3";
                    file_2 = zombie_snd[8]+snd_r_2+".mp3";
                    snd_ent.__KeyValueFromString("message", file);
                    snd_ent.SetOrigin(pos);
                    EntFireByHandle(snd_ent, "PlaySound", "", 0.00, null, null);
                    EntFireByHandle(snd_ent, "Volume", "2", 0.00, null, null);
                    self.EmitSound(file_2);
                    //EntFireByHandle(snd_ent, "AddOutput", "Message "+file_2, 0.02, null, null)
                    //EntFireByHandle(snd_ent, "PlaySound", "", 0.03, null, null);
                    //EntFireByHandle(snd_ent, "Volume", "10", 0.04, null, null);
                }
            }
            else if ( model == 31 )
            {
                ::BOT[id][16].Destroy();
                ::BOT[id][16] = null;
                return;
            }
            EntFireByHandle(ent, "AddOutput", "message "+snd, 0.01, null, null);
            EntFireByHandle(ent, "PlaySound", "", 0.02, null, null);
        }
    }
}

::Del_Siren <- function (id) {
    EntFire("siren_control_id_"+id, "Deactivate", "", 0.10);
    EntFire("siren_control_id_"+id, "Kill", "", 0.11);
    EntFire("siren_"+id, "AddOutput", "rendermode 1", 0.00);
    EntFire("siren_"+id, "AddOutput", "renderamt 0", 0.00);
    EntFire("siren_"+id, "ClearParent", "", 0.00);
    EntFire("siren_"+id, "Kill", "", 0.12);
    EntFire("sirenmodel_b_"+id, "ClearParent", "", 0.00);
    EntFire("sirenmodel_b_"+id, "Kill", "", 0.01);
    EntFire("sirenmodel_c_"+id, "ClearParent", "", 0.00);
    EntFire("sirenmodel_c_"+id, "Kill", "", 0.01);
    EntFire("siren_effect_"+id, "ClearParent", "", 0.00);
    EntFire("siren_effect_"+id, "Kill", "", 0.01);
    EntFire("siren_red_"+id, "ClearParent", "", 0.00);
    EntFire("siren_red_"+id, "Disable", "", 0.00);
    EntFire("siren_red_"+id, "Kill", "", 0.01);
    EntFire("siren_hurt_"+id, "ClearParent", "", 0.00);
    EntFire("siren_hurt_"+id, "Kill", "", 0.01);
}

::Del_Panzer <- function (id) {

    EntFire("panzer_"+id, "ClearParent", "", 0.00);
    EntFire("panzer_"+id, "Kill", "", 2.00);

    //EntFire("panzerb_"+id, "ClearParent", "", 0.00);
    EntFire("panzer_"+id, "BecomeRagdoll", "", 0.10.00);
    //EntFire("panzerb_"+id, "Kill", "", 2.00);

    local ui = Entities.FindByName(null, "model_control_id"+id);
    if (ui != null) {
    EntFireByHandle(ui, "Deactivate", "", 0.00, null, null);
    EntFireByHandle(ui, "Kill", "", 0.01, null, null);
    }

    local del_ent = Entities.FindByName(null, "melee_hurt_"+id);
    if (del_ent != null) {
    EntFireByHandle(del_ent, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent, "Kill", "", 0.01, null, null);
    }

    //del_ent.Destroy();
    local del_ent_2 = Entities.FindByName(null, "fire_hurt_"+id);
    if (del_ent_2 != null) {
    EntFireByHandle(del_ent_2, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_2, "Kill", "", 0.01, null, null);
    }

    local del_ent_3 = Entities.FindByName(null, "gun_hurt_"+id);
    if (del_ent_3 != null) {
    EntFireByHandle(del_ent_3, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_3, "Kill", "", 0.01, null, null);
    }

    local del_ent_4 = Entities.FindByName(null, "panzer_eye_light_"+id);
    if (del_ent_4 != null) {
    EntFireByHandle(del_ent_4, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_4, "TurnOff", "", 0.00, null, null);
    EntFireByHandle(del_ent_4, "Kill", "", 0.01, null, null);
    }

    local del_ent_5 = Entities.FindByName(null, "panzer_spotlight_"+id);
    if (del_ent_5 != null) {
    EntFireByHandle(del_ent_5, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_5, "LightOff", "", 0.00, null, null);
    EntFireByHandle(del_ent_5, "Kill", "", 0.01, null, null);
    }
    
    local del_ent_6 = Entities.FindByName(null, "panzer_spotlight_holder_"+id);
    if (del_ent_6 != null) {
    EntFireByHandle(del_ent_6, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_6, "Kill", "", 0.01, null, null);
    }

    local del_ent_7 = Entities.FindByName(null, "panzer_fire_light_"+id);
    if (del_ent_7 != null) {
    EntFireByHandle(del_ent_7, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_7, "TurnOff", "", 0.00, null, null);
    EntFireByHandle(del_ent_7, "Kill", "", 0.01, null, null);
    }

    //local del_ent_8 = Entities.FindByName(null, "panzer_punch_"+id);
    //if (del_ent_8 != null) {
    //EntFireByHandle(del_ent_8, "ClearParent", "", 0.00, null, null);
    //EntFireByHandle(del_ent_8, "Kill", "", 0.01, null, null);
    //}

    local laser = Entities.FindByName(null, "wplaser_"+id);
    if (laser != null) {
    EntFireByHandle(laser, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(laser, "Kill", "", 0.01, null, null);
    }

    EntFire("wplaser_tg_"+id, "ClearParent", "", 0.00);
    EntFire("wplaser_tg_"+id, "Kill", "", 0.01);
}

::Del_Raz <- function (id) {
    EntFire("raz_"+id, "ClearParent", "", 0.00);
    EntFire("raz_"+id, "Kill", "", 2.00);

    //EntFire("razb_"+id, "ClearParent", "", 0.00);
    EntFire("raz_"+id, "BecomeRagdoll", "", 0.10);
    //EntFire("razb_"+id, "Kill", "", 2.00);

    local ui = Entities.FindByName(null, "model_raz_control_id"+id);
    if (ui != null) {
    EntFireByHandle(ui, "Deactivate", "", 0.00, null, null);
    EntFireByHandle(ui, "Kill", "", 0.01, null, null);
    }

    local del_ent = Entities.FindByName(null, "zombie_slash_b_"+id);
    if (del_ent != null) {
    EntFireByHandle(del_ent, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent, "Kill", "", 0.01, null, null);
    //del_ent.Destroy();
    }

    local del_ent_2 = Entities.FindByName(null, "zombie_slash_c_"+id);
    if (del_ent_2 != null) {
    EntFireByHandle(del_ent_2, "ClearParent", "", 0.00, null, null);
    EntFireByHandle(del_ent_2, "Kill", "", 0.01, null, null);
    }

    EntFire("raz_gun_tg_"+id, "ClearParent", "", 0.00);
    EntFire("raz_gun_tg_"+id, "Kill", "", 0.01);
}

::exp_shake <- function () {
    local p,ent,pos;
    p = activator;
    pos = p.GetOrigin();
    ent = Entities.CreateByClassname("env_shake");
    ent.__KeyValueFromInt("spawnflags", 12)
    ent.__KeyValueFromInt("amplitude", 8);
    ent.__KeyValueFromInt("duration", 3);
    ent.__KeyValueFromInt("frequency", 40);
    ent.__KeyValueFromInt("radius", 512);
    ent.SetOrigin(pos);
    EntFireByHandle(ent, "StartShake", "", 0.00, null, null);
    EntFireByHandle(ent, "StopShake", "", 3.00, null, null);
    EntFireByHandle(ent, "Kill", "", 1.01, null, null);
}

::BOT_ADD <- function () 
{
    local delay = 0.00;
    for ( local i = 0; i < 4; i++ )
    {
        EntFire("servercommand", "command", "bot_add_t", delay);
        delay += 0.01;
    }
};

Pickertest <- function (i)
{
    local a = BOT[i][0].GetScriptScope();
    local b = Get32IDByUserid(a.userid);
    printl(b.tostring());
}

CheckBOTValid <- function () 
{

    EntFire("script", "RunScriptCode", "CheckBOTValid()", 5.00);
    EntFire("script", "RunScriptCode", "CheckBOTValid_The_second()", 2.00);

    local _user,sc,steamid;
    local delay = 0.00;
    for ( local i = 0; i < ::BOT.len(); i++ )
    {
        if ( i < 5 )
        {
            if ( ::BOT[i][0] == null || !(::BOT[i][0].IsValid()) )
            {
                EntFire("servercommand", "command", "bot_add_t", delay);
                delay += 0.30;
            }
        }
        else
        {
            if ( ::BOT[i][0] != null && ::BOT[i][0].IsValid() )
            {
                _user = ::BOT[i][0];
                sc = _user.GetScriptScope();
                steamid = ::Get32IDByUserid(sc.userid);
                
                if ( steamid.find("STEAM", 0) == null || _user.GetClassname() == "cs_bot" || sc.GetNameByUserid(sc.userid).tolower() == "nazizombies*" || sc.GetNameByUserid(sc.userid).tolower() == "soldier*" )
                {
                    //EntFireByHandle(_user, "Kill", "", 0.00, 0.00);
                    ::VS.SendToServer("bot_kick "+::GetNameByUserid(sc.userid));
                }
            }
        }
    }

    /*local ent,p,sc,steamid,zm,slot,delay;

    delay = 0.00;

    for (local i=0;i<BOT.len();i++) 
    {

        if (i < 5 && BOT[i][0] != null && (!BOT[i][0].IsValid()) || i < 5 && BOT[i][0] == null) 
        {

            zm = BOT[i][8];
            EntFire("servercommand", "command", "bot_add_t", delay);
            delay += 0.10;

        if (zm) 
        {

                for (local a=0;a<isWave.len();a++) 
                {

                    if (isWave[a]) 
                    {

                        slot = a;
                        break;

                    }
                }
                if (Waveing) 

                EntFire("script", "RunScriptCode", "SpawnZombie("+i+" 2 10 "+slot+")", 1.00);

            }
        }

        else if (i > 4) 
        {

            p = BOT[i][0];

            if (p != null && p.IsValid()) 
            {
                
                sc = p.GetScriptScope();
                steamid = Get32IDByUserid(sc.userid);

                if (steamid.tolower() == "bot") 
                
                {
                    EntFireByHandle(p, "Kill", "", 0.00, null, null);
                    //EntFire("servercommand", "command", "kick "+p.GetName());
                    //p.Destroy();

                }
            }

            if (i==BOT.len()-1) 
            
            {
                p = null;
                sc = null;
                steamid = null;
                local j = 0;

                while ((ent = Entities.FindByClassname(ent, "*")) != null) 
                {

                    if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot") 
                    {

                        p = ent;

                        if (p.IsValid()) 
                        {

                            sc = p.GetScriptScope();
                            steamid = Get32IDByUserid(sc.userid);

                            if (p.GetTeam() == 2) 
                            {

                                for (local a=0;a<BOT.len()-5;a++) 
                                {

                                    if (BOT[a][0] == p) 
                                    {

                                        j = 1;
                                        break;

                                    }
                                }
                                if (j==1) 
                                {

                                    j=0;
                                    continue;

                                }

                                if (steamid.tolower() == "bot") 
                                {

                                    EntFireByHandle(p, "Kill", "", 0.00, null, null);
                                    //EntFire("servercommand", "command", "kick "+p.GetName());
                                    //p.Destroy();
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }*/
}

CheckBOTValid_The_second <- function ()
{
    local ent,_user,sc,steamid;
    while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
    {
        if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
        {
            _user = ent;
            sc = _user.GetScriptScope();
            steamid = Get32IDByUserid(sc.userid);

            if ( steamid.tolower() == "bot" )
            {
                local pass = false;
                for ( local i = 0; i < ::BOT.len()-5; i++ )
                {
                    if ( BOT[i][0] == _user )
                    {
                        pass = true;
                        continue;
                    }
                }
                if ( !pass )
                {
                    //EntFireByHandle(_user, "Kill", "", 0.00, null, null);
                    ::VS.SendToServer("bot_kick "+::GetNameByUserid(sc.userid));
                }
            }
        }
    }
};

GiveWpnFromAtc <- function (_player,_class,equipent = null)
{
    equipent = Entities.CreateByClassname("game_player_equip");
    equipent.__KeyValueFromInt("spawnflags", 3);
    equipent.__KeyValueFromInt("item_kevlar", 1);
    equipent.__KeyValueFromInt("item_nvgs", 1);
    //equipent.__KeyValueFromInt("weapon_hkp2000", 1);
    equipent.__KeyValueFromInt("weapon_"+_class, 1);
    EntFireByHandle(equipent, "Use", "", 0.00, _player, null);
    EntFire("@ammo", "GiveAmmo", "", 0.00, _player);
    EntFireByHandle(equipent, "Kill", "", 0.00, null, null);
};

SpawnATC <- function (n,t,w)
{
    if ( BOT[n][0] != null && BOT[n][0].IsValid() ) 
    {
        if ( isWave[w] && !BOT[n][8] )
        {
            local atvr = BOT[n][0];

            if ( atvr.GetHealth() > 0 )
            {
                DoEntFire("!self", "RunScriptCode", "BOT["+n+"][8]=true", 0.00, self, self);

                switch (t)
                {
                    case 0:
                    {
                        atvr.SetModel(::zombie_model[31]);
                        EntFireByHandle(atvr, "Skin", "0", 0.00, null, null);
                        atvr.SetHealth(300);
                        atvr.SetMaxHealth(300);
                        ::VS.SetSpeed(atvr, 0, 0.9);
                        GiveWpnFromAtc(atvr,"ump45");
                        break;
                    }
                    case 1:
                    {
                        atvr.SetModel(::zombie_model[31]);
                        EntFireByHandle(atvr, "Skin", "0", 0.00, null, null);
                        atvr.SetHealth(300);
                        atvr.SetMaxHealth(300);
                        ::VS.SetSpeed(atvr, 0, 0.85);
                        GiveWpnFromAtc(atvr,"galilar");
                        break;
                    }
                    case 2:
                    {
                        atvr.SetModel(::zombie_model[31]);
                        EntFireByHandle(atvr, "Skin", "1", 0.00, null, null);
                        atvr.SetHealth(400);
                        atvr.SetMaxHealth(400);
                        ::VS.SetSpeed(atvr, 0, 0.7);
                        GiveWpnFromAtc(atvr,"xm1014");
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
                local r = RandomInt(0,34);
                atvr.SetOrigin(::Positions[r]);
                EntFire("tesla_temp", "ForceSpawn");
                EntFire("script", "RunScriptCode", "SpawnEffect("+n+")", 0.00);
                BOT[n][15] = false;
                if ( !ATC_Voice_Switch[n] )
                    ATC_Voice(n);
                EntFire("clientcommand", "command", "nightvision", 0.00, atvr);
                EntFire("eyelight_temp", "ForceSpawn");
                DoEntFire("!self", "RunScriptCode", "bindEyelight("+n+" "+t+")", 0.00, self, self);
            }
        }
    }
};

bindEyelight <- function (id,t)
{
    local ent;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        if ( ent.GetClassname() == "func_physbox" )
        {
            if ( ent.GetName() == "eyelight_holder" && t < 2 || ent.GetName() == "eyelight2_holder" && t == 2 )
            {
                local atvr = BOT[id][0];
                local pos = atvr.EyePosition() + atvr.GetForwardVector() * 12,ang = atvr.GetAngles();
                ent.SetAngles(0,ang.y,0);
                ent.SetOrigin(pos);
                EntFireByHandle(ent, "SetParent", atvr.GetName(), 0.00, null, null);
                EntFireByHandle(ent, "SetParentAttachment", "facemask", 0.00, null, null);
                ent.__KeyValueFromString("targetname", "");
                BOT[id][16] = ent;
                break;
            } 
        }
    }
};

ATC_Voice_Switch <- [false,false,false,false,false,false,false,false,false,false];
ATC_Voice <- function (id)
{
    if ( !ATC_Voice_Switch[id] )
        ATC_Voice_Switch[id] = true;
    local _timer = RandomInt(4,12);
    DoEntFire("!self", "RunScriptCode", "ATC_Voice("+id+")", _timer, self, self);

    local atvr = BOT[id][0],zm = BOT[id][8];
    if ( atvr.GetHealth() > 0 && zm ) 
    {
        if (atvr.GetModelName() == zombie_model[31]) 
        {

            local ene,myOrigin = atvr.EyePosition();
            while ( ( ene = Entities.FindByClassnameWithin(ene,"player",myOrigin,768) ) != null )
            {
                if ( ene.GetTeam() == 3 )
                {
                    printl("EntryRange");
                    local otherOrigin = ene.EyePosition(),frac = TraceLine(myOrigin, otherOrigin, null);
                    local myYaw = atvr.GetAngles().y;
                    if ( frac == 1.0 )
                    {
                        printl("Visual_location");
                        local otherVector = Vector( otherOrigin.x - myOrigin.x, otherOrigin.y - myOrigin.y, 0 );
	        		    local selfVector = Vector( cos( myYaw * PI / 180.0 ), sin( myYaw * PI / 180.0 ), 0 );
	        		    local scalar = ( otherVector.x * selfVector.x + otherVector.y * selfVector.y );
	        		    local ang = acos( scalar / ( otherVector.Length() * selfVector.Length() ) ) * 180.0 / PI;

                        for ( local i = 0; i < 10; i++ )
                        {

                            if ( ang.tostring().find( i.tostring(),0 ) != null )

                                break;

                            if ( i == 9 )

                                ang = 0;

                        }

                        if ( ang > -80 && ang < 80 )
                        {
                            printl("Contact");
                            if ( !BOT[id][15] )
                                BOT[id][15] = true;
                            break;
                        }
                    }
                }
            }

            local ent = Entities.FindByName(null, "zombie_snd_id"+id);
            local r = RandomInt(1,34),snd;
            !BOT[id][15] ? snd = ::ATC_SND[5]+r+".mp3" : snd = ::ATC_SND[6]+r+".mp3";
            while ( ( ene = Entities.FindByClassnameWithin(ene,"hegrenade_projectile",myOrigin,512) ) != null )
            {
                r = RandomInt(1,5);
                snd = ::ATC_SND[9]+r+".mp3"
            }

            if ( ent != null )
            {
                //ent.__KeyValueFromString("message", snd);
                EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
                EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
                EntFireByHandle(ent, "AddOutput", "message "+snd, 0.00, null, null);
                EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
            }
        }
    }
};

SpawnEffect <- function (id)
{
    local ent,ent2;
    local atvr = BOT[id][0];
    local pos = atvr.GetOrigin();
    pos.z += 36;
    ent = Entities.FindByName(null, "tesla");
    ent.__KeyValueFromString("targetname", "");
    ent.SetOrigin(pos);
    EntFireByHandle(ent, "TurnOn", "", 0.00, null, null);
    EntFireByHandle(ent, "TurnOff", "", 2.00, null, null);
    EntFireByHandle(ent, "Kill", "", 2.00, null, null);

    local file = map_snd[3];
    local snd = Entities.FindByName(null, "map_world_sound");
    snd.SetOrigin(pos);
    EntFireByHandle(snd, "AddOutput", "message "+file, 0.00, null, null);
    EntFireByHandle(snd, "PlaySound", "", 0.00, null, null);
    EntFireByHandle(snd, "Volume", "5", 0.00, null, null);
};

ZombViewPosAng <- [
    [Vector(-591,1542,259),Vector(2,301,0)],
    [Vector(1374,747,235),Vector(1,220,0)],
    [Vector(560,-958,255),Vector(4,101,0)],
    [Vector(-1029,-472,39),Vector(352,40,0)]
];
gameStart_zmView <- function (n)
{
    local _user,cam;
    for ( local i = 5; i < ::CamArray.len(); i++ )
    {
        cam = ::CamArray[i];
        if ( cam != null )
        {
            _user = BOT[i][0];
            if ( _user.IsValid() )
            {
                cam.SetOrigin(ZombViewPosAng[n][0]);
                cam.SetAngles(ZombViewPosAng[n][1].x,ZombViewPosAng[n][1].y,0);
                if ( n == 0 )
                {
                    //local ent = Entities.FindByName(null, "ui_t_"+i);
                    //EntFireByHandle(ent, "Deactivate", "", 0.00, null, null);
                    //EntFireByHandle(ent, "Kill", "", 0.00, null, null);
                    EntFireByHandle(cam, "Enable", "", 0.00, _user, null);
                    EntFire("clientcommand", "command", "Play "+::Background_music[8], 0.00, _user);
                    EntFireByHandle(_user, "SetHUDVisibility", "0", 0.00, null, null);
                    
                }

                if ( n == ZombViewPosAng.len()-1 )
                {
                    EntFireByHandle(cam, "Disable", "", 5.00, _user, null);
                    EntFireByHandle(_user, "SetHUDVisibility", "1", 5.00, null, null);
                    //EntFire("Script", "RunScriptCode", "ShowZombieHUD()", 5.00);
                    //EntFire("Script", "RunScriptCode", "SuperjumpTimer()", 7.00);
                    return;
                }
                EntFire("Script", "RunScriptCode", "gameStart_zmView("+(n+1)+")", 4.00);
                return;
            }
        }
    }
};

ZombieHUDText <- [
    ["阵地生命值","Fort Strength"],
    ["超级跳：","SuperJump"],
    ["就绪(F)","Ready(F)"],
    ["CD - ","CD - "],
    ["炮弹量","Ammo"],
    ["装填中...","Reloading..."]
];

GetSuperjumpState <- function (id)
{
    if ( BOT[id][14] )
        return ZombieHUDText[2][::m_lang];
    else
        return ZombieHUDText[3][::m_lang] + BOT[id][13];
}

g_textGroup <- null;//[]
ShowZombieHUD <- function ()
{
    if ( isOver )
        return;
    EntFire("Script", "RunScriptCode", "ShowZombieHUD()", 0.30);
    local ent,user,id,sc;
    while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
    {
        if ( ent.GetClassname() == "player" )
        {
            user = ent;
            if ( user.GetTeam() == 2 )
            {
                for ( local i = 0; i < BOT.len(); i++ )
                {
                    if ( i > 4 )
                    {
                        if ( BOT[i][0] == user )
                        {
                            id = i;
                            sc = user.GetScriptScope();

                            local gtext,text = "",pass = true;
                           /* if ( g_textGroup.len() > 0 )
                            {
                                for ( i = 0; i < g_textGroup.len(); i++ )
                                {
                                    if ( !pass && g_textGroup[i].GetOwner() == user )
                                    {
                                        gtext = g_textGroup[i];
                                        pass = false;
                                        break;
                                    }
                                }
                            }*/
                            if ( g_textGroup != null )
                            {
                                pass = false;
                                gtext = g_textGroup;
                            }

                            if ( pass )
                            {
                                gtext = Entities.CreateByClassname("game_text");
                                gtext.__KeyValueFromInt("spawnflags",0);
                                gtext.__KeyValueFromString("color","255 0 0");
                                gtext.__KeyValueFromInt("x",-1);
                                gtext.__KeyValueFromFloat("y",0.79);
                                gtext.__KeyValueFromInt("fadein",0);
                                gtext.__KeyValueFromInt("fadeout",0);
                                gtext.__KeyValueFromInt("holdtime",1);
                                gtext.__KeyValueFromInt("effect",0);
                                gtext.__KeyValueFromInt("channel",1);
                                //gtext.SetOwner(user);
                                //g_textGroup.push(gtext);
                                g_textGroup = gtext;
                            }

                            local slot = null;
                            for ( i = 0; i < isWave.len(); i++ ) 
                            {
                                if (isWave[i]) 
                                {
                                    slot = i;
                                    break;
                                }
                            }
                            if (::Waveing) 
                                text = ::Wave_Msg[3][::m_lang]+" "+(slot+1)+" "+::Wave_Msg[4][::m_lang] + "\n";
                            if ( user.GetModelName() != zombie_model[31] )
                                text += ZombieHUDText[0][::m_lang] + zombie_score + "/200 \n" + ZombieHUDText[1][::m_lang] + GetSuperjumpState(id);
                            else
                                text += ZombieHUDText[0][::m_lang] + zombie_score + "/200";

                            //gtext.__KeyValueFromString("message", text);
                            EntFireByHandle(gtext, "AddOutput", "message "+text, 0.00, null, null);
                            EntFireByHandle(gtext, "DisPlay", "", 0.00, user, null);
                            break;
                        }
                    }
                }
            }
        }
    }
};

::ZmNvgArray <- [null,null,null,null,null];
::ZmEyeGlowArray <- [[null,null],[null,null],[null,null],[null,null],[null,null]];
ZombiesNvg <- function (id)
{
    local atvr = BOT[id][0],sc = atvr.GetScriptScope();
    local ent;
    if ( ZmNvgArray[id-5] == null )
    {
        ent = Entities.FindByName(null, "zombieintro");
        ent.__KeyValueFromString("targetname", "nvg"+id);
        ZmNvgArray[id-5] = ent;
    }
    else
    {
        ent = ZmNvgArray[id-5];
    }

    if ( sc.nvg != 1 )
         sc.nvg = 1;
    EntFireByHandle(ent, "Enable", "", 0.00, null, null);
    updateZmNvg(id);
};

updateZmNvg <- function (id)
{
    local atvr = BOT[id][0],pos = atvr.GetOrigin(),sc = atvr.GetScriptScope();
    local ent = ZmNvgArray[id-5];
    if ( atvr.GetHealth() > 0 )
        ent.SetOrigin(pos);
    else
    {
        EntFireByHandle(ent, "Disable", "", 0.00, null, null);
        return;
    }
        EntFire("Script", "RunScriptCode", "updateZmNvg("+id+")", 0.01);
};

zombieEyeG <- function (id)
{
    local atvr = BOT[id][0],sc;
    sc = atvr.GetScriptScope();
    local ent,ent2;

    if ( ZmEyeGlowArray[id][0] == null && ZmEyeGlowArray[id][1] == null )
    {
        ent = Entities.FindByName(null, "zombie_eye_glow_l");
        ent.__KeyValueFromString("targetname", "");
        ent2 = Entities.FindByName(null, "zombie_eye_glow_r");
        ent2.__KeyValueFromString("targetname", "");
    
        if ( atvr.GetModelName() != ::zombie_model[31] )
        {
            EntFireByHandle(ent, "SetParent", atvr.GetName(), 0.00, null, null);
            EntFireByHandle(ent, "SetParentattachment", "Lefteye" 0.00, null, null);
            EntFireByHandle(ent2, "SetParent", atvr.GetName(), 0.00, null, null);
            EntFireByHandle(ent2, "SetParentattachment", "Righteye" 0.00, null, null);
            ZmEyeGlowArray[id][0] = ent;
            ZmEyeGlowArray[id][1] = ent2;
        }
        else
        {
            ent.Destroy();
            ent2.Destroy();
            return;
        }
    }
    else
    {
        ent = ZmEyeGlowArray[id][0];
        ent2 = ZmEyeGlowArray[id][1];
    }
    if ( sc.glow != 1 )
         sc.glow = 1;
    EntFireByHandle(ent, "Start", "", 1.00, null, null);
    EntFireByHandle(ent2, "Start", "", 1.00, null, null);
}

