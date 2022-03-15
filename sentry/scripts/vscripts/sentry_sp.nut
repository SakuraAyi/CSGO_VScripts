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

    ScriptPrintMessageChatAll( "Spawn" );

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
                        if (_UseBy.GetTeam() == 2)
                            sc.HostileCamp <- 3;
                        else if (_UseBy.GetTeam() == 3)
                            sc.HostileCamp <- 2;
                        _UseBy.__KeyValueFromString("targetname", rand().tostring());
                    }
                }
            }
        }
    }
    
    _UseBy = null;
    _Equip = null;

}