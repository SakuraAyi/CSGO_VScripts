//Squirrel
/*
 * Copyright (c) 2021.1.11 - 2021.1.17 SakuraAyi(11)
 * https://space.bilibili.com/2601958
 * https://weibo.com/u/5239535121
 * qq group:547256416
 * Version:0.7
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy, modify, merge, publish,
 * distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING
 * BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 * 
 */
//数学变量
const Pi = 3.14159265; //圆周率
const TwoPi = 6.2831853;
const HalfPi = 1.5707963;

const Rad = 0.01745329251994329576923690768489;
const Deg = 57.295779513082320876798154814105;

HarmmerSize <- ceil(sqrt(2) * 32768);//46341

::clientcommand <- null;
::servercommand <- null;
template <- EntityGroup[0];
temp_sc <- template.GetScriptScope();
//TraceOrig <- null;
Vec <- Vector(0,0,0);
invisible <- Vector(0,0,RAND_MAX/2);
_reference <- "models/shells/shell_12gauge.mdl";
Hit <- Vector(0,0,0);
Dist <- Vector(0,0,0);

_useBy <- [];//playey,triSwitch,is it melee
_wpn <- null;
SpeedMod <- null;
_num <- RAND_MAX;
::EntIO <- function (entity, output, target, input, param, delay, max)
{local line = output + " " + target + ":" + input + ":" + param + ":" + delay + ":" + max;EntFireByHandle(entity, "AddOutput", line, 0.00, null, null);};

::FontColor <- 
{
    White = (1).tochar(),Red = (2).tochar(),Purple = (3).tochar(),Green = (4).tochar(),
	LightGreen = (5).tochar(),LimeGreen = (6).tochar(),LightRed = (7).tochar(),Grey = (8).tochar(),
	Yellow = (9).tochar(),LightBlue = (10).tochar(),Blue = (11).tochar(),DarkBlue = (12).tochar(),
	DarkGrey = (13).tochar(),Pink = (14).tochar(),OrangeRed = (15).tochar(),Orange = (16).tochar()
};
::g_mapinfo <- "["+::FontColor.Yellow+"SakuraAyi"+::FontColor.White+"]";
::g_lang <- 0;
ChatMsg <- function (param, msg){local team = param;if ( team != 0 )ScriptPrintMessageChatTeam(team, msg);else ScriptPrintMessageChatAll(msg);};
hudhint <- function (user,msg){local plr = user;local sc = plr.GetScriptScope();local slot = sc.register;trace.tr_hint[slot].__KeyValueFromString("message", msg);EntFireByHandle(trace.tr_hint[slot], "ShowHudHint", "", 0.00, user, null);}

enum sw {off, on}; 
enum ready {no, yes}; 
class trace 
{
    tr_orig = [];
    tr_spn = [];
    tr_measure = [];
    tr_ui = [];
    tr_hint = [];
    progress = [];
    maxd = HarmmerSize; //hammer中最大单位是32768 算上对角线 四舍五入2的平方根*32768 长为46341
    mind = 512; //这是你放置的物品能达到多远，填写整数，如：128
    rot = -15; //道具旋转的速度，每0.1秒偏航角旋转的度数为,注意：此项必须为负数
    height = 64; //道具可移动的高度限制，40=1米 更准确为 39=1米
    space = 8; //和地面允许保留多少空间，如果为0放置的时候必须完全和地面贴合
    alpha = 100; //道具的不透明度，最高255为不透明
    propshowheight = 16; //这是指标模型的距离准心位置的高度相差调整，与实际放置位置无关。
    cd = 30; //道具的CD, 单位为/s(秒), 看自己需要设置
    state = ready.yes;
    type = 1;
};
_timer <- 20; //激活后多少秒爆炸, 不能大于冷却时间
second <- 0; //激活后数值会增加到(cd*10) 10=1s,满后重置为0
_item <- []; //index,rot,entity,can it be deployed,color,is break,placed entity
_Aud <- [];
item_index <- 1; //这是你需要生成道具的编号，格式为vs.tr_prop.x 尾数是编号, 你想生成哪个道具，就在这填写这个尾数。
item_tri_target <- "Earthly_Star_Relay"; //这是你道具放置成功后 需要激活的触发对象，如你用的logic_relay，在这填logic_relay的targetname
item_input <- "Trigger"; //触发命令类型
item_params <- ""; //触发命令参数
item_tri_target2 <- "Earthly_Star_Branch"; //这个是在放置后 在技能引爆之前，可以操作的触发事件
item_input2 <- "Test";
item_params2 <- "";
_msg <- 
[
    ["☛[操作]鼠标移动位置，\"E\"部署，右键旋转。", "☛[control]Mouse movement position, \"E\" deployment,right-click rotation."],
    ["目标点距离：", "Target distance:"],
    ["目标和地面的距离：", "Ground distance:"],
    ["单位","units"],
    ["米", "meter"],
    ["[✔] 可放置", "[✔] Can be placed"],
    ["[✘] 不可放置", "[✘] Cannot be placed"],
    ["[△] 可能会卡住", "[△] It could get stuck"],
    ["自身实体偏航角：", "Self Yaw:"],
    ["[△] 冷却结束剩余：", "[△] CD:"],
    ["☛[使用技能需要需持刀状态]", "☛[need switch knive]"],
    ["就绪", "ready"],
    ["[✘] 你丢失了神器!", "[✘] you lost artifact!"],
    ["[△] 引爆之前按E可提前爆炸", "[△] You can press e before the explosion. \nDetonate in advance"],

    [::FontColor.LightGreen + "eyetrace" + ::FontColor.White + "脚本开始运行", "Script Run.."]
];

//Distance between the x/y components of two 3D vectors.
function Distance2D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	
	return sqrt((a*a)+(b*b));
};

//Distance between two 3D vectors.
function Distance3D(v1,v2)
{
	local a = (v2.x-v1.x);
	local b = (v2.y-v1.y);
	local c = (v2.z-v1.z);
	
	return sqrt((a*a)+(b*b)+(c*c));
};

//Return the Pitch and Yaw between two 3D vectors.
function AngleBetween(v1,v2)
{
		local aZ = atan2((v1.y - v2.y),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),Distance2D(v1,v2))+Pi;
		
		return Vector(aY,aZ,0.0);
};

function AngleBetween2(v1,v2)
{
		local aZ = atan2((v1.z - v2.z),(v1.x - v2.x))+Pi;	
		local aY = atan2((v1.z - v2.z),(v1.y - v2.y))+Pi;
		
		return Vector(aY,aZ,0.0);
};

//Returns the difference between two angles
//actionsnippet.com/?p=1451
function AngleDiff(angle0,angle1)
{
    return (abs((angle0 + Pi -  angle1)%(Pi*2.)) - Pi);
};

//Normalizes a vector
function Normalize(v)
{
	local len = v.Length();
	return Vector(v.x/len,v.y/len,v.z/len);
};

//Cross product of two vectors
function Cross(v1, v2) 
{
	local v = Vector(0.0,0.0,0.0);
	v.x = ( (v1.y * v2.z) - (v1.z * v2.y) );
	v.y = ( (v1.x * v2.z) - (v1.z * v2.x) );
	v.z = ( (v1.x * v2.y) - (v1.y * v2.x) );
	return v;
};

//Constrain a number to a given range
function clamp(v,mi,ma)
{
	if(v < mi) return mi;
	if(v > ma) return ma;
	return v;
};

//Return the biggest of two numbers.
function max(v1,v2)
{
	if(v1 > v2) return v1;
	return v2;
};

//Return the smallest of two numbers.
function min(v1,v2)
{
	if(v1 < v2) return v1;
	return v2;
};
//Vector multiplication fix
function Mul(v1,v2)
{
	local typ = typeof(v2);
	
	//Vector * Scalar
	if(typ == "integer" || typ == "float")
	{
		return Vector(v1.x*v2,v1.y*v2,v1.z*v2);
	}
	//Vector * Vector
	if(typ == "Vector")
	{
		return Vector(v1.x*v2.x,v1.y*v2.y,v1.z*v2.z);
	}
	return null;
};

class TraceInfo
{
    constructor(h,d)
    {
        Hit = h;
        Dist = d;
    }

    Hit = null;
    Dist = null;
};

TraceVec <- function (start, end, filter)
{
	local dir = (end-start);
	local frac = TraceLine(start,end,filter);
	//return start+(dir*frac);
	return TraceInfo(start+(dir*frac),dir.Length());
};

TraceDir <- function (orig, dir, maxd, filter)
{
    local frac = TraceLine(orig,orig+dir*maxd,filter);
    if ( frac == 1.0 ) { return TraceInfo(orig+(dir*maxd), maxd);}
    return TraceInfo(orig+(dir*(maxd*frac)),maxd*frac);
};

function DrawAxis(pos,s,nocull,time,br,bg,bb)
{
	DebugDrawLine(Vector(pos.x-s,pos.y,pos.z), Vector(pos.x+s,pos.y,pos.z), 255, 0, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y-s,pos.z), Vector(pos.x,pos.y+s,pos.z), 0, 255, 0, nocull, time);
	DebugDrawLine(Vector(pos.x,pos.y,pos.z-(s+trace.mind)), Vector(pos.x,pos.y,pos.z+s), 0, 0, 255, nocull, time);
    //DebugDrawBox(pos, Vector(-8,-8,-8), Vector(8,8,8), br, bg, bb, 50, time);
}

function OnPostSpawn ()
{
    DoEntFire("!self", "RunScriptCode", "OnPostSpawn_Delay()", 0.10, self, self);
    //ChatMsg(0, ::g_mapinfo+" "+_msg[14][::g_lang]);
    ::clientcommand = Entities.FindByClassname(null, "point_clientcommand");::servercommand = Entities.FindByClassname(null, "point_servercommand");
    ::clientcommand == null ? ::clientcommand = Entities.CreateByClassname("point_clientcommand") : printl("clientcommand_found");
    ::servercommand == null ? ::servercommand = Entities.CreateByClassname("point_servercommand") : printl("servercommand_found");
    self.PrecacheModel(_reference);
    SpeedMod = Entities.CreateByClassname("player_speedmod");
    SpeedMod.__KeyValueFromInt("spawnflags", 1);
    Remove();
};
function OnPostSpawn_Delay ()
{
    local ent = Entities.FindByName(null, item_tri_target2);
    if ( ent != null )
    {
        ::EntIO(ent, "OnTrue", self.GetName(), "RunScriptCode", "Branch()", "0.00", "-1"), printl("Branch IO Write complete");
        local delay = 0.00;
        _timer <= trace.cd ? delay = _timer : delay = trace.cd; 
        ::EntIO(Entities.FindByName(null, item_tri_target), "OnTrigger", item_tri_target2, "Test", "", delay.tostring(), "-1")
    }
        for ( local i = 0; i < 2; i++ )
        {
            ent = Entities.FindByName(null, "Earthly_Star_Snd_"+(i+1));
            if ( ent != null )
                _Aud.push(ent);
        }
};
function Branch ()
{
    local ent,slot; for ( local i = 0; i < _useBy.len(); i++ ) { if ( _useBy[i][0] != null && _useBy[i][0].IsValid() ) { slot = i; break; } } _item[slot][5] = false; _item[slot][6] = null;
};

OnUse <- function ()
{
    local ent;
    local plr = activator,sc;
    local call = caller;
    if (call.GetClassname().find("weapon", 0) != null && ( _wpn == null || _wpn != null && !_wpn.IsValid() ) )
    {
        _wpn = call;
        if ( _wpn.ValidateScriptScope() )
        {
            local wpnsc = _wpn.GetScriptScope();
            wpnsc.artifact <- 1;
        }
    }
    local currentlength = 0;
    local Rereg = false;
    if ( plr.ValidateScriptScope() )
        sc = plr.GetScriptScope();
    else
        return;

    if ( _useBy.len() != 0 )
    {
        if ( "register" in sc )
        {
            if ( _useBy.len()-1 >= sc.register )
            {
                //if ( _useBy[sc.register][0] != null && _useBy[sc.register][0].IsValid() )
                //{
                    Rereg = true;
                    printl("exist");
                //}
            }
        }
    }
    if ( !Rereg )
    {
        _useBy.push([plr,sw.off,false]);trace.tr_hint.push(Entities.CreateByClassname("env_hudhint"));trace.tr_orig.push(CreateProp("prop_dynamic", Vec, _reference, 0));
        trace.tr_spn.push(Entities.CreateByClassname("info_target"));trace.tr_measure.push(Entities.CreateByClassname("logic_measure_movement"));trace.tr_ui.push([Entities.CreateByClassname("game_ui"),false]);
        _item.push([item_index, -1, null, false, "", true, null]);currentlength = _useBy.len(),currentlength--;_num = rand();
        _useBy[currentlength][0].__KeyValueFromString("targetname", "player_"+_num);sc = _useBy[currentlength][0].GetScriptScope();sc.register <- currentlength;
        printl("currentlength > " + currentlength + ", ");
    }
    else
    {
        local slot = sc.register;_useBy[slot][0] = plr;_useBy[slot][1] = sw.off;_useBy[slot][2] = false;trace.tr_hint[slot] = Entities.CreateByClassname("env_hudhint");trace.tr_orig[slot] = CreateProp("prop_dynamic", Vec, _reference, 0);
        trace.tr_spn[slot] = Entities.CreateByClassname("info_target");trace.tr_measure[slot] = Entities.CreateByClassname("logic_measure_movement");trace.tr_ui[slot][0] = Entities.CreateByClassname("game_ui");trace.tr_ui[slot][1] = false;
        _item[slot][0] = item_index;_item[slot][1] = -1;_item[slot][2] = null;_item[slot][3] = false;_item[slot][4] = "";_item[slot][5] = true;_item[slot][6] = null;currentlength = slot;
        printl("currentslot > " + slot + ", ");
    }
    trace.tr_hint[currentlength].SetOwner(_useBy[currentlength][0]);trace.tr_orig[currentlength].__KeyValueFromString("targetname", "tr_orig_"+_num);trace.tr_orig[currentlength].__KeyValueFromInt("rendermode", 10);
    trace.tr_spn[currentlength].__KeyValueFromString("targetname", "tr_spn_"+_num);trace.tr_measure[currentlength].__KeyValueFromString("target", trace.tr_orig[currentlength].GetName());trace.tr_measure[currentlength].__KeyValueFromInt("measuretype", trace.type);trace.tr_measure[currentlength].__KeyValueFromInt("targetscale", 1000);trace.tr_ui[currentlength][0].__KeyValueFromInt("FieldOfView", -1);
    trace.tr_ui[currentlength][0].__KeyValueFromInt("spawnflags", 128);trace.tr_ui[currentlength][0].SetOwner(_useBy[currentlength][0]);
    
    EntFireByHandle(trace.tr_measure[currentlength], "SetMeasureReference", trace.tr_spn[currentlength].GetName(), 0.00, null, null);EntFireByHandle(trace.tr_measure[currentlength], "SetTargetReference", trace.tr_spn[currentlength].GetName(), 0.00, null, null);EntFireByHandle(trace.tr_measure[currentlength], "SetMeasureTarget", _useBy[currentlength][0].GetName(), 0.00, null, null);EntFireByHandle(trace.tr_measure[currentlength], "Enable", "", 0.00, null, null);::EntIO(trace.tr_ui[currentlength][0], "PressedAttack2", self.GetName(), "RunScriptCode", "Control(0 "+currentlength+")", "0.00", "-1");::EntIO(trace.tr_ui[currentlength][0], "UnPressedAttack2", self.GetName(), "RunScriptCode", "Control(1 "+currentlength+")", "0.00", "-1");::EntIO(trace.tr_ui[currentlength][0], "PlayerOff", self.GetName(), "RunScriptCode", "Control(2 "+currentlength+")", "0.00", "-1");

    Activate();

};

Activate <- function ()
{
    local plr = activator,sc,slot;
    sc = plr.GetScriptScope();
    slot = sc.register;
    if ( _useBy[slot][1] == sw.off )
        _useBy[slot][1] = sw.on;
    if ( trace.state == ready.yes )
    {
        EntFireByHandle(template, "ForceSpawn", "", 0.00, null, null);
        DoEntFire("!self", "RunScriptCode", "SpawnEntity("+slot+")", 0.00, self, self);
    }
};

Deactivate <- function (slot)
{
    trace.tr_ui[slot][1] = false;
    if ( _useBy[slot][0] != null )
        return;
    else
    {
        trace.tr_orig[slot].Destroy();
        trace.tr_spn[slot].Destroy();
        trace.tr_measure[slot].Destroy();
        trace.tr_hint[slot].Destroy();
        if ( trace.tr_ui[slot][1] )
            EntFireByHandle(trace.tr_ui[slot], "Deactivate", "", 0.00, null, null);
        EntFireByHandle(trace.tr_ui[slot][0], "Kill", "", 0.00, null, null);
        if ( _item[slot][2] != null && _item[slot][2].IsValid() )
            _item[slot][2].Destroy();
        _useBy[slot][0] = null;
        _useBy[slot][1] = sw.off;
    }
};

CheckHolder <- function ()
{
    local plr,sc,slot;
    for ( local i = 0; i < _useBy.len(); i++ )
    {
        if ( _useBy[i][0] != null && _useBy[i][0].IsValid() )
        {
            plr = _useBy[i][0];
            sc = plr.GetScriptScope();
            slot = sc.register;
            if ( trace.state == ready.yes )
            {
                if ( _item[slot][2] == null )
                    EntFire("@script_aimtrace", "RunScriptCode", "Activate()", 0.00, plr);
            }
            if ( !trace.tr_ui[slot][1] )
                EntFireByHandle(trace.tr_ui[slot][0], "Activate", "", 0.00, plr, null),trace.tr_ui[slot][1] = true;
        }
    }
};

Think <- function ()
{
    if ( trace.state == ready.no )
    {
        second++;
        if ( (second%(trace.cd*10)) == 0 )
        {
            trace.state <- ready.yes;
            second = 0;
            printl("ready");
        }
    }
    CheckHolder();

    local plr,sc,slot,yaw,face,eye;
    foreach ( key, value in _useBy )
    {
        if ( value[0] != null && value[1] == sw.on )
        {
            plr = value[0];
            sc = plr.GetScriptScope();
            slot = key;
            if ( plr.IsValid() && plr.GetHealth() > 0 )
            {
                local ent;
                local viewmodel = "predicted_viewmodel";
                local pass = true;

                while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
                {
                    if ( ent == _wpn )
                    {
                        if ( ent.GetMoveParent() != plr )
                        {
                            value[0] = null;value[1] = sw.off;Deactivate(slot);printl("drop");
                            return;
                        }
                    }
                    if ( ent.GetClassname() == viewmodel )
                    {
                        if ( ent.GetMoveParent() == plr || ent.GetOwner() == plr )
                        {
                            local tof = true;
                            if ( ent.GetModelName().find("knife", 0) != null || ent.GetModelName() == "" )
                            {
                                if ( !value[2] )
                                    value[2] = true;
                            }
                            else
                            {
                                tof = false;
                                if ( value[2] )
                                {
                                    value[2] = false;
                                    if ( _item[slot][2] != null )
                                        _item[slot][2].SetOrigin(invisible);
                                }
                            }
                            if ( !tof || trace.state == ready.no )
                            {
                                local _time = (trace.cd-(second/10));
                                if ( second == 0 )
                                    _time = _msg[11][::g_lang];
                                local text = _msg[9][::g_lang] + _time +"\n" + _msg[13][::g_lang] + "\n" + _msg[10][::g_lang];
                                hudhint(plr,text);
                                pass = false;
                            }
                        }
                    }
                }

                if ( !pass )
                    return;
                
                eye = plr.EyePosition();
                yaw = plr.GetAngles().y;
                face = Vector(eye.x+cos(yaw * PI / 180.0)*1,eye.y+sin(yaw * PI / 180.0)*1,eye.z);

                Hit = TraceDir(eye, trace.tr_orig[slot].GetForwardVector(), trace.mind, plr).Hit;
                Dist = TraceDir(eye, trace.tr_orig[slot].GetForwardVector(), trace.mind, plr).Dist;
                //DebugDrawLine(eye, Hit, 0, 255, 0, false, 0.1);

                local br,bg,bb,color,text,dist;

                if ( _item[slot][2] != null &&  _item[slot][2].IsValid() )
                {
                    local itemYaw = _item[slot][2].GetAngles().y;
                    if ( _item[slot][1] >= 0 )
                        _item[slot][1] == 0 ? _item[slot][2].SetAngles(0,itemYaw+abs(trace.rot),0) : _item[slot][2].SetAngles(0,itemYaw+trace.rot,0);

                    local plr_pos = plr.GetOrigin();
                    local record = 0;
                    if ( Hit.z > plr_pos.z && abs(plr_pos.z - Hit.z) > trace.height )
                    {
                        record = plr_pos.z+trace.height;
                        record -= Hit.z;
                    }

                    local DHit = Vector(Hit.x,Hit.y,Hit.z-(abs(record)+trace.maxd));
                    local frac = TraceLine(Vector(Hit.x,Hit.y,Hit.z-abs(record)), DHit, null);
                    dist = trace.maxd * frac;
                    if ( dist > trace.space )
                        text = _msg[6][::g_lang],br=255,bg=0,bb=0,color=0,_item[slot][3] = false;
                    else
                        text = _msg[5][::g_lang],br=0,bg=255,bb=0,color=1,_item[slot][3] = true;
                    if ( dist < 0.1 )
                        dist = 0;

                    while ( ( ent = Entities.FindByClassname(ent, "*") ) != null )
                    {
                        local pos,total;
                        local pass = false;
                        pos = ent.GetOrigin();
                        total = 0;
                        if ( ent.GetClassname() == "player" )
                        {
                            pass = true;
                            pos.z += 36,total - 98;
                        }
                        else if ( ent.GetClassname().find("prop", 0) != null )
                            pass = true;

                        if ( pass )
                        {
                            total += (Hit - pos).LengthSqr();
                            if ( total <= 2034 )
                            {
                                if ( ent.GetName().find("tr_", 0) != null )
                                    continue;
                                if ( _item[slot][3] )
                                    text = _msg[7][::g_lang],br=255,bg=200,bb=0,color=2;
                                // printl("obstacle > " + ent.GetClassname() + " and name > " + ent.GetName());
                                break;
                            }
                        }
                    }

                    _item[slot][2].SetOrigin(Vector(Hit.x,Hit.y,( Hit.z-abs(record) ) + trace.propshowheight) );
                    if ( _item[slot][4] != color )
                    {
                        _item[slot][4] = color;_item[slot][2].__KeyValueFromString("rendercolor", br+" "+bg+" "+bb);
                        _item[slot][2].__KeyValueFromInt("rendermode", 4);_item[slot][2].__KeyValueFromInt("renderamt", trace.alpha);
                    }
                    DrawAxis(Vector(Hit.x,Hit.y,Hit.z-abs(record)),16.0,false,0.1,br,bg,bb);
                }
                
                text += "\n" + _msg[8][::g_lang] + format("%d", yaw);
                text += "\n" + _msg[1][::g_lang] + format("%d", Dist) + _msg[3][::g_lang] + " | "+format("%.2f", (Dist/40))+_msg[4][g_lang];
                text += "\n" + _msg[2][::g_lang] + format("%d", dist) + _msg[3][::g_lang] + " | "+format("%.2f", (dist/40))+_msg[4][g_lang];
                text += "\n" + _msg[0][::g_lang];
                hudhint(plr,text);
            }
            else
            {
                _useBy[slot][0] = null;
                local text = _msg[12][::g_lang];
                hudhint(plr,text);
                Deactivate(slot);
            }
        }
    }
};

SpawnEntity <- function (slot)
{
    local ent;
    for ( ent = Entities.First(); ent != null; ent = Entities.Next(ent) )
    {
        if ( ent.GetName().find("vs.tr_prop", 0) != null )
        {
            local name = ent.GetName();
            local nlen = name.len();
            if ( nlen != 12 )
            {
                printl("you entity name no match");
                return;
            }
            local num = name.slice(nlen-1,nlen);
            //printl("ent_num > " + num);
            if ( num == _item[slot][0].tostring() )
            {
                _item[slot][2] = ent;
                _item[slot][2].SetOrigin(invisible);
                continue;
            }
            else
                ent.Destroy();
        }
    }
};

Control <- function (param,slot)
{
    local plr = _useBy[slot][0];
    if ( param == 0 )
    {
        if ( !_useBy[slot][2] || _item[slot][2] == null )
            return;
        _item[slot][1] == -1 ? _item[slot][1] = 0 : _item[slot][1] = 1;
        EntFireByHandle(SpeedMod, "ModifySpeed", "0.99", 0.00, plr, null);
    }
    else if ( param == 1 )
    {
        _item[slot][1] == 0 ? _item[slot][1] = -2 : _item[slot][1] = -1;
        EntFireByHandle(SpeedMod, "ModifySpeed", "1.00", 0.00, plr, null);
    }
    else if ( param == 2 )
    {
        if ( _useBy[slot][2] )
        {
            if ( _item[slot][3] && trace.state == ready.yes )
            {
                trace.state <- ready.no;
                local prop = _item[slot][2];
                local pos = prop.GetOrigin();
                prop.__KeyValueFromString("targetname", "vs.ready");prop.__KeyValueFromString("rendercolor", "255 255 255");
                prop.__KeyValueFromInt("rendermode", 0);prop.__KeyValueFromInt("renderamt", 255);

                if ( prop.GetClassname().find("physics") >= 0 )
                    EntFireByHandle(prop, "EnableMotion", "", 0.00, null, null);
                else if ( prop.GetClassname().find("sprite") >= 0 )
                    EntFireByHandle(prop, "HideSprite", "", 0.00, null, null);
                DispatchParticleEffect("explosion_child_snow06a", prop.GetOrigin(), Vec);
                for ( local i = 0; i < _Aud.len(); i++ )
                {
                    if ( _Aud[i] != null )
                        _Aud[i].SetOrigin(pos);
                }
                _item[slot][6] = prop;
                _item[slot][2] = null;
                _item[slot][5] = false;
                EntFire(item_tri_target, item_input, item_params);
                printl("start");
            }
            else if ( _item[slot][6] != null && !_item[slot][5] && _item[slot][2] == null && trace.state == ready.no )
                EntFire(item_tri_target2, item_input2, item_params2),_item[slot][5] = true,printl("ignite");
        }
        Deactivate(slot);
    }
};

Remove <- function ()
{
    local ent;
    while ( (ent = Entities.FindByClassname(ent, "*") ) != null )
    {
        if ( ent.GetName().find("tr_") >= 0 )
            ent.Destroy();
        if ( ent.GetClassname().find("weapon") >= 0 )
        {
            if ( "artifact" in ent.GetScriptScope() )
            {
                ::SendToCMDClient(ent.GetOwner(), "slot3", 0.00);
                ent.Destroy();
                printl("previous_artifact_delete");
            }
        }
    }
};

test <- function ()
{
    local plr = activator; "register" in _useBy[0].GetScriptScope() ? printl("exist") : printl("non-exist"); if ( _useBy[0].ValidateScriptScope() ) { local sc = _useBy[0].GetScriptScope(); sc.register == 1 ? printl("yes") : printl("no"); }  
};
::SendToCMDClient <- function (user,param,delay)
    EntFireByHandle(::clientcommand, "command", param.tostring(), delay, user, null);
if("VS"in::getroottable()&&typeof::VS=="table"&&"MAX_COORD_FLOAT"in::getroottable()&&!::VS._reload&&::ENT_SCRIPT.IsValid())return;;local _v2=function(){}local _f=_v2.getinfos().src;_f=_f.slice(0,_f.find(".nut"));if(this!=::getroottable())return::DoIncludeScript(_f,::getroottable());;if(_f!="vs_library")::print("Loading vs_library...\n");;local PORTAL2="CPortal_Player"in::getroottable()&&"TurnOnPotatos"in::CPortal_Player&&::CPortal_Player.TurnOnPotatos.getinfos().native;local EVENTS=::Entities.FindByClassname(null,"logic_eventlistener")?true:false;::VS<-{Log={enabled=false,export=false,file_prefix="vs.log",filter="VL",L=[]},_reload=false}{local a=["split","print","_floatsize_","exp","seterrorhandler","assert","atan2","_charsize_","asin","atan","cos","PI","strip","newthread","lstrip","format","rstrip","acos","abs","_intsize_","collectgarbage","setroottable","enabledebuginfo","setdebughook","ceil","log10","RAND_MAX","rand","srand","suspend","compilestring","sqrt","floor","getstackinfos","log","fabs","dummy","getroottable","tan","array","_version_","setconsttable","sin","getconsttable","pow","type","regexp"];local b=["DispatchOnPostSpawn","self","__vname","PrecacheCallChain","OnPostSpawnCallChain","__vrefs","DispatchPrecache","OnPostSpawn","PostSpawn","Precache","PreSpawnInstance","__EntityMakerResult","__FinishSpawn","__ExecutePreSpawn"];local c=["_xa9b2dfB7ffe","VS","DoEntFireByInstanceHandle","ClearChat","Chat","ChatTeam","txt","Alert","AlertTeam","PrecacheModel","PrecacheScriptSound","delay","OnGameEvent_player_spawn","OnGameEvent_player_connect","VecToString","ENT_SCRIPT","HPlayer","Ent","Entc","max","min","clamp","MAX_COORD_FLOAT","MAX_TRACE_LENGTH","DEG2RAD","RAD2DEG","CONST","vs_library"];local d;if(!PORTAL2){d=["CHostage","Vector","ScriptIsLocalPlayerUsingController","GetDeveloperLevel","ScriptGetBestTrainingCourseTime","CSceneEntity","ScriptCoopMissionRespawnDeadPlayers","DispatchParticleEffect","CTriggerCamera","DoEntFire","RandomFloat","CBasePlayer","VSquirrel_OnReleaseScope","ScriptCoopMissionSetNextRespawnIn","ScriptCoopMissionSpawnNextWave","DoUniqueString","CBaseAnimating","ScriptPrintMessageCenterTeam","EntFireByHandle","Entities","SendToConsole","TraceLine","ScriptCoopMissionGetMissionNumber","ScriptCoopSetBotQuotaAndRefreshSpawns","ScriptPrintMessageChatTeam","IncludeScript","ScriptGetPlayerCompletedTraining","Documentation","__DumpScope","CEntities","PrintHelp","ScriptPrintMessageCenterAllWithParams","CBaseEntity","FrameTime","Time","Assert","ScriptCoopGiveC4sToCTs","DebugDrawBox","DebugDrawLine","ScriptHighlightAmmoCounter","Document","ScriptSetMiniScoreHidden","ScriptCoopCollectBonusCoin","CBaseFlex","ScriptPrintMessageCenterAll","ScriptSetRadarHidden","CGameSurvivalLogic","RecordAchievementEvent","GetFunctionSignature","ScriptIsWarmupPeriod","VSquirrel_OnCreateScope","ScriptShowFinishMsgBox","developer","CEnvEntityMaker","__ReplaceClosures","RetrieveNativeSignature","ScriptShowExitDoorMsg","SendToConsoleServer","GetMapName","EntFire","Msg","UniqueString","ScriptGetRoundsPlayed","CreateSceneEntity","ScriptGetGameType","DoIncludeScript","LateBinder","ShowMessage","LoopSinglePlayerMaps","ScriptGetValveTrainingCourseTime","CreateProp","printl","CFuncTrackTrain","CGameCoopMissionManager","ScriptSetPlayerCompletedTraining","CBaseMultiplayerPlayer","RegisterFunctionDocumentation","CPlayerVoiceListener","ScriptSetBestTrainingCourseTime","ScriptTrainingGivePlayerAmmo","ScriptCoopResetRoundStartTime","CScriptKeyValues","CCallChainer","CSimpleCallChainer","ScriptPrintMessageChatAll","ScriptGetGameMode","RandomInt","ScriptCoopMissionSpawnFirstEnemies","ScriptCoopExtendRoundDurationTime","ScriptCoopToggleEntityOutlineHighlights","ScriptMissionResetDangerZones","ScriptMissionCreateAndDetonateDangerZone","ScriptCoopMissionSetDeadPlayerRespawnEnabled"]}else{d=["__ReplaceClosures","GetDeveloperLevel","CSceneEntity","MarkMapComplete","CTriggerCamera","DoEntFire","RandomFloat","CBasePlayer","VSquirrel_OnReleaseScope","IsLevelComplete","CBaseMultiplayerPlayer","PrecacheMovie","CBaseAnimating","GetNumMapsPlayed","EntFireByHandle","Entities","SendToConsole","RegisterFunctionDocumentation","IncludeScript","SetMapAsPlayed","UpgradePlayerPortalgun","__DumpScope","CEntities","PrintHelp","RetrieveNativeSignature","ScriptSteamShowURL","UpgradePlayerPotatogun","FrameTime","Time","Assert","RequestMapRating","PlayerVoiceListener","DebugDrawBox","LoopSinglePlayerMaps","Document","GetCoopSectionIndex","SetHaveSeenDLCTubesReveal","CoopSetMapRunTime","AddGladosSpokenFlags","CoopSetCameFromLastDLCMap","IsPlayerBranchComplete","CoopGladosBlowUpBots","IsBranchComplete","NotifySpeedRunSuccess","CoopGetNumPortalsPlaced","CoopGetBranchTotalLevelCount","GetNumPlayersConnected","IsLocalSplitScreen","GetPlayerDeathCount","GetGladosSpokenFlags","GetHaveSeenDLCTubesReveal","CoopGetLevelsCompletedThisBranch","GetCameFromLastDLCMap","SaveMPStatsData","GivePlayerPortalgun","CLinkedPortalDoor","UniqueString","GetCoopBranchLevelIndex","SetDucking","CSimpleCallChainer","CCallChainer","GetPlayer","RecordAchievementEvent","IsMultiplayer","GetFunctionSignature","IsPlayerLevelComplete","VSquirrel_OnCreateScope","developer","CEnvEntityMaker","GetPlayerSilenceDuration","TryDLC1InstalledOrCatch","GetMapName","EntFire","Msg","CreateSceneEntity","player","AddCoopCreditsName","GetMapIndexInPlayOrder","GetOrangePlayerIndex","CPortal_Player","CPlayerVoiceListener","LateBinder","ShowMessage","CreateProp","TraceLine","printl","ScriptShowHudMessageAll","DebugDrawLine","GetHighestActiveBranch","Documentation","CBaseEntity","CPropLinkedPortalDoor","DoIncludeScript","CScriptKeyValues","GetBluePlayerIndex","DoUniqueString","CBaseFlex","AddBranchLevelName","RandomInt","Vector"]};;VS.slots_default<-[];VS.slots_default.extend(a);VS.slots_default.extend(b);VS.slots_default.extend(d);VS.slots_default.extend(c)}if(::print.getinfos().native)::Msg<-::print;;if(::EntFireByHandle.getinfos().native)::DoEntFireByInstanceHandle<-::EntFireByHandle;;::CONST<-getconsttable();::vs_library<-"vs_library v2.38.2";::MAX_COORD_FLOAT<-16384.0;::MAX_TRACE_LENGTH<-56755.84086241;::DEG2RAD<-0.01745329;::RAD2DEG<-57.29577951;if(!PORTAL2&&EVENTS){VS.Events<-delegate VS:{hProxy=null,flValidateTime=0.0,_SV=null}if(!("_xa9b2dfB7ffe"in getroottable()))::_xa9b2dfB7ffe<-[];if(!("OnGameEvent_player_spawn"in getroottable()))::OnGameEvent_player_spawn<-::dummy;if(!("OnGameEvent_player_connect"in getroottable()))::OnGameEvent_player_connect<-::dummy};;::collectgarbage();function VS::ForceReload():(_f){_reload=true;::print("Reloading vs_library...\n");return::DoIncludeScript(_f,::getroottable())}local _VEC=Vector();local Entities=::Entities,AddEvent=::DoEntFireByInstanceHandle,Vector=::Vector,RandomFloat=::RandomFloat,DebugDrawBox=::DebugDrawBox,DoUniqueString=::DoUniqueString,Time=::Time,format=::format,sin=::sin,cos=::cos,floor=::floor,atan2=::atan2,exp=::exp,pow=::pow,log=::log,compile=::compilestring;::max<-function(a,b)return a>b?a:b;::min<-function(a,b)return a<b?a:b;::clamp<-function(v,i,x){if(x<i)return x;else if(v<i)return i;else if(v>x)return x;else return v}function VS::IsInteger(f):(floor)return floor(f)==f;function VS::IsLookingAt(S,T,D,cos){local to=T-S;to.Norm();return to.Dot(D)>=cos}function VS::PointOnLineNearestPoint(S,E,P){local v1=E-S,d=v1.Dot(P-S)/v1.LengthSqr();if(d<0.0)return S;else if(d>1.0)return E;else return S+v1*d}function VS::GetAngle(f,t):(Vector,atan2){local d=f-t,p=57.29577951*atan2(d.z,d.Length2D()),y=57.29577951*(atan2(d.y,d.x)+3.14159265);return Vector(p,y,0.0)}function VS::GetAngle2D(f,t):(atan2){local d=t-f,y=57.29577951*atan2(d.y,d.x);return y}function VS::VectorVectors(F,R,U):(Vector){if(F.x==0.0&&F.y==0.0){R.x=0.0;R.y=-1.0;R.z=0.0;U.x=-F.z;U.y=0.0;U.z=0.0}else{local R=F.Cross(Vector(0.0,0.0,1.0));R.x=R.x;R.y=R.y;R.z=R.z;R.Norm();local U=R.Cross(F);U.x=U.x;U.y=U.y;U.z=U.z;U.Norm()}}function VS::AngleVectors(A,F=_VEC,R=null,U=null):(sin,cos){local sr,cr,rr,yr=0.01745329*A.y,sy=sin(yr),cy=cos(yr),pr=0.01745329*A.x,sp=sin(pr),cp=cos(pr);if(A.z){rr=0.01745329*A.z;sr=sin(rr);cr=cos(rr)}else{sr=0.0;cr=1.0};if(F){F.x=cp*cy;F.y=cp*sy;F.z=-sp};if(R){R.x=(-1.0*sr*sp*cy+-1.0*cr*-sy);R.y=(-1.0*sr*sp*sy+-1.0*cr*cy);R.z=-1.0*sr*cp};if(U){U.x=(cr*sp*cy+-sr*-sy);U.y=(cr*sp*sy+-sr*cy);U.z=cr*cp};return F}function VS::VectorAngles(F):(Vector,atan2,sqrt){local tmp,yaw,pitch;if(F.y==0.0&&F.x==0.0){yaw=0.0;if(F.z>0.0)pitch=270.0;else pitch=90.0}else{yaw=57.29577951*atan2(F.y,F.x);if(yaw<0.0)yaw+=360.0;tmp=sqrt(F.x*F.x+F.y*F.y);pitch=57.29577951*atan2(-F.z,tmp);if(pitch<0.0)pitch+=360.0};return Vector(pitch,yaw,0.0)}function VS::VectorYawRotate(vIn,fYaw,vOut=_VEC):(sin,cos){local rad=0.01745329*fYaw,sy=sin(rad),cy=cos(rad);vOut.x=vIn.x*cy-vIn.y*sy;vOut.y=vIn.x*sy+vIn.y*cy;vOut.z=vIn.z;return vOut}function VS::YawToVector(y):(Vector,sin,cos){local a=0.01745329*y;return Vector(cos(a),sin(a),0.0)}function VS::VecToYaw(v):(atan2){if(v.y==0.0&&v.x==0.0)return 0.0;local y=57.29577951*atan2(v.y,v.x);if(y<0.0)y+=360.0;return y}function VS::VecToPitch(v):(atan2){if(v.y==0.0&&v.x==0.0){if(v.z<0.0)return 180.0;else return -180.0};return 57.29577951*atan2(-v.z,v.Length2D())}function VS::VectorIsZero(v)return v.x==0.0&&v.y==0.0&&v.z==0.0;function VS::VectorsAreEqual(a,b,t=0.0){local x=a.x-b.x;if(x<0.0)x=-x;local y=a.y-b.y;if(y<0.0)y=-y;local z=a.z-b.z;if(z<0.0)z=-z;return(x<=t&&y<=t&&z<=t)}function VS::AnglesAreEqual(a,b,t=0.0){local d=a-b;d%=360.0;if(d>180.0)d-=360.0;else if(d<(-180.0))d+=360.0;;if(d<0.0)d=-d;return d<=t}function VS::CloseEnough(a,b,e){local d=a-b;if(d<0.0)d=-d;return d<=e}function VS::Approach(tg,v,s){local dt=tg-v;if(dt>s)v+=s;else if(dt<(-s))v-=s;else v=tg;;return v}function VS::ApproachAngle(tg,v,s){tg%=360.0;if(tg>180.0)tg-=360.0;else if(tg<(-180.0))tg+=360.0;;v%=360.0;if(v>180.0)v-=360.0;else if(v<(-180.0))v+=360.0;;local dt=tg-v;dt%=360.0;if(dt>180.0)dt-=360.0;else if(dt<(-180.0))dt+=360.0;;if(s<0.0)s=-s;if(dt>s)v+=s;else if(dt<(-s))v-=s;else v=tg;;return v}function VS::AngleDiff(dst,src){local df=dst-src;df%=360.0;if(df>180.0)df-=360.0;else if(df<(-180.0))df+=360.0;;return df}function VS::AngleNormalize(A){A%=360.0;if(A>180.0)A-=360.0;else if(A<(-180.0))A+=360.0;;return A}function VS::QAngleNormalize(A){A.x%=360.0;if(A.x>180.0)A.x-=360.0;else if(A.x<(-180.0))A.x+=360.0;;A.y%=360.0;if(A.y>180.0)A.y-=360.0;else if(A.y<(-180.0))A.y+=360.0;;A.z%=360.0;if(A.z>180.0)A.z-=360.0;else if(A.z<(-180.0))A.z+=360.0;;return A}function VS::SnapDirectionToAxis(D,E){local p=1.0-E;if((D.x<0.0?-D.x:D.x)>p){if(D.x<0.0)D.x=-1.0;else D.x=1.0;D.y=0.0;D.z=0.0;return D};if((D.y<0.0?-D.y:D.y)>p){if(D.y<0.0)D.y=-1.0;else D.y=1.0;D.z=0.0;D.x=0.0;return D};if((D.z<0.0?-D.z:D.z)>p){if(D.z<0.0)D.z=-1.0;else D.z=1.0;D.x=0.0;D.y=0.0;return D}}function VS::VectorCopy(src,dst){dst.x=src.x;dst.y=src.y;dst.z=src.z;return dst}function VS::VectorMin(a,b,o=_VEC){o.x=a.x<b.x?a.x:b.x;o.y=a.y<b.y?a.y:b.y;o.z=a.z<b.z?a.z:b.z;return o}function VS::VectorMax(a,b,o=_VEC){o.x=a.x>b.x?a.x:b.x;o.y=a.y>b.y?a.y:b.y;o.z=a.z>b.z?a.z:b.z;return o}function VS::VectorAbs(v){if(v.x<0.0)v.x=-v.x;if(v.y<0.0)v.y=-v.y;if(v.z<0.0)v.z=-v.z;return v}function VS::VectorAdd(a,b,o=_VEC){o.x=a.x+b.x;o.y=a.y+b.y;o.z=a.z+b.z;return o}function VS::VectorSubtract(a,b,o=_VEC){o.x=a.x-b.x;o.y=a.y-b.y;o.z=a.z-b.z;return o}function VS::VectorMultiply(a,b,o=_VEC){o.x=a.x*b;o.y=a.y*b;o.z=a.z*b;return o}function VS::VectorMultiply2(a,b,o=_VEC){o.x=a.x*b.x;o.y=a.y*b.y;o.z=a.z*b.z;return o}function VS::VectorDivide(a,b,o=_VEC){local d=1.0/b;o.x=a.x*d;o.y=a.y*d;o.z=a.z*d;return o}function VS::VectorDivide2(a,b,o=_VEC){o.x=a.x/b.x;o.y=a.y/b.y;o.z=a.z/b.z;return o}function VS::ComputeVolume(is,xs){local dt=xs-is;return dt.Dot(dt)}function VS::RandomVector(iv=-RAND_MAX,xv=RAND_MAX):(Vector,RandomFloat)return Vector(RandomFloat(iv,xv),RandomFloat(iv,xv),RandomFloat(iv,xv));function VS::CalcSqrDistanceToAABB(mins,maxs,pt){local dt,ds=0.0;if(pt.x<mins.x){dt=(mins.x-pt.x);ds+=dt*dt}else if(pt.x>maxs.x){dt=(pt.x-maxs.x);ds+=dt*dt};;if(pt.y<mins.y){dt=(mins.y-pt.y);ds+=dt*dt}else if(pt.y>maxs.y){dt=(pt.y-maxs.y);ds+=dt*dt};;if(pt.z<mins.z){dt=(mins.z-pt.z);ds+=dt*dt}else if(pt.z>maxs.z){dt=(pt.z-maxs.z);ds+=dt*dt};;return ds}function VS::CalcClosestPointOnAABB(i,x,p,o=_VEC){o.x=(p.x<i.x)?i.x:(x.x<p.x)?x.x:p.x;o.y=(p.y<i.y)?i.y:(x.y<p.y)?x.y:p.y;o.z=(p.z<i.z)?i.z:(x.z<p.z)?x.z:p.z;return o}function VS::ExponentialDecay(dO,dT,dt):(log,exp)return exp(log(dO)/dT*dt);function VS::ExponentialDecay2(hl,dt):(exp)return exp(-0.69314718/hl*dt);function VS::ExponentialDecayIntegral(dO,dT,dt):(log,pow)return(pow(dO,dt/dT)*dT-dT)/log(dO);function VS::SimpleSpline(v){local vSqr=v*v;return(3.0*vSqr-2.0*vSqr*v)}function VS::SimpleSplineRemapVal(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);local vS=cVal*cVal;return C+(D-C)*(3.0*vS-2.0*vS*cVal)}function VS::SimpleSplineRemapValClamped(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);cVal=(cVal<0.0)?0.0:(1.0<cVal)?1.0:cVal;local vS=cVal*cVal;return C+(D-C)*(3.0*vS-2.0*vS*cVal)}function VS::RemapVal(v,A,B,C,D){if(A==B)return v>=B?D:C;return C+(D-C)*(v-A)/(B-A)}function VS::RemapValClamped(v,A,B,C,D){if(A==B)return v>=B?D:C;local cVal=(v-A)/(B-A);cVal=(cVal<0.0)?0.0:(1.0<cVal)?1.0:cVal;return C+(D-C)*cVal}function VS::Bias(x,ba):(log,pow){local la=-1.0,e=0.0;if(la!=ba)e=log(ba)*-1.4427;return pow(x,e)}function VS::Gain(x,ba){if(x<0.5)return 0.5*Bias(2.0*x,1.0-ba);else return 1.0-0.5*Bias(2.0-2.0*x,1.0-ba)}function VS::SmoothCurve(x):(cos)return(1.0-cos(x*3.14159265))*0.5;function VS::MovePeak(x,pkp){if(x<pkp)return x*0.5/pkp;else return 0.5+0.5*(x-pkp)/(1.0-pkp)}local MovePeak=::VS.MovePeak,Gain=::VS.Gain;function VS::SmoothCurve_Tweak(x,pkp,pks):(MovePeak,Gain,cos){local mp=MovePeak(x,pkp);local sh=Gain(mp,pks);return(1.0-cos(sh*3.14159265))*0.5}function VS::Lerp(A,B,f)return A+(B-A)*f;function VS::FLerp(f1,f2,i1,i2,x)return f1+(f2-f1)*(x-i1)/(i2-i1);function VS::VectorLerp(v1,v2,f,o=_VEC){o.x=v1.x+(v2.x-v1.x)*f;o.y=v1.y+(v2.y-v1.y)*f;o.z=v1.z+(v2.z-v1.z)*f;return o}function VS::IsPointInBox(v,i,x)return(v.x>=i.x&&v.x<=x.x&&v.y>=i.y&&v.y<=x.y&&v.z>=i.z&&v.z<=x.z);function VS::IsBoxIntersectingBox(i1,x1,i2,x2){if((i1.x>x2.x)||(x1.x<i2.x))return false;if((i1.y>x2.y)||(x1.y<i2.y))return false;if((i1.z>x2.z)||(x1.z<i2.z))return false;return true}::Ent<-function(s,i=null):(Entities)return Entities.FindByName(i,s);::Entc<-function(s,i=null):(Entities)return Entities.FindByClassname(i,s);::VecToString<-function(V,P="Vector(",S=",",X=")")return P+V.x+S+V.y+S+V.z+X;function VS::DrawEntityBBox(t,e,r=255,g=138,b=0,a=0):(DebugDrawBox)return DebugDrawBox(e.GetOrigin(),e.GetBoundingMins(),e.GetBoundingMaxs(),r,g,b,a,t);local Trace=::TraceLine;class::VS.TraceLine{constructor(start=null,end=null,ent=null):(Vector,Trace){if(!start){local v=Vector();startpos=v;endpos=v;hIgnore=ent;fraction=1.0;return};startpos=start;endpos=end;hIgnore=ent;fraction=Trace(startpos,endpos,hIgnore)}function _cmp(d){if(fraction<d.fraction)return -1;if(fraction>d.fraction)return 1;return 0}function _add(d){return fraction+d.fraction}function _sub(d){return fraction-d.fraction}function _mul(d){return fraction*d.fraction}function _div(d){return fraction/d.fraction}function _modulo(d){return fraction%d.fraction}function _unm(){return -fraction}function _typeof(){return"trace_t"}startpos=null;endpos=null;hIgnore=null;fraction=0.0;hitpos=null;normal=null;m_Delta=null;m_IsSwept=null;m_Extents=null;m_IsRay=null;m_StartOffset=null;m_Start=null}local CTrace=::VS.TraceLine;function VS::TraceDir(v1,d,f=::MAX_TRACE_LENGTH,e=null):(CTrace)return CTrace(v1,v1+(d*f),e);function VS::TraceLine::DidHit()return fraction<1.0;function VS::TraceLine::GetEnt(r){return GetEntByClassname("*",r)}function VS::TraceLine::GetEntByName(n,r):(Entities){if(!hitpos)GetPos();return Entities.FindByNameNearest(n,hitpos,r)}function VS::TraceLine::GetEntByClassname(n,r):(Entities){if(!hitpos)GetPos();return Entities.FindByClassnameNearest(n,hitpos,r)}function VS::TraceLine::GetPos(){if(!hitpos){if(DidHit())hitpos=startpos+(endpos-startpos)*fraction;else hitpos=endpos};return hitpos}function VS::TraceLine::GetDist()return(startpos-GetPos()).Length();function VS::TraceLine::GetDistSqr()return(startpos-GetPos()).LengthSqr();local TraceDir=::VS.TraceDir;function VS::TraceLine::GetNormal():(Vector,TraceDir){if(!normal){local u=Vector(0.0,0.0,0.5),d=endpos-startpos;d.Norm();GetPos();normal=(hitpos-TraceDir(startpos+d.Cross(u),d).GetPos()).Cross(hitpos-TraceDir(startpos+u,d).GetPos());normal.Norm()};return normal}function VS::TraceLine::Ray(mins=::Vector(),maxs=::Vector()){m_Delta=endpos-startpos;m_IsSwept=m_Delta.LengthSqr()!=0.0;m_Extents=(maxs-mins)*0.5;m_IsRay=m_Extents.LengthSqr()<1.e-6;m_StartOffset=(mins+maxs)*0.5;m_Start=startpos+m_StartOffset;m_StartOffset*=-1.0;return this}function VS::UniqueString():(DoUniqueString){local s=DoUniqueString("");return s.slice(0,s.len()-1)}function VS::arrayFind(a,l){foreach(i,v in a)if(v==l)return i}function VS::arrayApply(a,f){foreach(i,v in a)a[i]=f(v)}local array=::array;function VS::arrayMap(a,f):(array){local n=array(a.len());foreach(i,v in a)n[i]=f(v);return n}function VS::DumpScope(I,A=false,P=true,G=true,D=0){local t=function(c)for(local i=0;i<c;++i)::print("   ");if(G)::print(" ------------------------------\n");if(I){foreach(key,val in I){local d=false;if(!A){foreach(k in slots_default)if(key==k)d=true}else if(key=="VS"||key=="Documentation")d=true;;if(!d){t(D);::print(key);switch(typeof val){case"table": ::print("(TABLE) : "+val.len());if(!P)break;::print("\n");t(D);::print("{\n");DumpScope(val,A,P,false,D+1);t(D);::print("}");break;case"array": ::print("(ARRAY) : "+val.len());if(!P)break;::print("\n");t(D);::print("[\n");DumpScope(val,A,P,false,D+1);t(D);::print("]");break;case"string": ::print(" = \""+val+"\"");break;case"Vector": ::print(" = "+::VecToString(val));break;default: ::print(" = "+val)}::print("\n")}}}else ::print("null\n");if(G)::print(" ------------------------------\n")}function VS::ArrayToTable(a){local t={}foreach(i,v in a)t[v]<-i;return t}function VS::GetStackInfo(D=false,P=false){::print(" --- STACKINFO ----------------\n");local s,j=2;while(s=::getstackinfos(j++)){if(s.func=="pcall"&&s.src=="NATIVE")break;::print(" ("+(j-1)+")\n");local w,m=s.locals;if("this"in m&&typeof m["this"]=="table"){if(m["this"]==::getroottable()){w="roottable"}else{w=GetVarName(m["this"]);m[w]<-delete m["this"]}};if(w=="roottable")DumpScope(s,P,0,0);else DumpScope(s,P,D,0);if(w)::print("scope = \""+w+"\"\n")}::print(" --- STACKINFO ----------------\n")}VS.GetCaller<-compile("return(getstackinfos(3).locals[\"this\"])");VS.GetCallerFunc<-compile("return(getstackinfos(3).func)");function VS::GetTableDir(I){if(typeof I!="table")throw"Invalid input type '"+typeof I+"' ; expected: 'table'";local r=_f627f40d21a6([],I);if(r)r.append("roottable");else r=["roottable"];r.reverse();return r}function VS::_f627f40d21a6(bF,t,l=::getroottable()){foreach(v,u in l)if(typeof u=="table")if(v!="VS"&&v!="Documentation")if(u==t){bF.append(v);return bF}else{local r=_f627f40d21a6(bF,t,u);if(r){bF.append(v);return r}}}function VS::FindVarByName(S){if(typeof S!="string")throw"Invalid input type '"+typeof S+"' ; expected: 'string'";return _fb3k55Ir91t7(S)}function VS::_fb3k55Ir91t7(t,l=::getroottable()){if(t in l)return l[t];else foreach(v,u in l)if(typeof u=="table")if(v!="VS"&&v!="Documentation"){local r=_fb3k55Ir91t7(t,u);if(r)return r}}function VS::GetVarName(v){local t=typeof v;if(t=="function"||t=="native function")return v.getinfos().name;return _fb3k5S1r91t7(t,v)}function VS::_fb3k5S1r91t7(t,i,s=::getroottable()){foreach(k,v in s){if(v==i)return k;if(typeof v=="table")if(k!="VS"&&k!="Documentation"){local r=_fb3k5S1r91t7(t,i,v);if(r)return r}}}if(::ENT_SCRIPT<-::Entc("worldspawn")){::ENT_SCRIPT.ValidateScriptScope();::VS.slots_default.append(::VS.GetVarName(::ENT_SCRIPT.GetScriptScope()))}else{(::ENT_SCRIPT<-::VS.CreateEntity("soundent")).ValidateScriptScope();::VS._ENT_SCRIPT<-::ENT_SCRIPT;::Msg("ERROR: Could not find worldspawn\n")};;::delay<-function(X,T=0.0,E=::ENT_SCRIPT,A=null,C=null):(AddEvent)return AddEvent(E,"RunScriptCode",""+X,T,A,C);local flTickRate=1.0/::FrameTime();function VS::GetTickrate():(flTickRate){return flTickRate}if(!PORTAL2){function VS::IsDedicatedServer()throw"not ready";local ENT=::ENT_SCRIPT;local TIMESTART=4.0;local TIMEOUT=12.0;local _TIMEOUT=TIMEOUT+FrameTime()*4;::VS.flCanCheckForDedicatedAfterSec<-fabs(clamp(Time(),0,_TIMEOUT)-_TIMEOUT);::_VS_DS_Init<-function():(TIMESTART,TIMEOUT,ENT){if(::_VS_DS_bInitDone){::VS.flCanCheckForDedicatedAfterSec=0.0;delete::_VS_DS_Init;delete::_VS_DS_IsListen;delete::_VS_DS_bInitDone;delete::_VS_DS_bExecOnce;return};local time=::Time();if(time>TIMESTART){::SendToConsole("script _VS_DS_IsListen()");if(time>TIMEOUT){::VS.IsDedicatedServer=function()return true;::_VS_DS_bInitDone=true}};::delay("::_VS_DS_Init()",0.1,ENT)}::_VS_DS_IsListen<-function(){::VS.IsDedicatedServer=function()return false;::_VS_DS_bInitDone=true}if(!("_VS_DS_bExecOnce"in::getroottable())){::_VS_DS_bExecOnce<-true;::_VS_DS_bInitDone<-false};if(::_VS_DS_bExecOnce){local time=::Time();if(time<TIMESTART){::delay("::_VS_DS_Init()",TIMESTART-time,ENT)}else{::_VS_DS_Init()};::_VS_DS_bExecOnce=false}};;if(!PORTAL2){local Chat=::ScriptPrintMessageChatAll;local ChatTeam=::ScriptPrintMessageChatTeam;::Chat<-function(s):(Chat)return Chat(" "+s);::ChatTeam<-function(i,s):(ChatTeam)return ChatTeam(i," "+s);::Alert<-::ScriptPrintMessageCenterAll;::AlertTeam<-::ScriptPrintMessageCenterTeam;::ClearChat<-function():(Chat)for(local i=9;i--;)Chat(" ");::txt<-{invis="\x00",white="\x01",red="\x02",purple="\x03",green="\x04",lightgreen="\x05",limegreen="\x06",lightred="\x07",grey="\x08",yellow="\x09",lightblue="\x0a",blue="\x0b",darkblue="\x0c",darkgrey="\x0d",pink="\x0e",orangered="\x0f",orange="\x10"}};;::EntFireByHandle<-function(t,a,v="",d=0.0,o=null,c=null):(AddEvent)return AddEvent(t,a+"",v+"",d,o,c);::PrecacheModel<-function(s)::ENT_SCRIPT.PrecacheModel(s);::PrecacheScriptSound<-function(s)::ENT_SCRIPT.PrecacheSoundScript(s);if(!PORTAL2){function VS::MakePersistent(e)return e.__KeyValueFromString("classname","soundent")}else{::VS.MakePersistent<-::dummy};;function VS::SetParent(c,p):(AddEvent){if(p)return AddEvent(c,"SetParent","!activator",0.0,p,null);return AddEvent(c,"ClearParent","",0.0,null,null)}function VS::ShowGameText(e,t,m=null,d=0.0):(AddEvent){if(m)e.__KeyValueFromString("message",""+m);return AddEvent(e,"Display","",d,t,null)}function VS::ShowHudHint(e,t,m=null,d=0.0):(AddEvent){if(m)e.__KeyValueFromString("message",""+m);return AddEvent(e,"ShowHudHint","",d,t,null)}function VS::HideHudHint(e,t,d=0.0):(AddEvent)return AddEvent(e,"HideHudHint","",d,t,null);function VS::CreateMeasure(g,n=null,p=false,e=true,s=1.0):(AddEvent){local r=e?n?n+"":"vs.ref_"+UniqueString():n?n+"":null;if(!r||!r.len())throw"Invalid targetname";local e=CreateEntity("logic_measure_movement",{measuretype=e?1:0,measurereference="",targetreference=r,target=r,measureretarget="",targetscale=s.tofloat(),targetname=e?r:null},p);AddEvent(e,"SetMeasureReference",r,0.0,null,null);AddEvent(e,"SetMeasureTarget",g,0.0,null,null);AddEvent(e,"Enable","",0.0,null,null);return e}function VS::SetMeasure(h,s):(AddEvent)return AddEvent(h,"SetMeasureTarget",s,0.0,null,null);function VS::CreateTimer(D,I,L=null,U=null,O=false,P=false):(AddEvent){local e=CreateEntity("logic_timer",null,P);if(I){e.__KeyValueFromInt("UseRandomTime",0);e.__KeyValueFromFloat("RefireTime",I.tofloat())}else{e.__KeyValueFromFloat("LowerRandomBound",L.tofloat());e.__KeyValueFromFloat("UpperRandomBound",U.tofloat());e.__KeyValueFromInt("UseRandomTime",1);e.__KeyValueFromInt("spawnflags",O.tointeger())};AddEvent(e,D?"Disable":"Enable","",0.0,null,null);return e}function VS::Timer(D,I,F=null,s=null,E=false,P=false){if(!I){::Msg("\nERROR:\nRefire time cannot be null in VS.Timer\nUse VS.CreateTimer for randomised fire times.\n");throw"NULL REFIRE TIME"};local h=CreateTimer(D,I,null,null,null,P);OnTimer(h,F,s?s:GetCaller(),E);return h}function VS::OnTimer(e,F,s=null,E=false)return AddOutput(e,"OnTimer",F,s?s:GetCaller(),E);function VS::AddOutput(e,O,F,s=null,E=false):(compile){if(!s)s=GetCaller();if(F){if(typeof F=="string"){if(F.find("(")!=null)F=compile(F);else F=s[F]}else if(typeof F!="function")throw"Invalid function type "+typeof F}else{F=null;E=true};e.ValidateScriptScope();local r=e.GetScriptScope();r[O]<-E?F:F.bindenv(s);e.ConnectOutput(O,O);return r}function VS::AddOutput2(e,O,F,s=null,E=false):(AddEvent){if(e.GetScriptScope()||typeof F=="function")return AddOutput(e,O,F,s,E);if(typeof F!="string")throw"Invalid function type "+typeof F;if(!s)s=GetCaller();if(!E){if(!("self"in s))throw"Invalid function path. Not an entity";AddEvent(e,"AddOutput",O+" "+s.self.GetName()+",RunScriptCode,"+F,0.0,s.self,e)}else{local n=e.GetName();if(!n.len()){n=UniqueString();SetName(e,n)};AddEvent(e,"AddOutput",O+" "+n+",RunScriptCode,"+F,0.0,null,e)}}function VS::CreateEntity(s,k=null,p=false):(Entities){local e=Entities.CreateByClassname(s);if(typeof k=="table")foreach(k,v in k)SetKeyValue(e,k,v);if(p)MakePersistent(e);return e}function VS::SetKeyValue(e,k,v){switch(typeof v){case"bool":case"integer":return e.__KeyValueFromInt(k,v.tointeger());case"float":return e.__KeyValueFromFloat(k,v);case"string":return e.__KeyValueFromString(k,v);case"Vector":return e.__KeyValueFromVector(k,v);case"null":return true;default:throw"Invalid input type: "+typeof v}}function VS::SetName(e,s)return e.__KeyValueFromString("targetname",s+"");function VS::DumpEnt(I=null):(Entities){if(!I){local e;while(e=Entities.Next(e)){local s=e.GetScriptScope();if(s)::Msg(e+" :: "+s.__vname+"\n")}return};if(typeof I=="string"){local e;while(e=Entities.Next(e))if(e+""==I)I=e};if(typeof I=="instance"){if(I.IsValid()){local s=I.GetScriptScope();if(s){::Msg("--- Script dump for entity "+I+"\n");DumpScope(s,0,1,0,1);::Msg("--- End script dump\n")}else return::Msg("Entity has no script scope! "+I+"\n")}else return::Msg("Invalid entity!\n")}else if(I){local e;while(e=Entities.Next(e)){local s=e.GetScriptScope();if(s){::Msg("\n--- Script dump for entity "+e+"\n");DumpScope(s,0,1,0,1);::Msg("--- End script dump\n")}}}}if(!PORTAL2){function VS::GetPlayersAndBots():(Entities){local e,P=[],B=[];while(e=Entities.FindByClassname(e,"cs_bot"))B.append(e.weakref());e=null;while(e=Entities.FindByClassname(e,"player")){local s=e.GetScriptScope();if("networkid"in s&&s.networkid=="BOT")B.append(e.weakref());else P.append(e.weakref())}return[P,B]}function VS::GetAllPlayers():(Entities){local e,a=[];while(e=Entities.FindByClassname(e,"player"))a.append(e.weakref());e=null;while(e=Entities.FindByClassname(e,"cs_bot"))a.append(e.weakref());return a}function VS::DumpPlayers(D=false){local a=GetPlayersAndBots(),p=a[0],b=a[1];::Msg("\n=======================================\n"+p.len()+" players found\n"+b.len()+" bots found\n");local c=function(_s,_a):(D){foreach(e in _a){local s=e.GetScriptScope();if(s)s=GetVarName(s);if(!s)s="null";::Msg(_s+"- "+e+" :: "+s+"\n");if(D&&s!="null")DumpEnt(e)}}c("[BOT]    ",b);c("[PLAYER] ",p);::Msg("=======================================\n")}};;if(PORTAL2){function VS::GetLocalPlayer(){local e;if(::IsMultiplayer())e=::Entc("player");else{e=::GetPlayer();if(e!=::player)::Msg("GetLocalPlayer: Discrepancy detected!\n")};SetName(e,"localplayer");return e}}else{function VS::GetLocalPlayer(){if(GetPlayersAndBots()[0].len()>1)::Msg("GetLocalPlayer: More than 1 player detected!\n");local e=::Entc("player");if(!e)return::Msg("GetLocalPlayer: No player found!\n");if(e!=GetPlayerByIndex(1))::Msg("GetLocalPlayer: Discrepancy detected!\n");SetName(e,"localplayer");::HPlayer<-e.weakref();return e}function VS::GetPlayerByIndex(i):(Entities){local e;while(e=Entities.FindByClassname(e,"player"))if(e.entindex()==i)return e;e=null;while(e=Entities.FindByClassname(e,"cs_bot"))if(e.entindex()==i)return e}};;function VS::FindEntityByIndex(i,s="*"):(Entities){local e;while(e=Entities.FindByClassname(e,s))if(e.entindex()==i)return e}function VS::IsPointSized(h){local v=h.GetBoundingMaxs();return v.x==0.0&&v.y==0.0&&v.z==0.0}function VS::FindEntityNearestFacing(O,F,T):(Entities){local bd=T,be,e=Entities.First();while(e=Entities.Next(e)){local v=e.GetBoundingMaxs();if(v.x==0.0&&v.y==0.0&&v.z==0.0)continue;local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>bd){bd=d;be=e}}return be}function VS::FindEntityClassNearestFacing(O,F,T,C):(Entities){local bd=T,be,e;while(e=Entities.FindByClassname(e,C)){local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>bd){bd=d;be=e}}return be}function VS::FindEntityClassNearestFacingNearest(O,F,T,C,R):(Entities){local X,be,e;if(R)X=R*R;else X=3.22122e+09;while(e=Entities.FindByClassname(e,C)){local de=e.GetOrigin()-O;de.Norm();local d=F.Dot(de);if(d>T){local q=(e.GetOrigin()-O).LengthSqr();if(X>q){be=e;X=q}}}return be}if(!PORTAL2){function VS::GetPlayerByUserid(i):(Entities){local e;while(e=Entities.FindByClassname(e,"player")){local s=e.GetScriptScope();if("userid"in s&&s.userid==i)return e}e=null;while(e=Entities.FindByClassname(e,"cs_bot")){local s=e.GetScriptScope();if("userid"in s&&s.userid==i)return e}}if(EVENTS){local gEventData=::_xa9b2dfB7ffe;local flTimeoutThold=::FrameTime()*2;local Time=::Time;function VS::Events::player_connect(D):(gEventData,Time,flTimeoutThold){if(D.networkid.len()){if(gEventData.len()>128){for(local i=64;i--;)gEventData.remove(0);::Msg("player_connect: ERROR!!! Player data is not being processed\n")};gEventData.append(D);return::OnGameEvent_player_connect(D)}else if(_SV){local dt=Time()-flValidateTime;if(!(dt>flTimeoutThold)){_SV.userid<-D.userid;if(!("name"in _SV))_SV.name<-"";if(!("networkid"in _SV))_SV.networkid<-""}else::Msg("player_connect: Unexpected error! "+dt+"\n");_SV=null;flValidateTime=0.0;return}}function VS::Events::player_spawn(D):(gEventData){if(gEventData.len())foreach(i,d in gEventData)if(d.userid==D.userid){local p=GetPlayerByIndex(d.index+1);if(!p||!p.ValidateScriptScope()){::Msg("player_connect: Invalid player entity\n");break};local s=p.GetScriptScope();if("networkid"in s){::Msg("player_connect: BUG!!! Something has gone wrong. ");if(s.networkid==d.networkid){::Msg("Duplicated data!\n");gEventData.remove(i)}else::Msg("Conflicting data!\n");break};if(!d.networkid.len())::Msg("player_connect: could not get event data\n");s.userid<-d.userid;s.name<-d.name;s.networkid<-d.networkid;gEventData.remove(i);break};;return::OnGameEvent_player_spawn(D)}function VS::Events::ForceValidateUserid(e):(AddEvent,Time){if(!e||!e.IsValid()||e.GetClassname()!="player")return::Msg("ForceValidateUserid: Invalid input: "+E+"\n");if(!hProxy)hProxy=CreateEntity("info_game_event_proxy",{event_name="player_connect"},true).weakref();flValidateTime=Time();e.ValidateScriptScope();_SV=e.GetScriptScope();AddEvent(hProxy,"GenerateGameEvent","",0,e,null)}function VS::Events::ValidateUseridAll(b=0){local f=::FrameTime();local d=::delay;local E=::ENT_SCRIPT;local i=0;foreach(v in GetAllPlayers())if(!("userid"in v.GetScriptScope())||b)d("::VS.Events.ForceValidateUserid(activator)",i++*f,E,v)}}};;local L=::VS.Log.L;if(PORTAL2){function VS::Log::Run(){if(!enabled)return;return _Start()}}else{function VS::Log::Run(){if(::VS.IsDedicatedServer())throw"Log unavailable on dedicated servers";if(!enabled)return;return _Start()}};;local Msg=::Msg;local flFrameTime=::FrameTime();function VS::Log::_Print(f):(Msg,L,delay,flFrameTime){local t=filter,p=Msg,L=L;if(!f)for(local i=nC;i<nN;++i)p(L[i]);else for(local i=nC;i<nN;++i)p(t+L[i]);nC+=nD;local v=nN+nD;nN=(v<0)?0:(nL<v)?nL:v;if(nC>=nN){if(f)_Stop();nL=null;nD=null;nC=null;nN=null;return};return delay("::VS.Log._Print("+f+")",flFrameTime)}function VS::Log::_Start():(flFrameTime){nL<-L.len();nD<-2000;nC<-0;nN<-::clamp(nD,0,nL);if(export){local file=file_prefix[0]==58?file_prefix.slice(1):file_prefix+"_"+::VS.UniqueString();_d<-::developer();::SendToConsole("developer 0;con_filter_enable 1;con_filter_text_out\""+filter+"\";con_filter_text\"\";con_logfile\""+file+".log\";script delay(\"::VS.Log._Print(1)\","+flFrameTime*4.0+")");return file}else{_Print(0)}}function VS::Log::_Stop()::SendToConsole("con_logfile\"\";con_filter_text_out\"\";con_filter_text\"\";con_filter_enable 0;developer "+_d);function VS::Log::Add(s):(L)L.append(s);function VS::Log::Clear():(L)L.clear();