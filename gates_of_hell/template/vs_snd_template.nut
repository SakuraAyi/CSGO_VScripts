/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

::script_snd_template <- self;
build_type <- -1;
player_id <- -1;
squad <- "";
pos <- Vector(0, 0, 0);
keyvalues <- "";
scope <- null;
function PreSpawnInstance( entityClass, entityName )
{
    local prefix;
    if (entityClass == "ambient_generic")
    {
        switch (build_type)
        {
            //helicopter_drop
            case 0:
            {
                prefix = script_intro.GetScriptScope().helicopter.g_name;
                keyvalues = 
                {
   		            targetname = prefix+"snd_"+(script_intro.GetScriptScope().helicopter.team.squad())
                    SourceEntityName = prefix+"sign_"+(script_intro.GetScriptScope().helicopter.team.squad())
                    radius = 32767
            	}
                break;
            }
            case 1:
            {
            }
            case 2:
            {
            }
            case 3:
            {
                prefix = script_intro.GetScriptScope().helicopter.g_name;
                keyvalues = 
                {
   		            targetname = prefix+"snd_guy_"+(script_intro.GetScriptScope().helicopter.team.squad(squad))+"_uid_"+player_id
                    SourceEntityName = prefix+"cam_"+(script_intro.GetScriptScope().helicopter.team.squad(squad))+"_uid_"+player_id
                    radius = 1250
            	}
                break;
            }

            //AT-4 Launcher
            case 4:
            {
                prefix = "rpg-";
                keyvalues = 
                {
                    targetname = prefix + rand(),
                    radius = 1250
            	}
                break;
            }
            case 5:
            {
                prefix = "rpg-";
                keyvalues = 
                {
                    targetname = prefix + rand(),
                    radius = 4096
            	}
                break;
            }
            default :
                return;
        }
    }

	return keyvalues;
};

function PostSpawn( entities )
{
	foreach( entityClass, handle in entities )
	{
        printl( entityClass + ": " + handle );
        switch (build_type)
        {
            ////helicopter_drop
            case 0:
            {
                local sign_heli = Entities.FindByName(null, script_intro.GetScriptScope().helicopter.g_name+"sign_"+script_intro.GetScriptScope().helicopter.team.squad());
                BaseVS(handle).SetParent(sign_heli);
                //self.EmitSound(SoundList[3]);
                BaseVS(handle).PlaySound(SoundList[3], 0.00);

                //shake sound
                BaseVS(handle).PlaySound(SoundList[2], 0.00);
                BaseVS(handle).PlaySound(SoundList[5], 0.01);

                //door_open
                BaseVS(handle).PlaySound(SoundList[7], 0.75);

                //rope_spot
                BaseVS(handle).PlaySound(SoundList[6], 1.30);

                //pilot
                BaseVS(handle).PlaySound(SoundList[9], 0.40);

                //ext_ster
                BaseVS(handle).PlaySound(SoundList[8], 12.00);

                EntFireByHandle(handle, "Kill", "", 12.00, null, null);
                ScriptPrintMessageChatAll("test")

                break;
            }
            case 1:
            {
                BaseVS(handle).PlaySound(SoundList[10], 0.00);
                EntFireByHandle(handle, "Kill", "", script_intro.GetScriptScope().helicopter.g_ropecutoff_frame_length, null, null);
                break;
            }
            case 2:
            {
                BaseVS(handle).PlaySound(SoundList[11], 0.00);
                EntFireByHandle(handle, "Kill", "", script_intro.GetScriptScope().helicopter.g_ropecutoff_frame_length, null, null);
                break;
            }
            case 3:
            {
                //local sign = Entities.FindByName(null, scope.helicopter.g_name+"cam_"+scope.helicopter.team.squad(squad)+"_uid_"+player_id);
                //BaseVS(handle).SetParent(sign);
                BaseVS(handle).PlaySound(SoundList[12], 7.00);
                EntFireByHandle(handle, "Kill", "", script_intro.GetScriptScope().helicopter.g_ropecutoff_frame_length, null, null);
                break;
            }

            //AT-4 Launcher
            case 4:
            {
                local plr = BaseVS(player_id).GetPlayerByUserid();
                local l_pos = plr.EyePosition();
                handle.SetOrigin(l_pos);
                BaseVS(handle).PlaySound(SoundList[13], 0.00);
                EntFireByHandle(handle, "Kill", "", 0.00, null, null);
                break;
            }
            case 5:
            {
                handle.SetOrigin(pos);
                local r = RandomInt(15,17);
                BaseVS(handle).PlaySound(SoundList[r], 0.00);
                EntFireByHandle(handle, "Kill", "", 0.00, null, null);
                break;
            }
            default :
            {
                handle.Destroy();
                return;
            }
        }
	}
};

Spawn <- function (n, squad = "", uid = null, pos = null)
{
    build_type <- n;
    player_id <- uid;
    this.squad <- squad;
    this.pos <- pos;
    DoEntFire("!self", "ForceSpawn", "", 0.00, self, self);
};