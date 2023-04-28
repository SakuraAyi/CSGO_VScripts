::items_template <- self;

Battery_Vector <- [
    Vector(-1336, -108, 96),
    Vector(-1334, -8, 96)
];

ArmorPlate_Vector <- [
    Vector(-1336, -108, 96),
    Vector(-1334, -8, 96)
];

function PreSpawnInstance(entityClass, entityName)
{
    if ((typeof slot) == "integer")
    {
        switch (slot)
        {
            case 0:
            {
                slot <- "nvg-battery";
                break;
            }
            case 1:
            {
                slot <- "armorplate";
                break;
            }
            default :
                return;
        }
    }
    local r = RandomInt(0, 360);
    local keyvalues = 
    {
        angles = r+" "+r+" "+r
    };
    return keyvalues;
};

function PostSpawn (entities)
{
    foreach (name, handle in entities)
    {
        if (handle == null) return;
        if (name != slot)
            handle.Destroy();
    }
};

Spawn <- function (n)
{
    slot <- n;
    DoEntFire("!self", "ForceSpawn", "", 0.00, self, self);
};
