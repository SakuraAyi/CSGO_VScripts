//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::CaseList <- [
    "models/weapons/w_rif_famas.mdl",//0
    "models/weapons/w_rif_galilar.mdl",//1
    "models/weapons/w_rif_m4a1.mdl",//2
    "models/weapons/w_rif_ak47.mdl",//3
    "models/weapons/w_rif_aug.mdl",//4
    "models/weapons/w_rif_sg556.mdl",//5
    "models/weapons/w_snip_awp.mdl",//6
    "models/weapons/w_snip_scar20.mdl",//7
    "models/weapons/w_snip_g3sg1.mdl",//8
    "models/weapons/w_shot_xm1014.mdl",//9
    "models/weapons/w_shot_mag7.mdl",//10
    "models/weapons/w_shot_sawedoff.mdl",//11
    "models/weapons/w_mach_m249.mdl",//12
    "models/weapons/w_smg_bizon.mdl",//13
    "models/weapons/w_smg_mp7.mdl",//14
    "models/weapons/w_smg_ump45.mdl",//15
    "models/weapons/w_smg_mp9.mdl",//16
    "models/weapons/w_smg_p90.mdl",//17
    "models/weapons/w_pist_fiveseven.mdl",//18
    "models/weapons/w_pist_elite.mdl",//19
    "models/weapons/w_pist_deagle.mdl",//20
    "models/weapons/w_pist_glock18.mdl",//21
    "models/weapons/w_pist_223.mdl",//22
    "models/weapons/w_pist_p250.mdl",//23
    "models/weapons/w_pist_cz_75.mdl",//24
    "models/props/11/teddy_bear/teddy_bear.mdl"//25
];

::WeaponList <- [
    "weapon_famas",
    "weapon_galilar",
    "weapon_m4a1",
    "weapon_ak47",
    "weapon_aug",
    "weapon_sg556",
    "weapon_awp",
    "weapon_scar20",
    "weapon_g3sg1"
    "weapon_xm1014",
    "weapon_mag7",
    "weapon_sawedoff",
    "weapon_m249",
    "weapon_bizon",
    "weapon_mp7",
    "weapon_ump45",
    "weapon_mp9",
    "weapon_p90",
    "weapon_fiveseven",
    "weapon_elite",
    "weapon_deagle",
    "weapon_glock",
    "weapon_usp_silencer",
    "weapon_p250",
    "weapon_cz75a",
    "none"
];

::Primary <- [
    "ak47",
    "m4a1",
    "aug",
    "sg556",
    "awp",
    "bizon",
    "famas",
    "g3sg1",
    "galilar",
    "m4a1_silencer",
    "m249",
    "mac10",
    "mag7",
    "mp7",
    "mp9",
    //"negev",
    "nova",
    "p90",
    "scar20",
    "ssg08",
    "ump45",
    "xm1014",
    "sawedoff"
];

::item_snd <- [
    "11/nazi/prop/barricade_1.mp3", // 0
    "11/nazi/prop/barricade_2.mp3", // 1
    "11/nazi/prop/barricade_3.mp3", // 2
    "11/nazi/prop/barricade_4.mp3", // 3
    "11/nazi/prop/barricade_5.mp3", // 4
    "11/nazi/prop/treasure_box.mp3", // 5
    "survival/briefcase_open_success_01.wav", // 6 gf
    "survival/buy_item_01.mp3", // 7 gf
    "ui/panorama/inventory_new_item_01.wav", // 8 gf
    "11/nazi/prop/buy.mp3", // 9
    "ui/panorama/lobby_error_01.wav", // 10 gf
    "physics/metal/metal_solid_impact_soft1.wav", // 11 gf
    
];

::item_text <- [
    ["随机武器箱 [费用:950]","Random Weapons Box [Cost: 950pts]"],//0
    ["标记手雷x6(可透视寻找敌人) [费用:100]","Tactical Awareness Grende x6 [Cost: 100pts]"],//1
    ["NOVA泵动式霰弹枪 [费用:600]","Nova Pump-Action Shotgun [Cost: 600pts]"],//2
    ["英特拉泰克TEC-DC9 [费用:300]","Intratec TEC-9 [Cost: 300pts]"],//3
    ["伯奈利M4super90霰弹枪 [费用:1200]","Benelli M4 Super 90 [Cost: 1200pts]"],//4
    ["英格拉姆Mac10式冲锋枪 [费用:1000]","Ingram MAC-10 [Cost: 1000pts]"],//5
    ["圣艾蒂安Famas轻型自动步枪 [费用:1800]","FAMAS [Cost: 1800pts]"],//6
    ["短管霰弹枪 [费用:1500]","Sawed-Off Shotgun [Cost: 1500pts]"],//7
    ["斯太尔SSG08战术狙击步枪 [费用:1000]","Steyr SSG 08 [Cost: 1000pts]"],//8
    ["M67式延时杀伤手雷x1 [费用:300]","M67 Grenade x1 [Cost: 200pts]"],//9
    ["医疗针x2 [费用:400]","Medi-Shot x2 [Cost: 400pts]"],//10
    ["护甲 [费用:200]","Armour [Cost: 200pts]"],//11
    ["克莱莫人员杀伤地雷 M18A1 x1 [费用:350]","M18 Claymore Mine x1 [Cost: 250pts]"],//12
    ["弹药 [费用:200]","Ammo [Cost: 200pts]"],//13

    ["开门 [费用:1000]","Open the door [Cost: 1000pts]"],//14
    ["移除沙发 [费用:1000]","Remove the sofa [Cost: 1000pts]"],//15
    
    ["回血仪 [费用:2000]","HealthCharger [Cost: 2000pts]"]
];

::PlayItem_Sound <- function (n) {
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "Global_Sound");
    if (snd != null) {
        file = item_snd[n];
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    }
}

::WeaponPos <- [
    Vector(453,599,-6), 
    Vector(453,599,40),

    Vector(-56,690,64), //2
    Vector(-420,578,64), //3
    Vector(557,-386,63), //4
    Vector(730,-326,65), //5
    Vector(751,690,205), //6
    Vector(818,-63,214), //7
    Vector(-261,582,208), //8
    Vector(158,540,211), //9

    Vector(459,605,0), //10 BOX ORI
    Vector(459,605,84), //11

    Vector(370,284,203), //12
    Vector(193,553,63), //13
    Vector(823,279,63), //14
];

::CostTips <- function () {
    //BoxCost();
    //SensorCost();
    NovaCost();
    TEC9Cost();
    XM1014Cost();
    MAC10Cost();
    FAMASCost();
    SawedoffCost();
    //SSG08Cost();
    //FragGrenadeCost();
    //HealthShotCost();
    //MineCost();
    //VestCost();
    //AmmoCost(1);
    //AmmoCost(2);
    //AmmoCost(3);

    //DoorCost();
    //CouchCost();
    //Couch_2_Cost();

    //JuggernogCost();
    //DoubletapCost();
    //StaminupCost();
    //ReviveCost();
    HealthChargerCost();
}

::Player_Start_Equip <- function () {
    local p,id;
    local p_weapons = ["weapon_usp_silencer","weapon_hegrenade"];
    local pist,eq;
    local wpn = null;
    local delay = 0.10;
    for (local i=0;i<Player.len();i++) {
        p = Player[i][0];
        if (p != null && p.IsValid()) {
            if (p.GetHealth() > Player_ZeroValue) {
                id = i;
                pist = Entities.FindByName(null, "character_pist_id_"+id);
                eq = Entities.FindByName(null, "character_eq_id_"+id);
                //EntFire("Script", "RunScriptCode", "PlayerKnife_Check()", 0.01);
                /*for (local c=0;c<p_weapons.len();c++) {
                    EntFire("@equip", "TriggerForActivatedPlayer", p_weapons[c], 0.00, p);
                }*/
                //local equip = Entities.CreateByClassname("game_player_equip");
                //equip.__KeyValueFromInt("spawnflags", 5);
                //equip.__KeyValueFromInt("weapon_knife", 1);
                //EntFireByHandle(equip, "Use", "", 0.00, p, null);
                //EntFireByHandle(equip, "Kill", "", 0.01, null, null);
                EntFire("knive_template", "ForceSpawn", "", delay);
                EntFire("Script", "RunScriptCode", "GiveBayonet("+id+")", delay+0.01);
                delay += 0.10;
                local _item = null;
                local equip = Entities.CreateByClassname("game_player_equip");
                equip.__KeyValueFromInt("spawnflags", 5);
                if (pist.GetModelName().find("223", 14) != null)
                     _item = "weapon_usp_silencer";
                else 
                {
                    wpn = pist.GetModelName().slice(22, pist.GetModelName().len()-6);
                    if ( wpn=="glock" )
                        _item = "weapon_"+wpn;
                    else 
                        _item = "weapon_"+pist.GetModelName().slice(22, pist.GetModelName().len()-4);
                }
                equip.__KeyValueFromInt(_item, 1);
                EntFireByHandle(equip, "Use", "", 0.00, p, null);
                EntFireByHandle(equip, "Kill", "", 0.00, null, null)
                EntFire("@Ammo", "GiveAmmo", "", 0.01, p);
            }
        }
        else {
            continue;
        }
    }
}


::PlayerWPN_Check <- function () {
    local p,id,sc,wpn,dm,ent;
    EntFire("Script", "RunScriptCode", "PlayerWPN_Check()", 0.10);
    for (local i=0;i<Primary.len();i++) {
        while ((ent = Entities.FindByClassname(ent, "weapon_"+Primary[i])) != null) {
            for (local c=0;c<Player.len();c++) {
                if (Player[c][0] != null) {
                    p = Player[c][0];
                    if (p.IsValid()) {
                        id = c;
                        p = Player[id][0];
                        sc = p.GetScriptScope();
                        wpn = Player[id][35];
                        dm = Player[id][22];
                        if (ent.GetMoveParent() == p) {
                        if (wpn == "none") {
                            if(p.GetHealth() > 0) {
                                if (dm != "deathmachine" && dm != "deathmachine_hp" && dm != "deathmachine_ammo" && 
                                    dm != "deathmachine_money" && dm != "deathmachine_nuke" && dm != "deathmachine_carpenter") {
                                    ent.Destroy();
                                    EntFire("clientcommand", "command", "slot3", 0.00, p);
                                }
                                for (local k=0;k<3;k++) {
                                    if (m_lang==0)
                                    ScriptPrintMessageChatAll("\x01 \x09 "+GetNameByUserid(sc.userid) + "\x02 请不要没有意义的控制台获取武器！好好遵守游戏规则！");
                                    else 
                                    ScriptPrintMessageChatAll("\x01 \x09 "+GetNameByUserid(sc.userid) + "\x02 Please don't get weapons without meaning! Follow the rules of the game!");
                                    }
                                    break;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

::GiveBayonet <- function (id) {

    local p,pos,knive;

    p = Player[id][0];
    pos = p.GetOrigin();
    knive = Entities.FindByName(null, "bayonet_");

    if (knive != null) {

        knive.__KeyValueFromString("classname", "weapon_knifegg");
        EntFireByHandle(knive, "addoutput", "targetname bayonet_"+id, 0.00, null, null);
        knive.SetOrigin(pos);

    }
    else {

        EntFire("knive_template", "ForceSpawn", "", 0.00);
        EntFire("Script", "RunScriptCode", "GiveBayonet("+id+")", 0.01);

    }
}

::Think_Decoy <- function () {
    //M18_Mine
    local ent = null;
    local ent_b = null;
    local owner,sc,id,voc;
    //local ori = null;
    while ((ent = Entities.FindByClassname(ent, "decoy_projectile")) != null) {
            owner = ent.GetOwner();
            //ori = owner.GetOrigin();
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == owner) {
                id = i;
                break;
            }
        }
        sc = owner.GetScriptScope();
        voc = sc._class;
        if (ent.IsValid()) {
            sc._deploy <- ent.GetOrigin();
            ent.Destroy();
            if (owner.GetVelocity().z == 0) {
                if (sc._deploycount >= sc._deploymax) {
                    EntFireByHandle(sc._deployed[0], "RunScriptCode", "Remove()", 0.00, null, null);
                }
                if (voc == career.rook) {
                    EntFire("vestbag_template", "ForceSpawn");
                }
                if (voc == career.trap) {
                    EntFire("m18mine_template", "ForceSpawn");
                    //EntFire("Script", "RunScriptCode", "M18Mine("+id+")", 0.01);
                }
                if (voc == career.support) {
                    EntFire("ammo_template", "ForceSpawn");
                }
                if (voc == career.doctor) {
                    EntFire("medkit_template", "ForceSpawn");
                }
            }
            else {
                ShowPlayerEventHudMsg(id,44);
                //EntFire("@equip_decoy", "Use", "", 0.00, owner);
                local equip = Entities.CreateByClassname("game_player_equip");
                equip.__KeyValueFromInt("spawnflags", 5);
                equip.__KeyValueFromInt("weapon_decoy", 1);
                EntFireByHandle(equip, "Use", "", 0.00, owner, null);
                EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            }
        }
        break;
    }
};


::M18Mine <- function (id) {
    local owner = null
    local ori,ang;
    local ent = null;
    local ent_b = null;
    local ck = null;
    local n = null;
    local name,name_b;
    owner = Player[id][0];
    ori = owner.GetOrigin(),ang = owner.GetAngles();
    ent = Entities.FindByName(null, "m18mine_");
    ent_b = Entities.FindByName(null, "m18mine_laser_");
    name = ent.GetName()+id+"_";
    name_b = ent_b.GetName()+id+"_";
    ent.__KeyValueFromString("targetname", name);
    ent_b.__KeyValueFromString("targetname", name_b);
    for (local i=0;i<6;i++) {
        ck = Entities.FindByName(null, name+i);
        if (ck==null) {
            n = i;
            break;
        }
        if (i==5) {
            printl("max_mine!!")
            ent.Destroy();
            ent_b.Destroy();
            ShowPlayerEventHudMsg(id,43);
            //EntFire("@equip_decoy", "Use", "", 0.00, owner);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_decoy", 1);
            EntFireByHandle(equip, "Use", "", 0.00, owner, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            return;
        }
    }
    ent.__KeyValueFromString("targetname", name+n);
    ent_b.__KeyValueFromString("targetname", name_b+n);
    EntFireByHandle(ent_b, "SetParent", name+n, 0.00, null, null);
    EntFire("Script", "RunScriptCode", "M18ORI_Delay("+id+" "+n+")", 0.01);
    //EntFire(name_b+n, "Enable", "", 1.00)
    EntFire("Script", "RunScriptCode", "M18_EXP_Tri("+id+" "+n+")", 1.10);
}

::M18ORI_Delay <- function (id,n) {
    local owner = Player[id][0];
    local sc = owner.GetScriptScope();
    local ori = owner.GetOrigin(),ang = owner.GetAngles();
    local ent = null;
    ent = Entities.FindByName(null, "m18mine_"+id+"_"+n);
    ent.SetOrigin(ori);
    ent.SetAngles(0,ang.y+180,0);
    local ent_b = null;
    local text = event_msg[42][m_lang];
    if (owner != null) {
    ent_b = Entities.CreateByClassname("env_hudhint");
    ent_b.__KeyValueFromString("message",text);
    ent_b.SetOwner(owner);
    EntFireByHandle(ent_b, "ShowHudhint", "", 0.00, owner, null);
    EntFireByHandle(ent_b, "Kill", "", 0.01, null, null);
    }
    local snd = null;
    local file = null;
    local r = null;
    snd = Entities.FindByName(null, "map_world_sound");
    if (snd != null) {
    file = item_snd[17];
    snd.__KeyValueFromString("message", file);
    snd.SetOrigin(ori);
    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
    EntFireByHandle(snd, "Volume", "5", 0.02, null, null);
    EntFireByHandle(snd, "AddOutput", "message "+item_snd[18], 0.03, null, null);
    EntFireByHandle(snd, "PlaySound", "", 0.04, null, null);
    }
    if (Player_Missile[id] != 0) {
        Player_Missile[id] -= 1;
    }
    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+": "+event_msg[41][m_lang]);
}

::M18_EXP_Tri <- function (id,n) {
    local owner = Player[id][0];
    local ent = null;
    local name = "m18mine_"+id+"_"+n;
    local ori = null,exp_ori = null,range = null;
    local exp = null;
    local filter = null;
    local p = null;
    ent = Entities.FindByName(null, name);
    if (ent != null) {
        //print("mine_checktarget..")
        ori = ent.GetOrigin() + ent.GetForwardVector() * -54;
        exp_ori = ori + ent.GetForwardVector() * -24;
        while ((range = Entities.FindByClassnameWithin(range, "*", Vector(ori.x,ori.y,ori.z+21), 42)) != null) {
            if (range.GetClassname() == "player") {
                p = range;
                if (p.GetTeam() == 2) {
                    filter = "Player_ID*";
                    exp = Entities.CreateByClassname("env_explosion");
                    //exp.__KeyValueFromInt("spawnflags", 16384);
			        exp.__KeyValueFromInt("iMagnitude", 8000);
                    exp.__KeyValueFromInt("iRadiusOverride", 96); //72
                    exp.__KeyValueFromString("ignoredEntity", filter);
                    exp.SetOrigin(exp_ori);
			        exp.SetOwner(owner);
                    EntFireByHandle(exp, "AddOutput", "classname prop_exploding_barrel", 0.00, null, null);
                    EntFireByHandle(exp, "Explode", "", 0.01, owner,owner);
                    DispatchParticleEffect("explosion_hegrenade_interior", ori, Vector(0,0,0));
                    local snd = null;
                    local file = null;
                    local r = null;
                    snd = Entities.FindByName(null, "map_world_sound");
                    if (snd != null) {
                        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
                        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
                        r = RandomInt(12,13);
                        file = map_snd[r];
                        snd.__KeyValueFromString("message", file);
                        snd.SetOrigin(ori);
                        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                        EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
                    }
                    ent.Destroy();
                }
            }
        }
        EntFire("Script", "RunScriptCode", "M18_EXP_Tri("+id+" "+n+")", 0.10);
    }
    else {
        return;
    }
}


function Decoy_bomb()
{
	ent <- null;
	while ((ent = Entities.FindByClassname(ent, "decoy_projectile")) != null)
	{
        printl("decoy_velocity.length>"+ent.GetVelocity().Length());
		if(ent.GetVelocity().Length() == Vector(0,0,0).Length())
		{		
            printl("decoy_velocity_stop.length>"+Vector(0,0,0).Length());
			owner <- ent.GetOwner();
			origin <- ent.GetOrigin();	
			
			exp <- Entities.CreateByClassname("env_explosion");
			exp.__KeyValueFromInt("iMagnitude", 2000);
					
			//ent.EmitSound(EXPLOSION_SOUND);
									
			exp.SetOrigin(origin);
			exp.SetOwner(owner);
									
			EntFireByHandle(exp, "Explode", "", 0.1, owner,owner);						
			ent.Destroy();						
			DispatchParticleEffect("explosion_c4_500", origin, origin);
		}		
	}
    EntFire("Script", "RunScriptCode", "Decoy_bomb()", 0.01);
}

::isgone <- false;
::BoxCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "CaseCost"
    local text = item_text[0][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "treasure_box_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),55)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                    if (!isgone) {
                    if (eye_see_space[id][0] != null) {
                        if (eye_see_space[id][0] == ent) {
                            if (p.GetHealth() > 0) {
                                entb.SetOwner(p);
                                EntFireByHandle(entb, "Display", "", 0.00, p, null);
                                //EntFireByHandle(entb, "Kill", "", 0.01, null, null);
                            }
                        }
                    }
                    }
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "BoxCost()", 0.15);
    }
}

::BoxLock <- false;
::WepReady <- false;
::OpenBox <- function () {
    local p = activator;
    local id = null;
    local cost = 950;
    local button = null;
    local within = null;
    local sc = p.GetScriptScope();
    button = Entities.FindByName(null, "treasure_box_button");
    for (local o=0;o<Player.len();o++) {
    within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),55);
    if (!BoxLock && p.GetTeam()==3 && !isgone && !WepReady) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        if (within != null && within == Player[id][0]) {
        if (Points[id] >= cost) {
            BoxLock = true;
            PointChange(id,cost,0);
            local ent = Entities.FindByName(null, "treasure_box_snd");
            local snd = item_snd[6];
            ent.__KeyValueFromString("message",snd);
            EntFire("treasure_box_snd", "PlaySound", "");
            EntFire("treasure_box", "SetAnimationNoReset", "open",0.10);
//            EntFire("treasure_box", "SetDefaultAnimation", "opened",0.80);
            EntFire("treasure_box_spotlight", "LightOn", "", 0.50);
            EntFire("treasure_box_light", "TurnOn", "", 0.50);
            EntFire("treasure_box_snd", "AddOutput", "message "+item_snd[5], 0.50);
            EntFire("treasure_box_snd", "PlaySound", "", 0.51);

            local entb = null;
            local r = RandomInt(0,CaseList.len()-1);
            local name = "casemodel";
            entb = CreateProp("prop_dynamic",WeaponPos[0],CaseList[r],0);
            entb.__KeyValueFromString("targetname",name);
            entb.SetAngles(0,30,0);
            EntFire("Script", "RunScriptCode", "WepAct()", 1.00);
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[13][m_lang]);
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

::WepAct <- function () {
    local ent = null;
    local r = RandomInt(0,CaseList.len()-1);
    ent = Entities.FindByName(null, "casemodel");
    if (ent != null) {
    local ori = ent.GetOrigin();
    ent.SetModel(CaseList[r]);
    if (ent.GetOrigin().z < WeaponPos[1].z) {
        ent.SetOrigin(Vector(ori.x,ori.y,ori.z+1));
    }
    else {
        if (ent.GetModelName() == CaseList[25]) {
            isgone = true;
            ent.SetAngles(-75,120,0);
            ent.SetOrigin(Vector(458,607,ori.z));
            local snd = null;
            local file = null;
            local ori = ent.GetOrigin();
            snd = Entities.FindByName(null, "map_world_sound");
            if (snd != null) {
                file = item_snd[12];
                snd.__KeyValueFromString("message", file);
                snd.SetOrigin(ori);
                EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                EntFire("Script", "RunScriptCode", "byebye()", 4.00);
            }
        }
        else {
            WepReady = true;
            EntFire("treasure_box_relay", "Trigger");
        }
        return;
    }
    EntFire("Script", "RunScriptCode", "WepAct()", 0.10);
    }
}

::box_alpha <- 255;
::byebye <- function () {
    local ent = null;
    ent = Entities.FindByName(null, "casemodel");
    local snd = null;
    local file = null;
    local ori = ent.GetOrigin();
    snd = Entities.FindByName(null, "Global_Sound");
    if (snd != null) {
        file = item_snd[13];
        snd.__KeyValueFromString("message", file);
        snd.SetOrigin(ori);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
        EntFireByHandle(snd, "Volume", "10", 0.02, null, null);
    }
    EntFireByHandle(ent, "Kill", "", 0.00, null, null);
    EntFire("treasure_box_spotlight", "LightOff", "", 0.50);
    EntFire("treasure_box_light", "TurnOff", "", 0.50);
    EntFire("treasure_box", "SetAnimationNoReset", "close",0.00);
    local box = Entities.FindByName(null, "treasure_box");
    box.__KeyValueFromInt("rendermode",1);
    EntFire("Script", "RunScriptCode", "Box_Move()", 1.00);
}

::Box_Move <- function() {
    local box = null;
    local ori = null;
    box = Entities.FindByName(null, "treasure_box");
    if (box != null) {
    local ori = box.GetOrigin();
    if (box.GetOrigin().z < WeaponPos[11].z) {
        box.SetOrigin(Vector(ori.x,ori.y,ori.z+2));
        if (box_alpha > 5) {
            box_alpha -= 5;
            box.__KeyValueFromInt("renderamt",box_alpha);
        }
    }
    else {
        EntFireByHandle(box, "Disable","", 0.00, null, null);
        box.SetOrigin(WeaponPos[10]);
        EntFire("Script", "RunScriptCode", "box_comeback()", 150.00);
        return;
    }
    EntFire("Script", "RunScriptCode", "Box_Move()", 0.02);
    }
}

::box_comeback <- function () {
    local box = null;
    local ori = null;
    box = Entities.FindByName(null, "treasure_box");
    if (box != null) {
        if (box_alpha < 255) {
            box_alpha += 5;
            box.__KeyValueFromInt("renderamt",box_alpha);
        }
        else {
            box.__KeyValueFromInt("rendermode",0);
            EntFire("Script", "RunScriptCode", "BoxRest()", 0.10);
            EntFireByHandle(box, "Enable","", 0.00, null, null);
            isgone = false;
            /*local boxsnd = Entities.FindByName(null, "treasure_box_snd");
            local file = map_snd[11];
            boxsnd.__KeyValueFromString("message", file);
            EntFireByHandle(boxsnd, "PlaySound", "", 0.00, null, null);
            EntFireByHandle(boxsnd, "Volume", "7", 0.01, null, null);*/
            return;
        }
    }
    EntFire("Script", "RunScriptCode", "box_comeback()", 0.05);
}

::GiveCaseWep <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    EntFire("treasure_box_relay", "CancelPending");
    local button = null;
    local within = null;
    button = Entities.FindByName(null, "treasure_box");
    for (local o=0;o<Player.len();o++) {
    within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),64);
    if (WepReady && p.GetTeam()==3 && within != null && within == p) {
        local ent = null;
        ent = Entities.FindByName(null, "casemodel");
        for (local i=0;i<CaseList.len();i++) {
            if (ent.GetModelName() == CaseList[i]) {
                local wep = WeaponList[i].slice(7,WeaponList[i].len());
                printl("weaponname>"+wep);
                if (wep=="ak47" || wep=="galilar" || wep=="sg556" || wep=="sawedoff" || wep=="glock") {
                    p.__KeyValueFromInt("teamnumber",2);
                    EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
                }
                if (wep=="deagle") {
                    EntFire("@Ammo", "GiveAmmo", "", 0.00, p);
                }
            for (local c=0;c<Primary.len();c++) {
                if (wep == Primary[c]) {
                    Player[id][35] = wep;
                }
            }
            //EntFire("@equip", "TriggerForActivatedPlayer", WeaponList[i], 0.00, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt(""+WeaponList[i], 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("treasure_box_spotlight", "LightOff");
            EntFire("treasure_box_light", "TurnOff");
            EntFire("treasure_box", "SetAnimationNoReset", "close",0.10);
//            EntFire("treasure_box", "SetDefaultAnimation", "idle",0.80);
            ent.Destroy();
            WepReady = false;
            EntFire("Script", "RunScriptCode", "BoxRest()", 2.00);
            return;
            }
        }
    }
    else {
        continue;
    }
    }
   
}

::ResetTeam <- function () {
    local p = activator;
    p.__KeyValueFromInt("teamnumber", 3);
}

::Timelimit <- function () {
    WepReady = false;
    EntFire("Script", "RunScriptCode", "WepAct_B()");
}

::WepAct_B <- function () {
    local ent = null;
    ent = Entities.FindByName(null, "casemodel");
    if (ent != null) {
    local ori = ent.GetOrigin();
    if (ent.GetOrigin().z > WeaponPos[0].z) {
        ent.SetOrigin(Vector(ori.x,ori.y,ori.z-2));
    }
    else {
        ent.Destroy();
        EntFire("treasure_box_spotlight", "LightOff", "", 0.60);
        EntFire("treasure_box_light", "TurnOff", "", 0.60);
        EntFire("treasure_box", "SetAnimationNoReset", "close",0.10);
//        EntFire("treasure_box", "SetDefaultAnimation", "idle",0.80);
        EntFire("Script", "RunScriptCode", "BoxRest()", 2.00);
        return;
    }
    EntFire("Script", "RunScriptCode", "WepAct_B()", 0.01);
    }
}


::BoxRest <- function () {
    BoxLock = false;
}


::WepShopModelList <- [
    "models/weapons/w_shot_nova.mdl",//0
    "models/weapons/w_pist_tec9.mdl",//1
    "models/weapons/w_shot_xm1014.mdl",//2
    "models/weapons/w_smg_mac10.mdl",//3
    "models/weapons/w_rif_famas.mdl",//4
    "models/weapons/w_shot_sawedoff.mdl",//5
    "models/weapons/w_eq_fraggrenade.mdl",///6
    "models/weapons/w_eq_healthshot.mdl",//7
    "models/weapons/11/m18mine_prop.mdl",//8
    "models/weapons/w_eq_sensorgrenade.mdl",//9
    "models/weapons/w_eq_armor.mdl"//10
];

::SensorCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "SensorCost"
    local text = item_text[1][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "sensor_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),24)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "SensorCost()", 0.15);
    }
}

::GiveSensor <- function () {
    local p = activator,id;
    local within = null;
    local button = null;
    local cost = 100;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_sensor";
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        local eqnum =  Player_Missile[id];
        button = Entities.FindByName(null, "sensor_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),24);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
                if (eqnum!=6) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            equip.__KeyValueFromInt("weapon_tagrenade", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            local eqnum =  Player_Missile[id];
            if (eqnum != 6) {
                Player_Missile[id] = 6;
            }
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[13],WepShopModelList[9],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,-180,0);
            EntFire("Script", "RunScriptCode", "SensorMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[55][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[60][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            }
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

::SensorMoveOut <- function () {
    local name = "wall_sensor";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y > 551) {
        ent.SetOrigin(Vector(ori.x,ori.y-0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "SensorMoveOut()",0.05);
}

::NovaCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "NovaCost"
    local text = item_text[2][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "nova_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "NovaCost()", 0.15);
    }
}

::GiveNova <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    local within = null;
    local button = null;
    local cost = 600;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_nova";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "nova_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_nova", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = name.slice(5,name.len());
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[2],WepShopModelList[0],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,-180,0);
            EntFire("Script", "RunScriptCode", "NovaMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[4][m_lang]);
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

::NovaMoveOut <- function () {
    local name = "wall_nova";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y > 687) {
        ent.SetOrigin(Vector(ori.x,ori.y-0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "NovaMoveOut()",0.05);
}

::TEC9Cost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "TEC9Cost"
    local text = item_text[3][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "tec9_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "TEC9Cost()", 0.15);
    }
}

::GiveTEC9 <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    local within = null;
    local button = null;
    local cost = 300;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_tec9";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "tec9_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            p.__KeyValueFromInt("teamnumber",2);
            EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_tec9", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[3],WepShopModelList[1],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,-180,0);
            EntFire("Script", "RunScriptCode", "TEC9MoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[5][m_lang]);
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

::TEC9MoveOut <- function () {
    local name = "wall_tec9";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y > 575) {
        ent.SetOrigin(Vector(ori.x,ori.y-0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "TEC9MoveOut()",0.05);
}

::XM1014Cost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "XM1014Cost"
    local text = item_text[4][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "xm1014_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "XM1014Cost()", 0.15);
    }
}

::GiveXM1014 <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    local within = null;
    local button = null;
    local cost = 1200;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_xm1014";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "xm1014_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_xm1014", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = name.slice(5,name.len());
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[4],WepShopModelList[2],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,0,0);
            EntFire("Script", "RunScriptCode", "XM1014MoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[6][m_lang]);
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

::XM1014MoveOut <- function () {
    local name = "wall_xm1014";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y < -383) {
        ent.SetOrigin(Vector(ori.x,ori.y+0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "XM1014MoveOut()",0.05);
}


::MAC10Cost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "MAC10Cost"
    local text = item_text[5][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "mac10_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "MAC10Cost()", 0.15);
    }
}

::GiveMAC10 <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    local within = null;
    local button = null;
    local cost = 1000;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_mac10";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "mac10_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            p.__KeyValueFromInt("teamnumber",2);
            EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_mac10", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = name.slice(5,name.len());
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[5],WepShopModelList[3],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,90,0);
            EntFire("Script", "RunScriptCode", "MAC10MoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[7][m_lang]);
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


::MAC10MoveOut <- function () {
    local name = "wall_mac10";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.x > 727) {
        ent.SetOrigin(Vector(ori.x-0.5,ori.y,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "MAC10MoveOut()",0.05);
}

::FAMASCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "FAMASCost"
    local text = item_text[6][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "famas_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "FAMASCost()", 0.15);
    }
}

::GiveFAMAS <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    local within = null;
    local button = null;
    local cost = 1800;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_famas";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "famas_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_famas", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = name.slice(5,name.len());
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[6],WepShopModelList[4],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,180,0);
            EntFire("Script", "RunScriptCode", "FAMASMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[8][m_lang]);
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

::FAMASMoveOut <- function () {
    local name = "wall_famas";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y > 687) {
        ent.SetOrigin(Vector(ori.x,ori.y-0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "FamasMoveOut()",0.05);
}

::SawedoffCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "SawedoffCost"
    local text = item_text[7][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "sawedoff_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "SawedoffCost()", 0.15);
    }
}

::GiveSawedoff <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    local within = null;
    local button = null;
    local cost = 1500;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_sawedoff";
    if (p.GetTeam() == 3) {
        button = Entities.FindByName(null, "sawedoff_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            p.__KeyValueFromInt("teamnumber",2);
            EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_sawedoff", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = name.slice(5,name.len());
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[7],WepShopModelList[5],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,90,0);
            EntFire("Script", "RunScriptCode", "SawedoffMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[9][m_lang]);
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

::SawedoffMoveOut <- function () {
    local name = "wall_sawedoff";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.x > 815) {
        ent.SetOrigin(Vector(ori.x-0.5,ori.y,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "SawedoffMoveOut()",0.05);
}

::SSG08_Cabinet <- false;
::SSG08Open <- function () {
    EntFire("furniture", "SetAnimationNoReset", "doorsopening");
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "map_world_sound");
    if (snd != null) {
        //EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        //EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file = map_snd[14];
        snd.SetOrigin(Vector(669,83,190));
        //snd.__KeyValueFromString("message", file);
        EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
    }
    EntFire("Script", "RunScriptCode", "SSG08OpenDone()",1.00);
}
::SSG08OpenDone <- function () {
    SSG08_Cabinet = true;
    SSG08Cost();
}
::SSG08Cost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "ssg08Cost"
    local text = item_text[8][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "ssg08_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "SSG08Cost()", 0.15);
    }
}

::GiveSSG08 <- function () {
    local p = activator,id;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == p) {
            id = i;
            break;
        }
    }
    
    if (SSG08_Cabinet) {
    local ent = null;
    local within = null;
    local cost = 1000;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    if (p.GetTeam() == 3) {
        ent = Entities.FindByName(null, "ssg08_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            PointChange(id,cost,0);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_ssg08", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            Player[id][35] = "ssg08";
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[10][m_lang]);
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
    else {
        SSG08Open();
    }
}


::FragGrenadeCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "FragCost"
    local text = item_text[9][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "grenade_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "FragGrenadeCost()", 0.15);
    }
}

::GiveFragGrenade <- function () {
    local p = activator;
    local within = null;
    local button = null;
    local id = null;
    local cost = 300;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_grenade";
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        local eqnum =  Player_Missile[id];
        button = Entities.FindByName(null, "grenade_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
                if (eqnum!=6) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            //EntFire("@equip", "TriggerForActivatedPlayer", "weapon_hegrenade", 0.00, p);
            //EntFire("@equip_frag", "Use", "", 0.00, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_hegrenade", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            local eqnum =  Player_Missile[id];
            if (eqnum != 6) {
                Player_Missile[id] += 1;
            }
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[8],WepShopModelList[6],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            ent.SetAngles(0,0,0);
            EntFire("Script", "RunScriptCode", "FragMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[11][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[60][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            } 
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
::FragMoveOut <- function () {
    local name = "wall_grenade";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.x < -258) {
        ent.SetOrigin(Vector(ori.x+0.5,ori.y,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "FragMoveOut()",0.05);
}

::HealthShotCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "healthshotCost"
    local text = item_text[10][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "healthshot_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "HealthShotCost()", 0.15);
    }
}

::GiveHealthShot <- function () {
    local p = activator;
    local within = null;
    local button = null;
    local id = null;
    local cost = 400;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_healthshot";
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        button = Entities.FindByName(null, "healthshot_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
                local shot = null;
                while ((shot = Entities.FindByClassname(shot, "weapon_healthshot")) != null) {
                    if (shot.GetOwner() == p) {
                        local ent = null;
                        ent = Entities.CreateByClassname("env_hudhint");
                        ent.__KeyValueFromString("message",event_msg[61][m_lang]);
                        ent.SetOwner(p);
                        EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                        EntFireByHandle(ent, "Kill", "", 0.01, null, null);
                        return;
                    }
                }
                local ent = null;
                ent = Entities.FindByName(null, name);
                PointChange(id,cost,0);
                local equip = Entities.CreateByClassname("game_player_equip");
                equip.__KeyValueFromInt("spawnflags", 5);
                equip.__KeyValueFromInt("weapon_healthshot", 1);
                equip.__KeyValueFromInt("weapon_healthshot", 1);
                EntFireByHandle(equip, "Use", "", 0.00, p, null);
                EntFireByHandle(equip, "Kill", "", 0.01, null, null);
                EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
                if (ent == null) {
                    ent = CreateProp("prop_dynamic",WeaponPos[9],WepShopModelList[7],0);
                    EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
                    ent.SetAngles(0,0,0);
                    EntFire("Script", "RunScriptCode", "HealthShotMoveOut()",0.10);
                }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[12][m_lang]);
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
::HealthShotMoveOut <- function () {
    local name = "wall_healthshot";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.y > 537) {
        ent.SetOrigin(Vector(ori.x,ori.y-0.5,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "HealthShotMoveOut()",0.05);
}

::VestCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "VestCost"
    local text = item_text[11][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "vest_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),28)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "VestCost()", 0.15);
    }
}

::MineCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "MineCost"
    local text = item_text[12][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "mine_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "MineCost()", 0.15);
    }
}

::GiveMine <- function () {
    local p = activator;
    local within = null;
    local button = null;
    local id = null;
    local cost = 350;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_mine";
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        local eqnum =  Player_Missile[id];
        button = Entities.FindByName(null, "mine_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
                if (eqnum!=6) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            //EntFire("@equip_decoy", "Use", "", 0.00, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("weapon_decoy", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            local eqnum =  Player_Missile[id];
            if (eqnum != 6) {
                Player_Missile[id] += 1;
            }
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[12],WepShopModelList[8],0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            EntFire("Script", "RunScriptCode", "MineMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[45][m_lang]);
            }
            else {
                local ent = null;
                ent = Entities.CreateByClassname("env_hudhint");
                ent.__KeyValueFromString("message",event_msg[60][m_lang]);
                ent.SetOwner(p);
                EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
                EntFireByHandle(ent, "Kill", "", 0.01, null, null);
            }
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

::MineMoveOut <- function () {
    local name = "wall_mine";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.x > 367) {
        ent.SetOrigin(Vector(ori.x-0.5,ori.y,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "MineMoveOut()",0.05);
}

::GiveVest <- function () {
    local p = activator;
    local within = null;
    local button = null;
    local id = null;
    local cost = 200;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "wall_vest";
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        button = Entities.FindByName(null, "vest_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            ent = Entities.FindByName(null, name);
            PointChange(id,cost,0);
            //EntFire("@Equip", "TriggerForActivatedPlayer", "item_kevlar", 0.00, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt("item_kevlar", 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            if (ent == null) {
            ent = CreateProp("prop_dynamic",WeaponPos[14],WepShopModelList[10],0);
            ent.SetAngles(0,180,0);
            EntFireByHandle(ent, "AddOutput", "targetname "+name, 0.00, null, null);
            EntFire("Script", "RunScriptCode", "VestMoveOut()",0.10);
            }
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[23][m_lang]);
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

::VestMoveOut <- function () {
    local name = "wall_vest";
    local ent = null;
    ent = Entities.FindByName(null, name);
    local ori = ent.GetOrigin();
    if (ori.x > 810) {
        ent.SetOrigin(Vector(ori.x-1.0,ori.y,ori.z));
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "VestMoveOut()",0.05);
}

::AmmoCost <- function (n) {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "AmmoCost"
    local text = item_text[13][m_lang];
    local tl = null;
    ent = Entities.FindByName(null, "ammo_button_"+n);
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "AmmoCost("+n+")", 0.10);
    }
}

::GiveAmmo <- function (n) {
    local p = activator;
    local within = null;
    local button = null;
    local id = null;
    local cost = 200;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    if (p.GetTeam() == 3) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        button = Entities.FindByName(null, "ammo_button_"+n);
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),32);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            PointChange(id,cost,0);
            EntFire("@Ammo", "GiveAmmo", "", 0.00, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[9], 0.00, p);
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[24][m_lang]);
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



::DropProp_Delay <- function (type,slot) {
    local p = activator;
    local ent = null;
    local light = null;
    local pos = p.GetOrigin();
    local name = null;
    local name_2 = null;
    local color = null;
    if (type==0) {
        name = "2xPoint";
        color = "0 255 255 255";
    }
    else if (type==1) {
        name = "hp";
        color = "255 49 49 255";
    }
    else if (type==2) {
        name = "ammo";
        color = "255 128 0 255";
    }
    else if (type==3) {
        name = "money";
        color = "255 255 0 255";
    }
    else if (type==4) {
        name = "nuke";
        color = "255 0 0 255";
    }
    else if (type==5) {
        name = "carpenter";
        color = "128 64 0 255";
    }
    else if (type==6) {
        name = "deathmachine";
        color = "254 77 1 255";
    }
        name_2 = "Drop_Prop_Light";
        ent = Entities.FindByName(null, name);
        ent.__KeyValueFromString("targetname",name+"_ready");
        light = Entities.FindByName(null, name_2);
        light.__KeyValueFromString("targetname",name_2+"_ready");
        light.__KeyValueFromString("_light",color);
        DropProp_Space[slot] = ent;
        DropProp_Light_Space[slot] = light;
        printl("prop_create_complete!");

        ent.SetOrigin(Vector(pos.x,pos.y,pos.z-15));
        light.SetOrigin(Vector(pos.x,pos.y,pos.z-10));
        EntFireByHandle(ent, "ShowSprite", "", 0.01, null, null);
        EntFire("Script", "RunScriptCode", "Drop_Prop_Dis("+type+" "+slot+" 20)", 0.00);
        EntFire("Script", "RunScriptCode", "Check_DropProp_Invalid()", 0.10);
        local snd,snd_2;
        local file,file_2;
        snd = Entities.FindByName(null, "map_world_sound");
        snd_2 = Entities.FindByName(null, "map_world_loop_sound_"+slot);
        if (snd != null) {
            file = item_snd[27];
            file_2 = item_snd[28];
            snd.SetOrigin(pos);
            snd_2.SetOrigin(pos);
            EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
            EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
            EntFireByHandle(snd_2, "Addoutput", "message "+file_2, 0.02, null, null);
            EntFireByHandle(snd_2, "PlaySound", "", 0.03, null, null);
            EntFireByHandle(snd_2, "Volume", "2", 0.04, null, null);
        }
        PickUpProp(type,slot);
}


::Check_DropProp_Invalid <- function () {
    local name_1 = null;
    local name_2 = null;
    local name_3 = null;
    local name_4 = null;
    local name_5 = null;
    local name_6 = null;
    local name_7 = null;
    local name_8 = null;
    local ent_1 = null;
    local ent_2 = null;
    local ent_3 = null;
    local ent_4 = null;
    local ent_5 = null;
    local ent_6 = null;
    local ent_7 = null;
    local ent_8 = null;
    name_1 = "2xPoint_ready"
    name_2 = "hp_ready"
    name_3 = "ammo_ready"
    name_4 = "money_ready";
    name_5 = "nuke_ready";
    name_6 = "carpenter_ready";
    name_7 = "deathmachine_ready";
    name_8 = "Drop_Prop_Light_ready";

    while ((ent_1 = Entities.FindByName(ent_1, name_1)) != null) {
        if (ent_1 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_1) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_1.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_2 = Entities.FindByName(ent_2, name_2)) != null) {
        if (ent_2 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_2) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_2.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_3 = Entities.FindByName(ent_3, name_3)) != null) {
        if (ent_3 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_3) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_3.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_4 = Entities.FindByName(ent_4, name_4)) != null) {
        if (ent_4 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_4) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_4.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_5 = Entities.FindByName(ent_5, name_5)) != null) {
        if (ent_5 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_5) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_5.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_6 = Entities.FindByName(ent_6, name_6)) != null) {
        if (ent_6 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_6) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_6.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_7 = Entities.FindByName(ent_7, name_7)) != null) {
        if (ent_7 != null) {
            for (local i=0;i<DropProp_Space.len();i++) {
                if (DropProp_Space[i] == ent_7) {
                    break;
                }
                else {
                    if (i==DropProp_Space.len()-1) {
                        ent_7.Destroy();
                        break;
                    }
                }
            }
        }
    }
    while ((ent_8 = Entities.FindByName(ent_8, name_8)) != null) {
        if (ent_8 != null) {
            for (local i=0;i<DropProp_Light_Space.len();i++) {
                if (DropProp_Light_Space[i] == ent_8) {
                    break;
                }
                else {
                    if (i==DropProp_Light_Space.len()-1) {
                        ent_8.Destroy();
                        break;
                    }
                }
            }
        }
    }
}

::weapon_save <- [null,null,null,null,null,null];
::isNuke <- false;
::PickUpProp <- function (type,slot) {
    local p = null;
    local steamid = null;
    local jugga = null;
    local pos = null;
    local ent = null;
    local light = null;
    ent = DropProp_Space[slot];
    light = DropProp_Light_Space[slot];
    local nearest = null;
    local sc = null;
    local id = null;
    local snd,snd_2;;
    local file;
    snd = Entities.FindByName(null, "map_world_sound");
    snd_2 = Entities.FindByName(null, "map_world_loop_sound_"+slot);
    if (snd != null) {
        file = item_snd[29];
    }
    if (ent != null) {
        pos = ent.GetOrigin();
    }
    if (type==0) {
        if (ent != null && ent.GetName() == "2xPoint_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] == "none") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    EntFire("clientcommand", "command", "play "+item_snd[10], 0.00, nearest);
                    Player[id][22] = "2xPoint";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                    Count_Switch[id] = true;
                    EntFire("Script", "RunScriptCode", "Count_Down("+id+")", 0.10);
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[16][m_lang]);
                    printl("picked up");
                    }
                    else if (Player[id][22] == "deathmachine") {
                        local msg = null;
                        msg = Entities.CreateByClassname("env_hudhint");
                        msg.__KeyValueFromString("message",event_msg[62][m_lang]);
                        msg.SetOwner(nearest);
                        EntFireByHandle(msg, "ShowHudHint", "", 0.00, nearest, null);
                        EntFireByHandle(msg, "Kill", "", 0.01, null, null);
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==1) {
        if (ent != null && ent.GetName() == "hp_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && Player[id][22] != "2xPoint_nuke") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    //EntFire("clientcommand", "command", "play "+item_snd[21], 0.00, nearest);
                    EntFire("clientcommand", "command", "play items/medshot4.wav", 0.00, nearest); //gf
                    if (Player[id][22] == "none") {
                    Player[id][22] = "hp";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                    }
                    else if (Player[id][22] == "2xPoint") {
                         Player[id][22] = "2xPoint_hp";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    else if (Player[id][22] == "deathmachine") {
                         Player[id][22] = "deathmachine_hp";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    jugga = Player[id][29];
                    /*steamid = Get32IDByUserid(sc.userid);
                    if (steamid.tostring() == author_steam_32id || steamid.tostring() == contributor_steam_32id) {
                        if (!jugga) {
                            p.SetHealth(author_health);
                        }
                        else {
                            p.SetHealth(author_health+1000);
                        }
                    }*/
                     if (!jugga) {
                        //if (Player_Valid_number < 4) {
                        //    p.SetHealth(Player_Health_LOWPLAYER);
                        //}
                        //else {
                            p.SetHealth(Player_Health);
                        //}
                    }
                    //else {
                        //if (Player_Valid_number < 4) {
                        //    p.SetHealth(Player_BigHealth_LOWPLAYER);
                        //}
                        //else {
                           // p.SetHealth(Player_BigHealth);
                        //}
                    //}
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[17][m_lang]);
                    printl("picked up");
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==2) {
        if (ent != null && ent.GetName() == "ammo_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && Player[id][22] != "2xPoint_nuke") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    //EntFire("clientcommand", "command", "play items/battery_pickup.mp3", 0.00, nearest);
                    EntFire("point_clientcommand", "Command", "play "+item_snd[8], 0.00, nearest);
                    if (Player[id][22] == "none") {
                    Player[id][22] = "ammo";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                     }
                    else if (Player[id][22] == "2xPoint") {
                         Player[id][22] = "2xPoint_ammo";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    else if (Player[id][22] == "deathmachine") {
                         Player[id][22] = "deathmachine_ammo";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    local entity = null;
                    local equip = null;
                    for (entity = Entities.First();entity != null;entity = Entities.Next(entity)) {
                        if(entity.GetClassname().find("weapon_", 0) != null && entity.GetMoveParent() == p) {
                            //printl("ent>"+entity);
                            if (entity.GetClassname() != "weapon_knife") {
                                local wep = null;
                                wep = entity.GetClassname().slice(7,entity.GetClassname().len());
                                if (wep=="ak47" || wep=="galilar" || wep=="sg556" || wep=="sawedoff") {
                                    p.__KeyValueFromInt("teamnumber",2);
                                    EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
                                }
                                if (wep=="negev" || wep=="hegrenade" || wep=="decoy" || wep=="tagrenade" || wep=="healthshot") {
                                    //return;
                                    continue;
                                }
                                //EntFire("@equip", "TriggerForActivatedPlayer", ""+entity.GetClassname(),0.00, p);
                                equip = Entities.CreateByClassname("game_player_equip");
                                equip.__KeyValueFromInt("spawnflags", 5);
                                equip.__KeyValueFromInt(""+entity.GetClassname(), 1);
                                EntFireByHandle(equip, "Use", "", 0.00, p, null);
                                EntFireByHandle(equip, "Kill", "", 0.01, null, null);
                                EntFire("@ammo", "GiveAmmo", "", 0.01, p);
                                EntFire("clientcommand", "command", "slot1", 0.01, p);
                                //local eqnum =  Player_Missile[id];
                                //if (eqnum != 0) {
                                //    Player_Missile[id] = 6;
                                //}
                            }
                            //Firing_times[id] = 0;
                        }
                        else {
                            //printl("skip");
                            continue;
                        }
                    }
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    self.EmitSound(item_snd[22]);
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[18][m_lang]);
                    printl("picked up");
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==3) {
        if (ent != null && ent.GetName() == "money_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && Player[id][22] != "2xPoint_nuke") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    EntFire("clientcommand", "command", "play items/battery_pickup.wav", 0.00, nearest); //gf
                    if (Player[id][22] == "none") {
                    Player[id][22] = "money";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                     }
                    else if (Player[id][22] == "2xPoint") {
                         Player[id][22] = "2xPoint_money";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    else if (Player[id][22] == "deathmachine") {
                         Player[id][22] = "deathmachine_money";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    local money = 500;
                    PointChange(id,money,1);
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[19][m_lang]);
                    printl("picked up");
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==4) {
        if (ent != null && ent.GetName() == "nuke_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && Player[id][22] != "2xPoint_nuke") {
                    isNuke = true;
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    //EntFire("clientcommand", "command", "play "+item_snd[11], 0.00, nearest);
                    local snd_l = null;
                    local file_l = null;
                    snd_l = Entities.FindByName(null, "Global_Sound");
                    if (snd_l != null) {
                        file_l = item_snd[11];
                        snd_l.__KeyValueFromString("message", file_l);
                        self.EmitSound(item_snd[23]);
                        EntFireByHandle(snd_l, "PlaySound", "", 0.30, null, null);
                        EntFireByHandle(snd_l, "Volume", "10", 0.31, null, null);
                    }
                    //self.EmitSound(item_snd[11]);
                    if (Player[id][22] == "none") {
                    Player[id][22] = "nuke";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                     }
                    else if (Player[id][22] == "2xPoint") {
                         Player[id][22] = "2xPoint_nuke";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    else if (Player[id][22] == "deathmachine") {
                         Player[id][22] = "deathmachine_nuke";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    local fade = null;
                    fade = Entities.CreateByClassname("env_fade");
                    fade.__KeyValueFromInt("spawnflags", 1);
                    fade.__KeyValueFromInt("duration", 3);
                    fade.__KeyValueFromInt("ReverseFadeDuration", 3);
                    fade.__KeyValueFromInt("holdtime", 0);
                    fade.__KeyValueFromInt("renderamt", 155);
                    fade.__KeyValueFromString("rendercolor", "242 242 242");
                    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
                    EntFireByHandle(fade, "Kill", "", 1.00, null, null);
                    local hurt = null;
                    local tg = "BOT_ID"//"BOT_ID*";
                    local num = 0.00;
                    for (local i=0;i<BOT.len();i++) {
                        num += 0.01;
                        hurt = Entities.CreateByClassname("point_hurt");
                        hurt.__KeyValueFromInt("DamageRadius", 50);
                        hurt.__KeyValueFromInt("DamageType", 0);
                        hurt.__KeyValueFromInt("Damage", 99999);
                        hurt.__KeyValueFromString("DamageTarget", tg+i);
                        hurt.__KeyValueFromFloat("DamageDelay", 0.1);
                        EntFireByHandle(hurt, "Hurt", "", 0.19+num, null, null);
                        EntFireByHandle(hurt, "Kill", "", 0.20+num, null, null);
                    }
                    Wave_Num = 0;
                    Standby_Num = null;
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    EntFire("Script", "RunScriptCode", "Wave_Check()", 0.00);
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[20][m_lang]);
                    printl("picked up");
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==5) {
        if (ent != null && ent.GetName() == "carpenter_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && Player[id][22] != "2xPoint_nuke" && Player[id][22] != "2xPoint_carpenter") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    EntFire("clientcommand", "command", "play "+item_snd[19], 0.00, nearest);
                    local snd_l = null;
                    local file_l = null;
                    snd_l = Entities.FindByName(null, "Global_Sound");
                    if (snd_l != null) {
                        file_l = item_snd[20];
                        //snd.__KeyValueFromString("message", file);
                        EntFireByHandle(snd_l, "Addoutput", "message "+file_l, 0.00, null, null);
                        EntFireByHandle(snd_l, "PlaySound", "", 0.01, null, null);
                        EntFireByHandle(snd_l, "Volume", "8", 0.02, null, null);
                    }
                    if (Player[id][22] == "none") {
                    Player[id][22] = "carpenter";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                     }
                    else if (Player[id][22] == "2xPoint") {
                         Player[id][22] = "2xPoint_carpenter";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    else if (Player[id][22] == "deathmachine") {
                         Player[id][22] = "deathmachine_carpenter";
                         EntFire("Script", "RunScriptCode", "Dual_skills_Return("+id+")", 2.00);
                    }
                    snd.SetOrigin(pos);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    local t = 0;
                    for (local i=1;i<=12;i++) {
                        t += 0.5;
                        EntFire("Script", "RunScriptCode", "fixbarr("+i+")", t);
                        EntFire("Script", "RunScriptCode", "fixbarr("+i+")", t+0.1);
                        EntFire("Script", "RunScriptCode", "fixbarr("+i+")", t+0.2);
                    }
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[21][m_lang]);
                    printl("picked up");
                    }
                }
            }
        }
        else {
            return;
        }
    }
    else if (type==6) {
        if (ent != null && ent.GetName() == "deathmachine_ready") {
            nearest = Entities.FindByClassnameNearest("player",ent.GetOrigin(),70);
            if (nearest != null && nearest.IsValid()) {
                if (nearest.GetTeam() == 3) {
                    for (local i=0;i<Player.len();i++) {
                        if (Player[i][0] == nearest) {
                            id = i;
                            p = nearest;
                            break;
                        }
                    }
                    sc = nearest.GetScriptScope();
                    if (Player[id][22]  == "none") {
                    ent.Destroy();
                    light.Destroy();
                    DropProp_Space[slot] = null;
                    DropProp_Light_Space[slot] = null;
                    EntFire("clientcommand", "command", "play "+item_snd[24], 0.00, nearest);
                    Player[id][22] = "deathmachine";
                    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")",0.10);
                    Count_Switch[id] = true;
                    EntFire("Script", "RunScriptCode", "Count_Down("+id+")", 0.10);
                    EntFireByHandle(snd, "Addoutput", "message "+file, 0.00, null, null);
                    EntFireByHandle(snd, "PlaySound", "", 0.01, null, null);
                    EntFireByHandle(snd_2, "StopSound", "", 0.05, null, null);
                    EntFireByHandle(snd_2, "Volume", "0", 0.05, null, null);
                    local entity = null;
                    weapon_save[id] = null;
                    for (entity = Entities.First();entity != null;entity = Entities.Next(entity)) {
                        if(entity.GetClassname().find("weapon_", 0) != null && entity.GetMoveParent() == p) {
                            //printl("ent>"+entity);
                            //if (entity.GetClassname() != (weapon_exclude)) {
                            //if (entity.GetModelName().slice(0,5) == "w_rif") {
                            if (entity.GetModelName().find("v_rif_", 14) != null || entity.GetModelName().find("v_shot_", 14) != null || 
                            entity.GetModelName().find("v_snip_", 14) != null || entity.GetModelName().find("v_smg_", 14) != null || 
                            entity.GetModelName().find("v_mach_", 14) != null) {
                            weapon_save[id] = entity.GetClassname();
                            //printl("save_weapon>"+entity.GetClassname());
                            break;
                            }
                            //else {
                            //    printl("no_primary");
                            //}
                        }
                    }
                    //EntFire("@equip", "TriggerForActivatedPlayer", "weapon_negev", 0.01, p);
                    local equip = Entities.CreateByClassname("game_player_equip");
                    equip.__KeyValueFromInt("spawnflags", 5);
                    equip.__KeyValueFromInt("weapon_negev", 1);
                    EntFireByHandle(equip, "Use", "", 0.00, p, null);
                    EntFireByHandle(equip, "Kill", "", 0.01, null, null);
                    Firing_times[id] = 0;
                    ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A "+event_msg[54][m_lang]);
                    printl("picked up");
                    }
                    else if (Player[id][22] == "2xPoint") {
                        local msg = null;
                        msg = Entities.CreateByClassname("env_hudhint");
                        msg.__KeyValueFromString("message",event_msg[62][m_lang]);
                        msg.SetOwner(nearest);
                        EntFireByHandle(msg, "ShowHudHint", "", 0.00, nearest, null);
                        EntFireByHandle(msg, "Kill", "", 0.01, null, null);
                    }
                }
            }
        }
        else {
            return;
        }
    }
    EntFire("Script", "RunScriptCode", "PickUpProp("+type+" "+slot+")",0.10);
}

::Dual_skills_Return <- function (id) {
    if (Player[id][23] != 30 && Player[id][23] != 0) {
        if (Player[id][22] != "none" && Player[id][22] != "deathmachine" && Player[id][22] != "deathmachine_hp" && Player[id][22] != "deathmachine_ammo" && 
        Player[id][22] != "deathmachine_money" && Player[id][22] != "deathmachine_nuke" && Player[id][22] != "deathmachine_carpenter") {
        Player[id][22] = "2xPoint";
        }
        else if (Player[id][22] != "none" && Player[id][22] != "2xPoint" && Player[id][22] != "2xPoint_hp" && Player[id][22] != "2xPoint_ammo" && Player[id][22] != "2xPoint_money" && 
        Player[id][22] != "2xPoint_nuke" && Player[id][22] != "2xPoint_carpenter") {
        Player[id][22] = "deathmachine";
        }
    }
}

::Drop_Prop_Dis <- function (type,slot,n) {
    local ent = null;
    local name = null;
    local light = null;
    local num = n;
    local snd;
    ent = DropProp_Space[slot];
    light = DropProp_Light_Space[slot];
    if (ent != null) {
    name = ent.GetName();
    }
    if (num==0 || name=="nuke_ready" && !Waveing) {
//        if (type==0) {
            if (ent != null) {
            ent.Destroy();
            light.Destroy();
            DropProp_Space[slot] = null;
            DropProp_Light_Space[slot] = null;
            snd = Entities.FindByName(null, "map_world_loop_sound_"+slot);
            EntFireByHandle(snd, "StopSound", "", 0.05, null, null);
            EntFireByHandle(snd, "Volume", "0", 0.05, null, null);
            printl("prop_clear");
            return;
            }
//        }
    }
    //printl("Drop_Prop_Dis>"+n+"/s");
    if (DropProp_Space[slot] != null && DropProp_Space[slot].IsValid()) {
    EntFire("Script", "RunScriptCode", "Drop_Prop_Dis("+type+" "+slot+" "+(num-1)+")", 1.00);
    }
    //else {
    //    printl("Drop_Prop_Dis>break");
    //}
}

::Player_Skill_Show <- function (id) {
    local p = Player[id][0];
    local ent = null;
    local name = "skillhint_id"+id;
    ent = Entities.FindByName(null,name);
    local text = null;
    local num = Player[id][23];
    if (!isOver && !end) {
    if (ent==null) {
    ent = Entities.CreateByClassname("game_text");
    ent.__KeyValueFromString("targetname",name);
    ent.__KeyValueFromInt("spawnflags",0);
    ent.__KeyValueFromString("color","240 110 0");
    ent.__KeyValueFromFloat("x",-0.72);
    ent.__KeyValueFromFloat("y",0.70);
    ent.__KeyValueFromInt("fadein",0);
    ent.__KeyValueFromInt("fadeout",0);
    ent.__KeyValueFromInt("holdtime",2);
    ent.__KeyValueFromInt("effect",0);
    ent.__KeyValueFromInt("channel",4);
    ent.SetOwner(p);
    }
    if (Player[id][22] == "2xPoint") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang];
    }
    else if (Player[id][22] == "hp") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[4][m_lang];
        Player[id][22] = "none"
        Player[id][23] = 0;
    }
    else if (Player[id][22] == "ammo") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[5][m_lang];
        Player[id][23] = 0;
    }
    else if (Player[id][22] == "money") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[6][m_lang];
        Player[id][23] = 0;
    }
    else if (Player[id][22] == "nuke") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[7][m_lang];
        Player[id][23] = 0;
    }
    else if (Player[id][22] == "carpenter") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[8][m_lang];
        Player[id][23] = 0;
    }
    else if (Player[id][22] == "deathmachine") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang];
    }

    else if (Player[id][22] == "2xPoint_hp") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[4][m_lang];
    }
    else if (Player[id][22] == "2xPoint_ammo") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[5][m_lang];
    }
    else if (Player[id][22] == "2xPoint_money") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[6][m_lang];
    }
    else if (Player[id][22] == "2xPoint_nuke") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[7][m_lang];
    }
    else if (Player[id][22] == "2xPoint_carpenter") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[8][m_lang];
    }

    else if (Player[id][22] == "deathmachine_hp") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[4][m_lang];
    }
    else if (Player[id][22] == "deathmachine_ammo") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[5][m_lang];
    }
    else if (Player[id][22] == "deathmachine_money") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[6][m_lang];
    }
    else if (Player[id][22] == "deathmachine_nuke") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[7][m_lang];
    }
    else if (Player[id][22] == "deathmachine_carpenter") {
        text = PlayerHudText[0][m_lang]+PlayerHudText[9][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[8][m_lang];
    }
    //else if (Player[id][22] == "2xPoint_deathmachine") {
    //    text = PlayerHudText[0][m_lang]+PlayerHudText[1][m_lang]+PlayerHudText[2][m_lang]+num+PlayerHudText[3][m_lang]+"\n"+PlayerHudText[9][m_lang];
    //}
    ent.__KeyValueFromString("message",text);
    if (p.GetHealth() > 0) {
        EntFire(name, "Display", "", 0.01, p);
    }
    if (Player[id][23] == 0) {
        Count_Switch[id] = false;
        //Player[id][22] = "none";
        //Player[id][23] = 30;
        EntFire("Script", "RunScriptCode", "Skill_Timer_Over_Delay_Tri("+id+")", 0.10);
        return;
    }
    EntFire("Script", "RunScriptCode", "Player_Skill_Show("+id+")", 0.10);
    }
}

::Skill_Timer_Over_Delay_Tri <- function (id) {
    local p = Player[id][0];
    local dm = Player[id][22];
    if (dm == "deathmachine" || dm == "deathmachine_hp" || dm == "deathmachine_ammo" || 
        dm == "deathmachine_money" || dm == "deathmachine_nuke" || dm == "deathmachine_carpenter") {
            local entity = null;
            for (entity = Entities.First();entity != null;entity = Entities.Next(entity)) {
                if(entity.GetClassname().find("weapon_", 0) != null && entity.GetMoveParent() == p) {
                    printl("ent>"+entity);
                    if (entity.GetClassname() == "weapon_negev") {
                        entity.Destroy();
                        EntFire("clientcommand", "command", "slot3", 0.00, p);
                        EntFire("clientcommand", "command", "slot1", 0.01, p);
                        break;
                    }
                }
            }
            local wpn = weapon_save[id];
            local s = null;
            if (wpn!=null) {
            s = wpn.slice(7,wpn.len());
            if (s=="ak47" || s=="galilar" || s=="sg556" || s=="sawedoff" || s=="glock") {
                p.__KeyValueFromInt("teamnumber",2);
                EntFire("Script", "RunScriptCode", "ResetTeam()", 0.01, p);
            }
            //EntFire("@equip", "TriggerForActivatedPlayer", wpn, 0.00, p);
            local equip = Entities.CreateByClassname("game_player_equip");
            equip.__KeyValueFromInt("spawnflags", 5);
            equip.__KeyValueFromInt(""+wpn, 1);
            EntFireByHandle(equip, "Use", "", 0.00, p, null);
            EntFireByHandle(equip, "Kill", "", 0.01, null, null);
            }
        }
        Player[id][22] = "none";
        Player[id][23] = 30;
}

::Count_Switch <- [false,false,false,false,false,false];
::Count_Down <- function (id) {
    if (Count_Switch[id]) {
        if (Player[id][23] != 0) {
        Player[id][23] -= 1;
        }
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "Count_Down("+id+")", 1.00);
}

::CheckNegev <- function () {
    local ent,p,id,dm;
    EntFire("Script", "RunScriptCode", "CheckNegev()", 1.00);
    while ((ent = Entities.FindByClassname(ent, "weapon_negev")) != null) {
        if (ent.IsValid()) {
            if (ent.GetMoveParent() != null) {
                p = ent.GetMoveParent();
                for (local i=0;i<Player.len();i++) {
                    if (Player[i][0] == p) {
                        id = i;
                        break
                    }
                }
                dm = Player[id][22];
                if (dm != "deathmachine" && dm != "deathmachine_hp" && dm != "deathmachine_ammo" && 
                    dm != "deathmachine_money" && dm != "deathmachine_nuke" && dm != "deathmachine_carpenter") {
                    ent.Destroy();
                    EntFire("clientcommand", "command", "slot3", 0.00, p);
                }
            }
        }
    }
}

::viewgod <- [false,false,false,false,false];
::JuggernogCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "JuggernogCost"
    local text = (m_lang == 0 ? "能量饮料:厚血 + 力量（大红） [费用:2500]" : "Juggernog: Increasing your health and attack power [Cost: 2500pts]"),text_2 = (m_lang == 0 ? "需要电力才能运作！" : "No Power");
    local tl = null;
    ent = Entities.FindByName(null, "juggernog_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),34)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    if (PowerRun) {
                        entb.__KeyValueFromString("message",text);
                    }
                    else {
                        entb.__KeyValueFromString("message",text_2);
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "JuggernogCost()", 0.15);
    }
}

::GiveJuggernog <- function () {

    local p = activator,id,egg,b;
    local pos = p.GetOrigin(),ang = p.GetAngles();
    local within = null;
    local button = null;
    local cost = 2500;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "drink_model_id_";
    local view,snd,file;
    local view_pos = Vector(206,301,206);//p.EyePosition() + p.GetForwardVector() * 30 + p.GetLeftVector() * 50;

    if (p.GetTeam() == 3 && PowerRun) {

        for (local i=0;i<Player.len();i++) {

            if (Player[i][0] == p) {

                id = i;
                break;

            }
        }

        if (!Player[id][29]) {

            button = Entities.FindByName(null, "juggernog_button");

            for (local o=0;o<Player.len();o++) {

                within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),34);

                if (within != null && within == p) {

                    if (Points[id] >= cost) {

                        local ent = null;

                        PointChange(id,cost,0);

                        EntFire("Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
                        EntFire("point_clientcommand", "Command", "slot3 ", 0.00, p);
                        EntFire("point_clientcommand", "Command", "slot2 ", 1.40, p);
                        EntFire("point_clientcommand", "Command", "play "+item_snd[30], 0.00, p);
                        EntFire("point_clientcommand", "Command", "play "+item_snd[31], 0.80, p);
                        EntFire("point_clientcommand", "Command", "play "+item_snd[32], 1.50, p);
                        //EntFire("point_clientcommand", "Command", "play "+item_snd[33], 1.70, p);
                        EntFire("point_clientcommand", "Command", "play "+item_snd[34], 1.70, p);

                        snd = Entities.FindByName(null, "map_world_player_sound_"+id);
                        file = item_snd[33];
                        snd.__KeyValueFromString("message", file);
                        snd.SetOrigin(pos);
                        EntFireByHandle(snd, "PlaySound", "", 2.00, null, null);
                        EntFireByHandle(snd, "Volume", "10", 2.01, null, null);

                        p.__KeyValueFromInt("rendermode",1);
                        p.__KeyValueFromInt("renderamt",0);
                        p.__KeyValueFromInt("disableflashlight",1);
                        p.__KeyValueFromInt("disableshadows",1);
                        p.__KeyValueFromInt("disableshadowdepth",1);
                        p.__KeyValueFromInt("disablereceiveshadows",1);

                        ent = CreateProp("prop_dynamic", pos, p.GetModelName(), 0);
                        ent.__KeyValueFromString("targetname", name+id);
                        ent.SetAngles(0,ang.y,0);

                        egg = Player[id][28];

                        if (Player[id][34] != "headcrab" && p.GetModelName()) {

                            EntFireByHandle(ent, "SetBodyGroup", "1", 0.00, null, null);

                        }

                        else if (p.GetModelName()) {

                            EntFireByHandle(ent, "SetBodyGroup", "6", 0.00, null, null);

                        }

                        else if (p.GetModelName() ) {

                            if (egg == "hibiki")

                                b = 2;

                            else if (egg == "verniy")

                                b = 3;

                            else if (egg == "akatsuki")

                                b = 0;

                            else if (egg == "ikazuchi")

                                b = 4;

                            else if (egg == "inazuma")

                                b = 6;

                            EntFireByHandle(ent, "SetBodyGroup", b.tostring(), 0.00, null, null);

                        }

                        EntFireByHandle(ent, "SetAnimation", "drink", 0.00, null, null);
                        view = Entities.FindByName(null, "character_view_id_"+id);
                        view.SetOrigin(Vector(view_pos.x,view_pos.y,view_pos.z-10));
                        view.SetAngles(-15,-55,0);
                        EntFireByHandle(view, "Enable", "", 0.00, p, null);
                        viewgod[id] = true;
                        EntFire("Script", "RunScriptCode", "viewgod["+id+"] = false", 1.50);
                        EntFireByHandle(view, "Disable", "", 1.40, p, null);
                        EntFire("juggernog_music", "PlaySound");
                        EntFire("Script", "RunScriptCode", "Jugg_Drinked("+id+")", 1.40);
                        ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[58][m_lang]);
                        
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
        else {
            local ent = null;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("message",event_msg[59][m_lang]);
            ent.SetOwner(p);
            EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
            EntFireByHandle(ent, "Kill", "", 0.01, null, null);
        }
    }
}

::Jugg_Drinked <- function (id) {
    local p = Player[id][0],steamid,sc;
    local mandown = Player[id][25];
    local jugg = Player[id][29],dtap = Player[id][30],
    stamin = Player[id][31],rev = Player[id][32];
    sc = p.GetScriptScope();
    EntFire("drink_model_id_"+id, "Kill");
    p.__KeyValueFromInt("rendermode",0);
    p.__KeyValueFromInt("renderamt",255);
    p.__KeyValueFromInt("disableflashlight",0);
    p.__KeyValueFromInt("disableshadows",0);
    p.__KeyValueFromInt("disableshadowdepth",0);
    p.__KeyValueFromInt("disablereceiveshadows",0);
    steamid = Get32IDByUserid(sc.userid);
    if (!mandown && p.GetHealth() > 0) {
        if (steamid.tostring() == author_steam_32id || steamid.tostring() == contributor_steam_32id) {
            p.SetHealth(author_health+1000);
            p.SetMaxHealth(author_health+1000);
        }
        else {
            if (Player_Valid_number < 4) {
                p.SetHealth(Player_BigHealth_LOWPLAYER);
                p.SetMaxHealth(Player_BigHealth_LOWPLAYER);
            }
            else {
                p.SetHealth(Player_BigHealth);
                p.SetMaxHealth(Player_BigHealth);
            }
        }
        Player[id][29] = true;
        local index = 0
        if (dtap && !stamin && !rev) {
            index = 2;
        }
        else if (stamin && !dtap && !rev) {
            index = 10;
        }
        else if (rev && !dtap && !stamin) {
            index = 11;
        }
        else if (dtap && stamin && !rev) {
            index = 5;
        }
        else if (dtap && rev && !stamin) {
            index = 6;
        }
        else if (stamin && rev && !stamin) {
            index = 12;
        }
        else if (stamin && rev && dtap) {
            index = 8;
        }
        else {
            index = 9;
        }
        SetPlayerScreen(id,index-1);
        //Player[id][33] = (index-1);
    }
    local stamin = Player[id][31];
    if (!stamin) {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
    }
    else {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p);
    }
}

::DoubletapCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "DoubletapCost"
    local text = (m_lang == 0 ? "能量饮料:射速（双伤） [费用:2000]" : "Double Damage Root Beer: Increasing the damage of fire [Cost: 2000pts]"),text_2 = (m_lang == 0 ? "需要电力才能运作！" : "No Power");
    local tl = null;
    ent = Entities.FindByName(null, "doubletap_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),34)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    if (PowerRun) {
                        entb.__KeyValueFromString("message",text);
                    }
                    else {
                        entb.__KeyValueFromString("message",text_2);
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "DoubletapCost()", 0.15);
    }
}

::GiveDoubletap <- function () {
    local p = activator,id,egg,b;
    local pos = p.GetOrigin(),ang = p.GetAngles();
    local within = null;
    local button = null;
    local cost = 2000;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "drink_model_id_";
    local view,snd,file;
    local view_pos = Vector(542,335,61);//p.EyePosition() + p.GetForwardVector() * 30 + p.GetLeftVector() * 50;
    if (p.GetTeam() == 3 && PowerRun) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        if (!Player[id][30]) {
        button = Entities.FindByName(null, "doubletap_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),34);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            PointChange(id,cost,0);
            EntFire("Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot3 ", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot2 ", 1.40, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[30], 0.00, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[31], 0.80, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[32], 1.50, p);
            //EntFire("point_clientcommand", "Command", "play "+item_snd[33], 1.70, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[37], 1.70, p);
            snd = Entities.FindByName(null, "map_world_player_sound_"+id);
            file = item_snd[33];
            snd.__KeyValueFromString("message", file);
            snd.SetOrigin(pos);
            EntFireByHandle(snd, "PlaySound", "", 2.00, null, null);
            EntFireByHandle(snd, "Volume", "10", 2.01, null, null);
            p.__KeyValueFromInt("rendermode",1);
            p.__KeyValueFromInt("renderamt",0);
            p.__KeyValueFromInt("disableflashlight",1);
            p.__KeyValueFromInt("disableshadows",1);
            p.__KeyValueFromInt("disableshadowdepth",1);
            p.__KeyValueFromInt("disablereceiveshadows",1);
            ent = CreateProp("prop_dynamic", pos, p.GetModelName(), 0);
            ent.__KeyValueFromString("targetname", name+id);
            ent.SetAngles(0,ang.y,0);
            egg = Player[id][28];
            if (Player[id][34] != "headcrab" && p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "2", 0.00, null, null);
            }
            else if (p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "7", 0.00, null, null);
            }
            else if (p.GetModelName() ) {
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
                EntFireByHandle(ent, "SetBodyGroup", b.tostring(), 0.00, null, null);
            }
            EntFireByHandle(ent, "SetAnimation", "drink", 0.00, null, null);
            view = Entities.FindByName(null, "character_view_id_"+id);
            view.SetOrigin(Vector(view_pos.x,view_pos.y,view_pos.z-10));
            view.SetAngles(-15,115,0);
            EntFireByHandle(view, "Enable", "", 0.00, p, null);
            viewgod[id] = true;
            EntFire("Script", "RunScriptCode", "viewgod["+id+"] = false", 1.50);
            EntFireByHandle(view, "Disable", "", 1.40, p, null);
            EntFire("dtap_music", "PlaySound");
            EntFire("Script", "RunScriptCode", "Dtap_Drinked("+id+")", 1.40);
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[63][m_lang]);
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
        else {
            local ent = null;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("message",event_msg[59][m_lang]);
            ent.SetOwner(p);
            EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
            EntFireByHandle(ent, "Kill", "", 0.01, null, null);
        }
    }
}

::Dtap_Drinked <- function (id) {
    local p = Player[id][0],steamid,sc;
    local mandown = Player[id][25];
    local jugg = Player[id][29],dtap = Player[id][30],
    stamin = Player[id][31],rev = Player[id][32];
    sc = p.GetScriptScope();
    EntFire("drink_model_id_"+id, "Kill");
    p.__KeyValueFromInt("rendermode",0);
    p.__KeyValueFromInt("renderamt",255);
    p.__KeyValueFromInt("disableflashlight",0);
    p.__KeyValueFromInt("disableshadows",0);
    p.__KeyValueFromInt("disableshadowdepth",0);
    p.__KeyValueFromInt("disablereceiveshadows",0);
    steamid = Get32IDByUserid(sc.userid);
    if (!mandown && p.GetHealth() > 0) {
        Player[id][30] = true;
        local index = 0;
        if (jugg && !stamin && !rev) {
            index = 2;
        }
        else if (stamin && !jugg && !rev) {
            index = 3;
        }
        else if (rev && !stamin && !jugg) {
            index = 4;
        }
        else if (jugg && stamin && !rev) {
            index = 5;
        }
        else if (jugg && rev && !stamin) {
            index = 6;
        }
        else if (stamin && rev && !jugg) {
            index = 7;
        }
        else if (stamin && rev && jugg) {
            index = 8;
        }
        else {
            index = 1;
        }
        SetPlayerScreen(id,index-1);
    }
    local stamin = Player[id][31];
    if (!stamin) {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
    }
    else {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p);
    }
}

::StaminupCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "StaminupCost"
    local text = (m_lang == 0 ? "能量饮料:耐力(跑速提升) [费用:2000]" : "Stamin-Up Soda: Increasing the sprinting speed [Cost: 2000pts]"),text_2 = (m_lang == 0 ? "需要电力才能运作！" : "No Power");
    local tl = null;
    ent = Entities.FindByName(null, "staminup_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),34)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    if (PowerRun) {
                        entb.__KeyValueFromString("message",text);
                    }
                    else {
                        entb.__KeyValueFromString("message",text_2);
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "StaminupCost()", 0.15);
    }
}

::GiveStaminup <- function () {
    local p = activator,id,egg,b;
    local pos = p.GetOrigin(),ang = p.GetAngles();
    local within = null;
    local button = null;
    local cost = 2000;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "drink_model_id_";
    local view,snd,file;
    local view_pos = Vector(-755,671,66);//p.EyePosition() + p.GetForwardVector() * 30 + p.GetLeftVector() * 50;
    if (p.GetTeam() == 3 && PowerRun) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        if (!Player[id][31]) {
        button = Entities.FindByName(null, "staminup_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),34);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            PointChange(id,cost,0);
            EntFire("Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot3 ", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot2 ", 1.40, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[30], 0.00, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[31], 0.80, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[32], 1.50, p);
            //EntFire("point_clientcommand", "Command", "play "+item_snd[33], 1.70, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[41], 1.70, p);
            snd = Entities.FindByName(null, "map_world_player_sound_"+id);
            file = item_snd[33];
            snd.__KeyValueFromString("message", file);
            snd.SetOrigin(pos);
            EntFireByHandle(snd, "PlaySound", "", 2.00, null, null);
            EntFireByHandle(snd, "Volume", "10", 2.01, null, null);
            p.__KeyValueFromInt("rendermode",1);
            p.__KeyValueFromInt("renderamt",0);
            p.__KeyValueFromInt("disableflashlight",1);
            p.__KeyValueFromInt("disableshadows",1);
            p.__KeyValueFromInt("disableshadowdepth",1);
            p.__KeyValueFromInt("disablereceiveshadows",1);
            ent = CreateProp("prop_dynamic", pos, p.GetModelName(), 0);
            ent.__KeyValueFromString("targetname", name+id);
            ent.SetAngles(0,ang.y,0);
            egg = Player[id][28];
            if (Player[id][34] != "headcrab" && p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "4", 0.00, null, null);
            }
            else if (p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "9", 0.00, null, null);
            }
            else if (p.GetModelName() ) {
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
                EntFireByHandle(ent, "SetBodyGroup", b.tostring(), 0.00, null, null);
            }
            EntFireByHandle(ent, "SetAnimation", "drink", 0.00, null, null);
            view = Entities.FindByName(null, "character_view_id_"+id);
            view.SetOrigin(Vector(view_pos.x,view_pos.y,view_pos.z-10));
            view.SetAngles(-15,-50,0);
            EntFireByHandle(view, "Enable", "", 0.00, p, null);
            viewgod[id] = true;
            EntFire("Script", "RunScriptCode", "viewgod["+id+"] = false", 1.50);
            EntFireByHandle(view, "Disable", "", 1.40, p, null);
            EntFire("stamin_music", "PlaySound");
            EntFire("Script", "RunScriptCode", "Stamin_Drinked("+id+")", 1.40);
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[64][m_lang]);
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
        else {
            local ent = null;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("message",event_msg[59][m_lang]);
            ent.SetOwner(p);
            EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
            EntFireByHandle(ent, "Kill", "", 0.01, null, null);
        }
    }
}

::Stamin_Drinked <- function (id) {
    local p = Player[id][0],steamid,sc;
    local mandown = Player[id][25];
    local jugg = Player[id][29],dtap = Player[id][30],
    stamin = Player[id][31],rev = Player[id][32];
    sc = p.GetScriptScope();
    EntFire("drink_model_id_"+id, "Kill");
    p.__KeyValueFromInt("rendermode",0);
    p.__KeyValueFromInt("renderamt",255);
    p.__KeyValueFromInt("disableflashlight",0);
    p.__KeyValueFromInt("disableshadows",0);
    p.__KeyValueFromInt("disableshadowdepth",0);
    p.__KeyValueFromInt("disablereceiveshadows",0);
    steamid = Get32IDByUserid(sc.userid);
    if (!mandown && p.GetHealth() > 0) {
        Player[id][31] = true;
        local index = 0;
        if (dtap && !jugg && !rev) {
            index = 3;
        }
        else if (jugg && !dtap && !rev) {
            index = 10;
        }
        else if (rev && !dtap && !jugg) {
            index = 14;
        }
        else if (dtap && jugg && !rev) {
            index = 5;
        }
        else if (jugg && rev && !dtap) {
            index = 12;
        }
        else if (dtap && rev && !jugg) {
            index = 7;
        }
        else if (dtap && rev && jugg) {
            index = 8;
        }
        else {
            index = 13;
        }
        SetPlayerScreen(id,index-1);
    }
    EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p);
}


::ReviveCost <- function () {
    if (ent_work) {
    local within = null;
    local p = null;
    local id = 0;
    local ent = null;
    local entb = null;
    local name = "ReviveCost"
    local text = (m_lang == 0 ? "能量饮料:快速救人(可自救) [费用:1500]" : "Quick Revive: Allowing self-revive & decreasing the time costs of reviving [Cost: 1500pts]"),text_2 = (m_lang == 0 ? "需要电力才能运作！" : "No Power");
    local tl = null;
    ent = Entities.FindByName(null, "revive_button");
    while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),34)) != null) {
        if (within != null) {
            if (within.GetTeam() == 3) {
                p = within;
                tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                if (tl==1.0) {
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
                        entb.__KeyValueFromString("color","255 255 255");
                        entb.__KeyValueFromInt("x",-1);
                        entb.__KeyValueFromFloat("y",0.60);
                        entb.__KeyValueFromFloat("fadein",0.00);
                        entb.__KeyValueFromFloat("fadeout",0.00);
                        entb.__KeyValueFromFloat("holdtime",0.30);
                        entb.__KeyValueFromInt("effect",0);
                        entb.__KeyValueFromInt("channel",3);
                    }
                    if (PowerRun) {
                        entb.__KeyValueFromString("message",text);
                    }
                    else {
                        entb.__KeyValueFromString("message",text_2);
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
                }
            }
        }
    }
    EntFire("Script", "RunScriptCode", "ReviveCost()", 0.15);
    }
}

::GiveRevive <- function () {
    local p = activator,id,egg,b;
    local pos = p.GetOrigin(),ang = p.GetAngles();
    local within = null;
    local button = null;
    local cost = 1500;
    local tb = getconsttable();
    local sc = p.GetScriptScope();
    local name = "drink_model_id_";
    local view,snd,file;
    local view_pos = Vector(418,-285,209);//p.EyePosition() + p.GetForwardVector() * 30 + p.GetLeftVector() * 50;
    if (p.GetTeam() == 3 && PowerRun) {
        for (local i=0;i<Player.len();i++) {
            if (Player[i][0] == p) {
                id = i;
                break;
            }
        }
        if (!Player[id][32]) {
        button = Entities.FindByName(null, "revive_button");
        for (local o=0;o<Player.len();o++) {
        within = Entities.FindByClassnameWithin(within,"player",button.GetOrigin(),34);
        if (within != null && within == p) {
            if (Points[id] >= cost) {
            local ent = null;
            PointChange(id,cost,0);
            EntFire("Player_SpeedMod", "ModifySpeed", "0.0", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot3 ", 0.00, p);
            EntFire("point_clientcommand", "Command", "slot2 ", 1.40, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[30], 0.00, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[31], 0.80, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[32], 1.50, p);
            //EntFire("point_clientcommand", "Command", "play "+item_snd[33], 1.70, p);
            EntFire("point_clientcommand", "Command", "play "+item_snd[39], 1.70, p);
            snd = Entities.FindByName(null, "map_world_player_sound_"+id);
            file = item_snd[33];
            snd.__KeyValueFromString("message", file);
            snd.SetOrigin(pos);
            EntFireByHandle(snd, "PlaySound", "", 2.00, null, null);
            EntFireByHandle(snd, "Volume", "10", 2.01, null, null);
            p.__KeyValueFromInt("rendermode",1);
            p.__KeyValueFromInt("renderamt",0);
            p.__KeyValueFromInt("disableflashlight",1);
            p.__KeyValueFromInt("disableshadows",1);
            p.__KeyValueFromInt("disableshadowdepth",1);
            p.__KeyValueFromInt("disablereceiveshadows",1);
            ent = CreateProp("prop_dynamic", pos, p.GetModelName(), 0);
            ent.__KeyValueFromString("targetname", name+id);
            ent.SetAngles(0,ang.y,0);
            egg = Player[id][28];
            if (Player[id][34] != "headcrab" && p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "3", 0.00, null, null);
            }
            else if (p.GetModelName()) {
                EntFireByHandle(ent, "SetBodyGroup", "8", 0.00, null, null);
            }
            else if (p.GetModelName() ) {
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
                EntFireByHandle(ent, "SetBodyGroup", b.tostring(), 0.00, null, null);
            }
            EntFireByHandle(ent, "SetAnimation", "drink", 0.00, null, null);
            view = Entities.FindByName(null, "character_view_id_"+id);
            view.SetOrigin(Vector(view_pos.x,view_pos.y,view_pos.z-10));
            view.SetAngles(-15,-70,0);
            EntFireByHandle(view, "Enable", "", 0.00, p, null);
            viewgod[id] = true;
            EntFire("Script", "RunScriptCode", "viewgod["+id+"] = false", 1.50);
            EntFireByHandle(view, "Disable", "", 1.40, p, null);
            EntFire("rev_music", "PlaySound");
            EntFire("Script", "RunScriptCode", "Rev_Drinked("+id+")", 1.40);
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+event_msg[65][m_lang]);
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
        else {
            local ent = null;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("message",event_msg[59][m_lang]);
            ent.SetOwner(p);
            EntFireByHandle(ent, "ShowHudHint", "", 0.00, p, null);
            EntFireByHandle(ent, "Kill", "", 0.01, null, null);
        }
    }
}

::Rev_Drinked <- function (id) {
    local p = Player[id][0],steamid,sc;
    local mandown = Player[id][25];
    local jugg = Player[id][29],dtap = Player[id][30],
    stamin = Player[id][31],rev = Player[id][32];
    sc = p.GetScriptScope();
    EntFire("drink_model_id_"+id, "Kill");
    p.__KeyValueFromInt("rendermode",0);
    p.__KeyValueFromInt("renderamt",255);
    p.__KeyValueFromInt("disableflashlight",0);
    p.__KeyValueFromInt("disableshadows",0);
    p.__KeyValueFromInt("disableshadowdepth",0);
    p.__KeyValueFromInt("disablereceiveshadows",0);
    steamid = Get32IDByUserid(sc.userid);
    if (!mandown && p.GetHealth() > 0) {
        Player[id][32] = true;
        local index = 0;
        if (dtap && !jugg && !stamin) {
            index = 4;
        }
        else if (jugg && !dtap && !stamin) {
            index = 11;
        }
        else if (stamin && !dtap && !jugg) {
            index = 14;
        }
        else if (dtap && jugg && !stamin) {
            index = 6;
        }
        else if (dtap && stamin && !jugg) {
            index = 7;
        }
        else if (jugg && stamin && !dtap) {
            index = 7;
        }
        else if (dtap && stamin && jugg) {
            index = 8;
        }
        else {
            index = 15;
        }
        SetPlayerScreen(id,index-1);
    }
    local stamin = Player[id][31];
    if (!stamin) {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p);
    }
    else {
        EntFire("Player_SpeedMod", "ModifySpeed", "1.3", 0.00, p);
    }
}

::PowerRun <- false;
::TurnOnPower <- function () {
    local p = activator;
    if (p.GetTeam() == 3) {
        EntFire("power", "SetAnimation", "move");
        EntFire("power", "SetAnimationDefault", "on", 0.10);
        EntFire("power_light", "TurnOn", "" 1.00);
        EntFire("power_light", "TurnOff", "" 1.05);
        EntFire("power_light", "TurnOn", "" 1.10);
        EntFire("juggernog_light", "TurnOn", "" 2.00);
        EntFire("juggernog_music", "PlaySound", "" 2.00);
        EntFire("doubletap_light", "TurnOn", "" 2.00);
        EntFire("dtap_music", "PlaySound", "" 2.00)
        EntFire("staminup_light", "TurnOn", "" 2.00);
        EntFire("stamin_music", "PlaySound", "" 2.00)
        EntFire("revive_light", "TurnOn", "" 2.00);
        EntFire("rev_music", "PlaySound", "" 2.00)
        EntFire("Script", "RunScriptCode", "TurnOnPower_Delay()", 2.10);
    }
}

::TurnOnPower_Delay <- function () {
    PowerRun = true;
};

::Pistol <- [
    "hkp2000",
    "usp_silencer",
    "p250",
    "elite",
    "glock",
    "fiveseven",
    "tec9",
    "deagle"
];

::Rifle <- [
    "famas",
    "galilar",
    "m4a1",
    "ak47",
    "aug",
    "sg556"
];

::SMG <- [
    "mac10",
    "mp5sd",
    "mp9",
    "ump45",
    "mp7",
    "p90",
    "bizon"
];

::Heavy <- [
    "m249",
    "nova",
    "xm1014",
    "mag7",
    "sawedoff",
];

::Sniper <- [
    "ssg08",
    "awp",
    "g3sg1",
    "scar20"
];

UseHealthCharger <- function ()
{
    local atvr = activator,user = null,id,sc;
    local ent = Entities.FindByName(null, "health_charger");
    local but = Entities.FindByName(null, "health_charger_button");

    if ( atvr.GetTeam() == 3 )
    {
        local data;
        foreach ( key, value in Player )
        {
            data = value;
            if ( data[0] != null && data[0].IsValid() )
            {
                if ( data[0] == atvr )
                {
                    user = atvr;
                    id = key;
                    sc = user.GetScriptScope();
                    break;
                }
            }
        }
        if ( user == null )
                return;
        
        local cost = 2000,text;
        if ( Points[id] >= cost )
        {
            PointChange(id,cost,0);
            user.SetHealth(Player_Health[id]);

            local fade = Entities.CreateByClassname("env_fade");
            fade.__KeyValueFromString("spawnflags", "5");
            fade.__KeyValueFromString("duration", "0.2");
            fade.__KeyValueFromString("ReverseFadeDuration", "0.2");
            fade.__KeyValueFromString("holdtime", "0");
            fade.__KeyValueFromString("renderamt", "10");
            fade.__KeyValueFromString("rendercolor", "128 255 0");
            EntFireByHandle(fade, "Fade", "", 0.00, user, null);
            EntFireByHandle(fade, "Kill", "", 0.00, null, null);

            user.PrecacheSoundScript("HealthShot.Pickup");
            user.EmitSound("HealthShot.Pickup");
            EntFireByHandle(ent, "SetAnimation", "absord", 0.00, null, null);
            EntFireByHandle(ent, "SetAnimation", "Charging", 1.10, null, null);
            EntFireByHandle(but, "Lock", "", 0.00, null, null);
            EntFireByHandle(but, "UnLock", "", 1.10, null, null);
            text = ["使用了回血仪","Use HealthCharger"];
            ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+text[::m_lang]);
            return;
        }
        else 
        {
            ent = null;
            ent = Entities.CreateByClassname("env_hudhint");
            ent.__KeyValueFromString("message",event_msg[3][m_lang]);
            ent.SetOwner(user);
            EntFireByHandle(ent, "ShowHudHint", "", 0.00, user, null);
            EntFireByHandle(ent, "Kill", "", 0.00, null, null);
        }
    }
};

HealthChargerCost <- function ()
{
    if ( ent_work )
    {
        local within = null;
        local p = null;
        local id = 0;
        local ent = null;
        local entb = null;
        local name = "ChargerCost"
        local text = item_text[16][::m_lang];
        local tl = null;
        ent = Entities.FindByName(null, "health_charger_button");
        while ((within = Entities.FindByClassnameWithin(within,"player",ent.GetOrigin(),32)) != null) 
        {
            if (within != null) 
            {
                if (within.GetTeam() == 3) 
                {
                    p = within;
                    tl = TraceLine(within.EyePosition(), ent.GetOrigin(), within);
                    if (tl==1.0) 
                    {
                        for (local i=0;i<Player.len();i++) 
                        {
                            if (Player[i][0] == p) 
                            {
                                id = i;
                                break;
                            }
                        }
                        entb = Entities.FindByName(null, name);
                        if (entb == null) 
                        {
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
                        if (eye_see_space[id][0] != null) 
                        {
                            if (eye_see_space[id][0] == ent) 
                            {
                                if (p.GetHealth() > 0) 
                                {
                                    entb.SetOwner(p);
                                    EntFireByHandle(entb, "Display", "", 0.00, p, null);
                                    //EntFireByHandle(entb, "Kill", "", 0.01, null, null);
                                }
                            }
                        }
                    }
                }
            }
        }
        EntFire("Script", "RunScriptCode", "HealthChargerCost()", 0.15);
    }
};

