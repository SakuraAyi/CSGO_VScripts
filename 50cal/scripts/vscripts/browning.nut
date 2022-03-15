class Browning
{
    Health = 20;
    Ammo = 400;
    Damage = 300;
    Range = 2048;
    interval = 0.15;
    CD = 1;
}

MyName <- self.GetName();
MyOrigin <- self.GetOrigin();
Mdl_y <- self.GetMoveParent();
_UseBy <- null;

muzzle_Ori <- Vector(0,0,0);
CurrentAng <- Vector(0,0,0);

m_view <- null;
m_ui <- null;
m_but <- null;
m_fire <- null;
m_aud <- null;
m_hurt <- null;
m_measure <- null;
m_MsTg <- null;
m_MsRf <- null;
m_shell <- null;
m_text <- null;

firing <- false;
second <- 4;
delay <- 0.03;

mPgb_switch <- false;
mPgb_hud <- null;
mPgb_current <- 0;
mPgb_end <- 15;

msg <- [["弹药:","Ammo:"],["补充完毕","Done!"],["终止！","Stop!"]];
mdl <- ["models/shells/shell_12gauge.mdl", "models/shells/shell_762nato.mdl"];
snd <- "player/ammo_pack_use.wav";

function Precache()
{
    for ( local i = 0; i < mdl.len(); i++ )
    {
        self.PrecacheModel(mdl[i]);
    }
}

function OnPostSpawn ()
{
    local pos = self.GetOrigin();
    local yaw = self.GetAngles().y,dir = yaw * PI / 180;

    muzzle_Ori = Vector(pos.x+(cos(dir)*41), pos.y+(sin(dir)*41), pos.z+3);

    m_fire = Entities.CreateByClassname("env_muzzleflash");
    m_fire.__KeyValueFromInt("scale", 3);
    m_fire.SetOrigin(muzzle_Ori);
    m_fire.SetAngles(0,yaw,0);

    EntFireByHandle(m_fire, "SetParent", MyName, 0.00, null, null);

    m_hurt = Entities.CreateByClassname("point_hurt");
    m_hurt.__KeyValueFromString("classname", "dronegun");
    m_hurt.__KeyValueFromInt("DamageType", 64); //2
    m_hurt.__KeyValueFromInt("Damage", Browning.Damage);
    m_hurt.__KeyValueFromInt("DamageRadius", 16);
    m_hurt.SetOrigin(MyOrigin);

    m_measure = Entities.CreateByClassname("logic_measure_movement");
    m_MsTg = CreateProp("prop_dynamic", Vector(0, 0, 0), mdl[0], 0);
    m_MsTg.__KeyValueFromInt("rendermode", 10);
    m_MsRf = Entities.CreateByClassname("info_target");

    local ne = MyName.slice(14, MyName.len());
    m_MsTg.__KeyValueFromString("TargetName", "MsTg" + ne);
    m_MsRf.__KeyValueFromString("TargetName", "MsRf" + ne);

    m_measure.__KeyValueFromString("Target", m_MsTg.GetName());
    m_measure.__KeyValueFromInt("MeasureType", 1);
    m_measure.__KeyValueFromInt("TargetScale", 1);

    EntFireByHandle(m_measure, "SetMeaSureTarget", "none", 0.00, null, null);
    EntFireByHandle(m_measure, "SetMeaSureReference", m_MsRf.GetName(), 0.00, null, null);
    EntFireByHandle(m_measure, "SetTargetReference", m_MsRf.GetName(), 0.00, null, null);
    EntFireByHandle(m_measure, "Disable", "", 0.00, null, null);

    m_view = Entities.CreateByClassname("point_viewcontrol");
    m_view.__KeyValueFromString("targetname", "m2_view");
    m_view.__KeyValueFromInt("SpawnFlags", 8);

    local viewPos = pos + self.GetForwardVector() * -16 + self.GetUpVector() * 9 + self.GetLeftVector() * -0.3;
    m_view.SetOrigin(viewPos);
    m_view.SetAngles(0,yaw,0);

    EntFireByHandle(m_view, "SetParent", MyName, 0.00, null, null);

    local ent = null;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        if ( ent.GetClassname() == "func_button" && ent.GetName() == "m2_button" )
        {
            if ( ent.GetMoveParent() == self )

                m_but = ent;
        }
        
        else if ( ent.GetClassname() == "ambient_generic" && ent.GetName() == "Browning_Sound" )
        {
                m_aud = ent;
                m_aud.__KeyValueFromString("targetname", "");
        }

        else if ( ent.GetClassname() == "info_particle_system" && ent.GetName() == "Browning_Shell" )
        {
                if ( ent.GetMoveParent() == self )

                m_shell = ent;
        }
        else if ( ent.GetClassname() == "vgui_world_text_panel" && ent.GetName() == "Browning_Text" )
        {
                if ( ent.GetMoveParent() == self )

                m_text = ent;
        }
    }

    EntIO(m_but, "OnPressed", MyName, "RunScriptCode", "OnUse()", "0.00", "-1");

    Think();
    //Shoot();

}

OnUse <- function ()
{
    local atvr = activator;

    if ( atvr != null )
    {
        local pos = atvr.EyePosition();
        local dist = MyOrigin - pos;
        local total = dist.LengthSqr();

        if ( atvr.GetHealth() > 0 && total < 2304 )
        {
            _UseBy = atvr;

            m_ui = Entities.CreateByClassname("game_ui");
            m_ui.__KeyValueFromFloat("FieldOfView", 0.0);
            m_ui.__KeyValueFromInt("SpawnFlags", 224);
            m_ui.SetOwner(_UseBy);
            m_ui.SetOrigin(MyOrigin);

            EntIO(m_ui, "PlayerOff", MyName, "RunScriptCode", "PlayerOff()", "0.00", "-1");
            EntFireByHandle(m_but, "Lock", "", 0.00, null, null);

            if ( Browning.Ammo != 0 )
            {
                //m_ui.ConnectOutput("PlayerOff", "PlayerOff");
                EntIO(m_ui, "PressedAttack", MyName, "RunScriptCode", "OpenFire()", "0.00", "-1");
                EntIO(m_ui, "UnPressedAttack", MyName, "RunScriptCode", "CeaseFire()", "0.05", "-1");

                EntFireByHandle(m_view, "Enable", "", 0.10, _UseBy, null);
                EntFireByHandle(m_ui, "Activate", "", 0.00, _UseBy, null);
                EntFireByHandle(m_measure, "SetMeaSureTarget", _UseBy.GetName(), 0.00, null, null);
                EntFireByHandle(m_measure, "Enable", "", 0.00, null, null);
            }

            else
            {
                mPgb_switch = true;
                DoEntFire("!self", "RunScriptCode", "counter()", 0.00, self, self);
                EntFireByHandle(m_ui, "Activate", "", 0.00, _UseBy, null);
                EntFire("clientcommand", "command", "Play " + snd, 0.00, _UseBy);
            }
        }
    }
}

counter <- function ()
{
    local DisPlayPgb = "";

    if ( mPgb_switch )
    {
        if ( mPgb_current < mPgb_end )
        {
            DoEntFire("!self", "RunScriptCode", "counter()", 0.10, self, self);
            mPgb_current++;

            for ( local i = 0; i < mPgb_current; i++ )
            {
                DisPlayPgb += "■";
            }

            for ( local i = mPgb_current; i < mPgb_end; i++ )
            {
                DisPlayPgb += "□";
            }

            if ( mPgb_hud == null )
            {
                mPgb_hud = Entities.CreateByClassname("env_hudhint");
                mPgb_hud.SetOwner(_UseBy);
            }
        }

        else
        {
            DisPlayPgb = msg[1][m_lang];
            Browning.Ammo <- 400;
            EntFireByHandle(m_ui, "DeActivate", "", 0.00, _UseBy, null);
            //return;
        }
    }

    else

        DisPlayPgb = msg[2][m_lang];

    mPgb_hud.__KeyValueFromString("message", DisPlayPgb);
    EntFireByHandle(mPgb_hud, "ShowHudHint", "", 0.00, _UseBy, null);
}

Think <- function ()
{

    DoEntFire("!self", "RunScriptCode", "Think()", delay, self, self);

    local text = msg[0][m_lang] + Browning.Ammo;
    EntFireByHandle(m_text, "SetDisPlayText", text.tostring(), 0.00, null, null);
    
    if ( _UseBy != null && _UseBy.IsValid() )
    {
        local pitch = m_MsTg.GetAngles().x;
        local yaw = m_MsTg.GetAngles().y;

        if ( pitch < 0 && pitch > -45 || pitch > 0 && pitch < 45 )

            self.SetAngles(pitch, 0, 0);

        //else
        
            //PlayerOff();

        Mdl_y.SetAngles(0, yaw, 0);
        CurrentAng = m_MsTg.GetAngles();

        Shoot();
    }
}

OpenFire <- function ()
{
    if ( !firing  )
    
        firing = true;
    
}

CeaseFire <- function ()
{
    if ( firing )
    {
        firing = false;
        second = 4;
        self.__KeyValueFromInt("Sequence", 0);
        DispatchParticleEffect("weapon_muzzle_smoke_long", muzzle_Ori, Vector(0, 0, 0));
    }

}

Shoot <- function ()
{

    second++

    local _int = abs(Browning.interval / delay);

    if ( firing && Browning.Ammo != 0 && second%_int == 0 )
    {

        if ( second == _int*2 )
        
            second = 0;

        local yaw = self.GetAngles().y,dir = yaw * PI / 180;
        muzzle_Ori = Vector(MyOrigin.x+(cos(dir)*48), MyOrigin.y+(sin(dir)*48), m_fire.GetOrigin().z);

        local m_bullet = CreateProp("prop_dynamic", muzzle_Ori, mdl[1], 0);
        m_bullet.SetAngles(CurrentAng.x, CurrentAng.y, 0);

        local shellOut = MyOrigin + self.GetForwardVector() * 9 + self.GetLeftVector() * -6;
        shellOut.z += 2;

        DispatchParticleEffect("weapon_tracers_shot", muzzle_Ori, Vector(0, yaw, 0));
        DispatchParticleEffect("weapon_muzzle_flash_smoke_medium", muzzle_Ori, Vector(0, yaw, 0));
        DispatchParticleEffect("weapon_muzzle_flash_autoshotgun_fallback2", muzzle_Ori, Vector(0, yaw, 0));
        DispatchParticleEffect("impact_concrete_child_base", muzzle_Ori, Vector(0, 0, 0));
        yaw = CurrentAng.y;
        yaw -= 90;
        if (yaw < -180)
        {
            yaw += 360;
        }
        //DispatchParticleEffect("weapon_shell_casing_50cal", shellOut, Vector(-35,yaw,0));
        DispatchParticleEffect("weapon_muzzle_flash_assaultrifle_parent_silenced", shellOut, Vector(0,yaw,0))
        EntFireByHandle(m_fire, "Fire", "", 0.00, null, null);
        EntFireByHandle(m_aud, "PlaySound", "", 0.00, null, null);
        self.__KeyValueFromInt("Sequence", 1);

        EntFireByHandle(m_shell, "Start", "", 0.10, null, null);
        EntFireByHandle(m_shell, "Stop", "", 0.11, null, null);
        Browning.Ammo <-  Browning.Ammo - 1;

        local pos,end,tl;
        for ( local i = 0; i < Browning.Range; i++ )
        {
            pos = m_bullet.GetOrigin(),end = pos + m_bullet.GetForwardVector() * i;
            tl = TraceLine(pos, end, m_bullet);

            if ( i == Browning.Range )
            {
                m_bullet.Destroy();
                return;
            }

            DebugDrawLine(pos, end, 251, 151, 0, false, 0.03);

            if ( tl == 1.0 )
            {
                m_bullet.SetOrigin(end);

                local ent;
                for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )//while(( ent = Entities.FindByClassname(ent, "*")) != null )
                {
                    if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
                    {
                        local vic = ent;
                        local vicPos = vic.GetOrigin(),vicPos2 = vic.EyePosition();
                        vicPos.z += 36;
                        local dist = pos - vicPos,total = dist.LengthSqr();
                        local dist2 = pos - vicPos2,total2 = dist2.LengthSqr();


                        if ( total < 900 || total2 < 256 )
                        {
                            m_hurt.__KeyValueFromString("DamageTarget", vic.GetName());
                            EntFireByHandle(m_hurt, "Hurt", "", 0.00, _UseBy, null);
                            DispatchParticleEffect("blood_impact_goop_heavy", vicPos, Vector(0, yaw-180, 0));
                            DispatchParticleEffect("blood_impact_headshot", vicPos, Vector(0, yaw-180, 0));
                            m_bullet.Destroy();

                            return;
                        }
                    }
                    
                    else
                    {
                        continue;
                    }
                } 
            }

            else
            {
                DispatchParticleEffect("weapon_decoy_ground_effect_shot", pos, Vector(0, yaw, 0));
                DispatchParticleEffect("weapon_tracers_mach", pos, Vector(0, yaw, 0));
                DispatchParticleEffect("impact_concrete_child_smoke", pos, Vector(90, yaw, 180));
                DispatchParticleEffect("balloon_impact", pos, Vector(0, 0, 0));
                m_bullet.Destroy();

                return;
            }
        }
    }
}


PlayerOff <- function ()
{
    if ( mPgb_switch )
    {
        mPgb_switch = false;
        mPgb_current = 0;
    }

    else
    {
        CeaseFire();
        EntFireByHandle(m_view, "Disable", "", 0.00, null, null);
        EntFireByHandle(m_measure, "Disable", "", 0.00, null, null);
        EntFireByHandle(m_measure, "SetMeaSureTarget", "none", 0.00, null, null);
    }
    EntFireByHandle(m_but, "Unlock", "", 1.00, null, null);

    m_ui.Destroy();
    DoEntFire("!self", "RunScriptCode", "_UseBy = null", 0.10, self, self);
    //_UseBy = null;
}

