::ModelList <- [
    "models/shells/shell_12gauge.mdl",
    "models/weapons/11/v_items.mdl",
    "models/props/de_inferno/hr_i/missile/missile_02.mdl",
    "models/vehicles/11/mw2019/blackhawk.mdl",
    "models/vehicles/11/mw2019/ropel.mdl",
    "models/11/mw2019/ani/chiefl.mdl",
    "models/11/mw2019/ani/guy01.mdl",
    "models/11/mw2019/ani/guy02.mdl", 
    "models/11/mw2019/ani/guy03.mdl",
    "models/humans/11/helipilot/pilot.mdl",
    "models/player/custom_player/11/mw2019/humans/usef_valvebiped.mdl",
    "models/player/custom_player/11/mw2019/humans/usef.mdl",
    "models/player/custom_player/11/mw2019/humans/usef_b.mdl",
    "models/player/custom_player/11/mw2019/humans/usef_c.mdl",
    "models/weapons/11/launcher/w_launcher_at4_close.mdl",
    "models/weapons/11/launcher/w_launcher_at4.mdl",
    "models/weapons/11/launcher/w_launcher_at4_drop.mdl",
    "models/weapons/11/arrmor/v_armorplate.mdl", //17
    "models/weapons/11/arrmor/w_armorplate.mdl",

    "models/weapons/11/knive/v_dao.mdl",
    "models/weapons/11/knive/w_dao.mdl",

    "models/props/11/army/glowstick.mdl",
];

::SoundList <- [
    "items/nvg_on.wav",
    "items/nvg_off.wav",
    "11/mw2019/heli_intro/sas1_veh1_ceilingrattles_spot_stat.mp3",
    "11/mw2019/heli_intro/sas1_veh1_int_quad_front_stat.mp3",
    "11/mw2019/heli_intro/sas1_veh1_int_quad_rear_stat.mp3",
    "11/mw2019/heli_intro/sas1_veh1_rattles_spot_stat.mp3",
    "11/mw2019/heli_intro/sas1_veh1_rope_spot_stat.mp3"
    "11/mw2019/heli_intro/sas1_veh1_door_ster_pan.mp3",
    "11/mw2019/heli_intro/sas1_veh1_ext_ster_pan.mp3",
    "11/mw2019/heli_intro/sas1_veh1_foley_doorman_npc.mp3",
    "11/mw2019/heli_intro/sas1_veh1_foley_seat1_plr.mp3",
    "11/mw2019/heli_intro/sas1_veh1_foley_seat2_plr.mp3",
    "11/mw2019/heli_intro/sas1_veh1_foley_seat3_plr.mp3",

    "weapons/at4/at4_fp.wav", //13
    "weapons/at4/at4_dist.wav",
    "weapons/at4/at4rpg_detonate_01.wav",
    "weapons/at4/at4rpg_detonate_02.wav",
    "weapons/at4/at4rpg_detonate_03.wav",

    "weapons/11/armorplate/open.wav", //18
    "weapons/11/armorplate/insert.wav",
    "weapons/11/armorplate/close.wav",

    "items/itempickup.wav",

    "weapons/11/eq_beginreload_01.wav", //22
    "weapons/11/eq_beginreload_02.wav",
    "weapons/11/eq_beginreload_03.wav",
    "weapons/11/eq_weapon_draw_01.wav",
    "weapons/11/eq_weapon_draw_02.wav",
    "weapons/11/eq_weapon_draw_03.wav",
    "weapons/11/eq_pistol_draw_01.wav",
    "weapons/11/eq_pistol_draw_02.wav",
    "weapons/11/eq_pistol_draw_03.wav",

];

function Precache ()
{
    for (local i = 0; i < ModelList.len(); i++)
        self.PrecacheModel(ModelList[i]);
    for (local i = 0; i < SoundList.len(); i++)
        self.PrecacheScriptSound(SoundList[i]);
};