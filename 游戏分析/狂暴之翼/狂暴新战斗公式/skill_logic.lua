

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

	local Rs = {formula_fac[8]，formula_fac[9]，formula_fac[10]}
	local crit_R = formula_fac[8]
	local dodge_R = formula_fac[9]
	local block_R = formula_fac[10]


	local dodge_val = v_tarEntity.dodge - v_srcEntity.hit
	local dodge_rate = math.max(formula_fac[4], formula_fac[6] + math.max(-formula_fac[6],(dodge_val/(dodge_val+dodge_R))))
	local block_val = v_tarEntity.block - v_srcEntity.dash
	local block_rate = math.max(formula_fac[5], 0 + math.max(0,block_val/(block_val+block_R)))
	local crit_val = v_tarEntity.crit - v_tarEntity.decrit
	local crit_rate = math.max(formula_fac[3], 0 + math.max(0, crit_val/(crit_val + crit_R)))
	
	--走圆桌，计算闪避，格挡，暴击
	local fac = 1
	local rates = {dodge_rate,block_rate,crit_rate}
	local hit_types = {eHitType.dodge,eHitType.block,eHitType.crit,eHitType.normal}
	local random1 = math.random()
	local hit_type_index
	for hit_type_index=1,3 do
		random1 = random1 - rates[hit_type_index]
		if random1 < 0 then
			break
		end
	end
	local rst_hit_type =  hit_types[hit_type_index]
	if rst_hit_type == eHitType.dodge then--闪避
		fac = 0
		result.damage_type = eHitType.dodge
	elseif rst_hit_type == eHitType.block then--格挡
		fac = fac * (1 - formula_fac[2])
		result.damage_type = eHitType.block
	elseif rst_hit_type == eHitType.crit then--暴击
		fac = fac * (formula_fac[1] + v_srcEntity.battle_attr.crit_hit - v_tarEntity.battle_attr.crit_dehit)
		result.damage_type = eHitType.crit
	else--普通
		fac = fac
	end
	--计算忽略防御
	local random2 = math.random()
	local ignor_defR = formula_fac[12]
	if random2 < (v_srcEntity.battle_attr.ignor_def - v_tarEntity.crit_dehit)/ignor_defR then
		result.is_ingor_def = true
		result.damage_type = eSkillHitType.real
	end


	local defFac = 1
	local hitType = skill_info.hitType
	local srcdamage = 0
	--计算防御免伤
	--核心防御减伤公式：属性伤害 = (攻1 - 防2) * (攻1 - 防2)/攻1
	--最终技能伤害 = 属性伤害 * 技能系数 + 技能基础伤害
	if result.damage_type == eSkillHitType.phisical then--物理伤害
		defFac = defFac * (v_srcEntity.battle_attr.atk - v_tarEntity.battle_attr.psdef * formula_fac[7])/v_srcEntity.battle_attr.atk
		srcdamage = (v_srcEntity.battle_attr.atk - v_tarEntity.battle_attr.psdef) * defFac * skill_fac + skill_base_dmg
	elseif result.damage_type == eSkillHitType.magical then--魔法伤害
		defFac = defFac * (v_srcEntity.battle_attr.atk - v_tarEntity.battle_attr.mgdef * formula_fac[7])/v_srcEntity.battle_attr.atk
		srcdamage = (v_srcEntity.battle_attr.atk - v_tarEntity.battle_attr.mgdef) * defFac * skill_fac + skill_base_dmg
	elseif result.damage_type == eSkillHitType.real then--真实伤害
		defFac = defFac
		srcdamage = v_srcEntity.battle_attr.atk * skill_fac + skill_base_dmg
	elseif result.damage_type == eSkillHitType.heal then--受到治疗
		defFac = defFac * (1 + v_tarEntity.treat_bonus)
		srcdamage = v_srcEntity.battle_attr.atk * defFac * skill_fac + skill_base_dmg
	end
	--计算加减伤
	local magnify_damageR = formula_fac[11]
	srcdamage  = srcdamage * (1 - v_srcEntity.battle_attr.reduce_damage + v_srcEntity.battle_attr.magnify_damage)/magnify_damageR
	result.damage = srcdamage
	--计算元素伤害
	if element_type and result.damage_type ~= eSkillHitType.heal then --如果该技能有元素类型，并且不是治疗
		local random3 = math.random()
		local element_triger_prob = element_prob * (1 + v_srcEntity.battle_attr.element_trigger - v_tarEntity.battle_attr.element_avoid)
		if random3 < element_triger_prob then
			local element_def = v_tarEntity.battle_attr["element_def_"..element_type]
			result.element_damage_type = element_type
			result.element_damage = (v_srcEntity.battle_attr.element_atk - element_def) * element_fac
		end
	end
	
	if result.damage_type ~= eSkillHitType.heal then
		--处理吸血
		result.suck = srcdamage * v_srcEntity.battle_attr.suck
		--处理反伤
		result.damage_reflect = srcdamage * v_tarEntity.battle_attr.damage_reflact
	end

end