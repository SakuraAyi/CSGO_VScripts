//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

/*
-----职业设定-----

【护甲兵】
生命值：2000；
移动速度：0.8；
特殊技能：开局自带护甲，每局结束将会获得新的护甲；
专属道具：可放置护甲包，可供队员补充（一个包有5块甲，一人仅补充一次）；
道具携带量：6
可放置（地图中同时存在的数量）：1

【突击兵】
生命值：1500；
移动速度：1.0；
特殊技能：拥有突击步枪 以及 手枪的伤害加成，每隔一段时间会获得一颗手雷；
专属道具：无；
道具携带量：null;
可放置（地图中同时存在的数量）：null;

【支援兵】*****团队中必须拥有此单位*****
生命值：1200；
移动速度：0.8；
特殊技能：拥有重型武器伤害加成，每隔一段时间会获得燃烧弹;
专属道具：可放置弹药包，可供队员补充（一个包可拿取5次弹药）；
道具携带量：6
可放置（地图中同时存在的数量）：2

【医疗兵】*****团队中必须拥有此单位*****
生命值：1800;
移动速度：1.2；
特殊技能：每隔一段时间将会补充一根医疗针，拥有冲锋枪武器加成；
专属道具：可放置医疗包，可治疗队员（注：自己不能使用医疗包）
道具携带量：30;
可放置（地图中同时存在的数量）：3;

【机械兵】
生命值：1000；
移动速度：1.1
特殊技能：拥有狙击武器伤害加成，每隔一段时间会获得遥控炸弹（前提得清空遥控炸弹，官方BUG：如果扔完了立马切换武器，遥控炸弹不会被清除。需要拿着遥控一小会才会被系统清除）；
专属道具：可放置“反人员地雷”，以及可部署“自动防御转轮机枪”（注：机枪塔可以随时移动，有20的生命值，需要补充弹药。如毁坏无法修复以及补充）
道具携带量(地雷)：40;  注：机枪塔仅限一架，不可再次补充；
可放置（地图中同时存在的数量）：10；

----------
*/





//  写的真是很乱嗷！能实现就好了！懒得改 _(:з」∠)_

enum career 
{
    rook,
    assault,
    support,
    doctor,
    trap
};

::CareerExist <- [false,false,false,false,false];
::CareerExist2 <- [false,false,false,false,false];

GetCareerName <- function (param)
{
    if ( param == career.rook )
    {
        local text = ["护甲兵","ROOK"];
        return text[::m_lang];
    }
    else if ( param == career.assault )
    {
        local text = ["突击兵","Assault"];
        return text[::m_lang];
    }
    else if ( param == career.support )
    {
        local text = ["支援兵","Support"];
        return text[::m_lang];
    }
    else if ( param == career.doctor )
    {
        local text = ["医疗兵","Doctor"];
        return text[::m_lang];
    }
    else if ( param == career.trap )
    {
        local text = ["机械兵","Trap"];
        return text[::m_lang];
    }
}

second <- 0;
second_b <- 0;
second_c <- 0;
second_d <- 0;

second_e <- 0;
second_f <- 0;
second_g <- 0;

delay <- pow(10, 2); // 20s
delay_b <- pow(10, 2); // 10.95445115010332, 10s
delay_c <- pow(2.23606797749979, 2); // 
delay_d <- pow(2.23606797749979, 2); // 0.5s

delay_e <- 250;
delay_f <- 300;
delay_g <- 150;

::Player_DefSpeed <- [1.0,1.0,1.0,1.0,1.0];

SetVOC <- function (id,index) 
{
    local p,sc;
    p = Player[id][0];
    sc = p.GetScriptScope();
    if (index==1) 
    {
        sc._class <- career.rook;
    }
    else if (index==2) 
    {
        sc._class <- career.assault;
    }
    else if (index==3)
    {
        sc._class <- career.doctor;
    }
    else if (index==4) 
    {
        sc._class <- career.support;
    }
    else if (index==5) 
    {
        sc._class <- career.trap;
    }
    ::CareerExist[sc._class] = true;
    //p.SetModel(zombie_model[23]);
}

vocskill_confirm <- function () 
{

    local ent,p,sc,id,voc,sp,eq,wpn,idx,idxB;

    while ((ent = Entities.FindByClassname(ent, "*")) != null) 
    {

        if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot") 
        {

            p = ent;

            if (p.IsValid()) 
            {

                if (p.GetTeam() == 3) 
                {

                    for (local i=0;i<Player.len();i++) 
                    {

                        if (Player[i][0] == p) 
                        {

                            id = i;

                            sc = p.GetScriptScope();
                            voc = sc._class;

                            if (voc == career.rook && !::CareerExist2[career.rook]) 
                            {
                                ::CareerExist2[career.rook] = true;
                                eq = Entities.CreateByClassname("game_player_equip");
                                eq.__KeyValueFromInt("spawnflags", 5);
                                //eq.__KeyValueFromInt("item_heavyassaultsuit", 1);
                                eq.__KeyValueFromInt("item_assaultsuit", 1);
                                //eq.__KeyValueFromInt("item_nvgs", 1);

                                Player_Health[id] = 2000;
                                p.SetMaxHealth(Player_Health[id]),p.SetHealth(Player_Health[id]);
                                idx = 1;
                                idxB = 0;

                                sc._carrymax <- 6;
                                sc._carry <- sc._carrymax;
                                sc._deploymax <- 1;

                                /*EntFire("servercommand", "command", "mp_heavyassaultsuit_aimpunch 0.5");
                                EntFire("servercommand", "command", "mp_heavyassaultsuit_deploy_timescale 0.8");
                                EntFire("servercommand", "command", "mp_heavyassaultsuit_speed 150");
                                EntFire("servercommand", "command", "mp_heavybot_damage_reduction_scale	0.5");*/
                                sp = (Player_DefSpeed[id] = 0.8);


                            }

                            else if (voc == career.assault && !::CareerExist2[career.assault]) 
                            {
                                ::CareerExist2[career.assault] = true;
                                eq = Entities.CreateByClassname("game_player_equip");
                                eq.__KeyValueFromInt("spawnflags", 5);
                                //eq.__KeyValueFromInt("item_nvgs", 1);
                                //eq.__KeyValueFromInt("item_assaultsuit", 1);

                                Player_Health[id] = 1500;
                                p.SetMaxHealth(Player_Health[id]),p.SetHealth(Player_Health[id]);
                                sp = (Player_DefSpeed[id] = 1.0);
                                idx = 0;
                                idxB = 1;
                            }

                            else if (voc == career.doctor && !::CareerExist2[career.doctor]) 
                            {
                                ::CareerExist2[career.doctor] = true;

                                eq = Entities.CreateByClassname("game_player_equip");
                                eq.__KeyValueFromInt("spawnflags", 5);
                                //eq.__KeyValueFromInt("item_nvgs", 1);
                                //eq.__KeyValueFromInt("item_assaultsuit", 1);

                                for (local i = 0; i < 2; i++) 
                                {

                                    eq.__KeyValueFromInt("weapon_healthshot", 1);
                                    eq.__KeyValueFromInt("weapon_healthshot", 1);

                                }

                                Player_Health[id] = 1800;
                                p.SetMaxHealth(Player_Health[id]),p.SetHealth(Player_Health[id]);
                                sp = (Player_DefSpeed[id] = 1.2);
                                idx = 2;
                                idxB = 2;

                                sc._carrymax <- 30;
                                sc._carry <- sc._carrymax;
                                sc._deploymax <- 3;
                            }

                            else if (voc == career.support && !::CareerExist2[career.support]) 
                            {
                                ::CareerExist2[career.support] = true;

                                eq = Entities.CreateByClassname("game_player_equip");
                                eq.__KeyValueFromInt("spawnflags", 5);
                                //eq.__KeyValueFromInt("item_nvgs", 1);
                                //eq.__KeyValueFromInt("item_assaultsuit", 1);

                                Player_Health[id] = 1200;
                                p.SetMaxHealth(Player_Health[id]),p.SetHealth(Player_Health[id]);
                                sp = (Player_DefSpeed[id] = 0.8);
                                idx = 3;
                                idxB = 3;

                                sc._carrymax <- 6;
                                sc._carry <- sc._carrymax;
                                sc._deploymax <- 2;
                            }
                    
                            else if (voc == career.trap && !::CareerExist2[career.trap]) 
                            {
                                ::CareerExist2[career.trap] = true;

                                eq = Entities.CreateByClassname("game_player_equip");
                                eq.__KeyValueFromInt("spawnflags", 5);
                                //eq.__KeyValueFromInt("item_nvgs", 1);
                                //eq.__KeyValueFromInt("item_assaultsuit", 1);
                                eq.__KeyValueFromInt("weapon_smokegrenade", 1);
                                eq.__KeyValueFromInt("weapon_flashbang", 1);

                                //for (local i = 0; i < 9; i++) 
                                //{

                                    eq.__KeyValueFromInt("weapon_breachcharge", 1);

                                //}

                                Player_Health[id] = 1000;
                                p.SetMaxHealth(Player_Health[id]),p.SetHealth(Player_Health[id]);
                                sp = (Player_DefSpeed[id] = 1.1);
                                idx = 4;
                                idxB = 4;

                                sc._carrymax <- 40;
                                sc._carry <- sc._carrymax;
                                sc._deploymax <- 10;

                            }
                            else 
                                continue

                            if (sp!=null)
                                ::VS.SetSpeed(p, 0, sp);

                            sc._bodyIdx <- idx;
                            sc._skinIdx <- idxB;
                            EntFire("Script", "RunScriptCode", "::SetPlayerModel("+id+ " " +idx+ " " +idxB+ ")");

                            EntFireByHandle(eq, "Use", "", 0.00, p, null);
                            EntFireByHandle(eq, "Kill", "", 0.01, null, null);

                            //break;
                        }
                    }
                }
            }
        }
    }
}

Think <- function () 
{
    if ( isOver )
        return;

    local data,_user,sc;

    foreach ( key, value in Player )
    {

        data = value;

        if ( data[ 0 ] != null && data[ 0 ].IsValid() )
        {

            _user = data[ 0 ];
            sc = _user.GetScriptScope();

            if ( _user.GetHealth() > Player_ZeroValue )
            {

                local allow = true,allow_2 = false,ent,eq;


                for ( ent = Entities.First(); ent != null; ent = Entities.Next( ent ) )
                {

                    if ( ent.GetClassname().find( "decoy", 0 ) != null && ent.GetMoveParent() == _user )
                    {

                        allow = false;

                        break;

                    }
                }

                if ( allow && sc._carry != 0 )
                {

                    if ( sc._class == career.rook )
                    {
                        second++;
                        if ( second%delay == 0 )
                        allow_2 = true;

                    }

                    else if ( sc._class == career.support )
                    {

                        second_b++;

                        if ( second_b%delay_b == 0 )
                        allow_2 = true;

                    }

                    else if ( sc._class == career.doctor )
                    {

                        second_c++;
                        if ( second_c%delay_c == 0 )
                        allow_2 = true;

                    }

                    else if ( sc._class == career.trap )
                    {

                        second_d++;
                        if ( second_d%delay_d == 0 )
                        allow_2 = true;

                    }

                    else

                    continue;
                    
                    if ( allow_2 )
                    {

                        eq = Entities.CreateByClassname( "game_player_equip" );
                
                        eq.__KeyValueFromInt( "spawnflags", 5 );
                        eq.__KeyValueFromInt( "weapon_decoy", 1 );
                        eq.SetOwner( _user );

                        if ( eq.GetOwner() != null && eq.GetOwner().IsValid() )
                        {

                            EntFireByHandle( eq, "Use", "", 0.00, _user, eq );
                            EntFireByHandle( eq, "Kill", "", 0.00, null, null );

                        }

                        else
                        
                        eq.Destroy();

                    }
                }

                allow = true;allow_2 = false;
                local _item = null;
                if ( sc._class == career.trap )
                    _item = "smokegrenade_projectile";
                else if ( sc._class == career.assault )
                    _item = "weapon_hegrenade";
                else if ( sc._class == career.support )
                    _item = "weapon_incgrenade";
                else if ( sc._class == career.doctor )
                    _item = "weapon_healthshot";
                if ( _item == null )
                    continue;
                
                for ( ent = Entities.First(); ent != null; ent = Entities.Next( ent ) )
                {
                    if ( ent.GetClassname().find( _item, 0 ) != null && ent.GetOwner() == _user )
                    {
                        if ( _item == "smokegrenade_projectile" )
                        {
                            ent.Destroy();
                            EntFire("sentry_template", "RunScriptCode", "Spawn()", 0.00, _user);
                            allow = false;
                            break;
                        }
                        else
                        {
                            allow = false;
                            break;
                        }
                    }
                }

                if ( allow )
                {
                    if ( sc._class == career.assault )
                    {
                        second_e++;
                        if ( second_e%delay_e == 0 )
                            allow_2 = true;
                    }
                    else if ( sc._class == career.support )
                    {
                        second_f++;
                        if ( second_f%delay_f == 0 )
                            allow_2 = true;
                    }
                    else if ( sc._class == career.doctor )
                    {
                        second_g++;
                        if ( second_g%delay_g == 0 )
                            allow_2 = true;
                    }
                    
                    if ( allow_2 )
                    {
                        eq = Entities.CreateByClassname( "game_player_equip" );
                        eq.__KeyValueFromInt( "spawnflags", 5 );
                        eq.__KeyValueFromInt( _item, 1 );
                        eq.SetOwner( _user );

                        if ( eq.GetOwner() != null && eq.GetOwner().IsValid() )
                        {
                            EntFireByHandle( eq, "Use", "", 0.00, _user, eq );
                            EntFireByHandle( eq, "Kill", "", 0.00, null, null );
                        }
                        else
                            eq.Destroy();
                    }
                }
            }
        }
    }

    if ( second == delay )
    second = 0;

    if ( second_b == delay_b )
    second_b = 0;

    if ( second_c == delay_c )
    second_c = 0;

    if ( second_d == delay_d )
    second_d = 0;

    //NewAdd
    GrenadeLauncher();
};

::GetArmorToRook <- function (_user = null)
{
    local sc;
    for ( local i = 0; i < ::Player.len(); i++ )
    {
        if ( ::Player[i][0] != null && ::Player[i][0].IsValid() )
        {
            sc = ::Player[i][0].GetScriptScope();
            if ( sc._class == career.rook )
            {
                _user = ::Player[i][0];
            }
        }
    }
    local text = ["你已获得全新的护甲","Obtained New Armor"];
    ::VS.GiveEquip(_user, "item_assaultsuit");
    ::VS.SendMsgToPlayer(_user, text[m_lang]);
    ::VS.PlayClientSnd(_user, ::Event_Snd[0]);
};

GrenadeLauncher <- function ()
{
    local ent;
    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {
        if (ent.GetClassname().find("projectile") != null)
        {
            local pjt = ent;
            if (pjt.GetModelName().find("flashbang") != null)
            {
                local plr = pjt.GetOwner();
                if (plr != null && plr.IsValid())
                {
                    if (plr.GetHealth() > 0)
                    {
                        local sc = plr.GetScriptScope();
                        if (sc._class == career.trap)
                        {
                            pjt.Destroy();
                            EntFire("sentry-helauncher_template", "RunScriptCode", "Spawn()", 0.00, plr);
                            break;
                        }
                    }
                }
            }
        }
    }
};