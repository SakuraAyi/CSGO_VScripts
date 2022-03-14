//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

PlayerConnect <- function (params)
{
    local tb = getconsttable();
    tb[params.userid] <- params.name;
    tb[params.userid.tostring()] <- params.networkid;
    setconsttable(tb);
    __DumpScope(3,"ConstTable_Data "+tb[params.userid].tostring());
}

target <- null;
Think <- function ()
{
    user <- null;
    while ((user = Entities.FindByClassname(user, "*")) != null) {
        if (user.GetClassname() == "player" || user.GetClassname() == "cs_bot") {
            if (user.ValidateScriptScope()) {
                if (target == null) {
                    if (!("userid" in user.GetScriptScope())) {
                        user.GetScriptScope().userid <- 1;
                        target = user;
                        EntFire("info_game_event_proxy", "GenerateGameEvent", "", 0.00, user);
                    }
                }
            }
        }
    }
}

PlayerUse <- function (params)
{
    if (target != null) {
        if (target.IsValid()) {
            local sc = target.GetScriptScope(),ct = getconsttable(),data;
            sc.userid <- params.userid;
            foreach (cv,idx in ct) {
                if (cv == params.userid.tostring()) {
                    data = idx;
                    break;  
                }
            }
            sc.userdata <- data;
            //EntFireByHandle(::target, "addoutput", "targetname "+data[1], 0.00, null, null);
            target = null;
            //ScriptPrintMessageChatAll(params.userid.tostring());
            //ScriptPrintMessageChatAll(data[0].tostring() + " , " + data[1].tostring());
            return;
        }
    }
}

