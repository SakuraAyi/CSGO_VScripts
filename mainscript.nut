//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

Pi <- 3.14159265
TwoPi <- 6.2831853
HalfPi <- 1.5707963

Rad <- 0.01745329251994329576923690768489
Deg <- 57.295779513082320876798154814105

//==================//
//--Math Functions--//
//==================//
//Distance between the x/y components of two 3D vectors.
function Distance2D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	
	return sqrt((a*a)+(b*b));
}

//Distance between two 3D vectors.
function Distance3D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	local c = (v2.z-v1.z);
	
	return sqrt((a*a)+(b*b)+(c*c));
}

//Return the Pitch and Yaw between two 3D vectors.
function AngleBetween(v1,v2)
{
		local aZ = atan2((v1.y - v2.y),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),Distance2D(v1,v2))+Pi;
		
		return Vector(aY,aZ,0.0);
}

function AngleBetween2(v1,v2)
{
		local aZ = atan2((v1.z - v2.z),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),(v1.y - v2.y))+Pi;
		
		return Vector(aY,aZ,0.0);
}

//Returns the difference between two angles
//actionsnippet.com/?p=1451
function AngleDiff(angle0,angle1)
{
    return (abs((angle0 + Pi -  angle1)%(Pi*2.)) - Pi);
}

//Normalizes a vector
function Normalize(v)
{
	local len = v.Length();
	return Vector(v.x/len,v.y/len,v.z/len);
}

//Cross product of two vectors
function Cross(v1, v2) 
{
	local v = Vector(0.0,0.0,0.0);
	v.x = ( (v1.y * v2.z) - (v1.z * v2.y) );
	v.y = ( (v1.x * v2.z) - (v1.z * v2.x) );
	v.z = ( (v1.x * v2.y) - (v1.y * v2.x) );
	return v;
}

//Constrain a number to a given range
function clamp(v,mi,ma)
{
	if(v < mi) return mi;
	if(v > ma) return ma;
	return v;
}

//Return the biggest of two numbers.
function max(v1,v2)
{
	if(v1 > v2) return v1;
	return v2;
}

//Return the smallest of two numbers.
function min(v1,v2)
{
	if(v1 < v2) return v1;
	return v2;
}
//Vector multiplication fix
function Mul(v1,v2)
{
	local typ = typeof(v2);
	
	//Vector * Scalar
	if(typ == "integer" || typ == "float")
	{
		return Vector(v1.x*v2,v1.y*v2,v1.z*v2);
	}
	//Vector * Vector
	if(typ == "Vector")
	{
		return Vector(v1.x*v2.x,v1.y*v2.y,v1.z*v2.z);
	}
	return null;
}

//=================//
//--Trace Helpers--//
//=================//
/*class TraceInfo 
{
	constructor(h,d)
	{
		Hit = h;
		Dist = d;
	}

	Hit = null;
	Dist = null;
}
//Returns the hit position of a trace between two points.
function TraceVec(start, end, filter)
{
	local dir = (end-start);
	local frac = TraceLine(start,end,filter);
	//return start+(dir*frac);
	return TraceInfo(start+(dir*frac),dir.Length());
}
//Returns the hit position of a trace along a normalized direction vector.
function TraceDir(orig, dir, maxd, filter)
{
	local frac = TraceLine(orig,orig+dir*maxd,filter);
	if(frac == 1.0) { return TraceInfo(orig+(dir*maxd),0.0);}
	return TraceInfo(orig+(dir*(maxd*frac)),maxd*frac);
}*/

//=================//
//--Debug Helpers--//
//=================//

//Draws a cross showing the X, Y, and Z axes.
function DrawAxis(pos,s,nocull,time)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-s), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
}

//Draw the bounding box of a given entity.
function DrawEntityBBox(ent,r,g,b,a,time)
{
	DebugDrawBox(ent.GetOrigin(),ent.GetBoundingMins(), ent.GetBoundingMaxs(), r, g, b, a, time)
}

//Draws a line along a given normal.
function DrawNormal(pos,norm,s,time)
{
	local ns = norm*s;
	DebugDrawLine(Vector(pos.x,pos.y,pos.z), Vector(pos.x+ns.x,pos.y+ns.y,pos.z+ns.z), 0, 255, 255, false, time);	
}

::VS <- 
{
    function SendToServer (param)
    {
        EntFire("servercommand", "command", param);
        printl(param);
    },
    function GiveEquip (entity, param)
    {
        local eq = Entities.CreateByClassname( "game_player_equip" );
        eq.__KeyValueFromInt("spawnflags", 5);
        eq.__KeyValueFromInt(param, 1);
        EntFireByHandle(eq, "Use", "", 0.00, entity, eq);
        EntFireByHandle(eq, "Kill", "", 0.00, null, null);
    },
    function SendMsgToPlayer (entity, param)
    {
        local ent = Entities.CreateByClassname("env_message");
        ent.__KeyValueFromString("message", param);
        EntFireByHandle(ent, "ShowMessage", "", 0.00, entity, null);
    },
    function SetSpeed (entity ,mod, param)
    {

        for ( local i = 0; i < _speedmod.len(); i++ )
        {
            if ( i == mod )
                EntFireByHandle(::_speedmod[i], "ModifySpeed", param.tostring(), 0.01, entity, null);
            else
                EntFireByHandle(::_speedmod[i], "ModifySpeed", "1.0", 0.00, entity, null);
        }
    },
    function PlayClientSnd (entity, param)
    {
        EntFire("clientcommand", "command", "Play "+param, 0.00, entity);
    },
    function PlayPosSnd (vec,param,vol,delay)
    {
        local ent = Entities.FindByName(null, "map_world_sound");
        ent.__KeyValueFromString("message", param);
        ent.SetOrigin(vec);
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volume", vol.tostring(), 0.00, null, null);
    },
    function SetAni (entity, param)
    {
        EntFireByHandle(entity, "SetAnimation", param, 0.00, null, null);
    }
};

LoadCmd <- function () 
{
        ::VS.SendToServer("sv_disable_immunity_alpha 1"); //禁止免疫alpha
        ::VS.SendToServer("mp_warmup_end"); //结束热身
        //::VS.SendToServer("gameinstructor_enable 1"); //是否开启玩家引导HUD
        ::VS.SendToServer("sv_cheats 0"); //开启作弊模式
        ::VS.SendToServer("mat_fullbright 0"); //地图全亮
        ::VS.SendToServer("sv_gravity 1200");  //玩家重力
        ::VS.SendToServer("sv_maxspeed 320"); //玩家速度，最大320，超出不变
        ::VS.SendToServer("sv_deadtalk 1"); //死亡后是否可以和存活玩家讲话和打字
        ::VS.SendToServer("sv_voiceenable 1"); //语音是否开启
        //::VS.SendToServer("sv_alltalk 1"); //是否允许CT和T语音互通（不推荐，替换以下两条）
        //::VS.SendToServer("sv_talk_enemy_dead 1"); //死亡状态的玩家是否可以听到敌人的语音和打字
        //::VS.SendToServer("sv_talk_enemy_living 1"); //存活状态的玩家是否可以听到敌人的语音和打字
        ::VS.SendToServer("sv_full_alltalk 1"); //任何玩家包括观察者都能够进行对话
        ::VS.SendToServer("sv_ignoregrenaderadio 1");

        ::VS.SendToServer("mp_ignore_round_win_conditions 1"); //是否无视结束当局的条件，即不会结束
        ::VS.SendToServer("mp_weapons_allow_map_placed 1"); //允许地图上默认放置的武器
        ::VS.SendToServer("mp_free_armor 0"); //免费的护甲 2为全甲
        ::VS.SendToServer("mp_defuser_allocation 0"); //是否免费发放拆弹器，1=随机，2=所有人
        ::VS.SendToServer("mp_require_gun_use_to_acquire 0"); //武器是否只能按E拾取
        ::VS.SendToServer("mp_respawn_immunitytime 0");//重生后的免疫攻击时间，单位/s
        ::VS.SendToServer("mp_teammates_are_enemies 0"); //团队是否互相成为敌对状态
        ::VS.SendToServer("mp_friendlyfire 1"); //是否开启友军伤害
        ::VS.SendToServer("ff_damage_reduction_bullets 0.3"); //友军伤害的比例，为0-1。子弹的伤害
        ::VS.SendToServer("ff_damage_reduction_grenade 0.1"); //友军伤害的比例，为0-1。手雷的伤害
        ::VS.SendToServer("ff_damage_reduction_grenade_self 0.3"); //手雷对自己伤害的比例，为0-1。手雷的伤害
        ::VS.SendToServer("ff_damage_reduction_other 0.3"); //友军伤害的比例，为0-1。除了子弹和手雷以外的伤害
        ::VS.SendToServer("ff_damage_bullet_penetration 0"); //如果友军伤害关闭，子弹的穿透力衰减
        ::VS.SendToServer("mp_damage_headshot_only 0"); //是否只允许爆头
        ::VS.SendToServer("mp_damage_scale_ct_body 1"); //对CT身体部位的伤害比例
        ::VS.SendToServer("mp_damage_scale_ct_head 1"); //对CT头部位的伤害比例
        ::VS.SendToServer("mp_damage_scale_t_body 1"); //对T身体部位的伤害比例
        ::VS.SendToServer("mp_damage_scale_t_head 1"); //对T头部位的伤害比例
        ::VS.SendToServer("mp_damage_vampiric_amount 0"); //是否开启吸血模式（击中玩家，对方所扣除的血量，将会返回给自己）
        ::VS.SendToServer("mp_give_player_c4 0"); //是否开局给玩家生成C4
        ::VS.SendToServer("mp_anyone_can_pickup_c4 1"); //是否任何人都能捡起C4
        ::VS.SendToServer("mp_death_drop_c4 1"); //死亡后是否掉落C4
        ::VS.SendToServer("mp_c4_cannot_be_defused 0"); //C4是否不能被拆除，1为不能
        ::VS.SendToServer("mp_c4timer 45"); //C4倒计时有多少秒
        ::VS.SendToServer("mp_drop_grenade_enable 1"); //是否可以丢弃投掷物
        ::VS.SendToServer("mp_drop_knife_enable 1"); //是否可以丢弃匕首
        ::VS.SendToServer("mp_death_drop_grenade 0"); //死后是否会掉落投掷物
        ::VS.SendToServer("mp_death_drop_gun 0"); //死后是否会掉落枪支
        ::VS.SendToServer("mp_death_drop_taser 0"); //死后是否会掉落电击枪
        ::VS.SendToServer("mp_teamcashawards 0"); //是否开启小队金钱奖励
        ::VS.SendToServer("mp_playercashawards 0"); //是否开启玩家金钱奖励
        ::VS.SendToServer("mp_afterroundmoney 0"); //回合之后给予玩家的金额
        ::VS.SendToServer("mp_economy_reset_rounds 0"); //每回合是否重置玩家的钱
        ::VS.SendToServer("mp_logmoney 0"); //开启资金记录
        ::VS.SendToServer("mp_maxmoney 32000"); //最大的资金
        ::VS.SendToServer("mp_startmoney 32000"); //初始资金
        ::VS.SendToServer("mp_buy_anywhere 0"); //任何地方开启购买
        ::VS.SendToServer("mp_buytime 3600"); //购买时间，单位/s
        ::VS.SendToServer("mp_weapons_allow_zeus 0"); //是否允许使用电击枪
        ::VS.SendToServer("maxplayers 32"); //最大玩家数量
        ::VS.SendToServer("mp_freezetime 0" );//开局玩家的冻结时间
        ::VS.SendToServer("mp_respawn_on_death_t 1");//是否开启T阵营死亡重生
        ::VS.SendToServer("mp_respawn_on_death_ct 1");//是否开启CT阵营死亡重生
        ::VS.SendToServer("mp_match_end_restart 1"); //游戏结束是否重启，而不是加载新地图
        ::VS.SendToServer("mp_match_restart_delay 5"); //游戏多久重启之前需要多久，单位/s
        ::VS.SendToServer("mp_match_end_changelevel 1"); //游戏结束后执行下一张图，即使一样
        ::VS.SendToServer("mp_endmatch_votenextmap 0"); //游戏结束是否允许投票换地图
        ::VS.SendToServer("mp_maxrounds 100"); //游戏最大有多少局
        ::VS.SendToServer("mp_round_restart_delay 3 "); //一局结束多久进入下一局，单位/s
        ::VS.SendToServer("mp_roundtime 60"); //一局多少时间,单位/min 除去拆弹和人质
        ::VS.SendToServer("mp_roundtime_defuse 60");//拆弹一局多少时间,单位/min
        ::VS.SendToServer("mp_roundtime_hostage 60");//人质一局多少时间,单位/min
        ::VS.SendToServer("mp_autoteambalance 0"); //是否打开队伍自动平衡
        ::VS.SendToServer("mp_limitteams 0"); //两阵营能接受的最大人数差距
        ::VS.SendToServer("mp_unpause_match"); //取消暂停
        ::VS.SendToServer("mp_humanteam any"); //人类可加入的阵营
        ::VS.SendToServer("mp_solid_teammates 0"); //是否穿过队友，0=完全穿透，1=可阻挡，2=只能站头顶
        ::VS.SendToServer("mp_autokick 0"); //是否开启自动踢人
        ::VS.SendToServer("mp_spectators_max 10"); //最大观察者数量
        ::VS.SendToServer("mp_forcecamera 1"); //玩家死亡后的视角范围，0=可观看任何队伍，1=只能看自己队伍，2=谁都看不了，黑屏

        ::VS.SendToServer("spec_freeze_deathanim_time 0"); //死亡后多久看见被击杀信息的时间，单位/s
        ::VS.SendToServer("spec_freeze_panel_extended_time 0");//冻结视角结束后，任然停留的时间
        ::VS.SendToServer("spec_freeze_time 1"); //死亡视角冻结时间有多长？单位/s
        ::VS.SendToServer("spec_freeze_time_lock 0.8"); //多长时间锁定玩家跳过冻结视角，单位/s
        ::VS.SendToServer("spec_freeze_traveltime 0"); //在死亡视角锁定对象并且定格需要的时间，单位/s （mp_forcecamera为0即可锁定敌方角色）

        ::VS.SendToServer("bot_allow_sub_machine_guns 1"); //BOT是否允许使用冲锋枪
        ::VS.SendToServer("bot_allow_pistols 1"); //BOT是否允许使用手枪
        ::VS.SendToServer("bot_allow_machine_guns 1"); //BOT是否允许使用机枪
        ::VS.SendToServer("bot_allow_rifles 1"); //BOT是否允许使用步枪
        ::VS.SendToServer("bot_allow_snipers 1"); //BOT是否允许使用狙击枪
        ::VS.SendToServer("bot_allow_shotguns 1"); //BOT是否允许使用霰弹枪
        ::VS.SendToServer("bot_knives_only"); //BOT是否只用匕首
        ::VS.SendToServer("bot_ignore_players 0"); //BOT是否无视玩家
        ::VS.SendToServer("bot_ignore_enemies 0"); //BOT是否无视敌人
        ::VS.SendToServer("bot_freeze 0"); //BOT是否冻结
        ::VS.SendToServer("bot_stop 0"); //是否停止BOT的一切行为
        ::VS.SendToServer("bot_chatter 0"); //BOT是否可以发无线电
        ::VS.SendToServer("bot_join_team t"); //BOT加入哪个阵营？
        ::VS.SendToServer("bot_dont_shoot 0"); //BOT是否不能开枪
        ::VS.SendToServer("bot_difficulty 3"); //BOT难度，0=简单，1=普通，2=困难，3=专家
        ::VS.SendToServer("bot_join_after_player 1"); //BOT是否在人类加入之后加入
        ::VS.SendToServer("bot_max_vision_distance_override -1"); //BOT多少距离能看见目标，单位为英寸
        ::VS.SendToServer("bot_max_visible_smoke_length 50"); //BOT透过这个烟雾多少长度能看到玩家？单位为英寸
        ::VS.SendToServer("bot_max_hearing_distance_override -1"); //BOT多少距离能听到目标动静？单位为英寸
        ::VS.SendToServer("bot_mimic 0");
        ::VS.SendToServer("healthshot_health 300");
        ::VS.SendToServer("healthshot_healthboost_time 2.5");
        ::VS.SendToServer("healthshot_healthboost_speed_multiplier 1.5");
        ::VS.SendToServer("healthshot_healthboost_damage_multiplier 1.5")
        ::VS.SendToServer("mp_weapons_allow_heavyassaultsuit 0");
        ::VS.SendToServer("ammo_item_limit_healthshot 1");
        ::VS.SendToServer("ammo_grenade_limit_total 4");
        ::VS.SendToServer("ammo_grenade_limit_flashbang 1");
        ::VS.SendToServer("ammo_grenade_limit_default 10");
        ::VS.SendToServer("ammo_338mag_max 60");
        ::VS.SendToServer("ammo_357sig_max 104");
        ::VS.SendToServer("ammo_357sig_min_max 120");
        ::VS.SendToServer("ammo_357sig_p250_max 182");
        ::VS.SendToServer("ammo_357sig_small_max 192");
        ::VS.SendToServer("ammo_45acp_max 200");
        ::VS.SendToServer("ammo_50AE_max 35");
        ::VS.SendToServer("ammo_556mm_box_max 600");
        ::VS.SendToServer("ammo_556mm_max 360");
        ::VS.SendToServer("ammo_556mm_small_max 360");
        ::VS.SendToServer("ammo_57mm_max 500");
        ::VS.SendToServer("ammo_762mm_max 360");
        ::VS.SendToServer("ammo_9mm_max 240");
        ::VS.SendToServer("ammo_buckshot_max 64");
        ::VS.SendToServer("ammo_grenade_limit_breachcharge 0");

        ::VS.SendToServer("sv_hegrenade_damage_multiplier 5");
};
LoadCmd();
::VS.SendToServer("bot_kick");

::m_lang <- 0;
::ChangeLanguage <- function () {
    if (m_lang == 1) {
    m_lang = 0;
    ScriptPrintMessageChatAll("\x01 \x05 地图已更改语言为中文");
    brushtext(0);
    }
    else {
    m_lang = 1;
    ScriptPrintMessageChatAll("\x01 \x05 Changed to English");
    brushtext(1);
    }

    for ( local i = 0; i < Player.len(); i++ )
    {
        if ( Player[i][0] != null && Player[i][0].IsValid() )
            ::Charachter_info(i);
    }
}

::brushtext <- function (n) {
    local tog,tg;  
    tg = "explain"
    tog = Entities.CreateByClassname("env_texturetoggle");
    tog.__KeyValueFromString("target", tg);
    EntFireByHandle(tog, "SetTextureIndex", ""+n, 0.00, null, null);
    EntFireByHandle(tog, "Kill", "", 0.01, null, null);
}

function Precache() {
    //NaziZombies
    printl("预缓存...");
    /*for (local i=1;i<5;i++) { //HECU
        self.PrecacheModel(Player_Model[0]+i+".mdl");
        printl("model:"+Player_Model[0]+i+".mdl");
    }*/
    //self.PrecacheScriptSound( EXPLOSION_SOUND );

    for (local i=0;i<Player_Model.len();i++) {
        self.PrecacheModel(Player_Model[i]);
        printl("model:"+Player_Model[i]);
    }
    for (local i=0;i<zombie_model.len();i++) {
        self.PrecacheModel(zombie_model[i]);
        printl("model:"+zombie_model[i]);
    }
    for (local i=0;i<CaseList.len();i++) {
        self.PrecacheModel(CaseList[i]);
        printl("case:"+CaseList[i]);
    }
    for (local i=0;i<ui_snd.len();i++) {
        self.PrecacheSoundScript(ui_snd[i]);
        printl("sound:"+ui_snd[i]);
    }
    for (local i=0;i<map_snd.len();i++) {
        self.PrecacheSoundScript(map_snd[i]);
        printl("sound:"+map_snd[i]);
    }
    for (local i=0;i<item_snd.len();i++) {
        self.PrecacheSoundScript(item_snd[i]);
        printl("sound:"+item_snd[i]);
    }
    for (local i=1;i<11;i++) {
        self.PrecacheSoundScript(cheer_list[0]+i+".mp3");
        printl("sound:"+cheer_list[0]+i+".mp3");
    }
    self.PrecacheSoundScript(cheer_list[1]);
    for (local i=0;i<MusicList.len();i++) {
        self.PrecacheSoundScript(MusicList[i]);
        printl("music:"+MusicList[i]);
    }
    for (local i=0;i<Background_music.len();i++) {
        self.PrecacheSoundScript(Background_music[i]);
        printl("music:"+Background_music[i]);
    }
    for (local i=0;i<21;i++) {
        self.PrecacheSoundScript(zombie_snd[0]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[0]+i+".mp3");
    }
    for (local i=0;i<14;i++) {
        self.PrecacheSoundScript(zombie_snd[1]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[1]+i+".mp3");
    }
    for (local i=0;i<28;i++) {
        self.PrecacheSoundScript(zombie_snd[2]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[2]+i+".mp3");
    }
    for (local i=0;i<11;i++) {
        self.PrecacheSoundScript(zombie_snd[3]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[3]+i+".mp3");
    }
    for (local i=0;i<12;i++) {
        self.PrecacheSoundScript(zombie_snd[4]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[4]+i+".mp3");
    }
    for (local i=0;i<7;i++) {
        self.PrecacheSoundScript(zombie_snd[5]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[5]+i+".mp3");
    }
    for (local i=0;i<7;i++) {
        self.PrecacheSoundScript(zombie_snd[6]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[6]+i+".mp3");
    }
    for (local i=0;i<2;i++) {
        self.PrecacheSoundScript(zombie_snd[7]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[7]+i+".mp3");
    }
    for (local i=0;i<5;i++) {
        self.PrecacheSoundScript(zombie_snd[8]+i+".mp3");
        printl("zombie_snd:"+zombie_snd[8]+i+".mp3");
    }
    for (local i=9;i<zombie_snd.len();i++) {
        self.PrecacheSoundScript(zombie_snd[i]);
        printl("zombie_snd:"+zombie_snd[i]);
    }
    for (local i=0;i<Reloading_Voice.len();i++) {
        self.PrecacheSoundScript(Reloading_Voice[i]);
        printl("sound:"+Reloading_Voice[i]);
    }
    for (local i=0;i<Grenade_Voice.len();i++) {
        self.PrecacheSoundScript(Grenade_Voice[i]);
        printl("sound:"+Grenade_Voice[i]);
    }
    for (local i=0;i<FriendlyFire_Voice.len();i++) {
        self.PrecacheSoundScript(FriendlyFire_Voice[i]);
        printl("sound:"+FriendlyFire_Voice[i]);
    }
    for (local i=0;i<Player_Hurt_Voice.len();i++) {
        self.PrecacheSoundScript(Player_Hurt_Voice[i]);
        printl("sound:"+Player_Hurt_Voice[i]);
    }
    for (local i=0;i<Player_Voice_Event_Sound.len();i++) {
        self.PrecacheSoundScript(Player_Voice_Event_Sound[i]);
        printl("sound:"+Player_Voice_Event_Sound[i]);
    }
    for (local i=0;i<Player_Kill_Voice.len();i++) {
        self.PrecacheSoundScript(Player_Kill_Voice[i]);
        printl("sound:"+Player_Kill_Voice[i]);
    }
    for (local i=0;i<Player_NiceShot_Voice.len();i++) {
        self.PrecacheSoundScript(Player_NiceShot_Voice[i]);
        printl("sound:"+Player_NiceShot_Voice[i]);
    }
    for (local i=0;i<panzer_snd_list.len();i++) {
        self.PrecacheSoundScript(panzer_snd_list[i]);
        printl("sound:"+panzer_snd_list[i]);
    }
    for (local i=0;i<Wave_NG_VO.len();i++) {
        self.PrecacheSoundScript(Wave_NG_VO[i]);
        printl("sound:"+Wave_NG_VO[i]);
    }
    for (local i=0;i<Event_Snd.len();i++) {
        self.PrecacheSoundScript(Event_Snd[i]);
        printl("sound:"+Event_Snd[i]);
    }
    for (local i=0;i<lighting_snd.len();i++) {
        self.PrecacheSoundScript(lighting_snd[i]);
        printl("sound:"+lighting_snd[i]);
    }
    
    self.PrecacheSoundScript(::ATC_SND[0]);
    self.PrecacheSoundScript(::ATC_SND[2]);
    self.PrecacheSoundScript(::ATC_SND[3]);
    self.PrecacheSoundScript(::ATC_SND[4]);
    for ( local i = 1; i < 11; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[1]+i+".mp3");
    }
    for ( local i = 1; i < 35; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[5]+i+".mp3");
    }
    for ( local i = 1; i < 40; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[6]+i+".mp3");
    }
    for ( local i = 1; i < 9; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[7]+i+".mp3");
    }
    for ( local i = 1; i < 15; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[8]+i+".mp3");
    }
    for ( local i = 1; i < 6; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[9]+i+".mp3");
    }
    for ( local i = 1; i < 3; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[10]+i+".mp3");
    }
    for ( local i = 1; i < 6; i ++ )
    {
        self.PrecacheSoundScript(::ATC_SND[11]+i+".mp3");
    }
    for ( local i = 1; i < 21; i ++ )
    {
        if ( i < 10 )
            self.PrecacheSoundScript(::ATC_SND[12]+"0"+i+".mp3");
        else
             self.PrecacheSoundScript(::ATC_SND[12]+i+".mp3");
    }
    //CreateSpeedTri();
    //Createblackblur();
}

::EntIO <- function (entitiy,output,target,input,param,delay,max) {

    local line = output+" "+target+":"+input+":"+param+":"+delay+":"+max;
    EntFireByHandle(entitiy, "AddOutput", line, 0.00, null, null);

    //ScriptPrintMessageChatAll("I/O Load");

}

::neg <- function (param) {
    
    local a = param;
    local b = a - (a * 2);
    
    if (param <= 0)

    return a;

    else

    return b;

}

::GetPlayerByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        return user;
                        break;
                    }
                }
            }
        }
    }
}

::GetNameByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        local tb = getconsttable();
                        return tb[user.GetScriptScope().userid];
                    }
                }
            }
        }
    }
}

::Get32IDByUserid <- function (uid) {
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if ("userid" in user.GetScriptScope()) {
                    if (user.GetScriptScope().userid == uid) {
                        local tb = getconsttable();
                        return tb[user.GetScriptScope().userid.tostring()];
                    }
                }
            }
        }
    }
}

::CreateSpeedTri <- function () {
    local ent = null;
    while ((ent = Entities.FindByClassname(ent, "player_speedmod")) != null) {
        if (ent.IsValid()) {
            ent.Destroy();
        }
    }
    EntFire("Script", "RunScriptCode", "CreateSpeed_delay()", 1.00);
}
::_speedmod <- [null, null, null];
CreateSpeed_delay <- function () {
    local ent = Entities.CreateByClassname("player_speedmod");
    local name = "Player_SpeedMod_";
    ent.__KeyValueFromString("targetname", name);

    local ent_limit = Entities.CreateByClassname("player_speedmod");
    local name_limit = "Player_SpeedMod_limit";
    ent_limit.__KeyValueFromString("targetname", name_limit);
    ent_limit.__KeyValueFromInt("spawnflags",13);

    local ent_limit_2 = Entities.CreateByClassname("player_speedmod");
    local name_limit_2 = "Player_SpeedMod_limit_2";
    ent_limit_2.__KeyValueFromString("targetname", name_limit_2);
    ent_limit_2.__KeyValueFromInt("spawnflags",12);

    DoEntFire("!self", "RunScriptCode", "RegSpeedMod()", 0.10, self, self);
    //printl("SpeedMod创建完毕");
}

RegSpeedMod <- function ()
{
    local ent;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        //if ( ent.GetClassname() == "player_speedmod" )
        //{
        if ( ent.GetName() == "Player_SpeedMod_" )
            ::_speedmod[0] = ent;
        else if ( ent.GetName() == "Player_SpeedMod_limit" )
            ::_speedmod[1] = ent;
        else if ( ent.GetName() == "Player_SpeedMod_limit_2" )
            ::_speedmod[2] = ent;
            //}
    }
}

