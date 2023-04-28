/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

class RPG_Properties
{
    //AT-4式84mm火箭筒
    prefix = "rpg-"
    CAL = "84mm"; // 口径84毫米，破甲弹，多用途弹 （预装弹射击后抛弃的一次性使用武器）
    Magnitude = 2000; //伤害当量级
    Radius = 256; // 杀伤范围半径
    Velocity = 11310; // 发射后 初速290m／s
    Range = 300*39; // 有效射程300米, 穿甲等效400mm以上
    Variance = 0.00 // 落点偏差，默认0.15
    Weight = 1.0; // 火箭弹质量3kg, 火箭筒战斗总质量6.7kg
    igniteDist = -8*2; // 多少距离触发引信
};

class RPG extends RPG_Properties
{
    handle = null;
    scope = null;
    dummy = null;
    dummySc = null;
    constructor (handle = null)
    {
        if ((typeof handle) == "integer")
            this.handle = BaseVS(handle).GetPlayerByUserid();
        else
            this.handle = handle;
        if (handle != null)
        {
            this.scope = this.handle.GetScriptScope();
            this.dummy = scope.m_dummy;
            this.dummySc = dummy.GetScriptScope();
        }
    }

    function BindAT4ForBack ()
    {
        local p = handle;
        local aim = scope.trace;
        local model = [ModelList[14], ModelList[15]];
        local attachID = p.LookupAttachment("primary");
        local attachVector = p.GetAttachmentOrigin(attachID);
        local attachAngles = p.GetAttachmentAngles(attachID);
        attachVector += aim.GetForwardVector() * 4 + aim.GetLeftVector() * -16 + aim.GetUpVector() * -4;
        local rpg = CreateProp("prop_dynamic", attachVector, model[0], 0);
        BaseVS(rpg).SetKeyValue("targetname", prefix+"rpgmodel_1_"+scope.userid);
        rpg.SetAngles(attachAngles.x, attachAngles.y, attachAngles.z);
        EntFireByHandle(rpg, "SetParent", p.GetName(), 0.00, null, null);
        EntFireByHandle(rpg, "SetParentAttachment", "primary2", 0.00, null, null);
        //EntFireByHandle(rpg, "SetParentAttachmentMaintainOffset", "primary", 0.00, null, null);
        scope.rpgmodel <- [rpg];

        rpg = CreateProp("prop_dynamic_ornament", Vector(0, 0, 0), model[1], 0);
        EntFireByHandle(rpg, "SetAttached", dummy.GetName(), 0.00, null, null);
        EntFireByHandle(rpg, "Disable", "", 0.00, null, null);
        scope.rpgmodel.push(rpg);
        BaseVS(rpg).SetKeyValue("targetname", prefix+"rpgmodel_2_"+scope.userid);
    }

    function Operation ()
    {
        local l_prefix = "dummy-";
        local plrOrigin = handle.GetOrigin();
        local plrAngles = scope.trace.GetAngles();
        local view = Entities.CreateByClassname("point_viewcontrol");
        BaseVS(view).SetKeyValue("targetname", l_prefix+"view_"+scope.userid);
        BaseVS(view).SetKeyValue("spawnflags", 136);
        
        local gameui = Entities.CreateByClassname("game_ui");
        BaseVS(gameui).SetKeyValue("targetname", l_prefix+"ui_"+scope.userid);
        BaseVS(gameui).SetKeyValue("spawnflags", 64);
        BaseVS(gameui).SetKeyValue("FieldOfView", -1);

        BaseVS(gameui).IO("PressedForward", dummy.GetName(), "RunScriptCode", "RPGControl(5)", "0.00", "-1");
        BaseVS(gameui).IO("PressedBack", dummy.GetName(), "RunScriptCode", "RPGControl(6)", "0.00", "-1");
        BaseVS(gameui).IO("PressedMoveLeft", dummy.GetName(), "RunScriptCode", "RPGControl(7)", "0.00", "-1");
        BaseVS(gameui).IO("PressedMoveRight", dummy.GetName(), "RunScriptCode", "RPGControl(8)", "0.00", "-1");

        BaseVS(gameui).IO("PressedAttack", dummy.GetName(), "RunScriptCode", "RPGControl(10)", "0.00", "-1");
        BaseVS(gameui).IO("PressedAttack2", dummy.GetName(), "RunScriptCode", "RPGControl(9)", "0.00", "-1");
        BaseVS(gameui).IO("UnpressedAttack2", dummy.GetName(), "RunScriptCode", "RPGControl(11)", "0.00", "-1");

        dummySc.view <- view;
        dummySc.ui <- gameui;
    }

    function Use (n)
    {
        local view = dummySc.view;
        local ui = dummySc.ui;
        if (n==1)
        {
            EntFireByHandle(scope.rpgmodel[0], "Disable", "", 0.00, null, null);
            EntFireByHandle(scope.rpgmodel[1], "Enable", "", 0.00, null, null);
            EntFireByHandle(ui, "Activate", "", 0.00, handle, ui);
            EntFireByHandle(view, "Enable", "", 0.00, handle, view);
        }
        else
        {
            EntFireByHandle(scope.rpgmodel[0], "Enable", "", 0.00, null, null);
            EntFireByHandle(scope.rpgmodel[1], "Disable", "", 0.00, null, null);
            EntFireByHandle(ui, "Deactivate", "", 0.00, handle, ui);
            EntFireByHandle(view, "Disable", "", 0.00, handle, view);
        }
    }

    function drop ()
    {
        local hand_attachID = handle.LookupAttachment("weapon_hand_R");
        local rpg_attachID = scope.rpgmodel[1].LookupAttachment("root");
        local pos = scope.m_dummy.GetAttachmentOrigin(hand_attachID);
        local ang = scope.rpgmodel[1].GetAttachmentAngles(rpg_attachID);
        local shooter = Entities.CreateByClassname("env_shooter");
        BaseVS(shooter).SetKeyValue("m_flVelocity", 2);
        BaseVS(shooter).SetKeyValue("m_iGibs", 1);
        BaseVS(shooter).SetKeyValue("simulation", 1);
        BaseVS(shooter).SetKeyValue("m_flGibLife", 2);
        BaseVS(shooter).SetKeyValue("shootmodel", ModelList[16]);
        BaseVS(shooter).SetKeyValue("gibangles", 80 + " " + ang.y + " " + ang.z);
        shooter.SetOrigin(pos);
        EntFireByHandle(shooter, "shoot", "", 0.00, null, null);
    }

    function Fire ()
    {
        local rpg_attachID = scope.rpgmodel[1].LookupAttachment("root");
        local muzzle = scope.rpgmodel[1].GetAttachmentOrigin(rpg_attachID) + scope.rpgmodel[1].GetForwardVector() * 19;
        local face = scope.m_dummy;
        local ang = face.GetAngles();//scope.rpgmodel[1].GetAttachmentAngles(rpg_attachID);
        local shooter = Entities.CreateByClassname("env_shooter");
        BaseVS(shooter).SetKeyValue("m_flVelocity", Velocity);
        BaseVS(shooter).SetKeyValue("m_flVariance", Variance);
        BaseVS(shooter).SetKeyValue("gibgravityscale", Weight);
        //BaseVS(shooter).SetKeyValue("massoverride", Weight);
        BaseVS(shooter).SetKeyValue("gibanglevelocity", 0);
        BaseVS(shooter).SetKeyValue("m_iGibs", 1);
        BaseVS(shooter).SetKeyValue("simulation", 1);
        BaseVS(shooter).SetKeyValue("m_flGibLife", 5);
        BaseVS(shooter).SetKeyValue("shootmodel", ModelList[2]);
        BaseVS(shooter).SetKeyValue("angles", -6 + " " + ang.y + " " + 0);
        BaseVS(shooter).SetKeyValue("gibangles", 0 + " " + (ang.y-90) + " " + 0);
        shooter.SetOrigin(muzzle);
        EntFireByHandle(shooter, "shoot", "", 0.00, null, null);
        DoEntFire("!self", "RunScriptCode", "items.FindGibs("+ scope.userid +")", 0.10, script_item, script_item);
    }
};