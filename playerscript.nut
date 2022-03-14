//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

::author_steam_32id <- "STEAM_1:0:92528290";
::contributor_steam_32id <- "STEAM_1:1:53589709";
::author_skin <- true;
//At the beginning of the production, there were six players. Later, I thought that at most five players were the most suitable, so I deleted one
::Player <- [
[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg", false,false,false,false,0, "voc", "none"], //20=Progress bar,21=state,22=Skill,23=Skill Time,fire man,down,ready, reviveing,28==egg,29==Juggernog, 34=voc
[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg", false,false,false,false,0, "voc", "none"],
[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg", false,false,false,false,0, "voc", "none"],
[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg", false,false,false,false,0, "voc", "none"],
[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg", false,false,false,false,0, "voc", "none"]
//[null,false,"|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|","|none|",0,0,0,0,0,0,0,0,0, false, "normal", "none", 30, false, false, false, false, "egg"]
];

::Player_Model <- [
    /*"models/player/custom_player/11/humans/ctm_hecu"
    "models/player/custom_player/11/cdc.mdl",//0
    "models/player/custom_player/11/cdc_down.mdl",//1
    "models/player/custom_player/11/cia.mdl",//2
    "models/player/custom_player/11/cia_down.mdl",//3
    "models/player/custom_player/11/humans/ctm_hecu1.mdl",//4
    "models/player/custom_player/11/hecu_down.mdl",//5
    "models/player/custom_player/11/DivisionSix.mdl",//6 */
    "models/player/custom_player/11/haz.mdl"
];

//::author_health <- 34768;
::Player_ZeroValue <- 0;
::Player_Health <- [100,100,100,100,100];
//::Player_Health_LOWPLAYER <- 33768;
//::Player_BigHealth <- 33768;
//::Player_BigHealth_LOWPLAYER <- 34768;
//::Player_down_Revive_HP <- 32968;
//::Player_down_Revive_HP_LOWPLAYER <- 33068;
//::Player_death_Revive_HP <- 33068;
//::Player_death_Revive_HP_LOWPLAYER  <- 33268;
::Player_Valid_number <- 0;
::Player_Alive_number <- 0;
//::Player_Down_number <- 0;
//::Player_Missile <- [0,0,0,0,0];
//::Player_healshot <- [0,0,0,0,0];


::Points <- [500,500,500,500,500,500];
::Player_Kill_Zombie_Number <- [0,0,0,0,0,0];
::Player_Assister_Zombie_Number <- [0,0,0,0,0,0];
::Player_Revive_friendly_Number <- [0,0,0,0,0,0];
::Player_friendlyFire_Number <- [0,0,0,0,0,0];
::Player_Down_Number <- [0,0,0,0,0,0];
::Player_Death_Number <- [0,0,0,0,0,0];
::death_count <- [40,40,40,40,40,40];

::PlayerPositions <- [
    Vector(195,614,8),
    Vector(-92,522,8),
    Vector(-678,479,5),
    Vector(577,500,8),
    Vector(578,-57,8),
    Vector(197,53,151),
    Vector(-98,578,152),
    Vector(573,-98,152),
    Vector(593,342,152),
    Vector(-537,610,152)
];

::PointText <- [
    ["你的点数：","Your points： "],
    [" 的点数：","'s points： "],
    ["点数"," points "],
    ["饮料加成：","Perk-a-Colas："],
    ["厚血","Juggernog"],
    ["双伤","Double Damage"],
    ["耐力","Stamin-Up Soda"],
    ["自救","Quick Revive"],
    ["无","None"]
];

::gamestatus <- [
    ["区域-","Zone-"],
    ["比分：","Score"],
    ["人类 - ","Humans"],
    ["僵尸 - ","Zombies"],
    ["阵地生命值：","Fort Strength："],
    ["人类获胜！","Humans win!"],
    ["僵尸获胜！","Zombies win!"],
    ["击杀数量：","Kills："],
    ["道具量：","Carrying item："],
    ["已部署道具：","Deployed item："],
    ["可部署数量：","Deployable item："],
    ["职业：","class："]
];

::PlayerHudText <- [
    ["已触发的技能:","Activated skill(s): "],
    ["【2倍击杀点数】/","[DOUBLE REWARDS]/"],
    ["剩余",""],
    ["秒"," seconds remaining."],
    ["【血量回满】"," [Self-Revive Kits] "],
    ["【弹药全满】"," [Ammo Pack] "],
    ["【资金收入】"," [Cash] "],
    ["【原子打击】"," [Nuclear Bomb] "],
    ["【高级木匠】"," [Automatic Repair] "],
    ["【死亡机器】/"," [Death Machine]/ "]
];

::Data_Text <- [
    ["击杀的僵尸数量: "," Zombies Killed: "],
    ["助攻次数: "," Kill Assists: "],
    ["救起队友次数: "," Teammates Revived: "],
    ["击中友军次数: "," Friendly Fire Incidents: "],
    ["倒下次数: "," Number Of Times Incapacitated: "],
    ["死亡次数: "," Deaths: "],
    ["拥有的点数"," Points Earned: "]
];

::CheckPlayersSpace <- function () {
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == null) {
            continue;
        }
        else if (!(Player[i][0].IsValid()) || Player[i][0].GetTeam() == 1) {
            Player[i][0] = null;
            Player[i][35] = "none";
        }
    }
}

::RegisterPlayer <- function ()
{
    if ( isOver )
        return;
    EntFire("Script", "RunScriptCode", "::RegisterPlayer()", 1.00);
    local ent,_user,sc,steamid;
    while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
    {
        if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
        {
            _user = ent;
            sc = _user.GetScriptScope();
            steamid = ::Get32IDByUserid(sc.userid);
            ::CheckRegisterUser();

            if ( _user.GetTeam() == 3 )
            {
                local empty = null;
                local _skip = false;
                for ( local i = 0; i < Player.len(); i++ )
                {
                    if ( Player[i][0] == null || !Player[i][0].IsValid() )
                    {
                        if ( empty == null)
                            empty = i;
                    }
                    if ( Player[i][0] == _user )
                    {
                        if ( !Player[i][26] )
                            Player[i][26] = true;
                        //printl("already_registered");
                        _skip = true;
                        //if ( !isStart )
                            //EntFire("clientcommand", "command", "Play "+::Background_music[5], 0.00, _user);
                        break;
                    }
                }
                if ( _skip )
                    continue;
                
                if ( empty != null && _user.GetHealth() > 0 )
                {
                    Player[empty][0] = _user;
                    Player[empty][26] = true;
                    sc._class <- -1;
                    sc.nvg <- 0;
                    sc._id <- empty;
                    ::PlayerSCdata(empty);
                    _user.__KeyValueFromString("targetname", "Player_ID"+empty);
                    EntFire("Script", "RunScriptCode", "::Delete_Player_Weapons()", 0.00, _user);
                    EntFire("Script", "RunScriptCode", "ClearAndSpawnPlayerVoiceEnt()", 0.00);
                    ::SpawnViewCam();

                    if ( isStart ) 
                        EntFire("Script", "RunScriptCode", "PlayerMidwayin("+empty+")", 0.10);
                    else
                        EntFire("Script", "RunScriptCode", "::matter()", 0.10, _user);

                    //printl("register_completed");
                    //SetPlayerScreen();
                    EntFire("clientcommand", "command", "cl_drawhud_force_radar -1", 0.00, _user);
                    continue;
                }
            }
            else if ( _user.GetTeam() == 2 )
            {
                if ( _user.GetModelName().find("tm_", 0) != null )
                    _user.SetModel(::zombie_model[32]);

                local i,k;
                if ( steamid.tolower() == "bot" )
                    i = 0,k = BOT.len()-5;
                else
                    i = 5,k = BOT.len();

                local empty = null;
                local _skip = false;
                for ( i; i < k; i++ )
                {
                    if ( BOT[i][0] == null || !BOT[i][0].IsValid() )
                    {
                        if ( empty == null)
                            empty = i;
                    }
                    if ( BOT[i][0] == _user )
                    {
                        _skip = true;
                        break;
                    }
                }
                if ( _skip )
                    continue;
                
                if ( empty != null )
                {
                    BOT[empty][0] = _user;
                    if ( BOT[empty][8] )
                        BOT[empty][8] = false;
                    sc.nvg <- 0;
                    sc.glow <- 0;
                    sc._id <- empty;
                    _user.__KeyValueFromString("targetname", "Zombie_ID"+empty);
                    EntFire("Script", "RunScriptCode", "::Delete_Player_Weapons()", 0.00, _user);
                    EntFire("Script", "RunScriptCode", "ClearAndSpawnZombieVoiceEnt()", 0.00);
                    ::SpawnViewCam();

                    if ( !isStart && steamid.tolower() != "bot" )
                        EntFire("Script", "RunScriptCode", "::matter()", 0.10, _user);

                    if ( ::ZmEyeGlowArray[empty][0] != null )
                    {
                        ::ZmEyeGlowArray[empty][0] = null;
                        ::ZmEyeGlowArray[empty][1] = null;
                    }
                    continue;
                }
            }
        }
    }
};

::CheckRegisterUser <- function ()
{
    local ent,_user;
    while ( (ent = Entities.FindByClassname(ent, "*")) != null )
    {
        if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
        {
            _user = ent;
            for ( local i = 0; i < ::Player.len(); i++ )
            {
                if ( ::Player[i][0] == _user )
                {
                    if ( _user.GetTeam() != 3 )
                    {
                        ::Player[i][0] = null;
                        EntFireByHandle(::CamArray[i], "Disable", "", 0.00, null, null);
                        local _ui;
                        while ( ( _ui = Entities.FindByClassname(_ui, "game_ui") ) != null )
                        {
                            if ( _ui.GetOwner() == _user )
                            {
                                EntFireByHandle(_ui, "Deactivate", "", 0.00, null, null);
                                EntFireByHandle(_ui, "Kill", "", 0.00, null, null);
                            }
                        }
                    }
                }
            }
            for ( local i = 0; i < ::BOT.len(); i++ )
            {
                if ( ::BOT[i][0] == _user )
                {
                    if ( _user.GetTeam() != 2 )
                    {
                        ::BOT[i][0] = null;
                        ::BOT[i][8] = false;
                        EntFireByHandle(::CamArray[i], "Disable", "", 0.00, null, null);
                        local _ui;
                        while ( ( _ui = Entities.FindByClassname(_ui, "game_ui") ) != null )
                        {
                            if ( _ui.GetOwner() == _user )
                            {
                                EntFireByHandle(_ui, "Deactivate", "", 0.00, null, null);
                                EntFireByHandle(_ui, "Kill", "", 0.00, null, null);
                            }
                        }
                    }
                }
            }
        }
    }
};

::PlayerSCdata <- function (id)
{
    local _user = Player[id][0],sc;
    if ( _user.ValidateScriptScope() )
    {
        sc = _user.GetScriptScope();
        sc._carrymax <- 0;
        sc._carry <- 0;
        sc._deploy <- 0;
        sc._deployed <- [null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null];
        sc._deploycount <- 0;
        sc._deploymax <- 0;
        sc._AllowPickup <- true;
    }
};

PlayerMidwayin <- function (id,atvr = null)
{
    if ( allready || isStart )
    {
        atvr = Player[id][0];
        
        local randList = [];
        for ( local i = 0; i < ::CareerExist.len(); i++ )
        {
            if ( !::CareerExist[i] )
                randList.push(i);
            else
                continue;
        }

        local r = RandomInt(0,randList.len()-1);

        if ( atvr.ValidateScriptScope() )
        {
            local sc = atvr.GetScriptScope();
            if ( sc._class == -1 )
            {
                sc._class <- randList[r];
                ::CareerExist[randList[r]] = true;
                EntFire("Script", "RunScriptCode", "vocskill_confirm()");
            }
        }
    }
};

::SetPlayerModel <- function (id,idx,idxB)
{
    local atvr = Player[id][0];
    atvr.SetModel(Player_Model[0]);
    EntFireByHandle(atvr, "SetBodyGroup", idx.tostring(), 0.00, null, null);
    EntFireByHandle(atvr, "Skin", (idxB+5).tostring(), 0.00, null, null);
}

::Delete_Player_Weapons <- function () 
{
    local p = activator;
    local sc = p.GetScriptScope();
    local steamid = Get32IDByUserid(sc.userid);
    if ( steamid.tolower() != "bot" )
    {
        local entity = null;
        for (entity = Entities.First();entity != null;entity = Entities.Next(entity)) 
        {
            if(entity.GetClassname().find("weapon_", 0) != null && entity.GetMoveParent() == p) 
            {
                if ( entity.GetClassname().find("knife", 0) != null && p.GetTeam() == 2)
                {
                    EntFire("clientcommand", "command", "slot3", 0.00, p);
                    continue;
                }
                entity.Destroy();
            }
        }
    }
};


::matter <- function () 
{
    local atvr,id,_view,_ui,_uiname,pos;
    local BlueTeam = false;
    atvr = activator;

    for ( local i = 0; i < (::Player.len() + ::BOT.len()-5); i++ )
    {
        if ( i < 5 )
        {
            if ( atvr.GetTeam() == 3 )
            {
                if ( ::Player[i][0] == atvr )
                {
                    id = i;
                    _uiname = "ui_ct_";
                    BlueTeam = true;
                    ::PlayMusic(5,10);
                    break;
                }
            }
        }
        else
        {
            if ( atvr.GetTeam() == 2 )
            {
                if ( ::BOT[i][0] == atvr )
                {
                    id = i;
                    _uiname = "ui_t_";
                    break;
                }
            }
        }
    }
    _view = ::CamArray[id];
    pos = Vector(8256,540,160);
    _view.SetOrigin(pos);
    _view.SetAngles(0,90,0);
    _ui = Entities.CreateByClassname("game_ui");
    _ui.__KeyValueFromString("targetname", _uiname+id);
    _ui.__KeyValueFromInt("spawnflags", 96);
    _ui.__KeyValueFromFloat("FieldOfView", -1.0);
    _ui.SetOwner(atvr);
    if ( BlueTeam )
        EntIO(_ui, "PressedBack", "Script", "RunScriptCode", "Character_UI()", "0.00", "1");
    else
        EntIO(_ui, "PressedBack", _view.GetName(), "Disable", "", "0.00", "1");
    EntIO(_ui, "PressedBack", "!self", "Deactivate", "", "0.00", "1");
    EntIO(_ui, "PressedBack", "!self", "Kill", "", "0.00", "1");
    EntFireByHandle(::CamArray[id], "Enable", "", 0.00, atvr, null);
    EntFireByHandle(_ui, "Activate", "", 0.30, atvr, null);

	ScriptPrintMessageChatAll("\x01 \x07 如遇到任何问题可在作者STEAM留言！\x01 \x09 联机群:547256416");
    ScriptPrintMessageChatAll("我的B站主页：\x01 \x04 https://space.bilibili.com/2601958");
	ScriptPrintMessageChatAll("\x01 \x05 You can leave a message to me on the workshop page to report bugs :)");

};

::TestPlayerSpace <- function () {
    __DumpScope(3,Player.tostring());
    for(local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
             printl("spacenum>"+i);
             printl("space>"+Player[i][0]);
        }
        else {
             printl("spacenull>"+i);
        }
    }
}

CheckSurvival <- function () 
{

    EntFire( "Script", "RunScriptCode", "CheckSurvival()", 0.10 );

    local data,ply,n1,n2,_ready;

    n1 = 0;n2 = 0;

    foreach ( key, value in Player )
    {

        data = value;

        if ( data[ 0 ] != null )
        {

            ply = data[ 0 ];

            if ( ply.IsValid() )
            {

                //_ready = Player[ key ][ 26 ] ;

                n1++;

                if ( ply.GetHealth() > 0 )
                {
                    local pass = true;
                    if ( ::Rescued.len() > 0 )
                    {
                        for (local i = 0; i < ::Rescued.len(); i++ )
                        {
                            if ( ::Rescued[i] == ply )
                            {
                               pass = false;
                               break;
                            }
                        }
                    }
                    if ( !pass )
                        continue;
                    n2++;
                }
            }
        }
    }

    ::Player_Valid_number = n1;
    ::Player_Alive_number = n2;


    /*local ent = null;
    local p = null;
    local id = null;
    local ready = null;
    local mandown = null;
    local revive = null;
    local num = 0,num_v = 0,num_d = 0;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null && Player[i][0].IsValid()) {
            num_v += 1;
            p = Player[i][0];
            id = i;
            mandown = Player[id][25];
            ready = Player[id][26];
            if (ready && p.GetHealth() > Player_ZeroValue) {
                num += 1;
                //printl("Player_ID "+i+" is alive"); 
            }
            else if (ready && p.GetHealth() <= Player_ZeroValue && p.GetHealth() > 100) {
                num += 1;
                p.SetHealth(Player_ZeroValue+1);
                revive = Player[id][32];
                if (!mandown && p.GetVelocity().z == 0) {
                    if (!revive) {
                        Player[id][25] = true;
                    }
                    Player[id][27] = false;
                    Player_Down(id);
                }
                //printl("Player_ID "+i+" is down");
            }
            if (mandown) {
                num_d += 1;
            }
            EntFire("Script", "RunScriptCode", "AllDead()", 1.00);
        }
        if (i==(Player.len()-1)) {
            Player_Valid_number = num_v;
            Player_Alive_number = num;
            Player_Down_number = num_d;
            CheckPlayersSpace();
            Del_NULLPlayerModel();
            //printl("alive>"+Player_Alive_number);
            //printl("down>"+ Player_Down_number);
            break;
        }
    }
    //if (!isOver) {
    EntFire("Script", "RunScriptCode", "CheckSurvival()", 0.02);
    //}*/
}

::Del_NULLPlayerModel <- function () {
    local p,id,model,model2;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] == null || Player[i][0] != null && !(Player[i][0].IsValid())) {
            id = i;
            model = Entities.FindByName(null, "Player_Model_ID_"+id);
            model2 = Entities.FindByName(null, "drink_model_id_"+id);
            if (model != null) {
                Player[id][25] = false;
                Player[id][27] = false;
                model.Destroy()
                //ScriptPrintMessageChatAll("test");
            }
            if (model2 != null) {
                model2.Destroy()
                //ScriptPrintMessageChatAll("test2");
            }
        }
    }
}

::SetMyPos <- function () {
    local p = activator;
    p.SetOrigin(PlayerPositions[0]);
}

game_playertextent <- null;
ShowPlayerPoint <- function () 
{
    if ( isOver )
        return;

    EntFire("Script", "RunScriptCode", "ShowPlayerPoint()", 0.30);

    local user,id,sc;

    if ( game_playertextent == null ) 
    {
        game_playertextent = Entities.CreateByClassname("game_text");
        game_playertextent.__KeyValueFromInt("spawnflags",0);
        game_playertextent.__KeyValueFromString("color","53 169 255");
        game_playertextent.__KeyValueFromInt("x",-1);
        game_playertextent.__KeyValueFromFloat("y",0.79);
        game_playertextent.__KeyValueFromInt("fadein",0);
        game_playertextent.__KeyValueFromInt("fadeout",0);
        game_playertextent.__KeyValueFromInt("holdtime",1);
        game_playertextent.__KeyValueFromInt("effect",0);
        game_playertextent.__KeyValueFromInt("channel",1);
    }

    local slot = null;
    local pass = false;
    for ( local i = 0; i < ( Player.len() + ::isWave.len() ); i++ )
    {
        if ( !pass && i < isWave.len())
        {
            if ( ::isWave[i] ) 
            {
                if ( slot == null )
                    slot = i;
            }
        }
        if ( !::Waveing || slot != null ) 
        {
            if ( !pass )
            {
                pass = true;
                i = 0;
            }
        }
        if ( pass && i < Player.len() )
        {
            if ( Player[i][0] != null && Player[i][0].IsValid() )
            {
                user = Player[i][0];sc = user.GetScriptScope();id = i;
                local wave,status;

                status = ::gamestatus[4][m_lang] + zombie_score + "/200 \n" + ::gamestatus[11][m_lang] + GetCareerName(sc._class) + "\n" +
                ::gamestatus[0][m_lang]+"A"+ areainfo(0) + ". " + ::gamestatus[0][m_lang]+"B"+ areainfo(1) + 
                ". " + ::gamestatus[0][m_lang]+"C"+ areainfo(2) + ". " + ::gamestatus[0][m_lang]+"D"+ areainfo(3) + ". \n" +
                ::gamestatus[8][m_lang] + sc._carry + " | " + ::gamestatus[9][m_lang] + sc._deploycount + " | " + ::gamestatus[10][m_lang] + sc._deploymax;

                if ( ::Waveing ) 
                {
                    wave = ::Wave_Msg[3][::m_lang]+" "+(slot+1)+" "+::Wave_Msg[4][::m_lang];
                    //game_playertextent.__KeyValueFromString("message",wave+"\n"+status+"\n"+PointText[0][::m_lang]+Points[id]);
                    EntFireByHandle(game_playertextent, "AddOutput", "message "+wave+"\n"+status+"\n"+PointText[0][::m_lang]+Points[id], 0.00, null, null);
                }
                else
                    //game_playertextent.__KeyValueFromString("message",status+"\n"+PointText[0][::m_lang]+Points[id]+"\n");
                    EntFireByHandle(game_playertextent, "AddOutput", "message "+status+"\n"+PointText[0][::m_lang]+Points[id]+"\n", 0.00, null, null);

                if (user.GetHealth() > 0) 
                    EntFireByHandle(game_playertextent, "Display", "", 0.00, user, null);
            }
        }
    }
};

::PointChange <- function (id,num,formula) {
    local p = Player[id][0];
    local ent = null;
    /*local name = "texthint_2_id"+id;
    local text = null;
    ent = Entities.FindByName(null,name);
    if (ent==null) {
        ent = Entities.CreateByClassname("game_text");
        ent.__KeyValueFromString("targetname",name);
        ent.__KeyValueFromInt("spawnflags",0);
        ent.__KeyValueFromInt("x",-1);
        ent.__KeyValueFromFloat("y",0.80);
        ent.__KeyValueFromFloat("fadein",0.30);
        ent.__KeyValueFromFloat("fadeout",0.30);
        ent.__KeyValueFromFloat("holdtime",1.5);
        ent.__KeyValueFromInt("effect",0);
        ent.__KeyValueFromInt("channel",2);
        ent.SetOwner(p);
    }*/
    if (formula==0) {
        //ent.__KeyValueFromString("color","255 0 0");
        //text="-";
        Points[id]-=num;
        if (Points[id] < 0) {
            Points[id] = 0;
        }
    }
    else if (formula==1) {
        //ent.__KeyValueFromString("color","0 255 0");
        //text="+";
        Points[id]+=num;
    }
    //ent.__KeyValueFromString("message",""+PointText[2][::m_lang]+text+num);
    //EntFire(name, "Display", "", 0.00, p);
}

::ShowAllPoints <- function () {
    local p = null;
    local tb = getconsttable();
    local sc = null;
    for (local i=0;i<Player.len();i++) {
        p = Player[i][0];
        if (Player[i][0] != null && Player[i][0].IsValid()) {
            sc = Player[i][0].GetScriptScope();
            if ("userid" in sc) {
                ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A"+PointText[1][::m_lang]+"\x01 \x0b "+Points[i]);
            }
        }
        else {
            continue;
        }
    }
}

::PlayerSpeed_tempState <- [false,false,false,false,false];
::player_punchview <- function (id) 
{
    local p,pos;
    p = Player[id][0];
    pos = p.GetOrigin();
    local ent = null;
    local name = "punch_id_"+id
    ent = Entities.FindByName(null, name);
    if (ent == null) 
    {
        ent = Entities.CreateByClassname("env_viewpunch");
        ent.__KeyValueFromString("targetname", name);
        ent.__KeyValueFromInt("spawnflags", 2);
        ent.__KeyValueFromFloat("radius", 32);
        ent.SetOrigin(pos);
        EntFireByHandle(ent, "SetParent", p.GetName(), 0.00, null, null);
    }
    local r = RandomInt(15,60);
    local r_2 = RandomInt(15,60);
    ent.__KeyValueFromString("punchangle", ""+r+" "+r_2+" 0");
    EntFireByHandle(ent, "ViewPunch", "", 0.01, p, null);

    if ( !::PlayerSpeed_tempState[id] ) 
    {
        ::VS.SetSpeed(p, 0, 0.5);
        ::PlayerSpeed_tempState[id] = true;
        EntFire("Script", "RunScriptCode", "PlayerSpeed_Reset("+id+")", 1.00);
    }
};

PlayerSpeed_Reset <- function (id) 
{
    local atvr = Player[id][0];
    if ( ::PlayerSpeed_tempState[id] )
    {
        ::PlayerSpeed_tempState[id] = false;
        ::VS.SetSpeed(atvr, 0, ::Player_DefSpeed[id]);
    }
};

::Player_State <- function () {
    local ent = null;
    local p = null;
    local id = null;
    local mandown = null;
    local liftup = null
    local ready = null;
    while ((ent = Entities.FindByClassname(ent, "*")) != null) {
        if (ent.GetClassname() == "player") {
            p = ent;
            if (p.GetTeam() == 3 && p.IsValid()) {
                for (local i=0;i<Player.len();i++) {
                    if (Player[i][0] == p ) {
                        id = i;
                        break;
                    }
                }
                ready = Player[id][26];
                mandown = Player[id][25];
                liftup = Player[id][27];
                if (ready && !mandown && p.GetHealth() < (Player_ZeroValue+40) && p.GetHealth() > 0) {
                    if (Player[id][21] != "gotodie") {
                    Player[id][21] = "gotodie";
                    EntFire("Script", "RunScriptCode", "Player_injury("+id+")", 5.00);
                    EntFire("Player_SpeedMod", "ModifySpeed", "0.6", 0.00, p)
                    }
                }
                else if (!mandown && p.GetHealth() >= (Player_ZeroValue+40)) {
                    if (Player[id][21] != "normal") {
                    Player[id][21] = "normal";
                    EntFire("Player_SpeedMod", "ModifySpeed", "1.0", 0.00, p)
                    }
                }
            }
        }
    }
//    printl("player_state_id>"+id);
    EntFire("Script", "RunScriptCode", "Player_State()", 1.00);
}

::Serious_injury_snd <- [
    "11/cod/voice/p1/goingtodie01.mp3",
    "11/cod/voice/p1/goingtodie02.mp3",
    "11/cod/voice/p1/goingtodie03.mp3",
    "11/cod/voice/p1/goingtodie04.mp3",
    "11/cod/voice/p1/goingtodie05.mp3",
    "11/cod/voice/p1/goingtodie06.mp3",
    "11/cod/voice/p1/goingtodie07.mp3",
    "11/cod/voice/p1/goingtodie08.mp3",
    "11/cod/voice/p1/goingtodie09.mp3",

    "11/cod/voice/p2/goingtodie01.mp3", // 9
    "11/cod/voice/p2/goingtodie02.mp3", // 10
    "11/cod/voice/p2/goingtodie03.mp3", // 11
    "11/cod/voice/p2/goingtodie04.mp3", // 12
    "11/cod/voice/p2/goingtodie05.mp3", // 13
    "11/cod/voice/p2/goingtodie06.mp3", // 14
    "11/cod/voice/p2/goingtodie07.mp3", // 15
    "11/cod/voice/p2/goingtodie08.mp3", // 16
    "11/cod/voice/p2/goingtodie09.mp3", // 17

    "11/cod/voice/p3/goingtodie01.mp3", // 18
    "11/cod/voice/p3/goingtodie02.mp3", // 19
    "11/cod/voice/p3/goingtodie03.mp3", // 20
    "11/cod/voice/p3/goingtodie04.mp3", // 21
    "11/cod/voice/p3/goingtodie05.mp3", // 22
    "11/cod/voice/p3/goingtodie06.mp3", // 23
    "11/cod/voice/p3/goingtodie07.mp3", // 24
    "11/cod/voice/p3/goingtodie08.mp3", // 25
    "11/cod/voice/p3/goingtodie09.mp3", // 26

    "11/cod/voice/p4/goingtodie01.mp3", // 27
    "11/cod/voice/p4/goingtodie02.mp3", // 28
    "11/cod/voice/p4/goingtodie03.mp3", // 29
    "11/cod/voice/p4/goingtodie04.mp3", // 30
    "11/cod/voice/p4/goingtodie05.mp3", // 31
    "11/cod/voice/p4/goingtodie06.mp3", // 32
    "11/cod/voice/p4/goingtodie07.mp3", // 33
    "11/cod/voice/p4/goingtodie08.mp3", // 34
    "11/cod/voice/p4/goingtodie09.mp3", // 35

    "11/cod/voice/p5/goingtodie01.mp3", // 36
    "11/cod/voice/p5/goingtodie02.mp3", // 37
    "11/cod/voice/p5/goingtodie03.mp3", // 38
    "11/cod/voice/p5/goingtodie04.mp3", // 39
    "11/cod/voice/p5/goingtodie05.mp3", // 40
    "11/cod/voice/p5/goingtodie06.mp3", // 41
    "11/cod/voice/p5/goingtodie07.mp3", // 42
    "11/cod/voice/p5/goingtodie08.mp3", // 43
    "11/cod/voice/p5/goingtodie09.mp3" // 44
];

::Player_injury <- function (id) {
    local p = Player[id][0];
    local sc = p.GetScriptScope();
    local mandown = null;
    local sndent = null;
    local snd = null;
    local r = null;
    local n = null;
    mandown = Player[id][25];
    sndent = Entities.FindByName(null, "Player_Voice_"+id);
    EntFireByHandle(sndent, "Volume", "0", 0.00, null, null);
    EntFireByHandle(sndent, "StopSound", "", 0.00, null, null);
    if (id==0) {
        r = RandomInt(0,8)
        snd = Serious_injury_snd[r];
        n = r+107;
    }
    else if (id==1) {
        r = RandomInt(9,17)
        snd = Serious_injury_snd[r];
        n = r+107;
    }
    else if (id==2) {
        r = RandomInt(18,26)
        snd = Serious_injury_snd[r];
        n = r+107;
    }
    else if (id==3) {
        r = RandomInt(27,35)
        snd = Serious_injury_snd[r];
        n = r+107;
    }
    else if (id==4) {
        r = RandomInt(36,44)
        snd = Serious_injury_snd[r];
        n = r+107;
    }
    else {
        return;
    }
    EntFireByHandle(sndent, "AddOutput", "message "+snd, 0.01, null, null);
    if (Player[id][21] == "gotodie" && !mandown) {
        if (p.GetHealth() > 0) {
            printl("injury_pid>"+id+"_hp>"+p.GetHealth());
            if (p.GetModelName()) {
        EntFireByHandle(sndent, "PlaySound", "", 0.02, p, null);
            }
        ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A: "+PlayerMsg[n][::m_lang]);
        }
    }
    else {
        return;
    }
    EntFire("Script", "RunScriptCode", "Player_injury("+id+")", 15.00);
}

::Player_Voice_Event_Sound <- [
    "11/cod/voice/p1/NS_1_exposed_acquired_01_r.mp3", // 0
    "11/cod/voice/p1/NS_1_exposed_acquired_02_r.mp3", // 1
    "11/cod/voice/p1/NS_1_exposed_acquired_03_r.mp3", // 2
    "11/cod/voice/p1/NS_1_exposed_acquired_04_r.mp3", // 3
    "11/cod/voice/p1/NS_1_exposed_acquired_05_r.mp3", // 4
    "11/cod/voice/p1/NS_1_exposed_acquired_06_r.mp3", // 5

    "11/cod/voice/p2/NS_2_exposed_acquired_01_r.mp3", // 6
    "11/cod/voice/p2/NS_2_exposed_acquired_02_r.mp3", // 7
    "11/cod/voice/p2/NS_2_exposed_acquired_03_r.mp3", // 8
    "11/cod/voice/p2/NS_2_exposed_acquired_04_r.mp3", // 9
    "11/cod/voice/p2/NS_2_exposed_acquired_05_r.mp3", // 10
    "11/cod/voice/p2/NS_2_exposed_acquired_06_r.mp3", // 11

    "11/cod/voice/p3/NS_3_exposed_acquired_01_r.mp3", // 12
    "11/cod/voice/p3/NS_3_exposed_acquired_02_r.mp3", // 13
    "11/cod/voice/p3/NS_3_exposed_acquired_03_r.mp3", // 14
    "11/cod/voice/p3/NS_3_exposed_acquired_04_r.mp3", // 15
    "11/cod/voice/p3/NS_3_exposed_acquired_05_r.mp3", // 16
    "11/cod/voice/p3/NS_3_exposed_acquired_06_r.mp3", // 17

    "11/cod/voice/p4/SC_1_exposed_acquired_01_r.mp3", // 18
    "11/cod/voice/p4/SC_1_exposed_acquired_02_r.mp3", // 19
    "11/cod/voice/p4/SC_1_exposed_acquired_03_r.mp3", // 20
    "11/cod/voice/p4/SC_1_exposed_acquired_04_r.mp3", // 21
    "11/cod/voice/p4/SC_1_exposed_acquired_05_r.mp3", // 22
    "11/cod/voice/p4/SC_1_exposed_acquired_06_r.mp3", // 23

    "11/cod/voice/p5/SC_3_exposed_acquired_01_r.mp3", // 24
    "11/cod/voice/p5/SC_3_exposed_acquired_02_r.mp3", // 25
    "11/cod/voice/p5/SC_3_exposed_acquired_03_r.mp3", // 26
    "11/cod/voice/p5/SC_3_exposed_acquired_04_r.mp3", // 27
    "11/cod/voice/p5/SC_3_exposed_acquired_05_r.mp3", // 28
    "11/cod/voice/p5/SC_3_exposed_acquired_06_r.mp3", // 29


    "11/cod/voice/p1/NS_1_order_action_suppress_01_r.mp3", // 30
    "11/cod/voice/p1/NS_1_order_action_suppress_02_r.mp3", // 31
    "11/cod/voice/p1/NS_1_order_action_suppress_03_r.mp3", // 32
    "11/cod/voice/p1/NS_1_order_action_suppress_04_r.mp3", // 33

    "11/cod/voice/p2/NS_2_order_action_suppress_01_r.mp3", // 34
    "11/cod/voice/p2/NS_2_order_action_suppress_02_r.mp3", // 35
    "11/cod/voice/p2/NS_2_order_action_suppress_03_r.mp3", // 36
    "11/cod/voice/p2/NS_2_order_action_suppress_04_r.mp3", // 37

    "11/cod/voice/p3/NS_3_order_action_suppress_01_r.mp3", // 38
    "11/cod/voice/p3/NS_3_order_action_suppress_02_r.mp3", // 39
    "11/cod/voice/p3/NS_3_order_action_suppress_03_r.mp3", // 40
    "11/cod/voice/p3/NS_3_order_action_suppress_04_r.mp3", // 41

    "11/cod/voice/p4/SC_1_order_action_suppress_01_r.mp3", // 42
    "11/cod/voice/p4/SC_1_order_action_suppress_02_r.mp3", // 43
    "11/cod/voice/p4/SC_1_order_action_suppress_03_r.mp3", // 44
    "11/cod/voice/p4/SC_1_order_action_suppress_04_r.mp3", // 45

    "11/cod/voice/p5/SC_3_order_action_suppress_01_r.mp3", // 46
    "11/cod/voice/p5/SC_3_order_action_suppress_02_r.mp3", // 47
    "11/cod/voice/p5/SC_3_order_action_suppress_03_r.mp3", // 48
    "11/cod/voice/p5/SC_3_order_action_suppress_04_r.mp3" // 49

];


::Player_Voice_Event <- function (id,msg) {
    local p,sc;
    p = Player[id][0];
    if (p != null) {
    sc = p.GetScriptScope();
    local ent = null;
    local snd = null;
    local r = null;
    local n = null;
    if (id==0) {
        if (msg==0) {
        r = RandomInt(0,5);
        }
        else if (msg==1) {
        r = RandomInt(30,33);
        }
    }
    else if (id==1) {
        if (msg==0) {
        r = RandomInt(6,11);
        }
        else if (msg==1) {
        r = RandomInt(34,37);
        }
    }
    else if (id==2) {
        if (msg==0) {
         r = RandomInt(12,17);
        }
        else if (msg==1) {
        r = RandomInt(38,41);
        }
    }
    else if (id==3) {
         if (msg==0) {
         r = RandomInt(18,23);
        }
        else if (msg==1) {
        r = RandomInt(42,45);
        }
    }
    else if (id==4) {
         if (msg==0) {
         r = RandomInt(24,29);
        }
        else if (msg==1) {
        r = RandomInt(46,49);
        }
    }
    snd = Player_Voice_Event_Sound[r]
    ent = Entities.FindByName(null, "Player_Voice_"+id);
    EntFireByHandle(ent, "Volume", "0", 0.00, null, null);
    EntFireByHandle(ent, "StopSound", "", 0.00, null, null);
    if (p.IsValid() && p.GetHealth() > Player_ZeroValue) {
        EntFireByHandle(ent, "AddOutput", "message "+snd, 0.01, null, null);
        if (p.GetModelName()) {
        EntFireByHandle(ent, "PlaySound", "", 0.02, p, null);
        }
        //ScriptPrintMessageChatTeam(3,"\x01 \x04 "+GetNameByUserid(sc.userid)+"\x0A: "+PlayerMsg[n][::m_lang]);
    }
    }
}

::eye_see_space <- [
    [null],
    [null],
    [null],
    [null],
    [null],
    [null]
];

::Playerfaced_Tri <- function () 
{
    local p = null;
    local name = "player_view_tg_";
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null && Player[i][0].IsValid() ) {
            p = Player[i][0];
            //p.SetAngles(0,0,0);
            EntFire(name+i, "Kill");
            EntFire("Script", "RunScriptCode", "Player_Face_Ang("+i+")", 0.00);
        }
        else
           return;
    }
};

::Player_Face_Ang <- function (id) 
{
    if (ent_work) 
    {
        local p = Player[id][0];
        local ent = null;
        local name = "player_view_tg_"+id;
        local dist = null;
        local ori,ang,yaw;
        local range = null; 
        //local num = [];
        local sw = false;
        ent = Entities.FindByName(null, name);
        if ( p != null && p.IsValid() ) 
        {
            ang = p.GetAngles();
            dist = p.EyePosition() + p.GetForwardVector() * 39;
            yaw = (ang.y)*PI/180.0;
            if (ent == null) {
                ent = Entities.CreateByClassname("info_target");
                ent.__KeyValueFromString("targetname", name);
                //ent.SetOrigin(Vector(dist.x,dist.y,dist.z-20));
                //EntFireByHandle(ent, "SetParent", "Player_ID"+id, 0.01, null, null);
                //EntFireByHandle(ent, "SetParentAttachmentMaintainOffset", "clip_limit", 0.02, null, null);
                //printl("create_view_tg");
            }
            ent.SetOrigin(Vector(dist.x,dist.y,dist.z-20));
            ori = ent.GetOrigin();
            range = Entities.FindByClassnameNearest("func_button", ori, 32);
            if (range != null && range.IsValid()) 
            {
                ::eye_see_space[id][0] = range;
                //printl("You've seen the button");
            }
            else 
            {
                ::eye_see_space[id][0] = null;
            }
            EntFire("Script", "RunScriptCode", "Player_Face_Ang("+id+")", 0.10);
        }
    else
       return;
    }
}
                    /*num = [null];
                    for (local i=0;i<eye_see_space[id].len();i++) {
                        if (eye_see_space[id][i] != range) {
                            if (num[0] != null) {
                            num.push(i);
                            }
                            else {
                                num[0] = i;
                            }
                            printl("num>"+num.len());
                            printl("Not in scope");
                        }
                        else if (eye_see_space[id][i] == range) {
                            printl("in scope");
                            break;
                        }
                        if (i==eye_see_space[id].len()-1) {
                            ::eye_see_space[id].push(range);
                            printl("see+1(push)");
                            printl("space>"+eye_see_space[id].len());
                            break;
                        }
                    }
                    for (local l=0;l<num.len();l++) {
                        if (eye_see_space[id].len() != 0) {
                            if (!sw) {
                                ::eye_see_space[id].remove(num[l]);
                                sw = true;
                            }
                            else {
                                ::eye_see_space[id].remove(num[l]-1);
                            }
                        //eye_see_space[id][l] = null;
                        printl("space(removed)>"+eye_see_space[id].len());
                        }
                    }
                    continue;
                }
            }
        }
        EntFire("Script", "RunScriptCode", "Player_Face_Ang("+id+")", 0.25);
    }
}*/

::DetectionZombie <- function (id) {
    local ent = null;
    local p = null;
    local pos = null;
    local pos_b = null;
    local z = null;
    local tl = null;
    p = Player[id][0];
    if ( p != null && p.IsValid() ) {
    pos = p.EyePosition();
    pos_b = Vector(pos.x,pos.y,pos.z-5) + p.GetForwardVector() * 300;
    while ((ent = Entities.FindByClassnameWithin(ent,"player",pos_b,256)) != null) {
        if (ent.GetTeam() == 2) {
            //printl("is zombie");
            z = ent;
            tl = TraceLine(pos,z.GetOrigin(),null);
            if (tl==1) {
                if (z.GetModelName() != ::zombie_model[23]) {
                //printl("This is it");
                Player_Voice_Event(id,0);
                EntFire("Script", "RunScriptCode", "DetectionZombie("+id+")", 20.00);
                return;
                }
                else {
                //printl("This is it");
                Player_Voice_Event(id,1);
                EntFire("Script", "RunScriptCode", "DetectionZombie("+id+")", 30.00);
                return;
                }
            }
        }
    }
    //printl("check..");
    }
    else 
        return;
    EntFire("Script", "RunScriptCode", "DetectionZombie("+id+")", 1.00);
}

::ui_snd <- [
    "ui/counter_beep.wav",//0 gf
    "ui/csgo_ui_button_rollover_large.wav",//1 gf
    "ui/csgo_ui_page_scroll.wav",//2 gf
    "ui/panorama/mainmenu_press_play_03.wav",//3 gf
    "music/11/blackstation_part3_edit_60.mp3",//4
    "music/11/damned_malu_v12.mp3",//5
    "music/11/mus_safehouse_underscore.mp3",//6
    "11/nazi/ui/lobby_join.mp3",//7
    "11/nazi/ui/globe_move_in.mp3",//8
    "11/nazi/ui/globe_move_out.mp3",//9
    "ui/bonus_alert_start.wav",//10 gf
    "11/nazi/ui/KanC/hibiki.mp3",//11
    "11/nazi/ui/KanC/verniy.mp3",//12
    "11/nazi/ui/KanC/akatsuiki.mp3",//13
    "11/nazi/ui/KanC/ikazuchi.mp3",//14
    "11/nazi/ui/KanC/inazuma.mp3"//15
];

::Character_CheckPlayers <- function () {
    local p,id,sc,name,ent,tog,tg;
    for (local i=0;i<Player.len();i++) {
        ent = Entities.FindByName(null, "character_state_id_"+i);
        tg = ent.GetName();
        tog = Entities.CreateByClassname("env_texturetoggle");
        tog.__KeyValueFromString("target", tg);
        if (Player[i][0] != null && Player[i][0].IsValid()) {
            p = Player[i][0];
            id = i;
            sc = p.GetScriptScope();
            if (!P_Ready[id]) {
            EntFireByHandle(tog, "SetTextureIndex", "0", 0.00, null, null);
            }
            name = GetNameByUserid(sc.userid);
            EntFire("vgui_text_id_"+id, "SetDisplayText", name.tostring());
        }
        else {
            P_Ready[i] = false;
            EntFireByHandle(tog, "SetTextureIndex", "2", 0.00, null, null);
            EntFire("character_roticon_id_"+i, "DisableDraw", "", 0.00);
            EntFire("vgui_text_id_"+i, "SetDisplayText", "none");
        }
        EntFireByHandle(tog, "Kill", "0", 0.01, null, null);
    }
    if (Someone_ready && !allready) {
        all_ready();
        EntFire("Script", "RunScriptCode", "Character_CheckPlayers()", 1.00);
    }
}

::Choice_Slot <- [
    [true,false,false],
    [true,false,false],
    [true,false,false],
    [true,false,false],
    [true,false,false],
    [true,false,false]
];
::Choice_model <- [
    [true,false,false,false,false,false,false,false],
    [true,false,false,false,false,false,false,false],
    [true,false,false,false,false,false,false,false],
    [true,false,false,false,false,false,false,false],
    [true,false,false,false,false,false,false,false],
    [true,false,false,false,false,false,false,false]
];
::model_Selected <- [
    false,
    false,
    false,
    false,
    false,
    false
];
::Choice_Pist <- [
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false]
];

::Choice_eq <- [
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false],
    [true,false,false,false]
];

::character_egg <- false;
::character_egg_ON <- function () {
    character_egg = true;
    local tog,tg;
    for (local i=0;i<Player.len();i++) {
        tg = "character_tips_id_"+i;
        tog = Entities.CreateByClassname("env_texturetoggle");
        tog.__KeyValueFromString("target", tg);
        EntFireByHandle(tog, "SetTextureIndex", "0", 0.00, null, null);
        EntFireByHandle(tog, "Kill", "", 0.01, null, null);
        EntFire(tg, "Enable");
        //EntFire(tg, "Disable", "", 5.00);
    }
    PlayItem_Sound(25);
    printl("character_egg_IsOn");
    //ScriptPrintMessageChatTeam(3, event_msg[56][::m_lang]);
}

::Character_Model_adjust <- function () {
    local ent,pos;
    for (local i=0;i<5;i++) {
        ent = Entities.FindByName(null, "character_model_id_"+i);
        pos = ent.GetOrigin();
        ent.SetOrigin(Vector(pos.x,pos.y,pos.z-2));
    }
}

::Someone_ready <- false;
::P_Ready <- [false,false,false,false,false,false];
::Character_UI <- function () 
{
    if ( !allready && !isStart ) 
    {
    Character_CheckPlayers();
    local pos = null;
    local p,id,ui,tog,tog_2,tog_3,fade;
    local bg,bg_2,ui_name,tog_name,tog_tg_2,tog_tg_3;
    p = activator;
    for (local i=0;i<Player.len();i++) 
    {
        if (Player[i][0] == p) 
        {
            id = i;
            break;
        }
    }
    Charachter_info(id);
    Choice_Slot[id] = [true,false,false];
    Choice_model[id] = [true,false,false,false,false,false,false,false];
    EntFireByHandle(p, "SetHUDVisibility", "0", 0.00, null, null);
    if (id==0)
        pos = Vector(8527,-3,237);
    else if (id==1)
        pos = Vector(9286,-2,237);
    else if (id==2) 
        pos = Vector(10026,-2,237);
    else if (id==3)
        pos = Vector(10779,-2,237);
    else if (id==4)
        pos = Vector(11547,-2,237);

    local view = null;
    view = ::CamArray[id];
    view.SetOrigin(pos);
    view.SetAngles(0,90,0);
    EntFire("map_start_fade", "Fade", "", 0.00, p);
    bg = "character_brush_id_"+id;
    tog_name = "character_toggle_id_"+id;
    tog_tg_2 = "character_fream_a_id_"+id;
    tog_tg_3 = "character_fream_c_id_"+id;
    local col = "255 128 64",col_2 = "0 128 0",col_3 = "255 255 255";

    ui = Entities.CreateByClassname("game_ui");
    ui.__KeyValueFromString("targetname", "character_ui_"+id);
    ui.__KeyValueFromInt("spawnflags", 352);
    ui.__KeyValueFromInt("FieldOfView", -1.0);
    ui.SetOwner(p);
    tog = Entities.CreateByClassname("env_texturetoggle");
    tog.__KeyValueFromString("targetname", tog_name);
    tog.__KeyValueFromString("target", bg);
    tog_2 = Entities.CreateByClassname("env_texturetoggle");
    tog_2.__KeyValueFromString("target", tog_tg_2);
    tog_3 = Entities.CreateByClassname("env_texturetoggle");
    tog_3.__KeyValueFromString("target", tog_tg_3);
        //EntFire("character_random_frame_id_"+id, "Enable");
    EntFireByHandle(tog_2, "SetTextureIndex", "2", 0.00, null, null);
    EntFireByHandle(tog_3, "SetTextureIndex", "1", 0.00, null, null);
    EntFireByHandle(tog_2, "Kill", "", 0.01, null, null);
    EntFireByHandle(tog_3, "Kill", "", 0.01, null, null);
    EntFire("character_brush_id_"+id, "Disable");
    EntFire("character_model_id_"+id, "Disable");
    EntFire("character_model_id_"+id, "SetGlowDisabled");
    EntFire("character_pist_id_"+id, "Enable");
    EntFire("character_pist_id_"+id, "SetGlowDisabled");
    EntFire("character_random_id_"+id, "Enable");
    EntFire("character_random_id_"+id, "Color", "255 255 255");
    EntFire("character_left_id_"+id, "Color", col_2);
    EntFire("character_right_id_"+id, "Color", col_2);
    EntFire("character_pist_left_id_"+id, "Color", col_3);
    EntFire("character_pist_right_id_"+id, "Color", col_3);
    EntFire("character_eq_left_id_"+id, "Color", col_3);
    EntFire("character_eq_right_id_"+id, "Color", col_3);
    EntIO(ui,"PressedMoveLeft","Script", "RunScriptCode", "Move_Choice("+id+" 0)", "0.00", "-1");
    EntIO(ui,"PressedMoveRight","Script", "RunScriptCode", "Move_Choice("+id+" 1)", "0.00", "-1");
    EntIO(ui,"PressedForward","Script", "RunScriptCode", "Move_Choice("+id+" 2)", "0.00", "-1");
    EntIO(ui,"PressedBack","Script", "RunScriptCode", "Move_Choice("+id+" 3)", "0.00", "-1");
    EntIO(ui,"PlayerOff","Script", "RunScriptCode", "Character_Confirm("+id+")", "0.10", "-1");
        //EntFire("character_view_id_"+id, "Enable", "", 0.00, p);
    EntFireByHandle(ui, "Activate", "", 2.00, p, null);

        //EntFire("clientcommand", "command", "play "+ui_snd[4], 0.00, p);
        //EntFire("blackstation_part3_edit_60_"+id, "PlaySound", "", 1.00);
        //EntFire("blackstation_part3_edit_60_"+id, "PlaySound", "", 60.00);
        //EntFire("blackstation_part3_edit_60_"+id, "PlaySound", "", 119.00);
    EntFire("character_roticon_id_"+id, "EnableDraw");
    }
}

::Character_Confirm <- function (id) {
    local p = Player[id][0],sc = p.GetScriptScope(),steamid;
    local ui_name = "character_ui_"+id;
    local model = Entities.FindByName(null, "character_model_id_"+id);
    local tog,tg;
    //tg = "character_tips_id_"+id;
    /*if (character_egg) {
        //steamid = Get32IDByUserid(sc.userid);
        //if (steamid.tostring() == author_steam_32id) {
        //    model.SetModel(zombie_model[23]);
        //}
        if (model_Selected[id] && model.GetModelName()  && Choice_model[id][4]) {
            if (hibiki) {
                EntFire("clientcommand", "command", "play "+Event_Snd[0], 0.00, p);
                EntFire(ui_name, "Activate", "", 0.01, p);
                tog = Entities.CreateByClassname("env_texturetoggle");
                tog.__KeyValueFromString("target", tg);
                EntFireByHandle(tog, "SetTextureIndex", "1", 0.00, null, null);
                EntFireByHandle(tog, "Kill", "", 0.01, null, null);
                EntFire(tg, "Enable");
                EntFire(tg, "Disable", "", 0.75);
                return;
            }
        }
        else if (model_Selected[id] && model.GetModelName()  && Choice_model[id][5]) {
            if (akatsuki) {
                EntFire("clientcommand", "command", "play "+Event_Snd[0], 0.00, p);
                EntFire(ui_name, "Activate", "", 0.01, p);
                tog = Entities.CreateByClassname("env_texturetoggle");
                tog.__KeyValueFromString("target", tg);
                EntFireByHandle(tog, "SetTextureIndex", "1", 0.00, null, null);
                EntFireByHandle(tog, "Kill", "", 0.01, null, null);
                EntFire(tg, "Enable");
                EntFire(tg, "Disable", "", 0.75);
                return;
            }
        }
        else if (model_Selected[id] && model.GetModelName()  && Choice_model[id][6]) {
            if (ikazuchi) {
                EntFire("clientcommand", "command", "play "+Event_Snd[0], 0.00, p);
                EntFire(ui_name, "Activate", "", 0.01, p);
                tog = Entities.CreateByClassname("env_texturetoggle");
                tog.__KeyValueFromString("target", tg);
                EntFireByHandle(tog, "SetTextureIndex", "1", 0.00, null, null);
                EntFireByHandle(tog, "Kill", "", 0.01, null, null);
                EntFire(tg, "Enable");
                EntFire(tg, "Disable", "", 0.75);
                return;
            }
        }
        else if (model_Selected[id] && model.GetModelName()  && Choice_model[id][7]) {
            if (inazuma) {
                EntFire("clientcommand", "command", "play "+Event_Snd[0], 0.00, p);
                EntFire(ui_name, "Activate", "", 0.01, p);
                tog = Entities.CreateByClassname("env_texturetoggle");
                tog.__KeyValueFromString("target", tg);
                EntFireByHandle(tog, "SetTextureIndex", "1", 0.00, null, null);
                EntFireByHandle(tog, "Kill", "", 0.01, null, null);
                EntFire(tg, "Enable");
                EntFire(tg, "Disable", "", 0.75);
                return;
            }
        }
    }*/
    if ( Choice_model[id][0] || !::CareerExist[4] && Choice_model[id][5] || !::CareerExist[2] && Choice_model[id][4] || 
    !::CareerExist[3] && Choice_model[id][3] || !::CareerExist[1] && Choice_model[id][2] || !::CareerExist[0] && Choice_model[id][1] )
        EntFire("Script", "RunScriptCode", "Character_Ready("+id+")", 0.10);
    else
    {
       local text = null;
       local ent = Entities.FindByName(null, "character_explain_id_"+id);

       text = Character_Text[34][m_lang];
       EntFireByHandle(ent, "SetDisplayText", text, 0.00, null, null);
       EntFire(ui_name, "Activate", "", 0.10, p);
       return;
    }
}

::Character_Ready <- function (id) {
    if (!Someone_ready) {
        Someone_ready = true;
        Character_CheckPlayers();
    }
    P_Ready[id] = true;
    printl("Player_ID_"+id+"is ready!");
    EntFire("character_ui_"+id, "Kill");
    local p,sc,steamid,tog,tog_2,tg,tg_2,model,pist,eq,index,body,state,fade;
    local pos = Vector(8306,315,127);
    local view = ::CamArray[id];
    local model = Entities.FindByName(null, "character_model_id_"+id);
    local pist = Entities.FindByName(null, "character_pist_id_"+id);
    local eq = Entities.FindByName(null, "character_eq_id_"+id);
    p = Player[id][0];
    sc = p.GetScriptScope();
    EntFire("Player_SpeedMod_limit", "ModifySpeed", "0.0", 0.00, p);
    fade = Entities.CreateByClassname("env_fade");
    fade.__KeyValueFromInt("spawnflags", 5);
    fade.__KeyValueFromInt("duration", 1);
    fade.__KeyValueFromInt("ReverseFadeDuration", 1);
    fade.__KeyValueFromFloat("holdtime", 0.25);
    fade.__KeyValueFromString("rendercolor", "0 0 0");
    EntFireByHandle(fade, "Fade", "", 0.00, p, null);
    EntFireByHandle(fade, "Kill", "", 0.01, null, null);
    view.SetOrigin(pos);
    tg = "character_bursh_id_"+id
    tog = Entities.CreateByClassname("env_texturetoggle");
    tog.__KeyValueFromString("target", tg);
    local snd,file,snd_ori;
    snd_ori = Entities.FindByName(null, "character_roticon_id_"+id).GetOrigin();
    for (local i=0;i<Choice_model[id].len();i++) {
        if (model_Selected[id] && Choice_model[id][i]) {
            index = i;
            break;
        }
    }
    if (index==null) 
    {
        local a = [];
        for ( local i = 0; i < ::CareerExist.len(); i++ )
        {
            if ( !::CareerExist[i] )
            {
                a.push(i);
            }
        }
        local r = RandomInt(0,a.len()-1);
        if ( a[r] == 0)
            index = 1;
        else if ( a[r] == 1)
            index = 2;
        else if ( a[r] == 2)
            index = 4;
        else if ( a[r] == 3)
            index = 3;
        else if ( a[r] == 4)
            index = 5;
        
    }
    SetVOC(id,index);
    EntFireByHandle(tog, "SetTextureIndex", index.tostring(), 0.00, null, null);
    EntFireByHandle(tog, "Kill", "", 0.01, null, null);
    state = Entities.FindByName(null, "character_state_id_"+id);
    tg_2 = state.GetName();
    tog_2 = Entities.CreateByClassname("env_texturetoggle");
    tog_2.__KeyValueFromString("target", tg_2);
    EntFireByHandle(tog_2, "SetTextureIndex", "1", 0.00, null, null);
    EntFireByHandle(tog_2, "Kill", "", 0.01, null, null);
    EntFire("character_model_id_"+id, "SetGlowDisabled");
    EntFire("character_pist_id_"+id, "SetGlowDisabled");
    EntFire("character_eq_id_"+id, "SetGlowDisabled");
    EntFire("character_roticon_id_"+id, "DisableDraw", "", 0.60);
    EntFire("clientcommand", "command", "play "+ui_snd[3], 0.00, p);
    //EntFire("clientcommand", "command", "play "+ui_snd[5], 0.30, p);
    self.EmitSound(ui_snd[7]);
    //Player[id][26] = true;
    if (!isStart && !allready) {
    all_ready();
    }
    //else {
    //    EntFireByHandle(view, "Disable", "", 0.0, p, null);
    //}
}

PlayCountdownSnd <- function (n)
{
    self.EmitSound(::ATC_SND[1]+n+".mp3");
}

::allready <- false;
::all_ready <- function () 
{
    if ( allready )
       return;

    local p,id,num=0,rdy=0,fade,fade_2,del_tog;
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            p = Player[i][0];
            if (p.IsValid()) {
                id = i;
                num+=1;
                if (P_Ready[id]) {
                    rdy+=1;
                }
            }
        }
    }
    if (rdy==num) {
        allready = true;
        ::VS.SendToServer("mp_respawn_on_death_ct 0");
        EntFire("servercommand", "command", "bot_add_t");
        EntFire("servercommand", "command", "bot_add_t", 0.30);
        CheckPlayersSpace();

        
        local delay = 0.00;
        local tn = 10;
        local n = tn;
        local view = Entities.CreateByClassname("point_viewcontrol_multiplayer");
        view.__KeyValueFromInt("target_team", 2);
        view.SetOrigin(Vector(8306,315,127));
        view.SetAngles(0,90,0);
        EntFireByHandle(view, "Enable", "", 0.00, null, null);
        EntFireByHandle(view, "Disable", "", tn, null, null);
        EntFireByHandle(view, "Kill", "", tn, null, null);
        for ( local i = 5; i < BOT.len(); i++ )
        {
            if ( BOT[i][0] != null && BOT[i][0].IsValid() )
            {
                BOT[i][0].SetAngles(0,0,0);
                BOT[i][0].SetOrigin(Vector(292,170,-758));
            }
        }

        del_tog = "character_toggle_id_";
        for (local i=0;i<Player.len();i++) {
            EntFire(del_tog+i, "Kill");
        }
        //EntFire("game_countdown", "EnableDraw");
        //EntFire("game_countdown", "alpha", "255");
        for (local i=0;i<tn;i++) {
            delay += 1.00;
            EntFire("game_countdown", "SetDisplayText", ""+n.tostring(), delay);
            DoEntFire("!self", "RunScriptCode", "PlayCountdownSnd("+n+")", delay, self, self);
            EntFire("game_countdown", "FireUser1", "", delay);
            /*if (n==8) {
                EntFire("game_countdown", "AddOutput", "textcolor 213 199 181", delay);
            }
            else if (n==6) {
                EntFire("game_countdown", "AddOutput", "textcolor 255 211 6", delay);
            }
            else if (n==3) {
                EntFire("game_countdown", "AddOutput", "textcolor 255 70 0", delay);
            }
            else if (n==2) {
                EntFire("game_countdown", "AddOutput", "textcolor 254 20 1", delay);
            }
            else if (n==1) {
                EntFire("game_countdown", "AddOutput", "textcolor 255 0 0", delay);
            }*/
            n-=1;
        }
        EntFire("game_countdown", "SetDisplayText", "Start", delay+1.0);
        vote_num = 1;
        EntFire("Script", "RunScriptCode", "p_vote()", delay+1.25);
        //EntFire("Script", "RunScriptCode", "game_start_tri()", n+1.26);
        fade = Entities.CreateByClassname("env_fade");
        fade.__KeyValueFromInt("spawnflags", 5);
        fade.__KeyValueFromInt("duration", 1);
        fade.__KeyValueFromInt("ReverseFadeDuration", 1);
        fade.__KeyValueFromFloat("holdtime", 0.50);
        fade.__KeyValueFromString("rendercolor", "0 0 0");
        EntFireByHandle(fade, "Fade", "", delay+1.25, p, null);
        EntFireByHandle(fade, "Kill", "", delay+1.26, null, null);
    }
}

::Title <- function () {
    self.EmitSound(ui_snd[8]);
    //Createblackblur();
    skip_vote();
    local p,id,sc,tog,tg,view,brush,brush_ori,brush_ori_2;
    tg = "Title_bg";
    brush = Entities.FindByName(null, "Title");
    brush_ori = Vector(8677,428,56);
    brush_ori_2 = Vector(8677,428,129);
    local pos = Vector(8675,340,127);
    local snd = null;
    local file = null;
    snd = Entities.FindByName(null, "Music");//music
    if (snd != null) {
        EntFireByHandle(snd, "StopSound", "", 0.00, null, null);
        EntFireByHandle(snd, "Volume", "0", 0.00, null, null);
        file = ui_snd[6];
        EntFireByHandle(snd, "Addoutput", "message "+file, 1.00, null, null);
        EntFireByHandle(snd, "PlaySound", "", 1.01, null, null);
        EntFireByHandle(snd, "Volume", "10", 1.02, null, null);
    }
    for (local i=0;i<Player.len();i++) {
        if (Player[i][0] != null) {
            p = Player[i][0];
            if (p.IsValid()) {
                id = i;
                EntFire("clientcommand", "command", "play none", 0.00, p);
                view = Entities.FindByName(null, "character_view_id_"+id);
                view.SetOrigin(pos);
                brush.SetOrigin(brush_ori);
                local delay = 2.00;
                while (brush != null) {
                    delay += 0.01;
                    if (brush_ori.z < brush_ori_2.z) {
                        brush_ori.z += 3 ;
                        //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                        EntFireByHandle(brush, "Addoutput", "origin "+brush_ori.x+" "+brush_ori.y+" "+brush_ori.z, delay, null, null);
                    }
                    else {
                        break;
                    }
                }
                EntFireByHandle(brush, "Enable", "", 2.02, null, null);
                EntFire("Script", "RunScriptCode", "self.EmitSound(ui_snd[10])", 2.01);
            }
        }
    }
    EntFire("Script", "RunScriptCode", "title_delay()", 10.01);
}

::title_delay <- function () {
    local fade;
    if (!vote_complete) {
    fade = Entities.CreateByClassname("env_fade");
    fade.__KeyValueFromInt("spawnflags", 0);
    fade.__KeyValueFromInt("duration", 3);
    fade.__KeyValueFromInt("ReverseFadeDuration", 3);
    fade.__KeyValueFromFloat("holdtime", 2.00);
    fade.__KeyValueFromString("rendercolor", "0 0 0");
    EntFireByHandle(fade, "Fade", "", 0.00, null, null);
    EntFireByHandle(fade, "Kill", "", 0.01, null, null);
    EntFire("Script", "RunScriptCode", "game_start_tri()", 3.10);
    }
}

::hibiki <- false;
::verniy <- false;
::akatsuki <- false;
::ikazuchi <- false;
::inazuma <- false;
::Move_Choice <- function (id,act) {
    //printl("pressed..");
    //Character_CheckPlayers();
    local p = Player[id][0];
    local col = "255 128 64",col_2 = "0 128 0",col_3 = "255 255 255";
    local model = Entities.FindByName(null, "character_model_id_"+id),n;
    local pist = Entities.FindByName(null, "character_pist_id_"+id);
    local eq = Entities.FindByName(null, "character_eq_id_"+id);
    local brush,brush_ori = Vector(8876,139,216),brush_ori_2 = Vector(8613,139,216),
    brush_ori_3 = Vector(9635,139,216),brush_ori_4 = Vector(9372,139,216),
    brush_ori_5 = Vector(10375,139,216),brush_ori_6 = Vector(10112,139,216),
    brush_ori_7 = Vector(11128,139,216),brush_ori_8 = Vector(10865,139,216),
    brush_ori_9 = Vector(11896,139,216),brush_ori_10 = Vector(11633,139,216);
    brush = Entities.FindByName(null, "character_brush_id_"+id);
    local tog_name = "character_toggle_id_"+id;
    if (act==2) {
        EntFire("clientcommand", "command", "play "+ui_snd[1], 0.00, p);
        if (Choice_Slot[id][0]) {
            return;
        }
        else if (Choice_Slot[id][1]) {
            Choice_Slot[id][1] = false;
            Choice_Slot[id][0] = true;
            EntFire("character_random_id_"+id, "Color", "255 255 255");
            EntFireByHandle(model, "SetGlowEnabled", "", 0.00, null, null);
            EntFireByHandle(pist, "SetGlowDisabled", "", 0.00, null, null);
            EntFire("character_left_id_"+id, "Color", col_2);
            EntFire("character_right_id_"+id, "Color", col_2);
            EntFire("character_pist_left_id_"+id, "Color", col_3);
            EntFire("character_pist_right_id_"+id, "Color", col_3);
        }
    }
    if (act==3) {
        EntFire("clientcommand", "command", "play "+ui_snd[1], 0.00, p);
        if (Choice_Slot[id][0]) {
            Choice_Slot[id][0] = false;
            Choice_Slot[id][1] = true;
            if (Choice_model[id][0]) {
            EntFire("character_random_id_"+id, "Color", "0 0 0");
            }
            else {
            EntFireByHandle(model, "SetGlowDisabled", "", 0.00, null, null);
            }
            EntFireByHandle(pist, "SetGlowEnabled", "", 0.00, null, null);
            EntFire("character_left_id_"+id, "Color", col_3);
            EntFire("character_right_id_"+id, "Color", col_3);
            EntFire("character_pist_left_id_"+id, "Color", col_2);
            EntFire("character_pist_right_id_"+id, "Color", col_2);
        }
        else if (Choice_Slot[id][2]) {
            return;
        }
    }
    if (Choice_Slot[id][0]) {
        if (act==0) {
            EntFire("clientcommand", "command", "play "+ui_snd[2], 0.00, p);
            EntFire("character_left_id_"+id, "Color", col);
            EntFire("character_left_id_"+id, "Color", col_2, 0.10);

            if (Choice_model[id][0]) {
                n = 4;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFire("character_random_id_"+id, "Disable");
                EntFire("character_model_id_"+id, "Enable");
                EntFireByHandle(model, "SetGlowEnabled", "", 0.00, null, null);
                model.SetModel(Player_Model[0]);
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                model_Selected[id] = true;
                Choice_model[id][0] = false;
                Choice_model[id][5] = true;
            }
            else if (Choice_model[id][5]) {
                n = 3;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][5] = false;
                Choice_model[id][4] = true;
            }
            else if (Choice_model[id][4]) {
                n = 2;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][4] = false;
                Choice_model[id][3] = true;
            }
            else if (Choice_model[id][3]) {
                n = 1;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", "0", 0.00, null, null);
                Choice_model[id][3] = false;
                Choice_model[id][2] = true;
            }
            else if (Choice_model[id][2]) {
                n = 0;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                model_Selected[id] = true;
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", "1" 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][2] = false;
                Choice_model[id][1] = true;
            }
            else if (Choice_model[id][1]) {
                model_Selected[id] = false;
                model.SetModel(::zombie_model[23]);
                EntFire("character_random_id_"+id, "Enable");
                EntFire("character_model_id_"+id, "Disable");
                EntFireByHandle(model, "SetGlowDisabled", "", 0.00, null, null);
                Choice_model[id][1] = false;
                Choice_model[id][0] = true;
                //return;
            }
        }
        else if (act==1) {
            EntFire("clientcommand", "command", "play "+ui_snd[2], 0.00, p);
            EntFire("character_right_id_"+id, "Color", col);
            EntFire("character_right_id_"+id, "Color", col_2, 0.10);

            if (Choice_model[id][0]) {
                n = 0;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFire("character_random_id_"+id, "Disable");
                EntFire("character_model_id_"+id, "Enable");
                EntFireByHandle(model, "SetGlowEnabled", "", 0.00, null, null);
                model.SetModel(Player_Model[0]);
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", "1", 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                model_Selected[id] = true;
                Choice_model[id][0] = false;
                Choice_model[id][1] = true;
            }
            else if (Choice_model[id][1]) {
                n = 1;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", "0", 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][1] = false;
                Choice_model[id][2] = true;
            }
            else if (Choice_model[id][2]) {
                n = 2;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][2] = false;
                Choice_model[id][3] = true;
            }
            else if (Choice_model[id][3]) {
                n = 3;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                Choice_model[id][3] = false;
                Choice_model[id][4] = true;
            }
            else if (Choice_model[id][4]) {
                n = 4;
                EntFire(tog_name, "SetTextureIndex", n.tostring());
                model_Selected[id] = true;
                EntFireByHandle(model, "Skin", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetBodyGroup", n.tostring(), 0.00, null, null);
                EntFireByHandle(model, "SetAnimation", "pose6", 0.00, null, null);
                Choice_model[id][4] = false;
                Choice_model[id][5] = true;
            }
            else if (Choice_model[id][5]) {
                model_Selected[id] = false;
                model.SetModel(::zombie_model[23]);
                EntFire("character_random_id_"+id, "Enable");
                EntFire("character_model_id_"+id, "Disable");
                EntFireByHandle(model, "SetGlowDisabled", "", 0.00, null, null);
                Choice_model[id][5] = false;
                Choice_model[id][0] = true;
                //return;
            }
        }
        EntFire("Script", "RunScriptCode", "SetModelOri_Delay("+id+")", 0.00);
    }
    Charachter_info(id);
    if (Choice_Slot[id][0] && Choice_model[id][1] || Choice_Slot[id][0] && Choice_model[id][2] || Choice_Slot[id][0] && Choice_model[id][3]  || Choice_Slot[id][0] && Choice_model[id][4] ||
    Choice_Slot[id][0] && Choice_model[id][5] || Choice_Slot[id][0] && Choice_model[id][6] || Choice_Slot[id][0] && Choice_model[id][7]) {
        local delay = 0.00;
        EntFireByHandle(brush, "Disable", "", 0.00, null, null);
        while (brush != null) {
            delay += 0.01;
            if (id == 0 && brush_ori.x > brush_ori_2.x) {
                brush_ori.x -= 10;
                //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                EntFireByHandle(brush, "Addoutput", "origin "+brush_ori.x+" "+brush_ori.y+" "+brush_ori.z, delay, null, null);
            }
            else if (id == 1 && brush_ori_3.x > brush_ori_4.x) {
                brush_ori_3.x -= 10;
                //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                EntFireByHandle(brush, "Addoutput", "origin "+brush_ori_3.x+" "+brush_ori_3.y+" "+brush_ori_3.z, delay, null, null);
            }
            else if (id == 2 && brush_ori_5.x > brush_ori_6.x) {
                brush_ori_5.x -= 10;
                //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                EntFireByHandle(brush, "Addoutput", "origin "+brush_ori_5.x+" "+brush_ori_5.y+" "+brush_ori_5.z, delay, null, null);
            }
            else if (id == 3 && brush_ori_7.x > brush_ori_8.x) {
                brush_ori_7.x -= 10;
                //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                EntFireByHandle(brush, "Addoutput", "origin "+brush_ori_7.x+" "+brush_ori_7.y+" "+brush_ori_7.z, delay, null, null);
            }
            else if (id == 4 && brush_ori_9.x > brush_ori_10.x) {
                brush_ori_9.x -= 10;
                //brush.SetOrigin(Vector(brush_now_ori.x-1,brush_now_ori.y,brush_now_ori.z));
                EntFireByHandle(brush, "Addoutput", "origin "+brush_ori_9.x+" "+brush_ori_9.y+" "+brush_ori_9.z, delay, null, null);
            }
            else {
                break;
            }
        }
        EntFireByHandle(brush, "Enable", "", 0.01, null, null);
    }
    else {
        EntFireByHandle(brush, "Disable", "", 0.00, null, null);
    }
    if (Choice_Slot[id][1]) {
        local ori = Vector(8534,134,172),ori_2 = Vector(8534,134,173),ori_3 = Vector(9293,135,172),ori_4 = Vector(9293,135,173),
        ori_5 = Vector(10033,135,172),ori_6 = Vector(10033,135,173),ori_7 = Vector(10786,135,172),ori_8 = Vector(10786,135,173),
        ori_9 = Vector(11554,135,172),ori_10  = Vector(11554,135,173);
        if (act==0) {
            EntFire("clientcommand", "command", "play "+ui_snd[2], 0.00, p);
            EntFire("character_pist_left_id_"+id, "Color", col);
            EntFire("character_pist_left_id_"+id, "Color", col_2, 0.10);
            if (Choice_Pist[id][0]) {
                pist.SetModel(CaseList[23]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][0] = false;
                Choice_Pist[id][2] = true;
            }
            else if (Choice_Pist[id][2]) {
                pist.SetModel(CaseList[21]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][2] = false;
                Choice_Pist[id][1] = true;
            }
            else if (Choice_Pist[id][1]) {
                pist.SetModel(CaseList[22]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][1] = false;
                Choice_Pist[id][0] = true;
            }
        }
        else if (act==1) {
            EntFire("clientcommand", "command", "play "+ui_snd[2], 0.00, p);
            EntFire("character_pist_right_id_"+id, "Color", col);
            EntFire("character_pist_right_id_"+id, "Color", col_2, 0.10);
            if (Choice_Pist[id][0]) {
                pist.SetModel(CaseList[21]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][0] = false;
                Choice_Pist[id][1] = true;
            }
            else if (Choice_Pist[id][1]) {
                pist.SetModel(CaseList[23]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][1] = false;
                Choice_Pist[id][2] = true;
            }
            else if (Choice_Pist[id][2]) {
                pist.SetModel(CaseList[22]);
                if (id==0) {
                    pist.SetOrigin(ori);
                }
                else if (id==1) {
                    pist.SetOrigin(ori_3);
                }
                else if (id==2) {
                    pist.SetOrigin(ori_5);
                }
                else if (id==3) {
                    pist.SetOrigin(ori_7);
                }
                else if (id==4) {
                    pist.SetOrigin(ori_9);
                }
                Choice_Pist[id][2] = false;
                Choice_Pist[id][0] = true;
            }
        }
    }
}

::Character_Text <- [
    ["- 随机职业 -","- RandomClass -"],
    ["【护甲兵】","- ROOK -"],
    ["生命值：2000","Health:2000"],
    ["移动速度：0.8","Speed:0.8"],
    ["特殊技能：拥有XM1014专属伤害加成，开局自带护甲，\n每局结束将会获得新的护甲","Special skill:Extra XM1014 damage.Gain \n armor at the start and end of each round."],
    ["专属道具：可放置护甲包，可供队员补充","Exclusive item:Deployable armor pack."],
    ["道具携带量：6","Carrying capacity of item: 6"],
    ["可放置（地图中同时存在的数量）：1","Max number of armor pack can be \n deployed at the same time: 1"],

    ["【突击兵】","- Assault -"],
    ["生命值：1500","Health:1500"],
    ["移动速度：1.0","Speed:1.0"],
    ["特殊技能：拥有突击步枪和手枪的伤害加成，\n 每隔一段时间会获得一颗手雷","Special skills:Extra AR & handgun damage. \n Gain a nade every few tens of seconds."],
    ["专属道具：无","Exclusive item:None "],

    ["【医疗兵】 \n **团队中必须拥有此单位**","- Doctor -\n (Must exist)"],
    ["生命值：1800","Health:1800"],
    ["移动速度：1.2","Speed:1.2"],
    ["特殊技能：每隔一段时间将会补充一根医疗针，\n 拥有冲锋枪武器加成","Special skill:Extra SMG damage. \n Gain a medishot every few tens of seconds."],
    ["专属道具：可放置医疗包，可治疗队员 \n （注：自己不能使用医疗包）","Exclusive item:First aid kit \n ( Can only be used by teammates)."],
    ["道具携带量：30",""],
    ["可放置（地图中同时存在的数量）：3","Max number of first aid kit can be \n deployed at the same time: 3"],

    ["【支援兵】 \n **团队中必须拥有此单位**","- Support -\n (Must exist)"],
    ["生命值：1200","Health:1200"],
    ["移动速度：0.8","Speed:0.8"],
    ["特殊技能：拥有重型武器伤害加成，\n 每隔一段时间会获得燃烧弹","Special skill:Heavy weapon damage. Gain \n an incendiary  every few tens of seconds."],
    ["专属道具：可放置弹药包，可供队员补充","Exclusive item:Ammo pack"],
    ["道具携带量：","Carrying capacity of item: 6"],
    ["可放置（地图中同时存在的数量）：2","Max number of ammo pack can be \n deployed at the same time: 2"],

    ["【机械兵】","- Trap -"],
    ["生命值：1000","Health:1000"],
    ["移动速度：1.1","Speed:1.1"],
    ["特殊技能：拥有狙击武器伤害加成","Special skill:Extra sniper rifle damage."],
    ["专属道具：可放置“反人员地雷”，\n 以及可部署“自动防御转轮机枪","Exclusive items:Anti-personnel mine, \n deployable automated sentry gun"],
    ["道具携带量(地雷)：40","Carrying capacity of item: 40"],
    ["可放置（地图中同时存在的数量）：10","Max number of first aid kit can be \n deployed at the same time: 10"],

    ["这个角色已被其他人选择，\n 请勿重复选择","Has been used by others"],
    ["",""]
];
::Charachter_info <- function (id)
{
    local text = null;
    local ent = Entities.FindByName(null, "character_explain_id_"+id);
    for ( local i = 0; i < Choice_model.len(); i++ )
    {
        if ( Choice_model[id][i] )
        {
            switch (i)
            {
                case 0:
                {
                    text = ::Character_Text[0][::m_lang];
                    break;
                }
                case 1:
                {
                    text = ::Character_Text[1][::m_lang]+"\n"+::Character_Text[2][::m_lang]+"\n"+
                    ::Character_Text[3][::m_lang]+"\n"+::Character_Text[4][::m_lang]+"\n"+
                    ::Character_Text[5][::m_lang]+"\n"+::Character_Text[6][::m_lang]+"\n"+
                    ::Character_Text[7][::m_lang];
                    break;
                }
                case 2:
                {
                    text = ::Character_Text[8][::m_lang]+"\n"+::Character_Text[9][::m_lang]+"\n"+
                    ::Character_Text[10][::m_lang]+"\n"+::Character_Text[11][::m_lang]+"\n"+
                    ::Character_Text[12][::m_lang];
                    break;
                }
                case 3:
                {
                    text = ::Character_Text[13][::m_lang]+"\n"+::Character_Text[14][::m_lang]+"\n"+
                    ::Character_Text[15][::m_lang]+"\n"+::Character_Text[16][::m_lang]+"\n"+
                    ::Character_Text[17][::m_lang]+"\n"+::Character_Text[18][::m_lang]+"\n"+
                    ::Character_Text[19][::m_lang];
                    break;
                }
                case 4:
                {
                    text = ::Character_Text[20][::m_lang]+"\n"+::Character_Text[21][::m_lang]+"\n"+
                    ::Character_Text[22][::m_lang]+"\n"+::Character_Text[23][::m_lang]+"\n"+
                    ::Character_Text[24][::m_lang]+"\n"+::Character_Text[25][::m_lang]+"\n"+
                    ::Character_Text[26][::m_lang];
                    break;
                }
                case 5:
                {
                    text = ::Character_Text[27][::m_lang]+"\n"+::Character_Text[28][::m_lang]+"\n"+
                    ::Character_Text[29][::m_lang]+"\n"+::Character_Text[30][::m_lang]+"\n"+
                    ::Character_Text[31][::m_lang]+"\n"+::Character_Text[32][::m_lang]+"\n"+
                    ::Character_Text[33][::m_lang];
                    break;
                }
                default:
                    break;
            }
            EntFireByHandle(ent, "SetDisplayText", text, 0.00, null, null);
        }
    }
};

::SetModelOri_Delay <- function (id) {
    local model = Entities.FindByName(null, "character_model_id_"+id);
    local model_ori_1 = Vector(8533,128,198),model_ori_1b = Vector(8525,128,198),
    model_ori_2 = Vector(9292,128,198),model_ori_2b = Vector(9284,128,198),
    model_ori_3 = Vector(10032,128,198),model_ori_3b = Vector(10022,128,198),
    model_ori_4 = Vector(10785,128,198),model_ori_4b = Vector(10777,128,198),
    model_ori_5 = Vector(11553,128,198),model_ori_5b = Vector(11545,128,198);
    //if (model.GetModelName() != Player_Model[4]) {
        if (id==0) {
            model.SetOrigin(model_ori_1);
          }
        else if (id==1) {
              model.SetOrigin(model_ori_2);
          }
         else if (id==2) {
             model.SetOrigin(model_ori_3);
         }
         else if (id==3) {
             model.SetOrigin(model_ori_4);
         }
         else if (id==4) {
              model.SetOrigin(model_ori_5);
         }
       //}
      //else {
         if (id==0) {
            model.SetOrigin(model_ori_1b);
           }
        else if (id==1) {
            model.SetOrigin(model_ori_2b);
          }
        else if (id==2) {
            model.SetOrigin(model_ori_3b);
            }
        else if (id==3) {
            model.SetOrigin(model_ori_4b);
        }
        else if (id==4) {
            model.SetOrigin(model_ori_5b );
        }
   //}
}

Screen <- null;
SetPlayerScreen <- function ()
{
    local file = "effects/blackblur.vtf";
    if ( Screen == null )
    {
        Screen = Entities.CreateByClassname("env_screenoverlay");
        Screen.__KeyValueFromString("OverlayName1", file);
        Screen.__KeyValueFromInt("OverlayTime1", -1);
    }
    EntFireByHandle(Screen, "StopOverlays", "", 0.00, null, null);
    EntFireByHandle(Screen, "StartOverlays", "", 0.00, null, null);
}