/*
----Copyright (c) 2020 - 2021 SakuraAyi(11)
----Language Squirrel
----For Counter-Strike:Global Offensive Vscript

----My Bilibili link -> https://space.bilibili.com/2601958
----My QQ Group -> 547256416
*/
Pi <- 3.14159265
TwoPi <- 6.2831853
HalfPi <- 1.5707963

Rad <- 0.01745329251994329576923690768489
Deg <- 57.295779513082320876798154814105

Owner <- null;
HostileCamp <- -1;
Health <- 20;
Ammo <- 12; // 40x46 he
TurretYawSpeed <- 5;
LaserColor_R <- 255;
LaserColor_G <- 0;
LaserColor_B <- 0;

_activate <- false;
measure <- null;
ms_tr <- null;
ms_tr_rf <- null;
ui <- null;
menu <- null;

second <- 0;

_identity <- null;
_target <- null;
_contact <- false;

but <- null;

gun <- null;
_shooter <- null;
aim <- null;
fire <- null;
shell <- null;
//smoke <- null;
//hitbox <- null;
hud <- null;
hudtxt <- [
    ["弹药量:","Ammo"],
    ["【榴弹发射器-AI】最大弹容量:12","[GrenadeLauncher-AI]FullAmmo:12"],
    ["补充弹药(40x46mm SR)","Reload(40x46mm SR)"],
    ["移动炮塔", "Move"],
    ["生命值：", "Helath:"]
];
glow <- null;

_shoot <- false;

_aud <- null;
_aud2 <- null;
_snd <- 
[
    "weapons/11/grenadelauncher/grenade_launcher_fire_1.wav", 
    "weapons/11/grenadelauncher/grenade_launcher_explode_1.wav", 
    "weapons/11/grenadelauncher/grenade_launcher_explode_2.wav", 
    "Survival.DroneGunFocusPlayer", 
    "weapons/hegrenade/explode5.wav",
    "Survival.BreachSoundWarningBeep",
    "weapons/c4/key_press2.wav",

    "weapons/11/grenadelauncher/grenade_launcher_deploy_1.wav",
    "weapons/11/grenadelauncher/grenade_launcher_latchopen.wav",
    "weapons/11/grenadelauncher/grenade_launcher_shellin.wav"
];

enum form
{
    place,
    move
}
state <- form.move;

model <- "models/shells/shell_12gauge.mdl";

deployYaw <- 0.000000;
currentPitch <- 0.000000;
currentYaw <- 0.000000;
otherVector <- Vector(0.000000,0.000000,0.000000);
selfVector <- Vector(0.000000,0.000000,0.000000);
scalar <- 0.000000;
otherOrigin <- Vector(0.000000,0.000000,0.000000);
myOrigin <- Vector(0.000000,0.000000,0.000000);
myYaw <- 0.000000;

Alive <- function ( param )
{

    local atv = param;

    if ( atv.GetHealth() > 0 )

        return true;

    else

        return false;

}

function Precache ()
{

    for ( local i = 0; i < _snd.len(); i++ )

        self.PrecacheScriptSound( _snd[i] );

    self.PrecacheModel( model );

}

Hit <- Vector(0,0,0);

class TraceInfo 
{
	constructor(h,d)
	{
		Hit = h;
		Dist = d;

        //ScriptPrintMessageChatAll( "Hit > " + Hit );
        //ScriptPrintMessageChatAll( "Dist > " + Dist );

	}

	Hit = null;
	Dist = null;
}

TraceDir <- function ( orig, dir, maxd, filter )
{

    local frac = TraceLine( orig, orig+dir*maxd,filter );

    return TraceInfo(orig+(dir*maxd*(frac-0.1)), maxd*frac);


}

function OnPostSpawn () 
{

    sentry_y <- self.GetMoveParent();
    sentry_m <- sentry_y.GetMoveParent();

    local ent;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next( ent ) )
    {

        if ( ent.GetName().find("sentry-helauncher_but", 0) != null )
        {

            if ( ent.GetMoveParent() == self )
                but = ent;
        }
        else if ( ent.GetName().find("sentry-helauncher_aud", 0) != null )_aud = ent;
        else if ( ent.GetName().find("sentry-helauncher_snd2", 0) != null )_aud2 = ent;
        else if ( ent.GetName().find("sentry-helauncher_shooter", 0) != null )_shooter = ent;
        else if ( ent.GetName().find("sentry-helauncher_particle", 0) != null )fire = ent;
        else if ( ent.GetName().find("sentry-helauncher_hud", 0) != null )
        {

            if ( ent.GetMoveParent() == self )
            {

                hud = ent;
                //hud.__KeyValueFromString( "displaytext", hudtxt + Ammo );
                EntFireByHandle( hud, "SetDisplayText", "" + hudtxt[0][m_lang] + Ammo, 0.00, null, null );

            }
        }
    }
    _shooter.__KeyValueFromInt("m_flVelocity", 1500);

    /*hud = Entities.CreateByClassname( "vgui_world_text_panel" ); //  game crash

    if ( hud.IsValid() )
    {
        local pyr = "-30 " + currentYaw + " -6";
        local color = "255 128 0";

        hud.__KeyValueFromString( "angles", pyr );
        hud.__KeyValueFromString( "displaytext", "test" );
        hud.__KeyValueFromString( "color", color );
        hud.__KeyValueFromString( "font", "MissionSelectLarge" );
        hud.__KeyValueFromInt( "height", 20 );
        hud.__KeyValueFromInt( "width", 20 );
        hud.__KeyValueFromInt( "textpanelwidth", 1024 );

        hud.SetOrigin( Vector( 5,289,82 ) );
        EntFireByHandle( hud, "SetParent", self.GetName(), 0.00, null, null );

    }*/

    /*gun = Entities.CreateByClassname( "env_gunfire" );

    if ( gun.IsValid() )
    {

        gun.__KeyValueFromString( "parentname", self.GetName() );
        gun.__KeyValueFromInt( "StartDisabled", 1 ) ;
        gun.__KeyValueFromString( "target", aim.GetName() );
        gun.__KeyValueFromInt( "maxburstsize", 1 );
        gun.__KeyValueFromInt( "minburstsize", 1 );
        gun.__KeyValueFromFloat( "maxburstdelay", 0.1 );
        gun.__KeyValueFromFloat( "minburstdelay", 0.1 );
        gun.__KeyValueFromInt( "spread", 1 );
        gun.__KeyValueFromInt( "bias", -1 )
        gun.__KeyValueFromString( "weaponname", "weapon_negev" );

        local pos = self.GetOrigin() + self.GetForwardVector() * 16;

        gun.SetOrigin( pos );

    }*/

    /*fire = Entities.CreateByClassname( "env_muzzleflash" );

    //if ( fire.IsValid() )
    //{

        fire.__KeyValueFromFloat( "scale", 3.5 );

        local pos = self.GetForwardVector() * 21;

        fire.SetAngles( 0,currentYaw,0 );
        fire.SetOrigin( pos );
        EntFireByHandle( fire, "SetParent", self.GetName(), 0.00, null, null );*/

    //}

    ::VS.EntIO( but, "OnPressed", self.GetName(), "RunScriptCode", "OnUse()", "0.00", "-1" );
    ::VS.EntIO( self, "OnTakeDamage", "!self", "RunScriptCode", "UnderAttack()", "0.00", "-1" );

    //Owner.__KeyValueFromString( "targetname", "player" );
    DoEntFire( "!self", "RunScriptCode", "BindUser()", 0.01, self, self );
    DoEntFire( "!self", "RunScriptCode", "Think()", 0.10, self, self );
    if (Owner.GetTeam() == 2)
        HostileCamp = 3;
    else if (Owner.GetTeam() == 3)
        HostileCamp = 2;

}

BindUser <- function ()
{

    //ScriptPrintMessageChatAll( "Binding" );

    if ( Owner != null && Owner.IsValid() )
    {

        //ScriptPrintMessageChatAll( "OwnerIsValid" );

        state = form.move;

        if ( _activate )
            _activate = false;

        _identity = null;
        _target = null;

        DoEntFire( "!self", "SetAnimation", "up", 0.10, self, self );
        self.__KeyValueFromInt( "rendermode", 4 );
        self.__KeyValueFromInt( "renderamt", 75 );
        self.__KeyValueFromInt( "solid", 0 );
        sentry_m.__KeyValueFromInt( "rendermode", 4 );
        sentry_m.__KeyValueFromInt( "renderamt", 75 );
        sentry_y.__KeyValueFromInt( "rendermode", 4 );
        sentry_y.__KeyValueFromInt( "renderamt", 75 );
        //EntFire(glow, "HideSprite");
        EntFireByHandle(hud, "Disable", "", 0.00, null, null);

        local m_yaw = sentry_m.GetAngles().y;

        if ( m_yaw < 0 )

            m_yaw = 180 + ( 180 + m_yaw );

        sentry_y.SetAngles(0,m_yaw,0);
        currentYaw = m_yaw;

        ui = Entities.CreateByClassname( "game_ui" );
    
        //if ( ui.IsValid() )
        //{
            ui.__KeyValueFromInt( "spawnflags", 64 );
            ui.__KeyValueFromInt( "FieldOfView", -1 );
            ui.SetOwner( Owner );

            ::VS.EntIO( ui, "PressedAttack", self.GetName(), "RunScriptCode", "deploy()", "0.00", "-1" );

            EntFireByHandle( ui, "Activate", "", 0.00, Owner, null );
        //}

        local pos = Owner.GetOrigin() + Owner.GetForwardVector() * 39;
        local ang = Owner.GetAngles();

        sentry_m.SetOrigin( pos );
        sentry_m.SetAngles( 0,ang.y,0 );

        measure = Entities.CreateByClassname( "logic_measure_movement" );
        ms_tr = CreateProp( "prop_dynamic", Vector(0, 0, 0), model, 0 );
        ms_tr.__KeyValueFromInt("rendermode", 10);
        ms_tr_rf = Entities.CreateByClassname( "info_target" );

        local ne = self.GetName().slice(12, self.GetName().len());

        ms_tr.__KeyValueFromString("targetname", "tr" + ne);
        ms_tr_rf.__KeyValueFromString("targetname", "tr_rf" + ne);

        //measure.__KeyValueFromString( "targetname", "measure");
        /*measure.__KeyValueFromString( "MeasureReference", "none" );
        measure.__KeyValueFromString( "MeasureTarget", "none" );
        measure.__KeyValueFromString( "TargetReference", "none" );*/
        measure.__KeyValueFromString( "Target", ms_tr.GetName() );
        measure.__KeyValueFromInt( "MeasureType", 1 );
        measure.__KeyValueFromInt( "TargetScale", 1000 );

        EntFireByHandle( measure, "SetMeasureTarget", Owner.GetName(), 0.00, null, null );
        //EntFireByHandle( measure, "Target", ms_tr.GetName(), 0.00, null, null );
        EntFireByHandle( measure, "SetMeasureReference", ms_tr_rf.GetName(), 0.00, null, null );
        EntFireByHandle( measure, "SetTargetReference", ms_tr_rf.GetName(), 0.00, null, null );

        EntFireByHandle( measure, "Enable", "", 0.10, null, null );

        //ScriptPrintMessageChatAll( "measure_createdone and owner > " + Owner.GetName()  );

    }
}

deploy <- function () 
{

    if ( Owner.GetVelocity().z == 0 )
    {

        local tl,pos = sentry_m.GetOrigin();
        local downVector = Vector(0,0,0);
        local fall = true;

        while ( fall )
        {
            pos.z+=16;
            downVector = pos + sentry_m.GetUpVector() * -18;
            tl = TraceLine(pos,downVector,sentry_m);
            pos.z-=16;

            if ( tl == 1.0 )
            {
                pos.z -= 2;
                sentry_m.SetOrigin(pos);
            }

            else
            {
                fall = false;
                break;
            }
        }
        state = form.place;

        self.__KeyValueFromInt( "rendermode", 0 );
        self.__KeyValueFromInt( "renderamt", 255 );
        self.__KeyValueFromInt( "solid", 6 );
        sentry_m.__KeyValueFromInt( "rendermode", 0 );
        sentry_m.__KeyValueFromInt( "renderamt", 255 );
        sentry_y.__KeyValueFromInt( "rendermode", 0 );
        sentry_y.__KeyValueFromInt( "renderamt", 255 );

        EntFireByHandle(but, "Lock", "", 0.00, null, null);
        EntFireByHandle(hud, "Enable", "", 0.60, null, null);
        EntFireByHandle(but, "UnLock", "", 0.90, null, null)
        //EntFire(glow, "ShowSprite");

        deployYaw  = sentry_y.GetAngles().y;

        if ( deployYaw < 0 )

            deployYaw = 180 + ( 180 + deployYaw );

        currentYaw = deployYaw;

        sentry_m.SetAngles(0,0,0);
        sentry_y.SetAngles(0,currentYaw,0);

        _activate = true;

        DoEntFire( "!self", "SetAnimation", "down", 0.00, self, self );

        EntFireByHandle( ui, "Deactivate", "", 0.00, Owner, null );
        EntFireByHandle( ui, "Kill", "", 0.01, null, null );
        measure.Destroy();
        ms_tr.Destroy();
        ms_tr_rf.Destroy();
    }
}

slt <- [];
OnUse <- function ()
{
    ::VS.PlayClientSnd(Owner,_snd[7]);
    local atvr;
    atvr = activator;

    if ( atvr.GetTeam() == 3 )
    {
        if ( Owner == atvr )
        {
            if ( state == form.place )
            {
                if ( ui == null || ui != null && !ui.IsValid() )
                {
                    ui = Entities.CreateByClassname("game_ui");
                    ui.__KeyValueFromInt("FieldOfView", -1);
                    ui.__KeyValueFromInt("spawnflags", 224);
                    ui.SetOwner(Owner);

                    ::VS.EntIO(ui, "PressedForward", self.GetName(), "RunScriptCode", "select(0)", "0.00", "-1");
                    ::VS.EntIO(ui, "PressedBack", self.GetName(), "RunScriptCode", "select(1)", "0.00", "-1");
                    ::VS.EntIO(ui, "PressedAttack", self.GetName(), "RunScriptCode", "OnConf()", "0.00", "-1");
                    ::VS.EntIO(ui, "PressedAttack2", "!self", "Deactivate", "", "0.00", "-1");
                    ::VS.EntIO(ui, "PlayerOff", self.GetName(), "RunScriptCode", "MenuOff()", "0.00", "-1");
                //ui.ConnectOutput("PlayerOff", "MenuOff");
                }

                else

                    return;

                EntFireByHandle(caller, "Lock", "", 0.00, null, null);

                EntFireByHandle(ui, "Activate", "", 0.00, Owner, null);

                MenuShow = true;
                DisPmenu();
            }
        }
    }
}

select <- function (s)
{
    ::VS.PlayClientSnd(Owner,_snd[8]);
    for ( local i = 0; i < slt.len(); i++ )
    {
        if ( slt[i] )
        {
            if ( s == 0 )
            {
                if ( i != 0 )
                {
                    slt[i] = false;
                    slt[i-1] = true;
                }

                else

                    break;
            }

            else
            {
                if ( i == 0 )
                {
                    slt[i] = false;
                    slt[i+1] = true;
                }

                else

                    break;
            }
        }
    }
}

MenuShow <- false;
DisPmenu <- function ()
{
    if ( MenuShow )
    {
        DoEntFire("!self", "RunScriptCode", "DisPmenu()", 0.1, self, self);

        if ( slt.len() == 0 )
        {
            for ( local i = 0; i < hudtxt.len()-3; i++ )
            {
                i == 0 ? slt.push(true) : slt.push(false);
            }
        }
        
        local text = hudtxt[1][m_lang] + "\n" + hudtxt[4][m_lang] + Health + "\n\n";
        local _l = "-->  ",_r = "  <--";
        local color = "0 255 255";

        for ( local i = 0; i < slt.len(); i++ )
        {
            slt[i] ? text += _l + hudtxt[i+2][m_lang] + _r + "\n" : text += hudtxt[i+2][m_lang] + "\n";
        }

        if ( menu == null )
        {
            menu = Entities.CreateByClassname("game_text");
            menu.__KeyValueFromInt("channel", 1);
            menu.__KeyValueFromString("color", color);
            menu.__KeyValueFromFloat("x", 0.2);
            menu.__KeyValueFromFloat("y", 0.33);
            menu.__KeyValueFromFloat("fadein", 0.03);
            menu.__KeyValueFromFloat("fadeout", 0.03);
            menu.__KeyValueFromFloat("holdtime", 0.3);
            menu.SetOwner(Owner);
        }

        menu.__KeyValueFromString("message", text);

        EntFireByHandle(menu, "DisPlay", "", 0.00, Owner, null);
    }
}

OnConf <- function ()
{


    for ( local i = 0; i < slt.len(); i++ )
    {
        if ( slt[i] )
        {
            if ( i == 0 )
            {
                ::VS.PlayClientSnd(Owner,_snd[9]);
                local num = 1,max = 12;

                if ( Ammo < max )
                {
                    if ( (Ammo + num) <= max )

                        Ammo += num;

                    else if ( (Ammo + num) > max )

                       Ammo = max;

                }

                else

                    return;

                LaserColor_R = 255;
                LaserColor_G = 0;
                LaserColor_B = 0;

                UpdateText();

                break;
            }

            else
            {
                ::VS.PlayClientSnd(Owner,_snd[6]);
                MenuShow = false;
                EntFireByHandle( ui, "Deactivate", "", 0.00, Owner, null );
                EntFireByHandle( ui, "Kill", "", 0.01, null, null );
                DoEntFire("!self", "RunScriptCode", "BindUser()", 0.10, self, self);

                break;

            }
        }
    }
}

MenuOff <- function ()
{
    MenuShow = false;
    slt[0] = true;
    slt[1] = false;
    EntFireByHandle(ui, "Kill", "", 0.00, null, null);
    EntFireByHandle(but, "Unlock", "", 0.00, null, null);
}

UpdateText <- function ()
{

    EntFireByHandle( hud, "SetDisplayText", "" + hudtxt[0][m_lang] + Ammo, 0.00, null, null );

}

Grenade <- function ()
{
    local ent;
    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {
        if (ent.GetClassname() == "gib")
        {
            local gib = ent;
            if (gib.GetModelName().find("grenade") != null)
            {
                local vel = gib.GetVelocity();
                local ori = gib.GetOrigin();
                if (vel.Length() < 300)
                {
                    Exp(gib,ori);
                    return;
                }
                local plr;
                while ((plr = Entities.FindByClassname(plr, "*")) != null)
                {
                    if (plr.GetClassname() == "player" || plr.GetClassname() == "cs_bot")
                    {
                        if (plr.GetHealth() < 1)
                            return;
                        local plrVector = plr.GetOrigin();
                        plrVector.z+=36;
                        local dist = ori - plrVector;
                        if (dist.LengthSqr() < 2304)
                        {
                            Exp(gib,ori);
                            return;
                        }
                    }
                }

                //printl("grenade_velocity > "+vel);
            }
        }
    }
};

Exp <- function (entity,ori)
{
    DispatchParticleEffect("explosion_basic", ori, ori);
    _aud2.SetOrigin(ori);
    local r = RandomInt(0,1);
    _aud2.__KeyValueFromString("message", _snd[1+r]);
    EntFireByHandle(_aud2, "PlaySound", "", 0.00, null, null);
    entity.Destroy();

    local exp = Entities.CreateByClassname("env_explosion");
    exp.__KeyValueFromInt("iMagnitude", 150);
    exp.__KeyValueFromString("classname", "prop_exploding_barrel");
    exp.SetOrigin(ori);
    exp.SetOwner(Owner);
    EntFireByHandle(exp, "Explode", "", 0.00, Owner, Owner);
};

Think <- function () 
{
    DoEntFire( "!self", "RunScriptCode", "Think()", 0.03, self, self );
    Grenade();
    switch ( _activate )
    {

        case false:
        {

            local atvori = Owner.GetOrigin(), atvang = ms_tr.GetAngles();

            Hit = TraceDir(Owner.EyePosition(), ms_tr.GetForwardVector(), 64, Owner).Hit;

            sentry_m.SetOrigin(Vector(Hit.x, Hit.y, atvori.z));
            sentry_m.SetAngles(0,atvang.y,0);

            if ( _contact )
            {
                CeaseFire();
                _contact = false;
            }

            break;

        }

        case true:
        {

            local data,m_targetVector,m_sentryOrigin,m_dir,UCSX,pitch,yaw,ang,tl;
	        local mark = false;

        //scan();

        if ( Ammo < 1 )
        {

            if ( _identity != null )

                _identity = null;

            if ( _target != null )

                _target = null;

            if ( _contact )

                CeaseFire();

            LaserColor_R = 255;
            LaserColor_G = 255;
            LaserColor_B = 255;

            return;

        }

        local ent;
        Player <- [];
        while ((ent = Entities.FindByClassname(ent, "*"))!= null)
        {
            if (ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot")
            {
                local plr = ent;
                if (plr.GetHealth() > 0 && plr.IsValid())
                {
                    if (plr.GetTeam()==HostileCamp)
                        Player.push(plr);
                }
            }
        }

        foreach ( key in Player )
        {

            data = key;

            if ( data != null && data.IsValid() )
            {

                if ( _identity == null || !_identity.IsValid() )

				    _identity = data;

                    //ScriptPrintMessageChatAll( "CheckIdentity" );

    		    if ( Alive(_identity) )
    		    {

                    //ScriptPrintMessageChatAll( "Found" );

        		    if ( _target != null && _target.IsValid() && Alive(_target) )

            		    _identity = _target;

                    //ScriptPrintMessageChatAll( "CheckScope" );

        		    myOrigin = self.GetOrigin();
        		    myYaw = self.GetAngles().y;
	    		    //printl( "MY1  " + myYaw )

	    		    if(myYaw < 0)
	    		    {

            		    myYaw = 180 + ( 180 + myYaw );
                
	    		    }

	    		    //printl( "MY  " + myYaw );
        		    otherOrigin = _identity.GetOrigin();
                    otherOrigin.z += 64;

        		    local tlpos = self.GetOrigin(),tlpos2 = otherOrigin;

        		    tl = TraceLine( tlpos, tlpos2, self );
        		    //GetHitPosition( self.GetOrigin(), otherOrigin );

        		    if ( ( myOrigin - otherOrigin ).LengthSqr() < 1048576 && tl == 1.0 )
        		    {

                        //ScriptPrintMessageChatAll( "Becoming.." );

            		    //currentPitch = self.GetAngles().x;
            		    //currentYaw = self.GetAngles().y;
	       		        otherVector = Vector( otherOrigin.x - myOrigin.x, otherOrigin.y - myOrigin.y, 0 );
	        		    selfVector = Vector( cos( myYaw * PI / 180.0 ), sin( myYaw * PI / 180.0 ), 0 );
	        		    scalar = ( otherVector.x * selfVector.x + otherVector.y * selfVector.y );
	        		    ang = acos( scalar / ( otherVector.Length() * selfVector.Length() ) ) * 180.0 / PI;

                        for ( local i = 0; i < 10; i++ )
                        {

                            if ( ang.tostring().find( i.tostring(),0 ) != null )

                                break;

                            if ( i == 9 )

                                ang = 0;

                        }

            		    if ( ang < 120 && ang > -120 )
            		    {

                            //ScriptPrintMessageChatAll( "Contact" );

                		    if ( _target == null || !_target.IsValid() )

                    		    _target = _identity;

                            _identity = null;

                		    break;

            		    }
        		    }

            	    _identity = null;
                    _target = null;
            	    CeaseFire();

    		    }

                else
                {

                    _identity = null;
                    continue;

                }
            }
        }

        if ( _target != null && !_target.IsValid() )
        {

            _identity = null;
            _target = null;
            return;

        }

        if ( _target != null && Alive(_target) )
        {

            m_targetVector = _target.GetOrigin();
            m_targetVector.z + 64;
            m_sentryOrigin = sentry_m.GetOrigin();
            m_sentryOrigin.z + 64;
            m_dir = m_targetVector - m_sentryOrigin;

            UCSX = sqrt( pow( m_dir.x,2 ) + pow( m_dir.y,2 ) );
            pitch = asin( m_dir.z / sqrt( pow( UCSX,2 ) + pow( m_dir.z,2 ) ) ) * 180 / PI * -1;
            yaw = asin( m_dir.y / sqrt( pow( m_dir.x,2 ) + pow( m_dir.y,2 ) ) ) * 180 / PI;

            if ( m_dir.x < 0 )

                yaw = 180 - yaw;

            if ( currentPitch != pitch )
            {

                if ( pitch > currentPitch )

                    self.SetAngles( ( currentPitch += 0.5 )-10,0,0 );

                else

                    self.SetAngles( ( currentPitch -= 0.5 )-10,0,0 );

            }

            if ( currentYaw != yaw )
            {

                //if ( yaw > currentYaw )
                //{

                //    sentry_y.SetAngles( 0,( currentYaw+=1 ),0 );

                //}

                //else
                //{

                //    sentry_y.SetAngles( 0,( currentYaw-=1 ),0 );

                //}

		    	if( yaw < 0 )
		    	{

		    	    if( currentYaw > 0 && yaw < 0 )
		    	    {

			    	    yaw += 360;
    
			    	}

			    	if( yaw > currentYaw )
			    	{

				    	if( yaw - currentYaw > 150 )
					    {

						    currentYaw = ( 360 - currentYaw );

					    }

					    sentry_y.SetAngles( 0,( currentYaw += TurretYawSpeed ),0 );

                        if( yaw < currentYaw )

                            sentry_y.SetAngles( 0,yaw,0 );

				    }

				    if( yaw < currentYaw )
				    {

					    if( currentYaw - yaw > 150 )
					    {

						    currentYaw = ( 360 - currentYaw );

					    }

					    sentry_y.SetAngles( 0,( currentYaw -= TurretYawSpeed ),0 );

                        if( yaw > currentYaw )

                            sentry_y.SetAngles( 0,yaw,0 );
                    }
                }

			    else
		    	{

				    if( yaw > 0 && currentYaw < 0 )
				    {

					    currentYaw = ( 360 + currentYaw );

			    	}

				    if( yaw > currentYaw )
				    {

				    	if( yaw - currentYaw > 150 )
				    	{

					    	currentYaw = ( 360 - currentYaw );

					    }

				    	sentry_y.SetAngles( 0,( currentYaw += TurretYawSpeed ),0 );

                        if( yaw < currentYaw )

                            sentry_y.SetAngles( 0,yaw,0 );

				    }

				    if( yaw < currentYaw )
				    {

				    	if( currentYaw - yaw > 150 )
				    	{

					    	currentYaw = ( 360 - currentYaw );

				    	}

					    sentry_y.SetAngles( 0,( currentYaw -= TurretYawSpeed ),0 );

                        if( yaw > currentYaw )

                            sentry_y.SetAngles( 0,yaw,0 );

			    	}
		    	}
            }

	    	//printl( "YAW : " + yaw + "   CY: " + currentYaw );
		    //ScriptPrintMessageChatAll( "Calibration.." );

		    if ( /*( pitch - currentPitch <= 15 && pitch - currentPitch >= -15 ) && */( yaw - currentYaw <= 15 && yaw - currentYaw >= -15 ) )
            {

                //ScriptPrintMessageChatAll( "Fire" );

                if ( !_contact )
                {
                    local pos;
                    pos = self.GetOrigin();
                    pos.z += 32;
                    DispatchParticleEffect( "radio_voice", pos, Vector(0.000000, 0.000000, 0.000000) );
                    EntFireByHandle( _aud, "AddOutput", "message " + _snd[0], 0.00 null, null);
                    _contact = true;
                }
                    second++;

                if ( _contact && second%(2*33) == 0 )
                {
                    OpenFire();
                    second = 0;
                    Ammo -= 1;
                }
                UpdateText();

                return;
            }
        }

        _target = null;
        CeaseFire();

        break;

        }

        default:
        {

            break;

        }
    }
}

OpenFire <- function ()
{
    EntFireByHandle( _aud, "PlaySound", "", 0.00, null, null);
    EntFireByHandle( fire, "DestroyImmediately", "", 0.00, null, null );
    EntFireByHandle( fire, "Start", "", 0.01, null, null );
    DoEntFire( "!self", "SetAnimation", "fire", 0.00, self, self );
    _shooter.__KeyValueFromString("gibangles", "-10 "+self.GetAngles().y+" 0");
    EntFireByHandle(_shooter, "shoot", "", 0.00, null, null);
    printl("fire");
};

CeaseFire <- function ()
{

    if ( _contact )
    {

        //EntFireByHandle( gun, "Disable", "", 0.00, null, null );
       // EntFireByHandle( shell, "DestroyImmediately", "", 0.00, null, null );
        DoEntFire( "!self", "SetAnimation", "ragdoll", 0.00, self, self );

        _contact = false;

    }
}

mt_scan <- 80;
mt_scan_dir <- false;
scan <- function ()
{

    local start,end,ang,yaw;

    start = self.GetOrigin() + self.GetLeftVector() * 2;
    start.z += 19.5;
    ang = self.GetAngles();
    yaw = ( ang.y + mt_scan ) * PI / 180.0;
    end = Vector( start.x+(cos(yaw)*64), start.y+(sin(yaw)*64),start.z );

    DebugDrawLine( start, end, LaserColor_R, LaserColor_G, LaserColor_B, false, 0.5 );

    if ( mt_scan < 80 && mt_scan_dir )
    {

        mt_scan += 2;

        if ( mt_scan == 80 )
        {

            mt_scan_dir = false;

        }
    }

    else if ( mt_scan > -80 && !mt_scan_dir )
    {
        
        mt_scan -= 2;

        if ( mt_scan == -80 )
        {

            mt_scan_dir = true;

        }
    }

    if ( mt_scan%80  == 0 && _target == null )
    {

        if ( Ammo > 0 )

            _aud.__KeyValueFromString( "message", _snd[3] );

        else
        
            _aud.__KeyValueFromString( "message", _snd[5] );

        EntFireByHandle( _aud, "PlaySound", "", 0.00, null, null);

    }
}

UnderAttack <- function ()
{

    ScriptPrintMessageChatAll( "UnderAttack" );

    Health -= 1;

    if ( Health == 0 )

        BreakDown();

}

BreakDown <- function ()
{
    EntFireByHandle( ui, "Deactivate", "", 0.00, Owner, null );
    DispatchParticleEffect( "explosion_hegrenade_interior", sentry_m.GetOrigin(), Vector(0,0,0) );
    EntFireByHandle( _aud, "Volume", "0", 0.00, null, null );
    EntFireByHandle( _aud, "AddOutput", "message " + _snd[4], 0.00, null, null );
    EntFireByHandle( _aud, "PlaySound", "", 0.00, null, null );

    EntFireByHandle( sentry_m, "KillHierarchy", "", 0.00, null, null );
    aim.Destroy();
    _aud.Destroy();
    _aud2.Destroy();
    /*measure.Destroy();
    ms_tr.Destroy();
    ms_tr_rf.Destroy();*/

}

GetHitPosition <- function ( start, end ) 
{

    local fraction = TraceLine( start, end, null );
    local hitpos = start + ( end - start ) * fraction;

    //if( _DEBUG_ )
    //{
        DebugDrawLine( start, end, 255, 255, 255, false, 0.1 );
        DebugDrawLine( hitpos - Vector(10, 0, 0), hitpos + Vector(10, 0, 0), 255, 0, 0, true, 0.1 );
        DebugDrawLine( hitpos - Vector(0, 10, 0), hitpos + Vector(0, 10, 0), 0, 255, 0, true, 0.1 );
        DebugDrawLine( hitpos - Vector(0, 0, 10), hitpos + Vector(0, 0, 10), 0, 0, 255, true, 0.1 );
    //}

    return hitpos;

}