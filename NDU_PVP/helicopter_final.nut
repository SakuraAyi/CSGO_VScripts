//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

LZ <- [
    [Vector(-1232,-1048,32),Vector(0,281,0)], // flyang yaw is 221
];

heli <- null;
heli_snd_holder <- null;
heli_ambient <- null;
view <- null;
mdl <- "models/props_vehicles/helicopter_rescue.mdl";
ani <- ["helicopter_coop_hostagepickup_flyin", "helicopter_coop_hostagepickup_idle", "4Lift"];
ptc <- ["aztec_copter_takeoff", "copter_land_loop_1"];
snd <- ["vehicles/insertion/helicopter.wav","ambient/playonce/machines/heli_pass_quick1.wav"];
pilotVoice <- [
    "11/nazi/heli/helipilot_ready1.wav",
    "11/nazi/heli/helipilot_ready3.wav",
    "11/nazi/heli/helipilot_ready7.wav",
    "11/nazi/heli/helipilot_ready9.wav",
    "11/nazi/heli/chopper01.wav",
    "11/nazi/heli/chopper02.wav",
    "11/nazi/heli/chopper03.wav",
    "11/nazi/heli/chopper04.wav",
    "11/nazi/heli/chopper05.wav"
];
TraceSwitch <- true;
Landed <- false;
::skinonourteeth <- false;
HumanNums <- 0;
NumberOfEvacuees <- 0;
::Rescued <- [];
second <- 0;


function Precache ()
{
    self.PrecacheModel(mdl);

    for ( local i = 0; i < pilotVoice.len(); i++ )
    {
        self.PrecacheSoundScript(pilotVoice[i]);
    }
}

function StartAimBot()
{
    sentry <- view;
    Think();
}

function Think() 
{
    if ( ::isOver )
        return;
    DoEntFire("!self", "RunScriptCode", "Think()", 0.01, self, self);

    local Target = heli;
    if( Target != null && TraceSwitch ) 
    {
        local m_attachmentID = Target.LookupAttachment("cam_pos");
        local m_attachmentVector = Target.GetAttachmentOrigin(m_attachmentID);
        local m_sentryAngles = sentry.GetAngles();
        local m_targetVector = m_attachmentVector;//Target.EyePosition();
        local m_sentryOrigin = sentry.GetOrigin();
        local m_dir = m_targetVector - m_sentryOrigin;

        local UCSX = sqrt(pow(m_dir.x,2)+pow(m_dir.y,2));
        local pitch = asin(m_dir.z / sqrt( pow(UCSX,2) + pow(m_dir.z,2) )) * 180 / PI * -1;
        local yaw = asin(m_dir.y / sqrt( pow(m_dir.x,2) + pow(m_dir.y,2) )) * 180 / PI;

        if(m_dir.x < 0)
            yaw = 180 - yaw;
        
        /*if ( m_sentryAngles.x < pitch )
            m_sentryAngles.x += 1;
        else
            m_sentryAngles.x -= 1;
        if ( m_sentryAngles.x > 0 && pitch > 0 && abs(m_sentryAngles.x - pitch) == 3 ||  m_sentryAngles.x < 0 && pitch < 0 && abs(m_sentryAngles.x - pitch) == 3 )
            return;
        if ( m_sentryAngles.y < yaw )
            m_sentryAngles.y += 1;
        else
            m_sentryAngles.y -= 1;
        if ( m_sentryAngles.y > 0 && yaw > 0 && abs(m_sentryAngles.y - yaw) == 3 ||  m_sentryAngles.y < 0 && yaw < 0 && abs(m_sentryAngles.y - yaw) == 3 )
            return;
        sentry.SetAngles(m_sentryAngles.x,m_sentryAngles.y,0);*/
        sentry.SetAngles(pitch,yaw,0);

        heli_snd_holder.SetOrigin(m_attachmentVector);
    }

    if ( Landed )
    {
        local m_attachmentID = Target.LookupAttachment("cam_pos");
        local m_attachmentVector = Target.GetAttachmentOrigin(m_attachmentID);
        local ent,user;

        second++;

        if ( second%2000 == 0 )
            EntFire("Script", "RunScriptCode", "ng_vo(2)");
        if ( second%800 == 0 )
        {
            local r = RandomInt(0,pilotVoice.len()-1);
            self.EmitSound(pilotVoice[r]);
        }
        if ( second >= 2400 )
            second = 0;

        ent = Entities.FindByClassnameWithin(ent, "player", m_attachmentVector, 128);
        if ( ent != null && ent.IsValid() )
        {
            user = ent;
            if ( user.GetTeam() == 3 && user.GetHealth() > 0 )
            {
                if ( NumberOfEvacuees < HumanNums || HumanNums == 0 )
                {
                    NumberOfEvacuees += 1;
                    if ( HumanNums == 0 )
                        HumanNums = ::Player_Alive_number;
                    //::Player_Alive_number -= 1;
                    user.SetOrigin(Vector(10069,-389,-360));
                    Rescued.push(user);
                    local clientview = Entities.CreateByClassname("point_viewcontrol");
                    clientview.__KeyValueFromInt("spawnflags", 12);
                    clientview.SetOrigin(Vector(-191,-436,430));
                    clientview.SetAngles(32,188,0);

                    EntFireByHandle(clientview, "Enable", "", 0.00, user, null);
                    Out();
                }
                if ( NumberOfEvacuees > 0 )
                {
                    if ( ::Player_Alive_number == 0 )
                    {
                        Out();
                    }
                }
            }
        }

        local m_propellerVector = Vector(-1160,-950,224),m_activatorVector,m_dist,m_total;
        local hurt;
        ent = null;
        while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
        {
            if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot")
            {
                user = ent;
                if ( user.GetHealth() > 0 )
                {
                    m_activatorVector = user.GetOrigin();
                    m_dist = m_propellerVector - m_activatorVector;
                    m_total = m_dist.LengthSqr();
                    if ( m_activatorVector.z > 160 && m_activatorVector.z < 264 && m_total < 129600 )
                    {
                        hurt = Entities.CreateByClassname("point_hurt");
                        hurt.__KeyValueFromString("DamageTarget", user.GetName());
                        hurt.__KeyValueFromInt("DamageType", 1);
                        hurt.__KeyValueFromInt("Damage", 99999);
                        EntFireByHandle(hurt, "Hurt", "", 0.00, null, null);
                        EntFireByHandle(hurt, "Kill", "", 0.00, null, null);
                    }
                }
            }
        }
    }
};

OnSpawn <- function ()
{
    ::skinonourteeth = true;
    if ( heli == null )
        heli = CreateProp("prop_dynamic", LZ[0][0], mdl, 0);
    heli.SetAngles(0,LZ[0][1].y,0);
    ::VS.SetAni(heli, ani[0]);
    heli.__KeyValueFromString("targetname", "helicopter_final");
    EntIO(heli, "OnAnimationDone", self.GetName(), "RunScriptCode", "OnLand()", "0.00", "1");

    view = Entities.CreateByClassname("point_viewcontrol_multiplayer");
    view.__KeyValueFromString("targetname", "view_final");
    view.__KeyValueFromInt("spawnflags", 136);
    //view.__KeyValueFromString("target", heli.GetName());
    //view.__KeyValueFromString("targetattachment", "cam_pos");
    //view.__KeyValueFromInt("trackspeed", 120);
    view.__KeyValueFromInt("fov", 55);
    view.__KeyValueFromInt("fov_rate", 3);
    view.SetOrigin(Vector(-350,216,345));
    EntFireByHandle(view, "Enable", "", 10.00, null, null);
    EntFireByHandle(view, "Disable", "", 18.00, null null);
    ::music_timer = 0;
    EntFire("Script", "RunScriptCode", "PlayMusic_loop(10,10,44)", 10.00);
    

    EntFire("heli_final_temp", "ForceSpawn");
    DoEntFire("!self", "RunScriptCode", "BindSnd()", 0.00, self, self);
    DoEntFire("!self", "RunScriptCode", "StartAimBot()", 0.00, self, self);
    EntFire("Script", "RunScriptCode", "ng_vo(1)", 13.50);
};

BindSnd <- function ()
{
    heli_snd_holder = Entities.FindByName(null, "heli_final_holder");
    heli_ambient = Entities.FindByName(null, "heli_final_sound");
    local pos;
    pos = heli.GetOrigin();
    heli_ambient.SetOrigin(pos);

    EntFireByHandle(heli_ambient, "PlaySound", "", 11.00, null, null);
    EntFireByHandle(heli_ambient, "StopSound", "", 19.00, null, null)
    EntFireByHandle(heli_ambient, "PlaySound", "", 19.00, null, null);
    DoEntFire("!self", "RunScriptCode", "self.EmitSound(snd[0])", 9.70, self, self);
}

OnLand <- function ()
{
    TraceSwitch = false;
    Landed = true;
    ::VS.SetAni(heli, ani[1]);
    local tempPos = LZ[0][0];tempPos.x = -1087;tempPos.y = -840;
    DispatchParticleEffect(ptc[1], tempPos, Vector(0,0,0));
    EntFire("heli_final_wall", "Enable");
    DoEntFire("!self", "RunScriptCode", "self.EmitSound(pilotVoice[3])", 3.00, self, self);
    //EntFire("Script", "RunScriptCode", "Wave_Start(6)");
};

Out <- function ()
{
    if ( NumberOfEvacuees == HumanNums )
    {
        isOver = true;
        EntFire("Script", "RunScriptCode", "PlayMusic(11,10)");

        heli.SetAngles(0,221,0);
        ::VS.SetAni(heli, ani[2]);
        self.EmitSound(snd[1]);

        view.SetOrigin(Vector(-960,-1000,730));
        view.SetAngles(90,-90,0);
        view.__KeyValueFromInt("fov", 110);
        view.__KeyValueFromInt("fov_rate", 6);
        EntFireByHandle(heli_ambient, "StopSound", "", 0.00, null, null);

        local clientview = null;
        while ( ( clientview = Entities.FindByClassname(clientview, "*") ) != null )
        {
            if ( clientview.GetClassname() == "point_viewcontrol" )
            {
                EntFireByHandle(clientview, "Disable", "", 0.00, null, null);
                EntFireByHandle(clientview, "Kill", "", 0.00, null, null);
            }
            else if ( clientview.GetClassname() == "player" )
                EntFireByHandle(clientview, "SetHUDVisibility", "0", 0.00, null, null);
        }
        EntFireByHandle(view, "Enable", "", 0.00, null, null);
        ::MissionFail(2);

        return;
    }
}