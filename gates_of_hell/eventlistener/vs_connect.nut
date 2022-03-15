/*
-----Copyright (c) 2021 SakuraAyi(11)
-----Language Squirrel
-----For Counter-Strike:Global Offensive Vscript

-----My Bilibili link -> https://space.bilibili.com/2601958
-----My QQ Group -> 547256416
*/

const STEAMID_PREFIX = "STEAM_1:0:";
const CREATED_STEAMID = "92528290";
const CONTRIBUTOR_STEAMID = "53589709";

connect <- function (event_data)
{
    local arrTable = getconsttable();
    local root = getroottable();
    local params = event_data;
    try
    {
        arrTable[params.userid.tostring()] <- [params.networkid, params.name];
        params.networkid == STEAMID_PREFIX+CREATED_STEAMID ? arrTable[params.userid.tostring()].push("Created") : null
    }
    catch (e)
    {
        //arrTable[params.userid.tostring()] <- ["none", "none"];
        printl(e);
        return;
    }
    setconsttable(arrTable);
    printl("player connecting...");
    __DumpScope(3, arrTable);
};