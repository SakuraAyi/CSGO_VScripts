//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

second <- 0;

_item <- null;

/*snd <- "EDIT_PLACE_PICK";

function Precache ()
{

    self.PrecacheScriptSound(snd);

}*/

Think <- function ()
{

    local bag,pos,dist,total;

    second++;

    if ( second%2 == 0 )
    {

        while ( ( bag = Entities.FindByClassname(bag, "*") ) != null )
        {

            //try {

                if ( bag.GetClassname() == "prop_physics" )
                {

                    if ( bag.GetName().find( "dufflebag", 0 ) != null )
                    {

                        if ( bag.IsValid() )
                        {

                            pos = bag.GetOrigin();dist = self.GetOrigin();dist -= pos;
                            total = dist.LengthSqr();

                            if ( total < 2304 )
                            {

                                _item = bag;
                                iUse();

                                //ScriptPrintMessageChatAll( "Done!" );

                                break;

                            }
                        }
                    }
                }
            //}

            /*catch ( e )
            {

                ScriptPrintMessageChatAll( e.tostring() );

            }*/
        }
    }

    if ( second == 10 )
    second = 0;

}

iUse <- function ()
{

    local Newscore = 50;
    ::zombie_score + Newscore <= (pow( 10, 2 )*2) ? ::zombie_score += Newscore : ::zombie_score = (pow( 10, 2 )*2);
    self.EmitSound(::Event_Snd[4]);
    ::Area_infoTips(6);

    Remove();

}

Remove <- function ()
{
    local sc,_user;

    if ( _item != null && _item.IsValid() )
    {
        sc = _item.GetScriptScope();
        sc._isPickUP = false;

        if ( sc._useBy != null )
        {
            _user = sc._useBy.GetScriptScope();
            _user._AllowPickup = true;
            sc._useBy = null;
        }
        if ( sc.m_ui != null && sc.m_ui.IsValid() )
            sc.m_ui.Destroy();
        _item.Destroy();
        _item = null;

        //ScriptPrintMessageChatAll( "Destroy" );
    }
}