::script_light_template <- self;
g_type <- -1;
g_target <- null;
g_pos <- Vector(0, 0, 0);

function PreSpawnInstance (entityClass, entityName)
{
    local keyvalues,prefix;
    prefix = "light-"
    switch (g_type)
    {
        //AT-4 Fire
        case 0:
        {
            
            keyvalues = {
                targetname = prefix+"AT4_",
                _light = "255 128 0 200",
                //angles = "90 0 0",
                pitch = -90,
                _inner_cone = 80,
                _cone = 90,
                distance = 768,
                spotlight_radius = 512,
                brightness = 4
            };
            break;
        }
        case 1:
        {
            keyvalues = {
                targetname = prefix+"glowstick_",
                //skin = g_target.GetScriptScope().skin,
                _light = g_target.GetScriptScope().color,
                //angles = "90 0 0",
                pitch = -90,
                _inner_cone = 80,
                _cone = 90,
                distance = 512,
                spotlight_radius = 300,
                brightness = 2
            };
            break;
        }
        default:
            return;
    }
    return keyvalues;
};

function PostSpawn (entities)
{
    foreach ( entityClass, entity in entities)
    {
        if (entitiy == null) return;
        printl( entityClass + ": " + entity );
        if (entityClass.find("light") != null)
        {
            BaseVS(entity).SetKeyValue("targetname", entity.GetName()+entity.entindex());

            local l_pos = g_target.GetOrigin();
            BaseVS(entity).SetKeyValue("origin", l_pos);

            if (g_target.ValidateScriptScope())
                g_target.GetScriptScope().light <- entity;
            if (entitiy.ValidateScriptScope())
                entitiy.GetScriptScope().owner <- g_target;
            EntFireByHandle(entity, "TurnOn", "", 0.00, null, null);
        }
    }
};

Spawn <- function (n, entity = null, pos = null, delay = 0.00)
{
    g_type <- n;
    g_target <- entity;
    g_pos <- pos;
    DoEntFire("!self", "ForceSpawn", "", delay, self, self);
};