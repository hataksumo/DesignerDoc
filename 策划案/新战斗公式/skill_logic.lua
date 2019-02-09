

local skill_info = CFG.SKILL_INFO.data
local skill_lv_info = CFG.SKILL_LV_INFO.data
local skill_lv_index = CFG.SKILL_LV_INFO.index__skillID
local formula_fac = CFG.FORMULA_FAC_INFO.data


eSkillHitType = {
	phisical = 1, --物理伤害
	magical = 2,  --魔法伤害
	adaptional = 3,  --自适应伤害
	real = 4, --真实伤害
	heal = 5, --治疗
}





function skillLogic.get_skillLv_info(v_skillID,v_skillLv)
	local skill_lv_info_index = skill_lv_index[v_skillID]
	if not skill_lv_info_index then
		Debug.Error("can't find the skill info id "..v_skillID)
		return
	end
	if v_skillLv > #skill_lv_info_index then
		v_skillLv = #skill_lv_info_index
	end
	local id = skill_lv_info_index[v_skillLv]
	return skill_lv_info[v_skillLv]
end


local function get_levelR_info(v_group,v_lv)
	local group = lvelr_fac_index[v_group]
	if not group then
		Debug.Error("can't find the level group id "..v_group)
	end
	if v_lv > #group then
		v_lv = #group
	end
	local id = group[v_lv]
	return lvelr_fac[id]
end


eHitType = {
	normal = 1, --普攻
	dodge = 2,  --闪避
	block = 3,  --格挡
	crit = 4    --暴击
}





function init_hit_rtn()
	return {hitType = eHitType.normal,damage = 0,damage_type = eSkillHitType.real,is_ingor_def = false,suck = 0,damage_reflect = 0,element_damage_type=0,element_damage=0}
end


--[[
	返回表内容
	rtn = {
		hitType, 普通命中1，闪避2，格挡3，暴击4
		damage, 伤害
		damage_type, 伤害类型
		is_ingor_def, 是否忽视防御
		suck, 吸血
		damage_reflect, 反伤
		element_damage_type, 元素伤害类型
		element_damage, 元素伤害
	}
]]
function skillLogic.skill_effect(v_srcEntity,v_tarEntity,v_skillID,v_skillLv)
	local result = init_hit_rtn()
	result.damage_type = skill_info.hitType
	local skill_info = skillLogic.get_skillLv_info(v_skillID,v_skillLv)
	--获取技能信息
	local skill_base_dmg = skill_info.basedamage
	local skill_fac = skill_info.fac
	local element_type = skill_info.element_type
	local element_damage_base = skill_info.element_damage_base
	local element_fac = skill_info.element_fac
	local element_prob = skill_info.element_prob

	--对于特殊对象进行判定
	if v_tarEntity.behit_damage then--伤害=固定伤害值*技能系数
		result.damage = v_tarEntity.behit_damage * skill_fac
		return result
	end

	--计算闪避，格挡，暴击
	local crit_R = formula_fac[8]--暴击基础R
	local dodge_R = formula_fac[9]--基础闪避R
	local block_R = formula_fac[10]--基础格挡R
	local decrit_R = formula_fac[17]--抗暴R
	local hit_R = formula_fac[18]--命中R
	local dash_R = formula_fac[19]--冲击R
	local decrit_sub_fac = formula_fac[14]--抗暴减法因子
	local hit_sub_fac = formula_fac[15]--命中减法因子
	local dash_sub_fac = formula_fac[16]--冲击减法因子
	local crit_hit_R = formula_fac[21]--基础爆伤等级

	local dodge_val = v_tarEntity.dodge - hit_sub_fac * v_srcEntity.hit
	local dodge_rate = math.min(formula_fac[4], formula_fac[6] + math.max(-formula_fac[6],(dodge_val/(hit_R*v_tarEntity.hit+dodge_R))))
	local block_val = v_tarEntity.block - dash_sub_fac * v_srcEntity.dash
	local block_rate = math.min(formula_fac[5], 0 + math.max(0,block_val/(dash_R*v_tarEntity.dash+block_R)))
	local crit_val = v_tarEntity.crit - decrit_sub_fac * v_tarEntity.decrit
	local crit_rate = math.min(formula_fac[3], 0 + math.max(0, crit_val/(decrit_R*v_tarEntity.decrit + crit_R)))
	
	--走圆桌，计算闪避，格挡，暴击
	local fac = 1
	local rates = {dodge_rate,block_rate,crit_rate}
	local hit_types = {eHitType.dodge,eHitType.block,eHitType.crit,eHitType.normal}
	local random1 = math.random()
	local hit_type_index = 1
	while hit_type_index<4 do
		random1 = random1 - rates[hit_type_index]
		if random1 < 0 then
			break
		end
		hit_type_index = hit_type_index + 1
	end
	local rst_hit_type =  hit_types[hit_type_index]
	if rst_hit_type == eHitType.dodge then--闪避
		fac = 0
		result.damage_type = eHitType.dodge
	elseif rst_hit_type == eHitType.block then--格挡
		fac = fac * (1 - formula_fac[2])
		result.damage_type = eHitType.block
	elseif rst_hit_type == eHitType.crit then--暴击
		fac = fac * (formula_fac[1] + (v_srcEntity.battle_attr.crit_hit - v_tarEntity.battle_attr.crit_dehit)/crit_hit_R))
		result.damage_type = eHitType.crit
	else--普通
		fac = fac
	end
	--计算忽略防御
	local random2 = math.random()
	if random2 < v_srcEntity.battle_attr.ignor_def - v_tarEntity.crit_dehit then
		result.is_ingor_def = true
		result.damage_type = eSkillHitType.real
	end

	local hitType = skill_info.hitType
	local srcdamage = 0
	--计算防御免伤
	--核心防御减伤公式：属性伤害 = (攻1 - 防2) * (攻1 - 防2)/攻1
	--最终技能伤害 = 属性伤害 * 技能系数 + 技能基础伤害
	local fn_def_fac = function(v_atk,v_def)
		return math.max(0,v_atk - v_def * formula_fac[7])/v_atk
	end
	local fn_get_srcdamage = function(v_atk,v_def,v_defFac)
		return ((v_atk - v_def * formula_fac[7]) * v_defFac * skill_fac + skill_base_dmg) * fac
	end

	local defFac = 1
	if result.damage_type == eSkillHitType.phisical then--物理伤害
		defFac = defFac * fn_def_fac(v_srcEntity.battle_attr.atk , v_tarEntity.battle_attr.psdef)
		srcdamage = fn_get_srcdamage(v_srcEntity.battle_attr.atk , v_tarEntity.battle_attr.psdef , defFac)
	elseif result.damage_type == eSkillHitType.magical then--魔法伤害
		defFac = defFac * fn_def_fac(v_srcEntity.battle_attr.atk , v_tarEntity.battle_attr.mgdef)
		srcdamage = fn_get_srcdamage(v_srcEntity.battle_attr.atk , v_tarEntity.battle_attr.mgdef , defFac)
	elseif result.damage_type == eSkillHitType.real then--真实伤害
		defFac = defFac
		srcdamage = (v_srcEntity.battle_attr.atk * skill_fac + skill_base_dmg) * fac
	elseif result.damage_type == eSkillHitType.heal then--受到治疗
		defFac = defFac * (1 + v_tarEntity.treat_bonus)
		srcdamage = (v_srcEntity.battle_attr.atk * defFac * skill_fac + skill_base_dmg) * fac
	end

	--计算元素伤害
	local element_damage = 0
	if element_type and result.damage_type ~= eSkillHitType.heal then --如果该技能有元素类型，并且不是治疗
		local random3 = math.random()
		local element_trigerR = formula_fac[13]
		local element_triger_prob = element_prob * (1 + (v_srcEntity.battle_attr.element_trigger - v_tarEntity.battle_attr.element_avoid)/element_trigerR)
		if random3 <= element_triger_prob then
			local element_def = v_tarEntity.battle_attr["element_def_"..element_type]
			result.element_damage_type = element_type
			element_damage = v_srcEntity.battle_attr.element_atk * element_fac + element_damage_base - element_def
		end
	end

	--计算加减伤
	local jianshang_fac = (1 - v_srcEntity.battle_attr.reduce_damage + v_srcEntity.battle_attr.magnify_damage)
	srcdamage = srcdamage * jianshang_fac
	element_damage = element_damage * jianshang_fac
	--伤害浮动
	local dmg_float_fac = formula_fac[20]
	srcdamage = srcdamage * math.random(1-dmg_float_fac,1+dmg_float_fac)
	--伤害赋值
	result.damage = math.floor(srcdamage) or 1
	result.element_damage = math.floor(element_damage) or 1
	
	if result.damage_type ~= eSkillHitType.heal then
		--处理吸血
		result.suck = srcdamage * v_srcEntity.battle_attr.suck
		--处理反伤
		result.damage_reflect = srcdamage * v_tarEntity.battle_attr.damage_reflact
	end

end