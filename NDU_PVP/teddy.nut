//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

totalNum <- 2;
TriNum <- 0;
Egg_Main <- null;
slot <- null;

function OnPostSpawn ()
{
    Egg_Main = Entities.FindByName(null, "Script_Eggs").GetScriptScope();
    Egg_Main.teddyTriBut.push(self);
};

OnUse <- function ()
{
    local atvr = activator;

    if ( atvr.GetTeam() == 2 )
    {
        TriNum += 1;
        if ( TriNum == totalNum )
        {
            for ( local i = 0; i < Egg_Main.teddy.len(); i++ )
            {
                if ( !Egg_Main.teddy[i] )
                {
                    Egg_Main.teddy[i] = true;
                    slot = i;
                    self.EmitSound(::map_snd[38]);
                    break;
                }
            }
        }
        else if ( TriNum > totalNum )
        {
            Egg_Main.teddy[slot] = false;
            Egg_Main.Remove(0);
        }
    }
};