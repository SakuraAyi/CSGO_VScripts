//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

_UseBy <- null;
_Equip <- null;

Alive <- function ( param )
{

    local atv = param;

    if ( atv.GetHealth() > 0 )

        return true;

    else

        return false;

}

Spawn <- function ()
{

    //ScriptPrintMessageChatAll( "Spawn" );

    local atv;

    atv = activator;
    _UseBy = atv;

    if ( _UseBy != null && _UseBy.IsValid() )
    {

        //local aim = Entities.CreateByClassname("info_target");
        //aim.__KeyValueFromString("targetname", "sentry_aim");

        DoEntFire( "!self", "ForceSpawn", "", 0.00, self, self );
        DoEntFire( "!self", "RunScriptCode", "GiveSentry()", 0.01, self, self );

    }
}

GiveSentry <- function ()
{

    if ( Alive(_UseBy) )
    {

        for ( local ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
        {

            if ( ent.GetName().find("sentry_pitch", 0) != null )
            {

                if ( ent.ValidateScriptScope() )
                {

                    local sc = ent.GetScriptScope();

                    if ( sc.Owner == null )
                    {

                        _Equip <- ent;
                        sc.Owner <- _UseBy;

                    }
                }
            }
        }
    }
    
    _UseBy = null;
    _Equip = null;

}