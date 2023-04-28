Useing <- false;

enum action
{
    idle,

    walk_forward,
    walk_back,
    walk_left,
    walk_right,

    run_forward,
    run_back,
    run_left,
    run_right,

    ready_aim,
    once_fire,

    release_aim,
};

movement <- {
    current = "",
    moving = false,
    aiming = false,
    shooting = false,
    crouch = false
};

sequence <- [
    "at4_noaim",
    "at4_run_forward",
    "at4_run_back",
    "at4_run_left",
    "at4_run_right",

    "at4_aim",
    "at4_fire",

    "at4_crouch_aim",
    "at4_crouch_fire"
];

DestroyDummyAndRPG <- function ()
{
    Owner.GetScriptScope().m_dummy <- null;
    Owner.GetScriptScope().rpgmodel <- null;
    EntFireByHandle(view, "Disable", "", 0.00, null, null);
    EntFireByHandle(view, "Kill", "", 0.00, null, null);
    EntFireByHandle(ui, "Deactivate", "", 0.00, null, null);
    EntFireByHandle(ui, "Kill", "", 0.00, null, null);
    DoEntFire("!self", "Kill", "", 0.00, self, self);

    local animerunning = script_item.GetScriptScope().c_viewevent[Owner.GetScriptScope().userid.tostring()];
    animerunning._run <- false;

    local yaw = Owner.GetAngles().y;
    Owner.SetAngles(0, yaw, 0);
    BaseVS(Owner).SetKeyValue("disableflashlight", 0);
    BaseVS(Owner).SetKeyValue("disablereceiveshadows", 0);
    BaseVS(Owner).SetKeyValue("disableshadowdepth", 0);
    BaseVS(Owner).SetKeyValue("disableshadows", 0);
    BaseVS(Owner).SetRenderAmt(0, 255);
    BaseVS(Owner).SetPlayerSpeed(4, 1.0);
};

RPGControl <- function (n)
{
    local seq;
    if ((typeof n) == "string")
        seq = n;
    else
    {
        switch (n)
        {
            case action.run_forward:
            {
                seq = sequence[1];
                break;
            }
    
            case action.run_back:
            {
                seq = sequence[2];
                break;
            }

            case action.run_left:
            {
                seq = sequence[3];
                break;
            }

            case action.run_right:
            {
                seq = sequence[4];
                break;
            }

            case action.ready_aim:
            {
                if (!movement.moving)
                {
                    if (!movement.crouch)
                        seq = sequence[5];
                    else
                    {
                        movement.current = "";
                        seq = sequence[7];
                    }
                }
                else
                    return;
                break;
            }

            case action.release_aim:
            {
                if (movement.aiming && !movement.shooting)
                {
                    movement.aiming = false;
                    BaseVS(Owner).SetPlayerSpeed(4, 0.9);
                }
                return;
            }

            case action.once_fire:
            {
                if (movement.aiming)
                {
                    if (!movement.crouch)
                        seq = sequence[6];
                    else
                        seq = sequence[8];
                }
                else
                    return;
                break;
            }
        }
    }

    if (movement.current != seq)
    {
        if (n > action.idle && n <= action.run_right)
        {
            if (movement.aiming)
               return;
            if (!movement.moving)
            {
                movement.moving = true;
            }
        }
        else if (n == action.ready_aim)
        {
            if (!movement.aiming)
            {
                movement.aiming = true;

                if (!movement.crouch)
                {
                    viewdist.forward <- -16;
                    viewdist.right <- 24;
                    viewdist.up <- 68;
                }
                else
                {
                    viewdist.forward <- -24;
                    viewdist.right <- 24;
                    viewdist.up <- 51;
                }
                viewdist.yaw <- 0;  

                BaseVS(Owner).SetPlayerSpeed(4, 0.0);
            }
        }
        else if (n == action.once_fire)
        {
            if (!movement.shooting)
            {
                movement.shooting = true;
                script_item.GetScriptScope().RPG(Owner).Fire();

                local l_delay;
                if (!movement.crouch)
                    l_delay = 1.28;
                else
                    l_delay = 1.50,BaseVS(self).SetAnim("heavy_deploy_crouch", l_delay-0.40);
                EntFireByHandle(Owner.GetScriptScope().rpgmodel[0], "Kill", "", 0.00, null, null);
                EntFireByHandle(script_item, "RunscriptCode", "RPG("+ Owner.GetScriptScope().userid +").drop()", l_delay-0.41, null, null);
                EntFireByHandle(Owner.GetScriptScope().rpgmodel[1], "Kill", "", l_delay-0.40, null, null);
                DoEntFire("!self", "RunScriptCode", "DestroyDummyAndRPG()", l_delay, self, self);
                script_snd_template.GetScriptScope().Spawn(4, "", Owner.GetScriptScope().userid);
                //BaseVS(Owner).SetPlayerSpeed(4, 1.0, l_delay);
            }
        }
        movement.current = seq;
        BaseVS(self).SetAnim(seq);
    } 
};

viewdist <- {
    aim = false,
    forward = -32,
    right = 24,
    up = 68,
    yaw = 6
};

Think <- function ()
{
    if (!work) return;
    
    local _parent = Owner;
    local vel = _parent.GetVelocity();
    local prev = "";
    if (vel.Length() < 1)
    {
        if (!movement.aiming && !movement.shooting)
        {
            local attachID = Owner.LookupAttachment("grenade0");//clip_limit
            local _headVector = Owner.GetAttachmentOrigin(attachID);
            local _oriVector = Owner.GetOrigin();
            local dist = (_headVector - _oriVector).Length();
            local stand_height = 64;
            local crouch_height = 46;
            local boundary = 39;

            local seq;
            if (dist.tointeger() < boundary)
            {
                seq = sequence[7];
                if (!movement.crouch)
                    movement.crouch = true;
            }
            else
            {
                seq = sequence[0];
                if (movement.crouch)
                    movement.crouch = false;
            }
            if (movement.current != seq)
            {
                prev = movement.current;
                movement.current = seq;
                BaseVS(self).SetAnim(seq);
                if (movement.moving)
                    movement.moving = false;
            }
        }

         if (!movement.aiming)
        {
            viewdist.forward <- -32;
            viewdist.right <- 24;
            if (!movement.crouch)
                viewdist.up <- 68;
            else
                viewdist.up <- 51;
            viewdist.yaw <- 6;
        }
    }
    else
    {
        if (!movement.moving)
        {
            if (prev.find("run") > 0)
            {
                RPGControl(prev);
            }
            else
                RPGControl(action.run_forward);
        }
    }

    local face = Owner.GetScriptScope().trace;
    local _Vector = Owner.GetOrigin() + self.GetForwardVector() * viewdist.forward + self.GetLeftVector() * viewdist.right + Owner.GetUpVector() * viewdist.up;
    local _VectorB = face.GetAngles();
    view.SetOrigin(_Vector);
    view.SetAngles(0, _VectorB.y+viewdist.yaw, 0);
    //Owner.SetAngles(0, _VectorB.y, 0);

    if ("activate" in this)
    {
        if (!("wpn_hide" in this))
            this.wpn_hide <- false;
        local ganmeuiname = "gameui-";
        local hwpn_ui = Entities.FindByName(null, ganmeuiname+Owner.GetScriptScope().userid);
        if (activate > 0)
            EntFireByHandle(hwpn_ui, "Activate", "", 0.00, Owner, hwpn_ui), wpn_hide <- true;
        else
            if (wpn_hide)
                EntFireByHandle(hwpn_ui "Deactivate", "", 0.10, Owner, hwpn_ui), wpn_hide <- false;
    }
};