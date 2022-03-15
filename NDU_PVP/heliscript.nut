//-----------------------------------------------------------------------
//--------------------- Copyright (c) SakuraAyi(11) ---------------------
//                  https://space.bilibili.com/2601958
//                    https://weibo.com/u/5239535121
//-----------------------------------------------------------------------

heli <- null;
crate <- null;
letter <- "abcdefghijklmnopqrstuvwxyz";
hang1 <- Vector(0.000000,0.000000,0.000000);
hang2 <- Vector(15.000000,0.000000,0.000000);
hang3 <- Vector(-15.000000,0.000000,0.000000);
hang4 <- Vector(-30.000000,0.000000,0.000000);
hang5 <- Vector(-60.000000,0.000000,0.000000);
hang6 <- Vector(0.000000,75.000000,0.000000);
hang7 <- Vector(-10.000000,30.000000,0.000000);
evacuate1 <- [2424,1707];
pathB <- false;
ptc <- "aztec_copter_takeoff";

angcrl <- function (param,r,n) 
{

    local ent,ang;

    ent = param;

    if (ent != null) 
    {

        ang = ent.GetAngles();

        if (r==0)
        ent.SetAngles(ang.x+n,ang.y,ang.z);
        if (r==1)
        ent.SetAngles(ang.x,ang.y+n,ang.z);
        if (r==2)
        ent.SetAngles(ang.x,ang.y,ang.z+n);

    }

    else

    printl("noent");

}

oricrl <- function (param,r,n) 
{

    local ent,pos,tl;

    ent = param;

    if ( ent != null && ent.IsValid() ) 
    {
        pos = ent.GetOrigin();// + ent.GetForwardVector() * 2;

        //tl = TraceLine(pos,pos + ent.GetForwardVector() * 128,ent);

        //if (tl==1.0)

        if (r==0)
            ent.SetOrigin(Vector(pos.x+n,pos.y,pos.z));
        if (r==1)
            ent.SetOrigin(Vector(pos.x,pos.y+n,pos.z));
        if (r==2)
            ent.SetOrigin(Vector(pos.x,pos.y,pos.z+n));

        if (r==3)
        {
            local ang = ent.GetAngles();
            local yaw = ang.y * PI / 180;
            ent.SetOrigin(Vector( pos.x+( cos(yaw)*n ), pos.y+( sin(yaw)*n ), pos.z ) );
        }
    }
}

helidelay <- function (n,c) 
{
    local text = ["物资直升机已到达","Here comes the airdrop"];
    ScriptPrintMessageCenterAll(text[m_lang]);
    EntFire("heli_temp", "ForceSpawn");
    EntFire("Script_heli", "RunScriptCode", "helicontrol("+n+" "+c+")", 0.01);
    self.EmitSound(::Event_Snd[1]);
} 

helicontrol <- function (n,c) 
{

    printl("heli_control...");

    local att,light,tn,ph,pos,pos2,ang,ang2,t,v,eva,delay,d;

    heli = Entities.FindByName(null, "blackhawk");
    crate = Entities.FindByName(null, "supplycrate");
    tn = Entities.FindByName(null, "heli_train_"+letter.slice(n,n+1));
    att = heli.LookupAttachment("SpotLight");
    light = heli.GetAttachmentOrigin(att);

    if (c==0) 
    {

        printl("spawn_heli_a");
        displayrope = true;
        spotlightbugfix = true;
        heliglow();
        helirope();
        helidust();

        EntFire("blackhawk_particle2", "Start", "", 0.01);
        if ( !pathB )
            EntFire("Script_Area", "RunScriptCode", "ng_vo(5)", 23.00);
            
        else
            EntFire("Script_Area", "RunScriptCode", "ng_vo(4)", 20.00);

        EntFire("blackhawk_sound", "PlaySound", "", 1.00);

        EntFire("supplycrate", "SetParentAttachmentMaintainOffset", "carry_attachment");
        //EntFire("supplycrate_light", "SetParentAttachmentMaintainOffset", "carry_attachment");
        EntFire("blackhawk_light_*", "SetParentAttachmentMaintainOffset", "carry_attachment");
        EntFire("blackhawk_spotlight*", "SetParentAttachment", "SpotLight");
        EntFireByHandle(heli, "SetAnimation", "fly", 0.10, null, null);
        EntFireByHandle(crate, "SetAnimation", "drop", 0.10, null, null);

        pos = tn.GetOrigin();
        heli.SetAngles(hang1.z+70,180.000000,hang1.z);
        heli.SetOrigin(pos);
    
        EntFireByHandle(heli, "SetParent", tn.GetName(), 0.00, null, null);
        if ( pathB )
            EntFire("heli_path_a_0", "ToggleAlternatePath", "", 0.00);
        EntFire(tn.GetName(), "StartForWard", "", 0.01);
    
        ang = heli.GetAngles().x;//hang1.x;
        delay = 0.00;
        v = 0.100000;
        d = 0.01;
        //if (ang>=hang1.x)
        t = (hang2.x-ang) / v; // 15 - 70 = -55 / 0.100000 = -550
        //else
        //t = (hang2.x+=ang) / v;

        if (t < 0) 
        {

            t = abs(t); // absolute value
            v = neg(v); // negative value v - ( 0.100000 * 2 ) (-0.100000

        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+hang1.y+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;

        }
    }

    else if (c==1) 
    {

        printl("elevation_"+c);
    
        ang = heli.GetAngles().x;
        delay = 0.00;
        v = 0.100000;
        d = 0.01;
        t = (hang3.x-ang) / v;

        if (t < 0) 
        {

            t = abs(t);
            v = neg(v);

        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+hang1.y+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;

        }
    }

    else if (c==2) 
    {

        printl("elevation_"+c);
    
        ang = heli.GetAngles().x;
        delay = 0.00;
        v = 0.250000;
        d = 0.01;
        t = (hang4.x-ang) / v;

        if (t < 0) 
        {

            t = abs(t);
            v = neg(v);

        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+hang1.y+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;

        }
    }
    
    else if (c==3) 
    {

        printl("elevation_"+c);

        if (n==0)
        ang = heli.GetAngles().x-2.6403;
        else
        ang = heli.GetAngles().x;
        delay = 0.00;
        v = 0.100000;
        d = 0.01;
        t = (hang5.x-ang) / v;

        if (t < 0) 
        {

            t = abs(t);
            v = neg(v);

        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+hang1.y+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;

        }
    }

    else if (c==4) 
    {

        printl("elevation_"+c);

        if ( !pathB )
        {
            EntFireByHandle(heli, "SetAnimation", "idle3", 0.10, null, null);
            EntFireByHandle(heli, "SetAnimation", "idle2", 5.80, null, null);
        }
        else
        {
            EntFireByHandle(heli, "SetAnimation", "idle3", 6.00, null, null);
            //EntFireByHandle(heli, "SetAnimation", "idle2", 15.00, null, null);
        }

        if (n==0)
        ang = heli.GetAngles().x-16.1176;
        else
        ang = heli.GetAngles().x;
        delay = 0.00;
        v = 0.200000;
        d = 0.01;
        t = (hang1.x - ang - 14.7342) / v;

        if (t < 0) 
        {

            t = abs(t);
            v = neg(v);

        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+hang1.y+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().y.tostring())", delay);
            delay += d;

        }
    }

    else if (c==5) 
    {

        printl("rotate_"+c);

        ang = heli.GetAngles().y;
        ang2 = heli.GetAngles().x;
        delay = 0.00;
        v = 0.200000;
        d = 0.01;
        t = (hang6.y - ang) / v;
        local t3 = t;

        if (t < 0) 
        {
            t = abs(t);
            v = neg(v);
            t3 = t;
        }

        local t2,v2 = 0.050000;
        if ( pathB )
        {
            t2 = (hang6.x - ang2) / v2;
            if (t2 < 0) 
            {
                t2 = abs(t2);
                v2 = neg(v2);
            }
            if ( t < t2 )
                t3 = t2;
        }

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t3;i++) 
        {
            if ( !pathB && i < t )
                EntFireByHandle(heli, "SetLocalAngles", ang2+" "+(ang+=v)+" "+hang1.z, delay, null, null);
            else if ( pathB )
                EntFireByHandle(heli, "SetLocalAngles", (ang2+=v2)+" "+(ang+=v)+" "+hang1.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().y.tostring())", delay);
            delay += d;

        }
    }

    else if (c==6) 
    {

        printl("return_"+c);

        pos = heli.GetOrigin(); // (n==0 -791.999939, -467.999908,)
        //ScriptPrintMessageChatAll(pos.tostring());
        ang = heli.GetAngles().x;
        ang2 = heli.GetAngles().y; 
        eva = evacuate1; // 2424,1707
        delay = 0.00;
        local delay2 = 0.01;
        //local delay3 = 1.00;
        v = 0.100000;
        local v2 = 0.250000;
        local v3 = 3.000000;
        local v3b = 2.028900;
        local v4 = 0.400000;
        d = 0.01;
        t = (hang7.x - ang) / v;
        local t2 = (hang7.y - ang2) / v2;
        local t3 = null;
        local a,b;


        if (pos.x < eva[0]) 
        {

            if (pos.x < 0)

            a = (eva[0] + abs(pos.x));

            else

            a = eva[0] - pos.x;

        }

        else 
        {

            if (eva[0] < 0)

            a = pos.x + abs(eva[0]);

            else
            {

            a = pos.x - eva[0];

            v3 = neg(v3);

            }

        }

        //ScriptPrintMessageChatAll("a:"+a);

        if (pos.y < eva[1]) 
        {

            if (pos.y < 0)

            b = (eva[1] + abs(pos.y));

            else

            b = eva[1] - pos.y;

        }

        else 
        {

            if (eva[1] < 0)

            b = pos.y + abs(eva[1]);

            else {

            b = pos.y - eva[1];

            v3b = neg(v3b);

            }

        }

        //ScriptPrintMessageChatAll("b:"+b);

        a = a / v3; //1072
        b = b / v3b; //1072

        if (a > b)

        t3 = a;

        else

        t3 = b;


        //ScriptPrintMessageChatAll("t3:"+t3);


        if (t < 0) 
        {

            t = abs(t);
            v = neg(v);

        }

        if (t2 < 0) 
        {

            t2 = abs(t2);
            v2 = neg(v2);

        }

        //local i1 = format("%.0f",t),i2 = format("%.0f",t2),i3 = format("%.0f",t3);

        printl("current_angle: "+ang.tostring());
        printl("loop_count: "+t.tostring());

        printl("current_angle2: "+ang2.tostring());
        printl("loop_count2: "+t2.tostring());

        EntFireByHandle(heli, "SetAnimation", "fly", 0.00, null, null);

        for (local i=0;i<t;i++) 
        {

            ang+=v;
            //EntFireByHandle(heli, "SetLocalAngles", (ang+=v)+" "+ang2+" "+hang1.z, delay, null, null);
            EntFire("Script_heli", "RunScriptCode", "angcrl(heli,0,"+v+")", delay);
            //EntFire("Script_heli", "RunScriptCode", "angcrl(heli,0,"+abs(v)+")", 3.00+delay);
            ////EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;

        }

        for (local i=0;i<t2;i++) 
        {

            ang2+=v2;
            //EntFireByHandle(heli, "SetLocalAngles", ang+" "+(ang2+=v2)+" "+hang1.z, delay, null, null);
            EntFire("Script_heli", "RunScriptCode", "angcrl(heli,1,"+v2.tostring()+")", delay2);
            EntFire("Script_heli", "RunScriptCode", "oricrl(heli,2,0.75)", 0.50+delay2);
            ////EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().y.tostring())", delay2);
            delay2 += d;

        }

        for (local i=0;i<t3;i++) 
        {

            if (i<a) 
            {


                EntFire("Script_heli", "RunScriptCode", "oricrl(heli,0,"+v3+")", delay2);

            }

            if (i<b) 
            {

                EntFire("Script_heli", "RunScriptCode", "oricrl(heli,1,"+v3b+")", delay2);

            }
    
            delay2 += d;

        }

        local t4 = (hang2.x - ang) / v4;

        if (t4 < 0) 
        {

            t4 = abs(t4);
            v4 = neg(v4);

        }

       // local i4 = format("%.0f",t4);
    

        for (local i=0;i<t4;i++) 
        {

           // EntFireByHandle(heli, "SetLocalAngles", (ang+=v4)+" "+ang2+" "+hang1.z, delay, null, null);
            EntFire("Script_heli", "RunScriptCode", "angcrl(heli,0,"+v4+")", 0.5+delay);
            delay += d;

        }

        //EntFireByHandle(heli, "SetAnimation", "fly2", delay2, null, null);
        
        /*for (local i=0;i<t3;i++) { // origin = 2962 1956
            
            if (t3 < t3b) {
                EntFire("Script_heli", "RunScriptCode", "oricrl(heli,0,"+v3+")", delay3);
            }
            if (t3 < t3c) {
                EntFire("Script_heli", "RunScriptCode", "oricrl(heli,1,"+v3+")", delay3);
            }
            ////EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetOrigin().x.tostring())", delay);
            ////EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetOrigin().y.tostring())", delay);
            delay3 += d;
        }*/

    }

    else if ( c == 7 ) 
    {
        ang = heli.GetAngles();
        delay = 0.00;
        v = 0.100000;
        d = 0.01;
        t = ((hang2.x+5)-ang.x) / v;

        if (t < 0) 
        {
            t = abs(t);
            v = neg(v);
        }

        printl("current_angle: "+ang.x.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {

            EntFireByHandle(heli, "SetLocalAngles", (ang.x+=v)+" "+ang.y+" "+ang.z, delay, null, null);
            //EntFire("Script_heli", "RunScriptCode", "ScriptPrintMessageChatAll(heli.GetAngles().x.tostring())", delay);
            delay += d;
        }
    }

    else if ( c == 8 )
    {
        ang = heli.GetAngles();
        delay = 0.00;
        v = 0.250000;
        d = 0.01;
        t = null;

        local dist = sqrt( ( pow(2781,2) + pow(1127,2) ) );
        //ScriptPrintMessageChatAll("起点与终点的对角线是"+dist);
        //local yaw = ang.y * PI / 180; 
        local speed = 4;

        t = dist / speed;

        printl("current_angle: "+ang.y.tostring());
        printl("loop_count: "+t.tostring());

        for (local i=0;i<t;i++) 
        {
            //pos = self.GetOrigin();
            //self.SetOrigin(Vector( pos.x+(cos(yaw)*2), pos.y+(sin(yaw)*2), pos.z ) );
            EntFire("Script_heli", "RunScriptCode", "oricrl(heli,3,"+speed+")", 0.50+delay);
            delay += d;
        }
    }
};

supdrop <- function () 
{

    local pos,ang,tl,clip,delay;

    //crate = Entities.FindByName(null, "supplycrate");

    if (crate != null) 
    {

        pos = crate.GetOrigin();
        ang = crate.GetAngles();
        clip = Entities.FindByName(null, "supplycrate_phybox");
        if ( !pathB )
            tl = TraceLine(pos,Vector(pos.x,pos.y,pos.z-5.000000),clip);
        else
            tl = TraceLine(pos,Vector(pos.x,pos.y,pos.z-10.000000),clip);

        //if (crate.GetMoveParent() != null)

        //EntFireByHandle(crate, "ClearParent", "", 0.00, null, null);
        
        if (tl==1.0) 
        {
            if ( !pathB )
                crate.SetOrigin(Vector(pos.x,pos.y,pos.z-7.500000));
            else
                crate.SetOrigin(Vector(pos.x,pos.y,pos.z-7.500000));
            EntFire("Script_heli", "RunScriptCode", "supdrop()", 0.01);

        }

        else 
        {

        if ( !pathB )
        {
            delay = 12;
            crate.SetAngles(ang.x+3,ang.y,ang.z-5);
            EntFire("Script_heli", "RunScriptCode", "helicontrol(0,6)", 0.00);
            EntFire("Script", "RunScriptCode", "ng_vo(11)", 40.00)
            EntFire("Script", "RunScriptCode", "Wave_Start(3)", 45);
        }
        else
        {
            delay = 11;
            crate.SetAngles(0-4,ang.y,0+3);
            EntFire("Script_heli", "RunScriptCode", "helicontrol(0,7)", 0.00);
            EntFire("Script_heli", "RunScriptCode", "helicontrol(0,8)", 3.00);
            EntFire("Script", "RunScriptCode", "Wave_Start(5)", 45);
        }
        EntFireByHandle(crate, "RunScriptCode", "Land = true", 0.15, null, null);

        EntFireByHandle(crate, "SetAnimation", "idle", 0.00, null, null);
        //EntFire("supplycrate_light", "ShowSprite");

        spotlightbugfix = false;

        EntFire("blackhawk_sound", "StopSound", "", delay);
        EntFire("blackhawk_sound", "Volume", "0", delay);
        EntFire("blackhawk_spotlight", "LightOff", "", delay-1.00);
        EntFire("blackhawk_spotlight2", "TurnOff", "", delay-1.00);
        EntFire("blackhawk_spotlight*", "Kill", "", delay);
        EntFire("heli_pariticle_a2", "Stop", "", 3.00);
        EntFireByHandle(heli, "KillHierarchy", "", delay, null, null);

        displayrope = false;
        EntFire("blackhawk_rope*", "SetLocalOrigin", "7654,-145,125");
        DispatchParticleEffect("explosion_child_clumps03a", Vector(pos.x,pos.y,pos.z), Vector(0.000000,0.000000,0.000000));

        } 
    }
}

displayrope <- true;
helirope <- function () 
{

    local att,carry,rope1,rope2,rope3,rope4,pt1,pt2,pt3,pt4;

    if (heli != null) 
    {

        if (displayrope) 
        {

        //printl("heli_rope_linked_box");

        att = heli.LookupAttachment("carry_attachment");
        carry = heli.GetAttachmentOrigin(att);

        rope1 = Entities.FindByName(null, "blackhawk_rope1");
        rope2 = Entities.FindByName(null, "blackhawk_rope2");
        rope3 = Entities.FindByName(null, "blackhawk_rope3");
        rope4 = Entities.FindByName(null, "blackhawk_rope4");
        

        pt1 = carry + (heli.GetUpVector() * 10) + (heli.GetForwardVector() * 1) + heli.GetLeftVector() * 31;
        pt2 = carry + (heli.GetUpVector() * 10) + (heli.GetForwardVector() * 1) + heli.GetLeftVector() * -31;
        pt3 = carry + (heli.GetForwardVector() * -5) + heli.GetLeftVector() * 35;
        pt4 = carry + (heli.GetForwardVector() * -5) + heli.GetLeftVector() * -35;

        rope1.SetOrigin(pt1);
        rope2.SetOrigin(Vector(pt3.x,pt3.y,pt3.z-60));
        rope3.SetOrigin(pt2);
        rope4.SetOrigin(Vector(pt4.x,pt4.y,pt4.z-60));

        EntFire("Script_heli", "RunScriptCode", "helirope()", 0.01);

        }
    }

    else {

        heli = Entities.FindByName(null, "blackhawk");
        helirope();

    }
}

helidust <- function () 
{

    local pos;

    if (heli != null) 
    {

        //pos = heli.GetOrigin();

        //DispatchParticleEffect("aztec_copter_takeoff_dust_high", pos, Vector(0.000000, 0.000000, 0.0000000));
        EntFire("blackhawk_particle", "Stop", "", 0.00);
        EntFire("blackhawk_particle", "Start", "", 0.01);

        EntFire("Script_heli", "RunScriptCode", "helidust()", 6.00);

    }
};

spotlightbugfix <- true;
heliglow <- function () 
{

    EntFire("blackhawk_light_1", "ShowSprite");
    EntFire("blackhawk_light_1b", "TurnOn");
    EntFire("blackhawk_light_1", "HideSprite", "", 0.10);
    EntFire("blackhawk_light_1b", "TurnOff", "", 0.10);
    EntFire("blackhawk_light_1", "ShowSprite", "", 0.20);
    EntFire("blackhawk_light_1b", "TurnOn", "", 0.20);
    EntFire("blackhawk_light_1", "HideSprite", "", 0.30);
    EntFire("blackhawk_light_1b", "TurnOff", "", 0.30);
    EntFire("blackhawk_light_1", "ShowSprite", "", 0.40);
    EntFire("blackhawk_light_1b", "TurnOn", "", 0.40);
    EntFire("blackhawk_light_1", "HideSprite", "", 0.50);
    EntFire("blackhawk_light_1b", "TurnOff", "", 0.50);

    EntFire("blackhawk_light_2", "ShowSprite", "", 1.50);
    //EntFire("blackhawk_light_2b", "TurnOn", "", 1.50);
    EntFire("blackhawk_light_2", "HideSprite", "", 1.60);
    //EntFire("blackhawk_light_2b", "TurnOff", "", 1.60);
    EntFire("blackhawk_light_2", "ShowSprite", "", 1.70);
    //EntFire("blackhawk_light_2b", "TurnOn", "", 1.70);
    EntFire("blackhawk_light_2", "HideSprite", "", 1.80);
    //EntFire("blackhawk_light_2b", "TurnOff", "", 1.80);
    EntFire("blackhawk_light_2", "ShowSprite", "", 1.90);
    //EntFire("blackhawk_light_2b", "TurnOn", "", 1.90);
    EntFire("blackhawk_light_2", "HideSprite", "", 2.00);
    //EntFire("blackhawk_light_2b", "TurnOff", "", 2.00);

    if ( spotlightbugfix )
    {
        EntFire("blackhawk_spotlight", "LightOff", "", 0.00);
        EntFire("blackhawk_spotlight", "LightOn", "", 0.01);
    }
    EntFire("Script_heli", "RunScriptCode", "heliglow()", 3.00); 

}

DisOnceParticle <- function ()
    DispatchParticleEffect(ptc, heli.GetOrigin(), Vector(0,0,0));
