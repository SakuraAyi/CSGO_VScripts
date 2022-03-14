//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

class panzer
{
    health = 10000;
    speed = 1.1;
    meleeDMG = 300;
    cannonDMG = 100;
    ammo = 30;
    i_forward = 0;
    i_back = 0;
    i_left = 0;
    i_right = 0;
    i_attack = 0;
    i_attack2 = 0;
    i_idle = 0;
    i_freeze = false;
};

script_main <- null;

i_selfName <- null;
i_spotlight <- null;
i_spotlight_holder <- null; 
i_eyelight <- null;
i_laser <- null;
i_shooter <- null;
i_hitbox <- null;

_UseBy <- null;
_PlayerID <- null;

m_measure <- null;
m_MsTg <- null;
m_MsRf <- null;
m_ui <- null;
m_view <- null;

second <- 0;

mdl <- "models/shells/shell_12gauge.mdl";
snd <- [
    "11/nazi/panzer/ambient_0",
    "11/nazi/panzer/anim_decepticon_lg_run_0",
    "11/nazi/panzer/swing_0 ",
    "11/nazi/panzer/melee_b.mp3",
    "11/nazi/panzer/death_00.mp3"
];

VS <- 
{
    function SetAni (entity,param)
    {
        EntFireByHandle(entity, "SetAnimation", param, 0.00, null, null);
    },
    function SetParent (entity,param,attach)
    {
        EntFireByHandle(entity, "SetParent", param, 0.00, null, null);
        if ( attach != null )
        {
            EntFireByHandle(entity, "SetParentAttachment", attach, 0.00, null, null);
        }
    },
    function SetScriptScope (target,param)
    {
        DoEntFire(target, "RunScriptCode", param, 0.00, target, target);
    }
};

function Precache ()
{
    for ( local i = 0; i < 5; i ++ )
    {
        self.PrecacheSoundScript(snd[0]+i+".mp3");
        if ( i != 0 )
            self.PrecacheSoundScript(snd[1]+i+".mp3");
        self.PrecacheSoundScript(snd[2]+i+".mp3");

        if ( i == 0 )
        {
            self.PrecacheSoundScript(snd[3]);
            self.PrecacheSoundScript(snd[4]);
        }
    }
};

function OnPostSpawn ()
{
    printl("spawn");
    Precache();
    i_selfName = self.GetName();

    script_main = Entities.FindByName(null, "Script");

    m_measure = Entities.CreateByClassname("logic_measure_movement");
    self.PrecacheModel(mdl);
    m_MsTg = CreateProp("prop_dynamic", Vector(0,0,0), mdl, 0);
    m_MsTg.__KeyValueFromInt("rendermode", 10);
    m_MsRf = Entities.CreateByClassname("info_target");

    local ne = "panzer";
    m_MsTg.__KeyValueFromString("targetname", "MsTg_"+ne);
    m_MsRf.__KeyValueFromString("targetname", "MsRf_"+ne);

    m_measure.__KeyValueFromString("Target", m_MsTg.GetName());
    m_measure.__KeyValueFromInt("MeasureType", 1);
    m_measure.__KeyValueFromInt("TargetScale", 1000);

    EntFireByHandle(m_measure, "SetMeaSureTarget", "none", 0.00, null, null);
    EntFireByHandle(m_measure, "SetMeaSureReference", m_MsRf.GetName(), 0.00, null, null);
    EntFireByHandle(m_measure, "SetTargetReference", m_MsRf.GetName(), 0.00, null, null);
    EntFireByHandle(m_measure, "Disable", "", 0.00, null, null);
    
    local viewpos = self.GetOrigin() + self.GetForwardVector() * -45 + self.GetUpVector() * 95 + self.GetLeftVector() * -30;
    local yaw = self.GetAngles().y;
    m_view = Entities.CreateByClassname("point_viewcontrol");
    m_view.__KeyValueFromInt("spawnflags", 0);
    m_view.SetAngles(0,yaw,0);
    m_view.SetOrigin(viewpos);
    EntFireByHandle(m_view, "SetParent", i_selfName, 0.00, null, null);

    m_ui = Entities.CreateByClassname("game_ui");
    m_ui.__KeyValueFromInt("spawnflags", 64);
    m_ui.__KeyValueFromInt("FieldOfView", -1);
    EntIO(m_ui, "PressedForward", i_selfName, "RunScriptCode", "if(panzer.i_back==0){panzer.i_forward <- 1;}else if(panzer.i_back==3){panzer.i_forward<-0;panzer.i_back<-0;}else if(panzer.i_back==2){panzer.i_forward<-3;}", "0.00", "-1");
    EntIO(m_ui, "UnPressedForward", i_selfName, "RunScriptCode", "if(panzer.i_back==3){panzer.i_back <- 1;panzer.i_forward <- 0;}else panzer.i_forward <- 0;", "0.00", "-1");
    EntIO(m_ui, "PressedBack", i_selfName, "RunScriptCode", "if(panzer.i_forward==0){panzer.i_back <- 1;}else if(panzer.i_forward==3){panzer.i_forward<-0;panzer.i_back<-0;}else if(panzer.i_forward==2){panzer.i_back<-3;}", "0.00", "-1");
    EntIO(m_ui, "UnPressedBack", i_selfName, "RunScriptCode", "if(panzer.i_forward==3){panzer.i_forward <- 1;panzer.i_back <- 0;}else panzer.i_back <- 0;", "0.00", "-1");
    EntIO(m_ui, "PressedMoveLeft", i_selfName, "RunScriptCode", "if(panzer.i_right==0){panzer.i_left <- 1;}else if(panzer.i_right==3){panzer.i_left<-0;panzer.i_right<-0;}else if(panzer.i_right==2){panzer.i_left<-3;}", "0.00", "-1");
    EntIO(m_ui, "UnPressedMoveLeft", i_selfName, "RunScriptCode", "if(panzer.i_right==3){panzer.i_right <- 1;panzer.i_left <- 0;}else panzer.i_left <- 0;", "0.00", "-1");
    EntIO(m_ui, "PressedMoveRight", i_selfName, "RunScriptCode", "if(panzer.i_left==0){panzer.i_right <- 1;}else if(panzer.i_left==3){panzer.i_left<-0;panzer.i_right<-0;}else if(panzer.i_left==2){panzer.i_right<-3;}", "0.00", "-1");
    EntIO(m_ui, "UnPressedMoveRight", i_selfName, "RunScriptCode", "if(panzer.i_left==3){panzer.i_left <- 1;panzer.i_right <- 0;}else panzer.i_right <- 0;", "0.00", "-1");
    EntIO(m_ui, "PressedAttack", i_selfName, "RunScriptCode", "panzer.i_attack <- 1", "0.00", "-1");
    EntIO(m_ui, "UnPressedAttack", i_selfName, "RunScriptCode", "panzer.i_attack <- 0;panzer.i_freeze <- false", "0.00", "-1");
    EntIO(m_ui, "PressedAttack2", i_selfName, "RunScriptCode", "panzer.i_attack2 <- 1", "0.00", "-1");
    EntIO(m_ui, "UnPressedAttack2", i_selfName, "RunScriptCode", "panzer.i_attack2 <- 0;panzer.i_attack <- 0;panzer.i_freeze <- false;LaserSwitch()", "0.00", "-1");

    //Think();
};

OnUse <- function (id)
{
    _UseBy = ::BOT[id][0];
    _PlayerID = id;
    EntFireByHandle(m_measure, "SetMeaSureTarget", _UseBy.GetName(), 0.00, null, null);
    EntFireByHandle(m_measure, "Enable", "", 0.00, null, null);
    EntFire("zombie_effects_template", "ForceSpawn");
    DoEntFire("!self", "RunScriptCode", "BindMDL()", 0.00, self, self);
};

BindMDL <- function ()
{
    local yaw = m_MsTg.GetAngles().y,ori = _UseBy.GetOrigin();
    
    self.SetAngles(0,yaw,0);
    self.SetOrigin(ori);
    //VS.SetParent(self, _UseBy.GetName(), null);
    VS.SetAni(self, "Arrive");
    
    i_spotlight = Entities.FindByName(null, "panzer_spotlight_");
    i_spotlight.__KeyValueFromString("targetname", "");
    i_spotlight_holder = Entities.FindByName(null, "panzer_spotlight_holder_");
    i_spotlight_holder.__KeyValueFromString("targetname", "");
    //i_eyelight = Entities.FindByName(null, "panzer_eye_light_");
    //i_eyelight.__KeyValueFromString("targetname", "");
    i_laser = Entities.FindByName(null, "wplaser_");
    i_laser.__KeyValueFromString("targetname", "");
    i_shooter = Entities.FindByName(null, "shooter_");
    i_shooter.__KeyValueFromString("targetname", "");
    local eyepos = self.GetOrigin() + self.GetUpVector() * 78 + self.GetForwardVector() * 26;
    local gunpos = self.GetOrigin() + self.GetUpVector() * 62 + self.GetForwardVector() * 56 + self.GetLeftVector() * -8;
    local laserTgPos = gunpos + self.GetForwardVector() * 1024;
    local selfAng = self.GetAngles();

    EntFireByHandle(i_spotlight_holder, "SetParent", i_selfName, 0.00, null, null);
    EntFireByHandle(i_spotlight_holder, "SetParentAttachment", "HeadLight", 0.00, null, null);
    EntFireByHandle(i_spotlight, "LightOff", "", 0.00, null, null);
    EntFireByHandle(i_spotlight, "LightOn", "", 3.00, null, null);

    /*i_eyelight.SetOrigin(eyepos);
    i_eyelight.SetAngles(0,selfAng.y-180,0);
    EntFireByHandle(i_eyelight, "SetParent", i_selfName, 0.00, null, null);
    EntFireByHandle(i_eyelight, "TurnOn", "", 0.00, null, null);*/

    i_shooter.SetOrigin(gunpos);
    i_shooter.SetAngles(0,selfAng.y,0);
    EntFireByHandle(i_shooter, "SetParent", i_selfName, 0.00, null, null);

    local laserTg = Entities.CreateByClassname("info_target");
    laserTg.__KeyValueFromString("targetname", "panzer_laserTg_");
    i_laser.__KeyValueFromString("LaserTarget", laserTg.GetName());
    i_laser.SetOrigin(gunpos);
    laserTg.SetOrigin(laserTgPos);
    EntFireByHandle(i_laser, "SetParent", i_selfName, 0.00, null, null);
    EntFireByHandle(laserTg, "SetParent", i_selfName, 0.00, null, null);

    i_hitbox = Entities.FindByName(null, "panzer_hitbox");
    i_hitbox.__KeyValueFromString("targetname", "");
    i_hitbox.__KeyValueFromInt("health", panzer.health);
    i_hitbox.SetOrigin(ori);
    EntFireByHandle(i_hitbox, "SetParent", _UseBy.GetName(), 0.00, null, null);

    EntFireByHandle(m_view, "Enable", "", 0.00, _UseBy, null);
    EntFireByHandle(m_ui, "Activate", "", 2.70, _UseBy, null);
    DoEntFire("!self", "RunScriptCode", "Think()", 2.70, self, self);
};

LaserSwitch <- function ()
{
    if ( panzer.i_attack2 == 2 )
        EntFireByHandle(i_laser, "TurnOn", "", 0.00, null, null);
    else
        EntFireByHandle(i_laser, "TurnOff", "", 0.00, null, null);
};

meleehurt <- function ()
{
    if ( panzer.i_attack == 2 )
    {
        local ori = self.GetOrigin() + self.GetUpVector() * 60 + self.GetForwardVector() * 60;
        local hurt = Entities.CreateByClassname("point_hurt");
        hurt.__KeyValueFromInt("Damage", panzer.meleeDMG);
        hurt.__KeyValueFromInt("DamageType", 0);
        hurt.__KeyValueFromInt("DamageRaduis", 256);
        hurt.__KeyValueFromInt("DamageDelay", 1);

        local ent,vic = null;
        while ( ( ent = Entities.FindByClassnameWithin(ent, "*", ori, 48) ) != null )
        {
            if ( ent.GetClassname() == "player" || ent.GetClassname() == "cs_bot" )
            {
                if ( ent.GetTeam() == 3 )
                {
                    vic = ent;
                    hurt.__KeyValueFromString("DamageTarget", vic.GetName());
                    break;
                }
            }
        }
        hurt.SetOwner(_UseBy);
        EntFireByHandle(hurt, "Hurt", "", 0.00, _UseBy, null);
        EntFireByHandle(hurt, "Kill", "", 0.00, null, null);
    }
};

timer <- 0;
Think <- function ()
{
    //printl("working...");
    DoEntFire("!self", "RunScriptCode", "Think()", 0.03, self, self);

    second++;

    local r = RandomInt(6,11);
    local one = floor(1/0.03);//format("%d",1/0.03);
    if ( timer == 0 )
        timer = one*r;
    //ScriptPrintMessageChatAll(timer.tostring());
    if ( second%timer == 0 )
    {
        second = 0;
        timer = 0;
        local ent = Entities.FindByName(null, "zombie_snd_id"+_PlayerID);
        local sr = RandomInt(0,4);
        ent.__KeyValueFromString("message", snd[0]+sr+".mp3");
        EntFireByHandle(ent, "PlaySound", "", 0.00, null, null);
        EntFireByHandle(ent, "Volueme", "4", 0.00, null, null);
    }

    local yaw = m_MsTg.GetAngles().y,ori = _UseBy.GetOrigin();
    self.SetAngles(0,yaw,0);
    self.SetOrigin(ori);
    if ( panzer.i_forward == 1 )
    {
        printl("forward");
        VS.SetAni(self, "Run");
        ::VS.SetSpeed(_UseBy, 1, panzer.speed);
        panzer.i_forward <- 2;
        panzer.i_idle <- 0;
        panzer.i_attack <- 0;
        panzer.i_attack2 <- 0;
        LaserSwitch();
    }
    else if ( panzer.i_back == 1 )
    {
        printl("back");
        VS.SetAni(self, "Walk2");
        ::VS.SetSpeed(_UseBy, 1, ((panzer.speed/2) - 0.2));
        panzer.i_back <- 2;
        panzer.i_idle <- 0;
        panzer.i_attack <- 0;
        panzer.i_attack2 <- 0;
        LaserSwitch();
    }

    if ( panzer.i_left == 1 )
    {
        printl("left");
        if ( panzer.i_forward != 2 && panzer.i_back != 2 )
        {
            VS.SetAni(self, "Run");
            ::VS.SetSpeed(_UseBy, 1, panzer.speed);
        }
        panzer.i_left <- 2;
        panzer.i_idle <- 0;
        panzer.i_attack <- 0;
        panzer.i_attack2 <- 0;
        LaserSwitch();
    }
    else if ( panzer.i_right == 1 )
    {
        printl("right");
        if ( panzer.i_forward != 2 && panzer.i_back != 2 )
        {
            VS.SetAni(self, "Run");
            ::VS.SetSpeed(_UseBy, 1, panzer.speed);
        }
        panzer.i_right <- 2;
        panzer.i_idle <- 0;
        panzer.i_attack <- 0;
        panzer.i_attack2 <- 0;
        LaserSwitch();
    }

    if ( panzer.i_attack == 1 && panzer.i_attack2 != 2 )
    {
        printl("attack")
        VS.SetAni(self, "Attack0");
        if ( !panzer.i_freeze )
        {
            ::VS.SetSpeed(_UseBy, 1, 0);
            panzer.i_freeze <- true;
        }
        DoEntFire("!self", "RunScriptCode", "meleehurt()", 0.10, self, self);
        panzer.i_attack <- 2;

        panzer.i_forward <- 0;
        panzer.i_back <- 0;
        panzer.i_left <- 0;
        panzer.i_right <- 0;
        panzer.i_idle <- 0;
    }
    else if ( panzer.i_attack == 1 && panzer.i_attack2 == 2 )
    {
        printl("fire")
        if ( panzer.ammo > 0 )
        {
            VS.SetAni(self, "PostFireChainGun");
            panzer.i_attack <- 2;
            EntFireByHandle(i_shooter, "shoot", "", 0.00, null, null);
            EntFireByHandle(script_main, "RunScriptCode", "::shootgibexp("+_PlayerID+")", 0.30, null, null);
            panzer.ammo <- (panzer.ammo - 1);
        }
    }
    else if ( panzer.i_attack2 == 1 && panzer.i_attack != 2 )
    {
        printl("pregun")
        VS.SetAni(self, "PreFireChainGun");
        if ( !panzer.i_freeze )
        {
            ::VS.SetSpeed(_UseBy, 1, 0);
            panzer.i_freeze <- true;
        }
        DoEntFire("!self", "RunScriptCode", "LaserSwitch()", 0.50, self, self);
        panzer.i_attack2 <- 2;

        panzer.i_forward <- 0;
        panzer.i_back <- 0;
        panzer.i_left <- 0;
        panzer.i_right <- 0;
        panzer.i_idle <- 0;
    }

    if ( panzer.i_idle == 0 && panzer.i_forward == 0 && panzer.i_back == 0 && panzer.i_left == 0 && panzer.i_right == 0 && panzer.i_attack == 0 && panzer.i_attack2 == 0 )
    {
        //printl("idle");
        VS.SetAni(self, "Idle");
        panzer.i_idle <- 1;
    }
};

