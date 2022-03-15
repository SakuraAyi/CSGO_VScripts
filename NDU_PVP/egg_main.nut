//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

teddy <- [false,false,false];
teddyUnlock <- false;
teddyTriBut <- [];
eggMusic <- false;

Think <- function ()
{
    if ( !teddyUnlock )
    {
        local num = 0;
        for ( local i = 0; i < teddy.len(); i++ )
        {
            if ( teddy[i] )
                num += 1;
        }

        if ( num == teddy.len() )
        {
            local text = ["\x01 \x04 嘿！有人触发了彩蛋，现在将会播放一首隐藏音乐！","\x01 \x04 Hey! Someone found the Easter egg, now a hidden music will be played!"]
            ScriptPrintMessageChatAll(text[::m_lang]);
            teddyUnlock = true;
            ::PlayMusic(9,5);
            ::music_loop = false;
            eggMusic = true;
            DoEntFire("!self", "RunScriptCode", "eggMusic = false", 360.00, self, self);
            Remove(0);
        }
    }
};

Remove <- function (n)
{
    if ( n == 0 )
    {
        for ( local i = 0; i < teddyTriBut.len(); i++ )
        {
            if ( teddyTriBut[i] != null && teddyTriBut[i].IsValid() )
                teddyTriBut[i].Destroy();
        }
        teddyTriBut.clear();
    }
};