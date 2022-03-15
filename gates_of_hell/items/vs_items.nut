/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

::script_item <- self;
DoIncludeScript("gates_of_hell/items/vs_at4.nut", this);
DoIncludeScript("gates_of_hell/items/vs_knife.nut", this);

::items <- {};
c_viewevent <- {};

g_allow_use_nvg <- true;
class Base
{
    handle = null;

    number = null;
    player = null;
    sc = null;

    constructor (handle)
    {
        local pass = false
        if ((typeof handle) == "integer")
        {
            this.number = handle;
            this.handle = BaseVS(handle.tointeger()).GetPlayerByUserid();
            if (BaseVS(this.handle).IsPlayer())
                pass = true
        }
        else { if (BaseVS(handle).IsPlayer()) { this.handle = handle; pass = true; } }
        
        if (pass) { this.player = this.handle; this.sc = this.player.GetScriptScope(); }
        else
            return;
    }
};

class NVG extends Base
{
    arr={};
    table={};

    nvgname = "vm-";
    ccname = "cc-";
    ganmeuiname = "gameui-";
    electric = 100;
    consume = (  (2)*10  );
    enable_delay = 1.00;

    function equip ()
    {
        local l_viewclass = "predicted_viewmodel";
        local l_viewmodel = null;
        while ((l_viewmodel = Entities.FindByClassname(l_viewmodel, l_viewclass)) != null)
        {
            if (this.player == l_viewmodel.GetMoveParent())
            {
                local l_propmodel = ModelList[1]
                local l_nvg = CreateProp("prop_dynamic", Vector(0, 0, 0), l_propmodel, 0);
                local _idx = l_nvg.entindex();
                this.player.GetScriptScope().ent_nvg <- _idx; 
                BaseVS(l_nvg).SetKeyValue("targetname", nvgname+"items_"+this.sc.userid);
                BaseVS(l_nvg).SetKeyValue("fademindist", 48);BaseVS(l_nvg).SetKeyValue("fademaxdist", 49);
                BaseVS(l_nvg).SetKeyValue("disableflashlight", 1);
                BaseVS(l_nvg).SetKeyValue("disableshadows", 1);
                BaseVS(l_nvg).SetKeyValue("disableshadowdepth", 1);
                BaseVS(l_nvg).SetKeyValue("DisableBoneFollowers", 1);
                BaseVS(l_viewmodel).SetKeyValue("targetname", "viewmodel-"+this.sc.userid);
                BaseVS(l_nvg).SetParent(l_viewmodel, "-13 -2 -11", "0 0 0");
                BaseVS(l_nvg).SetAnim(0, 0.00);
                BaseVS(l_nvg).SetRenderAmt(10, 0, 0.00);
                if (l_nvg.ValidateScriptScope())
                    l_nvg.GetScriptScope().electric <- this.electric;

                /*local l_cc = CreateNvgEffect();
                BaseVS(l_cc).SetKeyValue("targetname", ccname+this.sc.userid);
                l_cc.SetOwner(this.player);*/
                local sc_cc_template = Entities.FindByName(null, "cc_template").GetScriptScope();
                sc_cc_template.Spawn(this.sc.userid);
                
                ///////// hide weapon entity function
                local l_ui = CreateHideWeaponGUI();
                BaseVS(l_ui).SetKeyValue("targetname", ganmeuiname+this.sc.userid);
                l_ui.SetOwner(this.player);
                ///////// hide weapon entity function

                arr[this.sc.userid.tostring()] <- 0;
                table[this.sc.userid.tostring()] <- {pass = true};
                break;
            }
        }
    }

    function on_off ()
    {
        local _data = table[sc.userid.tostring()];
        local animerunning = script_item.GetScriptScope().c_viewevent[sc.userid.tostring()];
        if (!_data.pass || animerunning._run) return;
        if (!(this.sc.userid.tostring() in arr)) { local l_text = PlayerHint[3][g_lang]; BaseVS(player).ShowhintForClient(0, l_text); return; }
        if (!script_item.GetScriptScope().g_allow_use_nvg || arr[this.sc.userid.tostring()] < 0) return;

        local l_nvg = Entities.FindByName(null, nvgname+"items_"+this.sc.userid);
        local l_electric = l_nvg.GetScriptScope().electric;

        local dummy = sc.m_dummy, dummySc, dummyUseing = false;
        try
        {
            if (dummy != null && dummy.IsValid())
            {
                dummySc = dummy.GetScriptScope();
                if (dummySc.Useing)
                    dummyUseing = true;
            }
        }
        catch (e) null;

        local fd_io = 0.50; 
        local fd_holdtime = 0.25;
        local n = 0; //hideweapon_delay
        if (arr[this.sc.userid.tostring()] < 1)
        {
            BaseVS(l_nvg).SetAnim("down", 0.00);
            local bodyindex = 6;
            BaseVS(this.player).SetBodyGroup(bodyindex);
            sc.body_idx <- bodyindex;
            if (!dummyUseing)
            {
                BaseVS(l_nvg).SetRenderAmt(0, 255, 0.00);
                BaseVS(l_nvg).SetRenderAmt(10, 0, enable_delay);
            }
            else
                BaseVS(dummy).SetBodyGroup(bodyindex);
            //if (l_electric > 0)
                //BaseVS(this.player).PlaySndForClient(SoundList[0], enable_delay);
            Fade(this.player, "0 0 0", fd_io, fd_holdtime, (enable_delay-0.15));
            //local l_idx = this.player.entindex();
            arr[this.sc.userid.tostring()] <- 1;

            n = enable_delay*10;
        }
        else
        {
            local l_close_delay = 0.00;
            BaseVS(l_nvg).SetAnim("up", l_close_delay);
            BaseVS(l_nvg).SetAnim("default", (enable_delay));
            local bodyindex = 5;
            BaseVS(this.player).SetBodyGroup(bodyindex);
            sc.body_idx <- bodyindex;
            if (!dummyUseing)
            {
                BaseVS(l_nvg).SetRenderAmt(0, 255, l_close_delay);
                BaseVS(l_nvg).SetRenderAmt(10, 0, l_close_delay+(enable_delay));
            }
            else
                BaseVS(dummy).SetBodyGroup(bodyindex);
            Fade(this.player, "0 0 0", fd_io, 0.00, l_close_delay);
            BaseVS(this.player).PlaySndForClient(SoundList[1], l_close_delay);
            arr[this.sc.userid.tostring()] <- 0;

            n = enable_delay*10;//(enable_delay/2)*10;
        }
        BaseVS(l_nvg).SetBodyGroup(0);
        BaseVS(l_nvg).SetModelScale(3);
        BaseVS(l_nvg).SetLocalOrigin("-13 -2 -11");

        local hwpn_ui = Entities.FindByName(null, ganmeuiname+this.sc.userid);
        local hwpn_delay = 0.00;
        for (local i = 0; i < n-1; i++)
        {
            EntFireByHandle(hwpn_ui, "Activate", "", hwpn_delay, this.player, hwpn_ui);
            hwpn_delay += 0.10;
        }
        EntFireByHandle(hwpn_ui "Deactivate", "", (n/10)+0.01, this.player, hwpn_ui);

        _data.pass <- false;
        animerunning._run <- true;
        DoEntFire("!self", "RunScriptCode", "NVG.table[\""+sc.userid+"\"].pass <- true", 1.00, script_item, script_item);
        DoEntFire("!self", "RunScriptCode", "c_viewevent[\""+sc.userid+"\"]._run <- false", 1.00, script_item, script_item);
    }
};

class ArmorPlate extends Base
{
    viewmodel = "predicted_viewmodel";
    worldmodel = "weaponworldmodel";
    prefix = "vm-";
    arrmorType = "item_kevlar";
    default_num = 5;
    reload = 1; //Capacity space allowed to mount

    table = {};

    function equip ()
    {
        local vm;
        while ((vm = Entities.FindByClassname(vm, viewmodel)) != null)
        {
            if (vm.GetMoveParent() == player)
            {
                local model = ModelList[17];
                local ibas = CreateProp("prop_dynamic", Vector(0, 0, 0), model, 0);
                BaseVS(ibas).SetKeyValue("targetname", prefix+"armor_"+sc.userid);
                BaseVS(ibas).SetKeyValue("fademindist", 48);BaseVS(ibas).SetKeyValue("fademaxdist", 49);
                BaseVS(ibas).SetKeyValue("disableflashlight", 1);
                BaseVS(ibas).SetKeyValue("disableshadows", 1);
                BaseVS(ibas).SetKeyValue("disableshadowdepth", 1);
                BaseVS(ibas).SetKeyValue("DisableBoneFollowers", 1);
                BaseVS(ibas).SetRenderAmt(10, 0);
                
                BaseVS(ibas).SetParent(vm, "-1 -1 -1.6", "0 0 0");

                //local ibas_idx = ibas.entindex();
                //sc.armor_index <- ibas_idx;
                sc.ibas <- ibas;
                sc.armor_number <- default_num;

                table[sc.userid.tostring()] <- {pass = true};
                break;
            }
        }
    }

    function Load ()
    {
        if ("ibas" in this.sc)
        {
            local _data = table[sc.userid.tostring()];
            local animerunning = script_item.GetScriptScope().c_viewevent[sc.userid.tostring()];
            local ibas = sc.ibas;

            if (_data.pass && !animerunning._run)
            {
                if (sc.armor_number < 1)
                {
                    local l_text = PlayerHint[5][g_lang];
                    BaseVS(player).ShowhintForClient(0, l_text);
                    return;
                }

                BaseVS(ibas).SetRenderAmt(0, 255);

                local delay = 1.00;
                BaseVS(ibas).SetAnim("armorplate_open");
                BaseVS(player).PlaySndForClient(SoundList[18], 0.41);

                local mountTime = 0.96; //mount over time
                //Mount multiple
                //if (reload > 1)
                //{
                    local n;
                    if (sc.armor_number < reload)
                        n = sc.armor_number;
                    else
                        n = reload;
                    for (local i = 0; i < n; i++)
                    {
                        BaseVS(ibas).SetAnim("armorplate_insert", delay);
                        BaseVS(player).PlaySndForClient(SoundList[19], delay+0.50);
                        delay+=mountTime;
                        //sc.armor_number -= 1;
                        DoEntFire("!self", "RunScriptCode", "ArmorPlate("+sc.userid+").ShowleftAmount()", delay-0.3, script_item, script_item)
                    }
                //}

                BaseVS(player).GetItem(arrmorType, delay);
                BaseVS(ibas).SetAnim("armorplate_close", delay);
                BaseVS(player).PlaySndForClient(SoundList[20], delay);

                delay+=0.81
                BaseVS(ibas).SetRenderAmt(10, 0, delay);

                _data.pass <- false;
                animerunning._run <- true;
                DoEntFire("!self", "RunScriptCode", "ArmorPlate.table[\""+sc.userid+"\"].pass <- true", delay, script_item, script_item);
                DoEntFire("!self", "RunScriptCode", "c_viewevent[\""+sc.userid+"\"]._run <- false", delay, script_item, script_item);

                local hwpn_ui_prefix = "gameui-";
                local hwpn_ui = Entities.FindByName(null, hwpn_ui_prefix+sc.userid);

                local hwpn_delay = 0.00;
                for (local i = 0; i < (delay*10); i++)
                {
                    EntFireByHandle(hwpn_ui, "Activate", "", hwpn_delay, player hwpn_ui);
                    hwpn_delay += 0.10;
                }
                EntFireByHandle(hwpn_ui, "Deactivate", "", hwpn_delay+0.01, player hwpn_ui);
            }
        }
    }

    function ShowleftAmount ()
    {
        sc.armor_number -= 1;
        local text = PlayerHint[4][g_lang] + sc.armor_number;
        BaseVS(player).ShowhintForClient(0, text);
    }
};

class Glowstick extends Base
{
    table={};
    prefix = "vm-";

    default_num = 15;
    lightColor = {yellow = "255 255 0", red = "255 0 0", blue = "0 128 255", green = "0 255 0"};
    throwVel = [500, 250]; 
    Life = "300"; //s

    function Sign ()
    {
        local hand = Entities.FindByName(null, prefix+"items_"+sc.userid);
        this.table[sc.userid.tostring()] <- {hand = hand, pass = true, skin = 0, on = false, ready = false, throwing = false};
        sc.glowstick_number <- default_num;
    }

    function Switch ()
    {
        local _data = table[sc.userid.tostring()];
        local animerunning = script_item.GetScriptScope().c_viewevent[sc.userid.tostring()];
        local hand = _data.hand;
        
        if (_data.pass)
        {
            local readyDelay = 0.6;

            if (!_data.on)
            {
                if (animerunning._run || sc.glowstick_number < 1) return;
                
                BaseVS(hand).SetRenderAmt(0, 255);
                BaseVS(hand).SetAnim("glowstick_draw");
                BaseVS(hand).SetAnim("glowstick_idle", readyDelay);
                DoEntFire("!self", "RunScriptCode", "Glowstick.table[\""+sc.userid+"\"].ready <- true", readyDelay, script_item, script_item);
                BaseVS(hand).SetBodyGroup(1);
                local r = RandomInt(0,3);
                BaseVS(hand).SetSkin(r);
                _data.skin <- r;

                BaseVS(hand).SetModelScale(1);
                BaseVS(hand).SetLocalOrigin("-1.5 2 0");

                _data.on <- true;
                animerunning._run <- true;

                if (!("cl" in _data))
                {
                    local cl = Entities.CreateByClassname("game_ui");
                    BaseVS(cl).SetKeyValue("spawnflags", 64);
                    BaseVS(cl).SetKeyValue("FieldOfView", -1.0);
                    BaseVS(cl).IO("PressedAttack", script_item.GetName(), "RunScriptCode", "Glowstick("+sc.userid+").Throw(0)", "0.00", "-1");
                    BaseVS(cl).IO("PressedAttack2", script_item.GetName(), "RunScriptCode", "Glowstick("+sc.userid+").Throw(1)", "0.00", "-1");
                    _data.cl <- cl;
                }

                EntFireByHandle(_data.cl, "Activate", "", 0.00, player, _data.cl);
            }
            else
            {
                BaseVS(hand).SetRenderAmt(10, 0);
                _data.throwing <- false;
                _data.on <- false;
                _data.ready <- false;
                _data.current_anim <- "";

                script_item.GetScriptScope().c_viewevent[sc.userid.tostring()]._run <- false;

                local hwpn_ui_prefix = "gameui-";
                local hwpn_ui = Entities.FindByName(null, hwpn_ui_prefix+sc.userid);
                EntFireByHandle(hwpn_ui, "Deactivate", "", 0.03, player hwpn_ui);
                EntFireByHandle(_data.cl, "Deactivate", "", 0.03, player, _data.cl);
            }
            _data.pass <- false;
            DoEntFire("!self", "RunScriptCode", "Glowstick.table[\""+sc.userid+"\"].pass <- true", readyDelay, script_item, script_item);
        }
    }

    function Throw (n)
    {
        local uid = sc.userid;
        local _data = table[uid.tostring()];
        local hand = _data.hand;

        if (_data.ready && !_data.throwing)
        {
            _data.throwing <- true;
            _data.ready <- false;
            local dropDelay = 0.27;
            local endDelay = 0.5;
            BaseVS(hand).SetAnim("glowstick_throw");
            BaseVS(hand).SetBodyGroup(0, dropDelay);

            local shooter = Entities.CreateByClassname("env_shooter");
            BaseVS(shooter).SetKeyValue("spawnflags", 4);
            if (n == 0)
                BaseVS(shooter).SetKeyValue("m_flVelocity", throwVel[0]);
            else
                BaseVS(shooter).SetKeyValue("m_flVelocity", throwVel[1]);
            BaseVS(shooter).SetKeyValue("gibanglevelocity", 90);
            BaseVS(shooter).SetKeyValue("m_iGibs", 1);
            BaseVS(shooter).SetKeyValue("simulation", 1);
            BaseVS(shooter).SetKeyValue("m_flGibLife", Life);
            BaseVS(shooter).SetKeyValue("shootmodel", ModelList[21]);
            
            _data.shooter <- shooter;

            EntFireByHandle(shooter, "shoot", "", dropDelay, null, null);
            DoEntFire("!self", "RunScriptCode", "items.FindGibs("+ sc.userid +")", dropDelay+0.03, script_item, script_item);

            local template = script_light_template.GetScriptScope();
            
            
            sc.glowstick_number--;
            if (sc.glowstick_number > 0)
            {
                local readyDelay = 0.6;
                BaseVS(hand).SetAnim("glowstick_draw", endDelay);
                BaseVS(hand).SetBodyGroup(1, endDelay+0.1);
                BaseVS(hand).SetAnim("glowstick_idle", endDelay+readyDelay);
                _data.current_anim <- "";

                local r = RandomInt(0,3);
                BaseVS(hand).SetSkin(r,endDelay+0.1);
                DoEntFire("!self", "RunScriptCode", "Glowstick.table[\""+sc.userid+"\"].skin <- "+r, endDelay+0.1, script_item, script_item);

                DoEntFire("!self", "RunScriptCode", "Glowstick.table[\""+sc.userid+"\"].throwing <- false", endDelay, script_item, script_item);
                DoEntFire("!self", "RunScriptCode", "Glowstick.table[\""+sc.userid+"\"].ready <- true", endDelay+readyDelay, script_item, script_item);
            }
            else
                script_item.GetScriptScope().Glowstick(player).Switch();
        }
    }

    function MoveAni ()
    {
        if (!("userid" in sc)) return;
        local uid = sc.userid;
        if (uid.tostring() in table)
        {
            local _data = table[uid.tostring()];
            local hand = _data.hand;

            if ("shooter" in _data)
            {
                if (_data.shooter != null && _data.shooter.IsValid())
                {
                    local face = sc.trace;
                    local ptich = face.GetAngles().x;
                    local yaw = face.GetAngles().y;
                    local shooter = _data.shooter;
                    BaseVS(shooter).SetKeyValue("angles", ptich-5 + " " + yaw + " " + 0);

                    local attachID = player.LookupAttachment("weapon_hand_R");
                    local pos = player.GetAttachmentOrigin(attachID);
                    shooter.SetOrigin(pos);
                }
            }

            if (!("current_anim" in _data))
                _data.current_anim <- "";
            if (_data.on)
            {
                local hwpn_ui_prefix = "gameui-";
                local hwpn_ui = Entities.FindByName(null, hwpn_ui_prefix+sc.userid);
                EntFireByHandle(hwpn_ui, "Activate", "", 0.00, player hwpn_ui);

                if (!_data.ready || _data.throwing) return;
                local anim;
                if (handle.GetVelocity().Length() > 64)
                {
                    anim = "glowstick_move";
                    if (_data.current_anim != anim)
                        BaseVS(hand).SetAnim(anim);
                }
                else
                {
                    anim = "glowstick_idle";
                    if (_data.current_anim != anim)
                        BaseVS(hand).SetAnim(anim);
                }
                _data.current_anim <- anim;
            }
        }
    }
};

items.second <- 0.00;
function items::Think ()
{
    //DoEntFire("!self", "RunScriptCode", "items.Think()", 0.01, script_item, script_item)
    if (!work) return;
    
    second++;
    //ScriptPrintPlayerHintChatAll(second.tostring());

    local scope = script_item.GetScriptScope();
    local l_ent;
    local l_once = false;
    for (l_ent = Entities.First(); l_ent != null; l_ent = Entities.Next(l_ent))
    {
        if (BaseVS(l_ent).IsPlayer())
        {
            local l_plr = l_ent;
            if (l_plr.IsValid() && BaseVS(l_plr).IsAlive() && l_plr.GetTeam() == 3)
            {
                local l_sc = l_plr.GetScriptScope();

                try scope.knive(l_plr).run() catch(e) printl(e);
                scope.Glowstick(l_plr).MoveAni()
                //try
                //{
                    if ("userid" in l_sc)
                    {
                        local l_uid = l_sc.userid;
                        local c_ = scope.c_viewevent;
                        if (!(l_uid.tostring() in c_))
                            c_[l_uid.tostring()] <- {_run = false};

                        //night vision sight
                        if (!(l_uid.tostring() in scope.NVG.arr))
                        {
                            if (!l_once)
                            {
                                scope.NVG(l_plr).equip();
                                l_once = true;

                                //return;
                            }
                        }
                        else
                        {
                            local l_cc = Entities.FindByName(null, scope.NVG.ccname+l_sc.userid);
                            local l_cc_sc = l_cc.GetScriptScope();
                            local l_nvg_sc = Entities.FindByName(null, scope.NVG.nvgname+"items_"+l_sc.userid).GetScriptScope();
                            local l_text = "";
                            if (scope.NVG.arr[l_uid.tostring()] > 0)
                            {
                                if (!l_cc_sc.isenable && l_nvg_sc.electric > 0)
                                    EntFireByHandle(l_cc, "Enable", "", scope.NVG.enable_delay, null, null), BaseVS(l_plr).PlaySndForClient(SoundList[0], scope.NVG.enable_delay+0.1), l_cc.GetScriptScope().isenable <- true;
                                if (second%(scope.NVG.consume*10) == 0)
                                {
                                    if (l_nvg_sc.electric != 0)
                                        l_nvg_sc.electric--;
                                    this.second <- 0.00;
                                    //ScriptPrintPlayerHintChatAll(l_nvg_sc.electric.tostring());
                                }
                                if (second%10 == 0) {l_text = PlayerHint[0][g_lang] + format("%.2f", l_nvg_sc.electric) + "%"; BaseVS(l_plr).ShowhintForClient(0, l_text);}
                                BaseVS(l_cc).SetKeyValue("origin", l_plr.GetOrigin());
                            }
                            if (scope.NVG.arr[l_uid.tostring()] == 0 && l_cc_sc.isenable || l_nvg_sc.electric < 1)
                                EntFireByHandle(l_cc, "Disable", "", 0.00, null, null),l_cc.GetScriptScope().isenable <- false;
                            else if (scope.NVG.arr[l_uid.tostring()] < 0) scope.NVG.arr[l_sc.userid.tostring()] <- 0;
                        }

                        //armor
                        if (!(l_uid.tostring() in scope.ArmorPlate.table))
                        {
                            if (!l_once)
                            {
                                scope.ArmorPlate(l_plr).equip();
                                l_once = true;
                            }
                        }

                        //glowstick
                        if (!(l_uid.tostring() in scope.Glowstick.table))
                        {
                            if (!l_once)
                            {
                                scope.Glowstick(l_plr).Sign();
                                l_once = true;
                            }
                        }

                    }
                //}
                //catch (e)
                    //printl(e);
            }
        }
    }
};

function items::CreateEquip (wpnClass)
{
    local eq = Entities.CreateByClassname("game_player_equip");
    BaseVS(eq).SetKeyValue("spawnflags", 5);
    BaseVS(eq).SetKeyValue(wpnClass.tostring(), 1);
    return eq;
};

function items::ClearEquip (entityPlayer)
{
    if (BaseVS(entityPlayer).IsPlayer())
    {
        local plr = entityPlayer;
        local sc = plr.GetScriptScope();
        if (plr.GetTeam() == 3)
        {
            try
            {
                if (sc.m_dummy != null && sc.m_dummy.IsValid())
                {
                    sc.m_dummy.Destroy();
                    sc.m_dummy <- null;
                    sc.rpgmodel[0].Destroy();
                    sc.rpgmodel[1].Destroy();
                    sc.rpgmodel <- null;
                }
            }
            catch (e)
            {
                printl(e);
            }
        }
    }
};

function items::DrawSound (entityPlayer, modelName)
{
    local uid = entityPlayer.GetScriptScope().userid;
    local prev = script_item.GetScriptScope().knive.table[uid.tostring()].previous;
    if (modelName.find("pist") > 0 || modelName.find("dao") > 0)
    {
        local r = RandomInt(28, 30);
        local snd = SoundList[r];
        BaseVS(entityPlayer).PlaySndForClient(snd);
    }
    else if (modelName.find("eq") > 0)
    {
        local r = RandomInt(25, 27);
        local snd = SoundList[r];
        BaseVS(entityPlayer).PlaySndForClient(snd);
    }
    else if (modelName.find("weapon") > 0)
    {
        local r = RandomInt(22, 24);
        local snd = SoundList[r];
        BaseVS(entityPlayer).PlaySndForClient(snd);
    }
};

function items::FindGibs (uid = null)
{
    if (!work)
        return;
    
    local plr = null;
    local ent;
    while ((ent = Entities.FindByClassname(ent, "*")) != null)
    {
        if (ent.GetClassname() == "gib")
        {
            if (ent.GetModelName().find("missile") > 0)
            {
                local rocket = ent;
                local rocketSc = rocket.GetScriptScope();
                BaseVS(rocket).SetKeyValue("targetname", "missile-"+rocket.entindex());
                if (uid != null)
                {
                    plr = BaseVS(uid).GetPlayerByUserid();
                    rocket.SetOwner(plr);
                    script_light_template.GetScriptScope().Spawn(0, rocket);
                    return;
                }
                else
                {
                    plr = rocket.GetOwner();
                    if (plr != null)
                    {
                        local mainScope = script_item.GetScriptScope();
                        local _start = rocket.GetOrigin();
                        local TriPos = _start + rocket.GetLeftVector() * mainScope.RPG().igniteDist;
                        local vel = rocket.GetVelocity(); //Why can't we get the speed of the physical model?
                        DispatchParticleEffect("explosion_child_core04b", _start, _start);
                        DispatchParticleEffect("explosion_child_core06a", _start, _start);

                        local TriPos2 = _start + rocket.GetLeftVector() * abs(mainScope.RPG().igniteDist*2); local TriPos3 = _start + rocket.GetForwardVector() * mainScope.RPG().igniteDist; local TriPos4 = _start + rocket.GetForwardVector() * abs(mainScope.RPG().igniteDist); local TriPos5 = _start + rocket.GetUpVector() * mainScope.RPG().igniteDist; local TriPos6 = _start + rocket.GetUpVector() * abs(mainScope.RPG().igniteDist);
                        //BaseVS(rocket).GetHitPosition(TriPos);
                        
                        local frac = TraceLine(_start, TriPos, null); local frac2 = TraceLine(_start, TriPos2, null); local frac3 = TraceLine(_start, TriPos3, null); local frac4 = TraceLine(_start, TriPos4, null); local frac5 = TraceLine(_start, TriPos5, null); local frac6 = TraceLine(_start, TriPos6, null);

                        local pass = false;
                        if (frac < 1.0 || frac2 < 1.0 || frac3 < 1.0 || frac4 < 1.0 || frac5 < 1.0 || frac6 < 1.0)
                            pass = true;
                        else
                        {
                            local ene = Entities.FindByClassnameNearest("player", TriPos, 75);
                            if (ene != null)
                                pass = true;
                        }
                        if (pass)
                        {
                            rocket.Destroy();
                            local exp = Entities.CreateByClassname("env_explosion");
                            BaseVS(exp).SetKeyValue("classname", "prop_exploding_barrel"); BaseVS(exp).SetKeyValue("iMagnitude", mainScope.RPG().Magnitude); BaseVS(exp).SetKeyValue("iRadiusOverride", mainScope.RPG().Radius); BaseVS(exp).SetKeyValue("origin", _start);
                            exp.SetOwner(plr);
                            EntFireByHandle(exp, "Explode", "", 0.00, plr, plr);
                            script_snd_template.GetScriptScope().Spawn(5, "", -1, _start);
                            break;
                        }
                    }
                    if ("light" in rocketSc)
                    {
                        local pos = rocket.GetOrigin();
                        rocketSc.light.SetOrigin(pos);
                    }
                }
            }
            else if (ent.GetModelName().find("glowstick") > 0)
            {
                local glowstick = ent;
                local sc; 
                if (glowstick.ValidateScriptScope())
                    sc = glowstick.GetScriptScope();

                if (!("pass" in sc))
                {
                    if (uid != null)
                    {
                        BaseVS(glowstick).SetKeyValue("targetname", "glowstick-"+glowstick.entindex());
                        sc.pass <- 1;

                        plr = BaseVS(uid).GetPlayerByUserid();
                        local mainSc = script_item.GetScriptScope();
                        local skin = mainSc.Glowstick(plr).table[uid.tostring()].skin;
                        local color;
                        switch (skin)
                        {
                            case 0:
                            {
                                color = mainSc.Glowstick.lightColor.yellow;
                                break;
                            }
                            case 1:
                            {
                                color = mainSc.Glowstick.lightColor.red;
                                break;
                            }
                            case 2:
                            {
                                color = mainSc.Glowstick.lightColor.blue;
                                break;
                            }
                            case 3:
                            {
                                color = mainSc.Glowstick.lightColor.green;
                                break;
                            }
                        }
                        sc.skin <- skin;
                        sc.color <- color;
                        BaseVS(glowstick).SetKeyValue("skin", skin);
                        script_light_template.GetScriptScope().Spawn(1, glowstick);
                        return;
                    }
                }
                else
                {
                    if ("light" in sc)
                    {
                        local pos = glowstick.GetOrigin();
                        pos.z+=16;
                        sc.light.SetOrigin(pos);
                    }
                }
            }
        }
        else if (ent.GetClassname().find("light") != null)
        {
            local sc = ent.GetScriptScope();
            if ("owner" in sc)
                if (sc.owner == null || !sc.owner.IsValid())
                    ent.Destroy();
        }
    }
};