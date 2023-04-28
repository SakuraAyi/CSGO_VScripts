/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

ID <- -1;

function PreSpawnInstance( entityClass, entityName )
{
    local prefix;
    local scope = script_item.GetScriptScope();
    if (entityClass == "color_correction")
        prefix = scope.NVG.ccname;
	local keyvalues =
	{ 
   		targetname = prefix+ID
	};
	return keyvalues;
};

function PostSpawn( entities )
{
    this.ID = -1;
	foreach( entityClass, handle in entities )
	{
		printl( entityClass + ": " + handle );
        BaseVS(handle).SetKeyValue("maxfalloff", 26);
        BaseVS(handle).SetKeyValue("fadeInDuration", 0.00);
        BaseVS(handle).SetKeyValue("maxweight", 10.0);

        if (handle.ValidateScriptScope())
            handle.GetScriptScope().isenable <- false;
	}
};

Spawn <- function (uid)
{
    this.ID = uid;
    DoEntFire("!self", "ForceSpawn", "", 0.00, self, self);
};