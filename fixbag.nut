//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

_but <- null;
_useBy <- null;
m_ui <- null;

_isPickUP <- false;

snd <- "Survival.ItemPickup";
position <- [
    Vector(1558,1672,171),
    Vector(1390,247,188),
    Vector(887,616,160),
    Vector(1209,-540,145),
    Vector(1409,-315,186),
    Vector(1640,-110,171),
    Vector(1567,781,175),
    Vector(1354,-1439,194),
    Vector(1141,-1339,118),
    Vector(1017,-1463,172),
    Vector(1208,-706,123),
    Vector(1018,-864,151),
    Vector(716,-1363,74),
    Vector(-23,-1295,9),
    Vector(-98,-1165,18),
    Vector(217,-1232,22),
    Vector(589,-899,24),
    Vector(658,-1044,8),
    Vector(345,-647,106),
    Vector(225,-825,117),
    Vector(-112,-494,8),
    Vector(-340,-402,4),
    Vector(-602,-390,6),
    Vector(46,86,4),
    Vector(295,29,20),
    Vector(-206,97,5),
    Vector(-918,-265,11),
    Vector(-903,-436,14),
    Vector(-1332,-719,1),
    Vector(-1612,-1032,30),
    Vector(-2039,-1312,150),
    Vector(-1580,-484,54),
    Vector(-1709,97,33),
    Vector(-1897,-497,97),
    Vector(-1697,176,26),
    Vector(-2158,159,243),
    Vector(-1722,833,7),
    Vector(-1519,719,14),
    Vector(-1943,1217,119),
    Vector(-1646,1322,50),
    Vector(-1138,836,11),
    Vector(-1139,694,11),
    Vector(-1036,671,76),
    Vector(-1080,954,11),
    Vector(-400,780,10),
    Vector(-1176,1567,61),
    Vector(-944,1622,77),
    Vector(-655,1610,54),
    Vector(-653,1443,14),
    Vector(-386,1284,10),
    Vector(-9,1586,-5),
    Vector(496,1648,46),
    Vector(639,1709,62),
    Vector(714,1362,24),
    Vector(670,1121,21),
    Vector(683,744,15),
    Vector(24,1144,22),
    Vector(-294,1557,-14),
    Vector(-534,1176,8),
    Vector(-150,-1045,6),
    Vector(-200,-1365,14),
    Vector(1590,1133,176),
    Vector(-727,1929,186),
    Vector(-340,1164,12),
    Vector(-245,-810,116),
    Vector(-547,-794,86),
    Vector(175,-586,27),
    Vector(498,-1378,126),
    Vector(428,-1439,126), 
    Vector(375,-1376,126),
    Vector(239,-1426,126),
    Vector(135,-1364,126),
    Vector(688,-902,63),
    Vector(1357,1873,170),
    Vector(963,-645,158),
    Vector(1324,-70,173),
    Vector(155,-5,9),
    Vector(-1058,-278,-6),
    Vector(-1550,628,17)
];

function Precache ()
{

    self.PrecacheScriptSound(snd);
    
}

function OnPostSpawn ()
{

    while ( ( _but = Entities.FindByName( _but, "dufflebag_button" ) ) !=null )
    {

        if ( _but.IsValid() )
        {

            if ( _but.GetMoveParent() == self )
            {

                local ne;
                ne = _but.GetName() + "_ready";
                _but.__KeyValueFromString( "targetname", ne );

                EntIO( _but, "OnPressed", self.GetName(), "RunScriptCode", "OnPickUp()", "0.00", "-1" );

                break;

            }
        }
    }

    local r = RandomInt(0, position.len()-1);
    local r2 = RandomInt(0,360);
    self.SetOrigin(position[r]);
    self.SetAngles(0,r2,0);

}

OnPickUp <- function ()
{

    //ScriptPrintMessageChatAll( "Use.." );

    local atv,data,sc,pos,ang;

    atv = activator;

    if ( !_isPickUP )
    {

        foreach ( key, value in Player )
        {

            data = value;

            if ( data[ 0 ] != null && data[ 0 ].IsValid() )
            {

                if ( atv == data[ 0 ] )
                {

                    //ScriptPrintMessageChatAll( "Confirm_User" );

                    _useBy = atv;
                
                    if ( _useBy.ValidateScriptScope() )
                    sc = _useBy.GetScriptScope();

                    if ( !( "view" in sc ) )
                    sc.view <- null;

                    if ( !( "_AllowPickup" in sc ) )
                    sc._AllowPickup <- true;

                    //ScriptPrintMessageChatAll( "ScriptScopeChecked" );

                    if ( sc._AllowPickup ) 
                    {

                        local ent;
                        for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
                        {

                            //if ( ent.GetClassname().find( "predicted", 0 ) != null )
                            //{

                                //if ( ent.GetMoveParent() == _useBy || ent.GetOwner() == _useBy )
                                //{

                                    //ScriptPrintMessageChatAll( "View_Found" );

                                    //if ( sc.view == null )
                                    //{

                                        //sc.view = ent;
                                        //sc.view.__KeyValueFromString( "targetname", "vm_"+sc.userid );

                                    //}

                                    //pos = _useBy.GetOrigin() + _useBy.GetForwardVector() * 48;pos.z -= 24;
                                    pos = _useBy.GetOrigin() + _useBy.GetForwardVector() * 29;pos.z += 36;
                                    ang = _useBy.GetAngles();

                                    self.SetOrigin( pos );
                                    self.SetAngles( 0,ang.y+90,0 );
                                    DoEntFire( "!self", "SetParent", _useBy.GetName(), 0.00, self, self ); //sc.view.GetName()

                                    //_but.__KeyValueFromFloat( "min_use_angle", 0.0 );

                                    _isPickUP = true;
                                    sc._AllowPickup = false;
                                    EntFireByHandle( _but, "Lock", "", 0.00, null, null );
                                    self.EmitSound(snd);

                                    if ( m_ui == null || m_ui != null && !m_ui.IsValid() )
                                    {
                                        m_ui = Entities.CreateByClassname("game_ui");
                                        m_ui.__KeyValueFromInt("spawnflags", 128);
                                        m_ui.__KeyValueFromInt("FieldOfView", -1);
                                        EntIO(m_ui, "PlayerOff", self.GetName(), "RunScriptCode", "Drop()", "0.00", "-1");
                                        EntIO(m_ui, "PlayerOff", "!self", "Kill", "", "0.00", "-1");
                                    }
                                    m_ui.SetOwner(_useBy);
                                    EntFireByHandle(m_ui, "Activate", "", 0.00, _useBy, null);

                                    //ScriptPrintMessageChatAll( "PickUp" );

                                    return;

                                //}
                            //}
                        }
                    }

                    else 

                    break;

                }
            }
        }
    }

    /*else {

        if ( atv == _useBy )
        {

            EntFireByHandle( self, "ClearParent", "", 0.00, null, null );
            EntFireByHandle( self, "EnableMotion", "", 0.01, null, null );

            _but.__KeyValueFromFloat( "min_use_angle", 0.9 );

            _useBy = null;
            _isPickUP = false;

            if ( _useBy.ValidateScriptScope() )
            sc = _useBy.GetScriptScope();

            sc._AllowPickup = true;

            ScriptPrintMessageChatAll( "Drop" );

        }
    }*/
}

Drop <- function ()
{
    printl("drop");

    local pos,sc;
    pos = _useBy.GetOrigin() + _useBy.GetForwardVector() * 21 + _useBy.GetUpVector() * 72;

    //self.SetOrigin(pos);
    local userName = _useBy.GetName();
    DoEntFire("!self", "ClearParent", "", 0.00, self, self);
    DoEntFire("!self", "SetLocalOrigin", pos.x+" "+pos.y+" "+pos.z, 0.00, self, self);
    DoEntFire("!self", "SetParent", userName, 0.00, self, self);
    DoEntFire("!self", "ClearParent", "", 0.00, self, self);
    DoEntFire("!self", "EnableMotion", "", 0.00, self, self);
    //_but.__KeyValueFromFloat( "min_use_angle", 0.9 );

    if ( _useBy.ValidateScriptScope() )
        sc = _useBy.GetScriptScope();

    _isPickUP = false;
    sc._AllowPickup = true;
    _useBy = null;

    EntFireByHandle(_but, "UnLock", "", 0.00, null, null);
    //ScriptPrintMessageChatAll( "Drop" );
} 

Think <- function ()
{

    local pos,pos2,tl,sc;

    if ( _useBy != null && _useBy.IsValid() )
    {

        if ( _useBy.GetHealth() < 1 )
        {

            if ( _useBy.ValidateScriptScope() )
            sc = _useBy.GetScriptScope();

            pos = _useBy.GetOrigin();pos.z += 88;

            DoEntFire( "!self", "ClearParent", "", 0.00, self, self );
            DoEntFire( "!self", "EnableMotion", "", 0.00, self, self );
            DoEntFire( "!self", "SetLocalOrigin", "" + pos.x + " " + pos.y + " " + pos.z, 1.00, self, self) ;

            EntFireByHandle( _but, "UnLock", "", 0.00, null, null );

            _useBy = null;
            _isPickUP = false;
            sc._AllowPickup = true;
            m_ui.Destroy();

        }

        /*else 
        {

            local ang,yaw,dist,total;

            pos = self.GetOrigin();
            pos2 = pos + self.GetLeftVector() * -32;
            ang = _useBy.GetAngles();
            yaw = ang.y * PI / -180.0;

            tl = TraceLine( pos, pos2, self);

            if ( tl != 1.0 )
            {

                dist = ( pos - _useBy.GetOrigin() );
                total = dist.LengthSqr();

                if ( total > 361 )

                self.SetOrigin( Vector( pos.x+( cos( yaw ) * 1 ), pos.y+( sin( yaw ) * 1 ), pos.z ) );

            }
        }*/
    }
}
