module("CFG",package.seeall)
ATTRIBUTE_INFO = {}

--======================mainData==========================
ATTRIBUTE_INFO.data = {
	[1] = {id = 1,ename = "max_hp",cname = "最大生命",value_type = 1,battle_score_fac = 0.1},--角色的最大生命值，当生命值为0时，角色死亡
	[2] = {id = 2,ename = "max_mp",cname = "最大魔法",value_type = 1,battle_score_fac = 0},--角色释放技能需要消耗魔法值
	[3] = {id = 3,ename = "atk",cname = "攻击力",value_type = 1,battle_score_fac = 3},--角色的攻击力
	[4] = {id = 4,ename = "psdef",cname = "物理防御",value_type = 1,battle_score_fac = 3},--角色的物理防御力
	[5] = {id = 5,ename = "mgdef",cname = "魔法防御",value_type = 1,battle_score_fac = 3},--角色的魔法防御力
	[6] = {id = 6,ename = "move_speed",cname = "移动速度",value_type = 1,battle_score_fac = 0},--角色的移动速度
	[7] = {id = 7,ename = "crit",cname = "暴击等级",value_type = 1,battle_score_fac = 30},--角色的暴击能力，初始暴击伤害为200%
	[8] = {id = 8,ename = "decrit",cname = "抗暴等级",value_type = 1,battle_score_fac = 30},--角色对抗暴击的能力
	[9] = {id = 9,ename = "hit",cname = "命中等级",value_type = 1,battle_score_fac = 30},--角色命中的能力
	[10] = {id = 10,ename = "dodge",cname = "闪避等级",value_type = 1,battle_score_fac = 30},--角色闪避的能力
	[11] = {id = 11,ename = "block",cname = "格挡等级",value_type = 1,battle_score_fac = 30},--角色格挡的能力
	[12] = {id = 12,ename = "dash",cname = "冲击等级",value_type = 1,battle_score_fac = 30},--角色对抗格挡的能力
	[13] = {id = 13,ename = "element_atk",cname = "元素攻击",value_type = 1,battle_score_fac = 1},--元素的攻击能力
	[14] = {id = 14,ename = "element_def_1",cname = "元素1抗性",value_type = 1,battle_score_fac = 1},--元素1的抗性
	[15] = {id = 15,ename = "element_def_2",cname = "元素2抗性",value_type = 1,battle_score_fac = 1},--元素2的抗性
	[16] = {id = 16,ename = "element_def_3",cname = "元素3抗性",value_type = 1,battle_score_fac = 1},--元素3的抗性
	[17] = {id = 17,ename = "element_def_4",cname = "元素4抗性",value_type = 1,battle_score_fac = 1},--元素4的抗性
	[18] = {id = 18,ename = "magnify_demage",cname = "增伤",value_type = 2,battle_score_fac = 10000},--百分比提升伤害
	[19] = {id = 19,ename = "reduce_demage",cname = "减伤",value_type = 2,battle_score_fac = 10000},--百分比伤害减免
	[20] = {id = 20,ename = "ignor_def",cname = "卓越以及",value_type = 2,battle_score_fac = 10000},--无视防御的概率
	[21] = {id = 21,ename = "def_concern",cname = "坚实",value_type = 2,battle_score_fac = 10000},--减少无视防御的概率
	[22] = {id = 22,ename = "crit_hit",cname = "暴伤",value_type = 2,battle_score_fac = 1750},--百分比暴击伤害加成
	[23] = {id = 23,ename = "crit_dehit",cname = "暴伤减免",value_type = 2,battle_score_fac = 1750},--减少所受到的暴击伤害
	[24] = {id = 24,ename = "element_shatter",cname = "元素无视防御",value_type = 2,battle_score_fac = 10000},--元素无视防御几率
	[25] = {id = 25,ename = "element_trigger",cname = "元素触发",value_type = 2,battle_score_fac = 10000},--元素触发几率提升
	[26] = {id = 26,ename = "element_avoid",cname = "元素躲闪",value_type = 2,battle_score_fac = 10000},--元素触发几率下降
	[27] = {id = 27,ename = "magnify_hp",cname = "百分比生命加成",value_type = 2,battle_score_fac = 0},--百分比提升角色最大生命值
	[28] = {id = 28,ename = "magnify_mp",cname = "百分比法力加成",value_type = 2,battle_score_fac = 0},--百分比提升角色最大魔法值
	[29] = {id = 29,ename = "magnify_atk",cname = "百分比攻击加成",value_type = 2,battle_score_fac = 0},--百分比提升角色物理攻击力
	[30] = {id = 30,ename = "magnify_element_atk",cname = "百分比元素攻击加成",value_type = 2,battle_score_fac = 0},--提升角色的元素伤害
	[31] = {id = 31,ename = "magnify_psdef",cname = "百分比物理防御加成",value_type = 2,battle_score_fac = 0},--百分比提升角色物理防御力
	[32] = {id = 32,ename = "magnify_mgdef",cname = "百分比魔法防御加成",value_type = 2,battle_score_fac = 0},--百分比提升角色魔法防御力
	[33] = {id = 33,ename = "magnify_element_def",cname = "百分比元素防御加成",value_type = 2,battle_score_fac = 0},--提升角色的元素防御
	[34] = {id = 34,ename = "treat_bonus",cname = "治疗增强",value_type = 2,battle_score_fac = 0},--百分比提升受到治疗的效果
	[35] = {id = 35,ename = "demage_reflact",cname = "反伤",value_type = 2,battle_score_fac = 0},--百分比反伤
	[36] = {id = 36,ename = "suck",cname = "吸血",value_type = 2,battle_score_fac = 0}--百分比吸血
}
--=================uindex__ename=================
ATTRIBUTE_INFO.uindex__ename = {["max_hp"] = 1,["max_mp"] = 2,["atk"] = 3,["psdef"] = 4,["mgdef"] = 5,
	["move_speed"] = 6,["crit"] = 7,["decrit"] = 8,["hit"] = 9,["dodge"] = 10,
	["block"] = 11,["dash"] = 12,["element_atk"] = 13,["element_def_1"] = 14,["element_def_2"] = 15,
	["element_def_3"] = 16,["element_def_4"] = 17,["magnify_demage"] = 18,["reduce_demage"] = 19,["ignor_def"] = 20,
	["def_concern"] = 21,["crit_hit"] = 22,["crit_dehit"] = 23,["element_shatter"] = 24,["element_trigger"] = 25,
	["element_avoid"] = 26,["magnify_hp"] = 27,["magnify_mp"] = 28,["magnify_atk"] = 29,["magnify_element_atk"] = 30,
	["magnify_psdef"] = 31,["magnify_mgdef"] = 32,["magnify_element_def"] = 33,["treat_bonus"] = 34,["demage_reflact"] = 35,
	["suck"] = 36}