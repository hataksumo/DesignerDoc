_G.SkillManage = {}
_G.attackDisPrecision = 10
local tempV1 = _Vector2.new()
local mathmax = math.max
local mathmin = math.min

local eSkillHitType = {
	phisical = 1, --物理伤害
	magical = 2,  --魔法伤害
	adaptional = 3,  --自适应伤害
	real = 4, --真实伤害
	heal = 5, --治疗
}
local eHitType = {
	normal = 1, --普攻
	dodge = 2,  --闪避
	block = 3,  --格挡
	crit = 4    --暴击
}

function _G.GetSkillArg(key, skilllv, cfg)
	if key == 'count' then
		return type(cfg[#cfg]) == 'table' and cfg[#cfg][2] or #cfg --数目
	end
	if not skilllv then return end
	if type(cfg[#cfg]) ~= 'table' then
		return cfg[skilllv]
	end
	for i, v in ipairs(cfg) do
		if skilllv >= v[1] and skilllv <= v[2] then
			if key == 'skillcoe' then
				return v[3] * skilllv + v[4]
			elseif key == 'skilldamage' then
				return v[3] * skilllv + v[4]
			elseif key == 'fight' then
				return v[3] * skilllv + v[4]
			elseif key == 'itemcount' then
				return toint(v[3] * skilllv * skilllv + v[4] * skilllv + v[5])
			end
		end
	end
	return 0
end

--得到使用技能的GUID
local skillguid = -999999999
function _G.newSkillGuid()
	skillguid = skillguid + 1
	return skillguid
end
--对地使用的技能距离判断
function SkillManage.attackPointDisAble( skill, entity, point )
	local pos =_Vector2.new( entity:gp'currPos'.x, entity:gp'currPos'.y )
	local point =_Vector2.new( point.x, point.y )
	local dir = _Vector2.sub( point, pos )
	local m = dir:magnitude()
	m = m - entity:gp'sizeR'
	--服务器增加一点误差(服务器只做最大距离判断)
	local max = skill.useRangeParm1
	if( entity.ridewSkillData ) then
		max = max + entity.ridewSkillData[1]
	end
	local ret = (m - attackDisPrecision) <= max

	if( not ret ) then
		return false
	end
	return true
end

--对对象使用的技能距离判断
function SkillManage.attackDistanceAble( skill, player, entity )
	local playerPos = _Vector2.new( player:gp'currPos'.x, player:gp'currPos'.y )
	local entityPos = _Vector2.new( entity:gp'currPos'.x, entity:gp'currPos'.y )
	local dir = _Vector2.sub( entityPos, playerPos )
	local m = dir:magnitude( )
	m = m - ( player:gp'sizeR' + entity:gp'sizeR' )
	--服务器增加一点误差(服务器只做最大距离判断)
	local max = skill.useRangeParm1
	if( entity.ridewSkillData ) then
		max = max + entity.ridewSkillData[1]
	end
	if skill.tinyrush then
		max = max + skill.tinyrush
	end

	local ret = (m - attackDisPrecision) <= max
	if( not ret ) then
		return false
	end
	return true
end

-- 获取技能的等级 返回技能等级和技能id
function SkillManage.getSkillLevel(e, skill, srcskill)
	if e:gp'type' == 'role' and (skill.type == "xp" or skill.type == "other") then
		local id, lv = Advisor.getXpSkill( e )
		return lv, id
	elseif e:gp'type' == 'role' then
		--玩家变身怪物
		local skillcfg = Cfg.cfg_skill[skill.id]
		if e:isMonAva( ) then
			for index, id in pairs( e.playerskill.monskill ) do
				if id == (skillcfg.srcskill or skill.id) then
					local lv = e.playerskill.monskilllv[index] or 1
					return lv, id
				end
			end
		else
			local broadchangesysid = e.changesys and e:gp'broadchangesys'.id or -1
			if broadchangesysid > 0 then
				--变身
				-- _js('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>', skill.id, srcskill.id)
				for id, _ in pairs( e.changesys.skills or {} ) do
					if id == (skillcfg.srcskill or skill.id) then
						local lv = e.changesys.skilllv and e.changesys.skilllv[id] or 1
						return lv, id
					elseif srcskill and id == srcskill.id then
						local lv = e.changesys.skilllv and e.changesys.skilllv[id] or 1
						return lv, srcskill.id
					end
				end
			else
				local lv = SkillGift.skillLvById(e, skill.id, srcskill and srcskill.id) or skill.level
				return lv, srcskill and srcskill.id or skill.id
			end
		end
	elseif e:isSp'roleava' and e:gp'roleava' then
		local skillidx = table.ifind(e.skill, skill.id)
		local lv = e.skilllv[skillidx]
		return lv, skill.id
	else
		local lv = skill.level or 1
		return lv, skill.id
	end
end

function SkillManage.useRangeSelectPoint( player, point, skill )
	local eList = {}
	if( skill.useRange == CFG_USERANGES.CIRCLE_POINT_ALLENEMY ) then	--根据不同的技能作用范围得到技能作用玩家数组
		eList = SkillManage.roundPointAllEnemy( player, point, skill.useRangeParm1 )
	end
	return eList
end

--检查技能配置是否匹配 endbuffstate用
function SkillManage.checkSkill( skillcfg, checkskillinfo )
	if not skillcfg or not checkskillinfo then return true end
	for k, v in pairs(checkskillinfo) do
		if skillcfg and skillcfg[k] and skillcfg[k] ~= v then--判断是否相关的技能,只有条件都匹配了才结束buff
			return false
		end
	end
	return true
end

--给玩家上一个不能通过正常学习的被动技能
function SkillManage.addGiftToRole( role, id, isnotreset )
	local cfg = cfg_gift[id]
	assert(cfg, 'error gift id:   '..id)

	--要求骑乘
	if( cfg.isneedride and not Ride.isRiding( role ) ) then
		return
	end

	role.dynagift[ #role.dynagift + 1 ] = id
	if(cfg.addattrGift) then
		if cfg.addattrGiftfight then
			AttrSys.add( role, {[2] = cfg.addattrGift}, isnotreset, 'gift'..id )
		else
			AttrSys.add( role, {[3] = cfg.addattrGift}, isnotreset, 'gift'..id )
		end
	elseif( cfg.autobuff1pro ) then
		role.autobuff1pro = role.autobuff1pro or {}
		role.autobuff1pro[id] = { cfg.autobuff1pro[1], cfg.autobuff1pro[2], 0, combatstate=cfg.autobuff1pro[3] }
	elseif( cfg.combuff ) then
		if role.loaded then
			for _, buffgroupid in next, cfg.combuff do
				BuffSys.addBuffGroup( role, role, { groupID=buffgroupid, type='gift' }, isnotreset )
			end
		else
			--延迟加buff, 等玩家loaded, 属性都准备好
			Timer.add( 2000, function()
				for _, buffgroupid in next, cfg.combuff do
					BuffSys.addBuffGroup( role, role, { groupID=buffgroupid, type='gift' }, isnotreset )
				end
			end )
		end
	elseif cfg.bookbuffs then --兵书buff
		local adv = Advisor.getDefault( role )
		if adv then
			local advlv = adv.star + 1
			local buffgroupid = cfg.bookbuffs[advlv]
			if buffgroupid then
				BuffSys.addBuffGroup( role, role, { groupID=buffgroupid, type='gift' }, isnotreset )
			end
		end
	end
end
function SkillManage.subGiftToRole( role, id, isnotreset )
	local havegift = false
	for i, v in ipairs( role.dynagift ) do
		if( v == id ) then
			table.remove( role.dynagift, i )
			havegift = true
			break
		end
	end
	if not havegift then return end

	local cfg = cfg_gift[id]
	if(cfg.addattrGift) then
		if cfg.addattrGiftfight then
			AttrSys.sub( role, {[2] = cfg.addattrGift}, isnotreset, 'gift'..id )
		else
			AttrSys.sub( role, {[3] = cfg.addattrGift}, isnotreset, 'gift'..id )
		end
	elseif( cfg.autobuff1pro ) then
		role.autobuff1pro[id] = nil
	elseif( cfg.combuff ) then
		for _, buffgroupid in next, cfg.combuff do
			BuffSys.closeByID( role, buffgroupid, isnotreset )
		end
	elseif cfg.bookbuffs then --兵书buff
		local adv = Advisor.getDefault( role )
		if adv then
			local advlv = adv.star + 1
			local buffgroupid = cfg.bookbuffs[advlv]
			if buffgroupid then
				BuffSys.closeByID( role, buffgroupid, isnotreset )
			end
		end
	end
end


--神器伤害天赋
function SkillManage.famousGiftPro( entity, target )
	if( entity.dynagift ) then
		for _, id in ipairs( entity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.famousattack ) then
				if( entity.artifactatt and randomResultMore( gift.famousattack[1]+(entity.addfamouspro and entity.addfamouspro or 0) ) ) then
					local elist = SkillManage.roundTargetSomeEnemy( entity, target, gift.famousattack[3], gift.famousattack[4] )
					local extpro = gift.famousattack[2]
					if( entity.extfamouspro ) then
						extpro = extpro + entity.extfamouspro
					end
					local damage = math.floor(extpro*0.1*entity.artifactatt*( entity.addfamousdamage and entity.addfamousdamage or 1 ))

					local info = {}
					for _, e in ipairs( elist ) do
						local t = {}
						local death, trueValue, islose, oldhp = e:modifyHp( entity:gp'guid', -damage, {}, 'famous', true)

						if( not islose ) then
							t[ 'famous' ] = { value = -damage, truevalue = trueValue, oldhp=oldhp }
							if( entity:gp'type' == 'role' ) then
								entity:updateSerAttack()
							end
						end
						if( death ) then
							t[ 'famousDeath' ] = true
							--if( entity:gp'type' == 'role' ) then
								--entity:updateSerAttack()
							--end
						end

						info[e:gp'guid'] = t
					end


					CallRound( entity ).FamousAttackInfo{ SrcGUID = entity:gp'guid', TarGUID = target:gp'guid', Info = info }
					GrowSYS.addApt( entity, 'artifact', 1 )

					SkillManage.giftPaoText( entity, gift )
				end
				break
			end
		end
	end
end

--跳跃落点的时候触发的天赋
function SkillManage.jumpGiftPro( entity )
	local type = entity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	local srcEntity = entity
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.jumpendGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end
				if( isrideattack and randomResult( gift.jumpendGift[2] ) ) then
					local type = gift.jumpendGift[1]
					local buffGroupID = gift.jumpendGift[3]
					if( type == 1 ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
						SkillManage.giftPaoText( srcEntity, gift )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.jumpendGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end
				if( isrideattack and randomResult( gift.jumpendGift[2] ) ) then
					local type = gift.jumpendGift[1]
					local buffGroupID = gift.jumpendGift[3]
					if( type == 1 ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
						SkillManage.giftPaoText( srcEntity, gift )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end
end

--杀死目标的时候触发的天赋
function SkillManage.killGiftPro( entity, point )
	local type = entity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	local pos
	if not point then
		pos = {x=entity:gp'currPos'.x, y=entity:gp'currPos'.y}
	end

	if( entity.playergift.gift ) then
		for _, id in ipairs( entity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.killGift and randomResult(gift.killGift[1]) ) then
				local type = gift.killGift[3]
				if( gift.killGift[4] ) then
					if( cfg_zone[ entity:getZone().id ].iscrossf ) then
						if( type == 1 ) then
							BuffSys.addBuffGroup( entity, entity, { groupID=gift.killGift[2], type='gift' } )
						elseif( type == 3 ) then
							BuffSys.addSceneBuffGroup( entity, entity.zoneguid, gift.killGift[2], {x=pos.x, y=pos.y}, nil, {skilldamage=entity.skilldamage} )
						end
						SkillManage.giftPaoText( entity, gift )
					end
				else
					if( type == 1 ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.killGift[2], type='gift' } )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( entity, entity.zoneguid, gift.killGift[2], {x=pos.x, y=pos.y}, nil, {skilldamage=entity.skilldamage} )
					end
					SkillManage.giftPaoText( entity, gift )
				end
			end
		end
	end

	if( entity.dynagift ) then
		for _, id in ipairs( entity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.killGift and randomResult(gift.killGift[1]) ) then
				local type = gift.killGift[3]
				if( gift.killGift[4] ) then
					if( cfg_zone[ entity:getZone().id ].iscrossf ) then
						if( type == 1 ) then
							BuffSys.addBuffGroup( entity, entity, { groupID=gift.killGift[2], type='gift' } )
						elseif( type == 3 ) then
							BuffSys.addSceneBuffGroup( entity, entity.zoneguid, gift.killGift[2], {x=pos.x, y=pos.y}, nil, {skilldamage=entity.skilldamage} )
						end
						SkillManage.giftPaoText( entity, gift )
					end
				else
					if( type == 1 ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.killGift[2], type='gift' } )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( entity, entity.zoneguid, gift.killGift[2], {x=pos.x, y=pos.y}, nil, {skilldamage=entity.skilldamage} )
					end
					SkillManage.giftPaoText( entity, gift )
				end
			end
		end
	end
end

--当hp条件满足时触发的被动技能
function SkillManage.hpGiftPro( entity )
	local type = entity:gp'type'
	if( type ~= 'role' ) then
		return
	end

	if( entity.playergift.gift ) then
		for _, id in ipairs( entity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.hpGift ) then
				local per = gift.hpGift[1]
				if( per > 0 ) then
					if( entity:gp'hp' > AttrSys.get( entity, 'maxHp' )*per*0.01 ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.hpGift[2], type='gift' } )
					end
				else
					if( entity:gp'hp' < (-AttrSys.get( entity, 'maxHp' )*per*0.01) ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.hpGift[2], type='gift' } )
					end
				end
			end
		end
	end

	if( entity.dynagift ) then
		for _, id in ipairs( entity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.hpGift ) then
				local per = gift.hpGift[1]
				if( per > 0 ) then
					if( entity:gp'hp' > AttrSys.get( entity, 'maxHp' )*per*0.01 ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.hpGift[2], type='gift' } )
					end
				else
					if( entity:gp'hp' < (-AttrSys.get( entity, 'maxHp' )*per*0.01) ) then
						BuffSys.addBuffGroup( entity, entity, { groupID=gift.hpGift[2], type='gift' } )
					end
				end
			end
		end
	end
end
-- 神算天赋技能
---src, skill, srcskill, targetguid, targetpos, skillguid, extData
function SkillManage.attackSchemeGift( srcEntity, targetguid, targetpos )
	if not srcEntity then return end
	local type = srcEntity:gp'type'
	if type ~= 'role' then
		return
	end
	--cd中
	if srcEntity.cdManager.cds['schemegift'] and not srcEntity.cdManager:cdIsOver('schemegift') then
		return
	end
	for id, v in pairs(srcEntity.schemegifts or {}) do
		local cfg = Cfg.cfg_scheme_gift[id]
		if cfg and cfg.attackGiftskill then
			if randomResult( cfg.attackGiftskill[2] ) then
				-- dump(cfg.attackGiftskill)
				local type, skillId = cfg.attackGiftskill[1], cfg.attackGiftskill[3]
				_yss("----type = ", type, "---skillId = ", skillId)
				if type == 1 then-- 触发技能
					local cfgSkill = Cfg.cfg_skill[skillId]
					local extData = {originType = 'scheme'}
					-- 加cd
					if cfgSkill.cdTime then
						-- srcEntity.cdManager:newCD( 'schemegift', nil, 5 )
						srcEntity.cdManager:newCD( 'schemegift', nil, cfgSkill.cdTime )
						srcEntity.cdManager:actionCD( 'schemegift' )
					end
					SkillManage.skillAttack(srcEntity, cfgSkill, cfgSkill, targetguid, targetpos, newSkillGuid(), extData)
				end
				return
			end
		end
	end
end
--天赋攻击别人时给别人上BUFF
function SkillManage.attackGiftOtherPro( srcEntity, tarEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.attackGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end
				if( isrideattack and randomResult( gift.attackGift[2] ) ) then
					local type = gift.attackGift[1]
					local buffGroupID = gift.attackGift[3]
					if( type == 2 ) then
						BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=buffGroupID, type='gift' } )
						SkillManage.giftPaoText( srcEntity, gift )
					elseif( type == 4 ) then
						BuffSys.addSceneBuffGroup( srcEntity, tarEntity.zoneguid, buffGroupID, {x=tarEntity:gp'currPos'.x, y=tarEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.attackGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end
				if( isrideattack and randomResult( gift.attackGift[2] ) ) then
					local type = gift.attackGift[1]
					local buffGroupID = gift.attackGift[3]
					if( type == 2 ) then
						BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=buffGroupID, type='gift' } )
						-- SkillManage.giftPaoText( srcEntity, gift )
					elseif( type == 4 ) then
						BuffSys.addSceneBuffGroup( srcEntity, tarEntity.zoneguid, buffGroupID, {x=tarEntity:gp'currPos'.x, y=tarEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end
end

--天赋攻击别人时给自己上BUFF(针对单个目标都判断)
function SkillManage.attacksGiftSelfPro( srcEntity, tarEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.attacksGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end
				if( isrideattack and randomResult( gift.attacksGift[2] ) ) then
					local ishp = true
					if( gift.attacksGift[4] ) then
						if( gift.attacksGift[4] > 0 ) then
							if( tarEntity:gp'hp' < AttrSys.get( tarEntity, 'maxHp' )*gift.attacksGift[4]*0.01 ) then
								ishp = false
							end
						else
							if( tarEntity:gp'hp' > -AttrSys.get( tarEntity, 'maxHp' )*gift.attacksGift[4]*0.01 ) then
								ishp = false
							end
						end
					end
					if( ishp ) then
						local type = gift.attacksGift[1]
						local buffGroupID = gift.attacksGift[3]
						if( type == 1 ) then
							BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )

							SkillManage.giftPaoText( srcEntity, gift )
						elseif( type == 2 ) then
							BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=buffGroupID, type='gift' } )
						elseif( type == 3 ) then
							BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
						end
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.attacksGift ) then
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(srcEntity) ) then
					isrideattack = false
				end

				if( isrideattack and randomResult( gift.attacksGift[2] ) ) then
					local ishp = true
					if( gift.attacksGift[4] ) then
						if( gift.attacksGift[4] > 0 ) then
							if( tarEntity:gp'hp' < AttrSys.get( tarEntity, 'maxHp' )*gift.attacksGift[4]*0.01 ) then
								ishp = false
							end
						else
							if( tarEntity:gp'hp' > -AttrSys.get( tarEntity, 'maxHp' )*gift.attacksGift[4]*0.01 ) then
								ishp = false
							end
						end
					end
					if( ishp ) then
						local type = gift.attacksGift[1]
						local buffGroupID = gift.attacksGift[3]
						if( type == 1 ) then
							BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )

							SkillManage.giftPaoText( srcEntity, gift )
						elseif( type == 2 ) then
							BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=buffGroupID, type='gift' } )
						elseif( type == 3 ) then
							BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
						end
					end
				end
			end
		end
	end
end

--天赋攻击别人时给自己上BUFF
function SkillManage.attackGiftSelfPro( srcEntity, skill )
	if skill.noattackGift then return end
	if skill.buffSkillInfo then return end--buff触发的技能不要再触发gift了,避免循环skill->attackGiftSelf->buff->buffskill->attackGiftSelf->buff->buffskill->attackGiftSelf
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.attackGift ) then
				--_js('!!!!!')
				if( randomResult( gift.attackGift[2] ) ) then
					local ishp = true
					if( gift.attackGift[4] ) then
						if( gift.attackGift[4] > 0 ) then
							if( srcEntity:gp'hp' < AttrSys.get( srcEntity, 'maxHp' )*gift.attackGift[4]*0.01 ) then
								ishp = false
							end
						else
							if( srcEntity:gp'hp' > -AttrSys.get( srcEntity, 'maxHp' )*gift.attackGift[4]*0.01 ) then
								ishp = false
							end
						end
					end
					--_js('!!!!!2!!!',ishp)
					if( ishp ) then
						local type = gift.attackGift[1]
						local buffGroupID = gift.attackGift[3]
						if( type == 1 ) then
							BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
							SkillManage.giftPaoText( srcEntity, gift )

							--第一个buff生效后触发的第2个buff
							local tartype = gift.attackGift[5]
							if tartype then
								if tartype == 2 then--给所有命中目标加buff
									for _, guid in pairs(srcEntity.hitList) do
										local tarEntity = Entity.byGUID( guid )
										local tarBuffGroupID = gift.attackGift[6]
										BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=tarBuffGroupID, type='gift' } )
									end
								end
							end
						elseif( type == 3 ) then
							--_js('yyy')
							BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
						end
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.attackGift ) then
				if( randomResult( gift.attackGift[2] ) ) then
					local ishp = true
					if( gift.attackGift[4] ) then
						if( gift.attackGift[4] > 0 ) then
							if( srcEntity:gp'hp' < AttrSys.get( srcEntity, 'maxHp' )*gift.attackGift[4]*0.01 ) then
								ishp = false
							end
						else
							if( srcEntity:gp'hp' > -AttrSys.get( srcEntity, 'maxHp' )*gift.attackGift[4]*0.01 ) then
								ishp = false
							end
						end
					end
					if( ishp ) then
						local type = gift.attackGift[1]
						local buffGroupID = gift.attackGift[3]
						if gift.growsys == 'godweapon' then
							if not GodWeapon.checkCanGift(srcEntity,gift.id,gift.godweapon) then return end
						elseif gift.growsys == 'flag' then
							if not _Flag.cangift(srcEntity) then return end
						end

						if( type == 1 ) then
							BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
							-- SkillManage.giftPaoText( srcEntity, gift )

							--第一个buff生效后触发的第2个buff
							local tartype = gift.attackGift[5]
							if tartype then
								if tartype == 2 then--给所有命中目标加buff
									for _, guid in pairs(srcEntity.hitList) do
										local tarEntity = Entity.byGUID( guid )
										local tarBuffGroupID = gift.attackGift[6]
										BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=tarBuffGroupID, type='gift' } )
									end
								end
							end
						elseif( type == 3 ) then
							BuffSys.addSceneBuffGroup( srcEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
						end
						if gift.growsys == 'godweapon' then
							srcEntity.gwGiftCd = _now()
						elseif gift.growsys == 'flag' then
							srcEntity.flagGiftCd = _now()
						end
					end
				end
			end
		end
	end
end
--天赋受到技能攻击时Buff组处理
function SkillManage.getHitGiftPro( srcEntity, tarEntity, skill )
	local type = tarEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( tarEntity.playergift.gift ) then
		for _, id in ipairs( tarEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.getHitGift ) then
				local ishp = true
				if( gift.getHitGift[4] ) then
					if( gift.getHitGift[4] > 0 ) then
						if( tarEntity:gp'hp' < AttrSys.get( tarEntity, 'maxHp' )*gift.getHitGift[4]*0.01 ) then
							ishp = false
						end
					else
						if( tarEntity:gp'hp' > -AttrSys.get( tarEntity, 'maxHp' )*gift.getHitGift[4]*0.01 ) then
							ishp = false
						end
					end
				end

				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(tarEntity) ) then
					isrideattack = false
				end

				if( SkillManage.checkSkill( skill, gift.getHitGift[5] ) and isrideattack and ishp and randomResult( gift.getHitGift[2] ) ) then
					local type = gift.getHitGift[1]
					local buffGroupID = gift.getHitGift[3]
					if( type == 1 ) then
						BuffSys.addBuffGroup( tarEntity, tarEntity, { groupID=buffGroupID, type='gift' } )

						SkillManage.giftPaoText( tarEntity, gift )

						--额外的天赋效果
						if( gift.extGift ) then
							for i, extid in ipairs( tarEntity.dynagift ) do
								local extgift = cfg_gift[ extid ]
								for ii, category in ipairs( gift.extGift ) do
									if( category == extgift.category ) then
										BuffSys.addBuffGroup( tarEntity, tarEntity, { groupID=extgift.extGift[1], type='gift' } )
										break
									end
								end
							end
						end
					elseif( type == 2 ) then
						BuffSys.addBuffGroup( tarEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( tarEntity, tarEntity.zoneguid, buffGroupID, {x=tarEntity:gp'currPos'.x, y=tarEntity:gp'currPos'.y} )
					elseif( type == 4 ) then
						BuffSys.addSceneBuffGroup( tarEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end

	if( tarEntity.dynagift ) then
		for _, id in ipairs( tarEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.getHitGift ) then
				local ishp = true
				if( gift.getHitGift[4] ) then
					if( gift.getHitGift[4] > 0 ) then
						if( tarEntity:gp'hp' < AttrSys.get( tarEntity, 'maxHp' )*gift.getHitGift[4]*0.01 ) then
							ishp = false
						end
					else
						if( tarEntity:gp'hp' > -AttrSys.get( tarEntity, 'maxHp' )*gift.getHitGift[4]*0.01 ) then
							ishp = false
						end
					end
				end
				local isrideattack = true
				if( gift.isneedride and not Ride.isRiding(tarEntity) ) then
					isrideattack = false
				end
				if( SkillManage.checkSkill( skill, gift.getHitGift[5] ) and isrideattack and ishp and randomResult( gift.getHitGift[2] ) ) then
					local type = gift.getHitGift[1]
					local buffGroupID = gift.getHitGift[3]
					if( type == 1 ) then
						BuffSys.addBuffGroup( tarEntity, tarEntity, { groupID=buffGroupID, type='gift' } )

						SkillManage.giftPaoText( tarEntity, gift )

						--额外的天赋效果
						if( gift.extGift ) then
							for i, extid in ipairs( tarEntity.dynagift ) do
								local extgift = cfg_gift[ extid ]
								for ii, category in ipairs( gift.extGift ) do
									if( category == extgift.category ) then
										BuffSys.addBuffGroup( tarEntity, tarEntity, { groupID=extgift.extGift[1], type='gift' } )
										break
									end
								end
							end
						end
					elseif( type == 2 ) then
						BuffSys.addBuffGroup( tarEntity, srcEntity, { groupID=buffGroupID, type='gift' } )
					elseif( type == 3 ) then
						BuffSys.addSceneBuffGroup( tarEntity, tarEntity.zoneguid, buffGroupID, {x=tarEntity:gp'currPos'.x, y=tarEntity:gp'currPos'.y} )
					elseif( type == 4 ) then
						BuffSys.addSceneBuffGroup( tarEntity, srcEntity.zoneguid, buffGroupID, {x=srcEntity:gp'currPos'.x, y=srcEntity:gp'currPos'.y} )
					end
				end
			end
		end
	end
end

--天赋技能受到爆击攻击时给自己上Buff组处理
function SkillManage.getCriGiftPro( srcEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.getcriGift ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.getcriGift, type='gift' } )
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.getcriGift ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.getcriGift, type='gift' } )
			end
		end
	end
end

--天赋技能爆击攻击时给对方上Buff组处理
function SkillManage.criToGiftPro( srcEntity, tarEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.critoGift ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.critoGift, type='gift' } )
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.critoGift ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.critoGift, type='gift' } )
			end
		end
	end
end

--天赋技能爆击攻击时Buff组处理
function SkillManage.criGiftPro( srcEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.criGift ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.criGift, type='gift' } )
			elseif( gift.cridecchangecd and srcEntity.changesys ) then
				if( randomResult( gift.cridecchangecd[1] ) ) then
					local now = os.now()
					--_js('!!!', now,srcEntity.changesys.cdtotime, now-srcEntity.changesys.cdtotime )
					if( now < srcEntity.changesys.cdtotime ) then
						local newcdtotime = srcEntity.changesys.cdtotime - gift.cridecchangecd[2]*1000
						newcdtotime = mathmax( now, newcdtotime )
						srcEntity.changesys.cdtotime = newcdtotime
						CallCSByRole( srcEntity ).UpdateChangeSys{Token=srcEntity.getToken(), Info = { cdtotime = newcdtotime } }
						CallEntity( srcEntity ).UpdateChangeCd{ Info = { cdtotime = newcdtotime } }
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.criGift ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.criGift, type='gift' } )
			end
		end
	end
end

--天赋技能命中时Buff组处理
function SkillManage.hitGiftPro( srcEntity )
	local type = srcEntity:gp'type'
	if( type ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.hitGift ) then
				local per = gift.hitGift[1]
				if( per > 0 ) then
					if( srcEntity:gp'hp' > AttrSys.get( srcEntity, 'maxHp' )*per*0.01 ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.hitGift[2], type='gift' } )
					end
				else
					if( srcEntity:gp'hp' < (-AttrSys.get( srcEntity, 'maxHp' )*per*0.01) ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.hitGift[2], type='gift' } )
					end
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.hitGift ) then
				local per = gift.hitGift[1]
				if( per > 0 ) then
					if( srcEntity:gp'hp' > AttrSys.get( srcEntity, 'maxHp' )*per*0.01 ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.hitGift[2], type='gift' } )
					end
				else
					if( srcEntity:gp'hp' < (-AttrSys.get( srcEntity, 'maxHp' )*per*0.01) ) then
						BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.hitGift[2], type='gift' } )
					end
				end
			end
		end
	end
end

--天赋使用技能的时候闪电链效果
function SkillManage.useSkillLink( srcEntity, category, target )
	if( not target ) then
	elseif( not target.isDeath ) then
		return
	elseif( target:isDeath() ) then
		return
	end

	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillLink and gift.useskillLink[1][category] and randomResult( gift.useskillLink[2] ) ) then
				local eList  = SkillManage.roundTargetSomeEnemy( srcEntity, target, gift.useskillLink[3], gift.useskillLink[4] )
				local info = {}
				local ishaveLink = false
				for _, e in ipairs( eList ) do
					local hp = -math.floor( AttrSys.get(srcEntity, 'att')*gift.useskillLink[5]*0.01 )
					e:modifyHp( srcEntity:gp'guid', hp, nil, 'gift' )
					info[ #info + 1 ] = { guid = e:gp'guid' }
					ishaveLink = true
					srcEntity:onAttack( e )
					e:onGetHit( srcEntity )
				end
				if( ishaveLink ) then
					CallRound( srcEntity ).LinkAttackInfo{ SrcGUID = srcEntity:gp'guid', Info = info }
				end
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillLink and gift.useskillLink[1][category] and randomResult( gift.useskillLink[2] ) ) then
				local eList  = SkillManage.roundTargetSomeEnemy( srcEntity, target, gift.useskillLink[3], gift.useskillLink[4] )
				local info = {}
				local ishaveLink = false
				for _, e in ipairs( eList ) do
					local hp = -math.floor( AttrSys.get(srcEntity, 'att')*gift.useskillLink[5]*0.01 )
					e:modifyHp( srcEntity:gp'guid', hp, nil, 'gift' )
					info[ #info + 1 ] = { guid = e:gp'guid' }
					ishaveLink = true
					srcEntity:onAttack( e )
					e:onGetHit( srcEntity )
				end
				--_js('-----ishaveLink---', ishaveLink)
				if( ishaveLink ) then
					CallRound( srcEntity ).LinkAttackInfo{ SrcGUID = srcEntity:gp'guid', Info = info }
				end
			end
		end
	end
end


--天赋使用技能的时候的BUFF组处理
function SkillManage.useSkillSelfGiftPro( srcEntity, category, skill )
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillGift and gift.useskillGift[1][category] and SkillManage.checkSkill( skill, gift.useskillGift[1] ) and gift.useskillGift[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift[3], type='gift' } )
			end
			if( gift.useskillGift2 and gift.useskillGift2[1][category] and SkillManage.checkSkill( skill, gift.useskillGift2[1] ) and gift.useskillGift2[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift2[3], type='gift' } )
			end
			if( gift.useskillGift3 and gift.useskillGift3[1][category] and SkillManage.checkSkill( skill, gift.useskillGift3[1] ) and gift.useskillGift3[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift3[3], type='gift' } )
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillGift and gift.useskillGift[1][category] and gift.useskillGift[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift[3], type='gift' } )
			end
			if( gift.useskillGift2 and gift.useskillGift2[1][category] and SkillManage.checkSkill( skill, gift.useskillGift2[1] ) and gift.useskillGift2[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift2[3], type='gift' } )
			end
			if( gift.useskillGift3 and gift.useskillGift3[1][category] and SkillManage.checkSkill( skill, gift.useskillGift3[1] ) and gift.useskillGift3[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskillGift3[3], type='gift' } )
			end
		end
	end
end

--天赋使用技能的时候的BUFF组处理
function SkillManage.useSkillTarGiftPro( srcEntity, tarEntity, category )
	if( srcEntity:gp'type' ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillGift and gift.useskillGift[1][category] and SkillManage.checkSkill( skill, gift.useskillGift[1] ) and gift.useskillGift[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift[3], type='gift' } )
			end
			if( gift.useskillGift2 and gift.useskillGift2[1][category] and SkillManage.checkSkill( skill, gift.useskillGift2[1] ) and gift.useskillGift2[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift2[3], type='gift' } )
			end
			if( gift.useskillGift3 and gift.useskillGift3[1][category] and SkillManage.checkSkill( skill, gift.useskillGift3[1] ) and gift.useskillGift3[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift3[3], type='gift' } )
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskillGift and gift.useskillGift[1][category] and SkillManage.checkSkill( skill, gift.useskillGift[1] ) and gift.useskillGift[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift[3], type='gift' } )
			end
			if( gift.useskillGift2 and gift.useskillGift[1][category] and SkillManage.checkSkill( skill, gift.useskillGift2[1] ) and gift.useskillGift2[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift2[3], type='gift' } )
			end
			if( gift.useskillGift3 and gift.useskillGift3[1][category] and SkillManage.checkSkill( skill, gift.useskillGift3[1] ) and gift.useskillGift3[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskillGift3[3], type='gift' } )
			end
		end
	end
end

--天赋使用技能的时候的BUFF组处理,基于伤害值,吸血之类的
function SkillManage.useSkillDamageGiftPro( srcEntity, tarEntity, category, skilldamage )
	if( srcEntity:gp'type' ~= 'role' ) then
		return
	end
	if( srcEntity.playergift.gift ) then
		for _, id in ipairs( srcEntity.playergift.gift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskilldamageGift and (gift.useskilldamageGift[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift[1] ) ) and gift.useskilldamageGift[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskilldamageGift[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift2 and (gift.useskilldamageGift2[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift2[1] ) ) and gift.useskilldamageGift2[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskilldamageGift2[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift and (gift.useskilldamageGift[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift[1] ) ) and gift.useskilldamageGift[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskilldamageGift[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift2 and (gift.useskilldamageGift2[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift2[1] ) ) and gift.useskilldamageGift2[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskilldamageGift2[3], type='gift', skilldamage = skilldamage } )
			end
		end
	end

	if( srcEntity.dynagift ) then
		for _, id in ipairs( srcEntity.dynagift ) do
			local gift = cfg_gift[ id ]
			if( gift.useskilldamageGift and (gift.useskilldamageGift[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift[1] ) ) and gift.useskilldamageGift[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskilldamageGift[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift2 and (gift.useskilldamageGift2[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift2[1] ) ) and gift.useskilldamageGift2[2] == 1 ) then
				BuffSys.addBuffGroup( srcEntity, srcEntity, { groupID=gift.useskilldamageGift2[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift and (gift.useskilldamageGift[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift[1] ) ) and gift.useskilldamageGift[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskilldamageGift[3], type='gift', skilldamage = skilldamage } )
			end
			if( gift.useskilldamageGift2 and (gift.useskilldamageGift2[1][category] or SkillManage.checkSkill( skill, gift.useskilldamageGift2[1] ) ) and gift.useskilldamageGift2[2] == 2 ) then
				BuffSys.addBuffGroup( srcEntity, tarEntity, { groupID=gift.useskilldamageGift2[3], type='gift', skilldamage = skilldamage } )
			end
		end
	end
end

--单一对象，敌人或者友方
function SkillManage.singleTarget( player, target, skill )
	local eList = {}
	if not target:isDeath() and target:isVisible(player) and
		 (CampManage.campRelation( player, target ) == 'enemy' or CampManage.campRelation( player, target ) == 'friend') then
		eList[1] = target
	end
	return eList
end

--目标是友方选取此友方，或者选取自己
function SkillManage.singleFriendOrSelf( player, target, skill )
	local eList = {}
	if CampManage.campRelation( player, target ) == 'friend' and not target:isDeath() and target:isVisible(player) then
		eList[1] = target
	else
		eList[1] = player
	end
	return eList
end

--目标玩家范围内的所有敌对玩家
function SkillManage.roundTargetAllEnemy( player, target, round, maxNum )
	local eList = {}
	if( not target ) then return eList end
	local targetPos = target:gp'currPos'
	local entitysList = CanAttackInSights( target.sights )
	local num = 0
	maxNum = maxNum or 8
	for _, e in pairs( entitysList ) do
		if SkillManage.checkTarget(player, e) then
		-- if( CampManage.campRelation( player, e ) == 'enemy' ) then
			local otherPos = e:gp'currPos'
			local dis = getDistance( targetPos, otherPos )
			dis = dis - player:gp'sizeR' - target:gp'sizeR'
			if not maxNum then
				if dis <= round then eList[ #eList + 1 ] = e end
			else
				if dis <= round and num < maxNum then
					num = num + 1
					eList[ #eList + 1 ] = e
				else
					break
				end
			end
		end
	end
	return eList
end

--得到自己为圆范围内的所有友方单位，包括自己
function SkillManage.roundSelfAllFriend( player, target, attackRange, maxNum )
	local eList = {}
	local selfPos = player:gp'currPos'
	local entitysList = CanAttackInSights( player.sights )
	local num = 0
	maxNum = maxNum or 8
	for _, e in pairs( entitysList ) do
		if CampManage.campRelation( player, e ) == 'friend' and not e:isDeath() and e:isVisible(player) and (e:gp'type' == 'monster' or e:gp'type'=='role') then
			local otherPos = e:gp'currPos'
			local dis = getDistance( selfPos, otherPos )
			dis = dis - player:gp'sizeR' - e:gp'sizeR'
			if not maxNum then
				if dis <= attackRange then eList[ #eList + 1 ] = e end
			else
				if dis <= attackRange and num < maxNum then
					num = num + 1
					eList[ #eList + 1 ] = e
				else
					break
				end
			end
		end
	end
	return eList
end

--得到自己为圆范围内的所有敌方单位
function SkillManage.roundSelfAllEnemy( player, target, attackRange, maxNum )
	local eList = {}
	local selfPos = player:gp'currPos'
	local entitysList = CanAttackInSights( player.sights )
	local num = 0
	maxNum = maxNum or 8
	for _, e in pairs( entitysList ) do
		-- if CampManage.campRelation( player, e ) == 'enemy' then
		if SkillManage.checkTarget(player, e) then
			local otherPos = e:gp'currPos'
			local dis = getDistance( selfPos, otherPos )
			dis = dis - player:gp'sizeR' - e:gp'sizeR'
			if dis <= attackRange then
				if not maxNum then
					eList[ #eList + 1 ] = e
				else
					if num < maxNum then
						num = num + 1
						eList[ #eList + 1 ] = e
					else
						break
					end
				end
			end
		end
	end
	return eList
end

--得到自己为圆范围内的所有可攻击对象
function SkillManage.roundSelfAllEntity( player, target, attackRange )
	local eList, fList = {}, {}
	local entitysList = CanAttackInSights( player.sights )
	for _, e in pairs( entitysList ) do
		local otherPos = e:gp'currPos'
		local dis = getDistance( player:gp'currPos', otherPos )
		dis = dis - player:gp'sizeR' - e:gp'sizeR'
		if( dis <= attackRange ) then
			if SkillManage.checkTarget(player, target) then
				eList[ #eList + 1 ] = e
			else
				fList[ #fList + 1 ] = e
			end
		end
	end
	--xmz( '--------roundSelfAllEntity------', #eList )
	return eList, fList
end

--得到目标点范围内的所有敌对玩家
function SkillManage.roundPointAllEnemy( player, point, attackRange )
	local eList = {}
	if( not point ) then return eList end
	local entitysList = CanAttackInSights( player.sights )
	for _, e in pairs( entitysList ) do
		if( CampManage.campRelation( player, e ) == 'enemy' ) then
			--xmz( '--------roundPointAllEnemy-----', getDistance( e.currPos, point ), attackRange )
			local dis = getDistance( e:gp'currPos', point )
			dis = dis - e:gp'sizeR'
			if( dis <= attackRange ) then
				eList[ #eList + 1 ] = e
			end
		end
	end
	--xmz( '--------roundPointAllEnemy------', #eList )
	return eList
end

--单一敌人
function SkillManage.singleEnemy( src, target, skill )
	local eList = {}
	if SkillManage.checkTarget(src, target) then
		eList[1] = target
	end
	return eList
end
--得到自己为圆范围内的一定数量的敌方单位
function SkillManage.roundSelfSomeEnemy( src, target, attackRange, maxNum )
	local eList = {}
	local srcPos = src:gp'currPos'
	local list = src:getCanAttacks( true )
	local num = 0
	maxNum = maxNum or 8
	for guid, e in pairs( list ) do
		if SkillManage.checkTarget(src, e) and num < maxNum then
			local dis = getDistance( srcPos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= attackRange then
				num = num + 1
				eList[ num ] = e
			end
		end
	end

	return eList
end
--得到目标对象范围内的有限数量的敌对玩家
function SkillManage.roundTargetSomeEnemy( src, target, skill, attackRange, maxNum )
	local eList = {}

	local tarPos = target:gp'currPos'
	local list = target:getCanAttacks( true )
	local num = 0
	maxNum = maxNum or 8
	if( CampManage.campRelation( src, target ) == 'enemy' ) then
		num = num + 1
		eList[ num ] = target
	end

	for guid, e in pairs( list ) do
		if SkillManage.checkTarget(src, e) and num < maxNum then
			local dis = getDistance( tarPos, e:gp'currPos' )
			dis = dis - target:gp'sizeR' - e:gp'sizeR'
			if dis <= attackRange  then
				num = num + 1
				eList[ num ] = e
			end
		end
	end
	return eList
end

----算法描述,先构造一个表示dir到_Vector2.new( 1, 0 )的旋转矩阵，然后把矩阵转到正X、Y坐标里去判断
-- -- additional表示是否将矩形前方的相当于矩形的宽的长度计算在内
function SkillManage.lineSomeEnemy( src, tar, point, length, width, maxNum, additional, rangefeedback )
	if additional then length = length + width end
	local srcpos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local p = _Vector2.new( point.x, point.y )
	local dir = _Vector2.sub( p, srcpos )
	dir:normalize()
	local temp = _Vector2.new( 1, 0 )
	local cosdir = (dir.x*temp.x + dir.y*temp.y)/dir:magnitude()
	local r = math.acos( cosdir )
	local mat = _Matrix2D.new()
	if( dir.y >=0 ) then
		mat:setRotation( -r )
	else
		mat:setRotation( r )
	end

	local eList = {}
	--_js( '!!!!!!!!', point[1], point[2] )

	local num = 0
	local haveselect = nil
	-- if( tar and CampManage.campRelation( src, tar ) == 'enemy' ) then
	-- 	local dis = getDistance( srcpos, tar:gp'currPos' )
	-- 	dis = dis - src:gp'sizeR' - tar:gp'sizeR'
	-- 	if dis <= length then
	-- 		num = num + 1
	-- 		eList[ num ] = tar
	-- 		haveselect = tar:gp'guid'
	-- 	end
	-- end
	local sels = {}
	maxNum = maxNum or 8
	local list = src:getCanAttacks( true )
	for guid, e in pairs( list ) do
		--_js( '------lineSomeEnemy---', e:gp'guid', num, maxNum, length, width, getDistance( srcpos, e:gp'currPos' ) )
		if SkillManage.checkTarget(src, e) and num < maxNum and haveselect ~= e:gp'guid' then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= length then
				local epos = _Vector2.new( e:gp'currPos'.x, e:gp'currPos'.y )
				local difv = _Vector2.sub( epos, srcpos )
				difv = mat:apply( difv )
				-- _js('---',difv.x, difv.y )
				if difv.x > 0 and difv.x < length and difv.y > - width / 2 and difv.y < width / 2 then
					num = num + 1
					sels[e] = true
					eList[ num ] = e
				end
			end
		end
	end

	-- 附加圆形范围内目标
	for guid, e in pairs( list ) do
		if SkillManage.checkTarget(src, e) and num < maxNum and haveselect ~= e:gp'guid' and not sels[e] then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= (rangefeedback or SectorAppendRange) then
				num = num + 1
				sels[e] = true
				eList[ num ] = e
			end
		end
	end

	return eList
end

--扇形攻击, r为半径, maxNum为命中数量上限, angle为扇形角度
--先算出圆内的，然后拿e的位置向量与dir通过点积算夹角，通过夹角来判断
function SkillManage.sectorSomeEnemy( src, tar, point, r, maxNum, angle, backdis, rangefeedback )
	local eList = {}
	local haveselect = nil
	local num = 0
	local srcpos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local startPos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local p = _Vector2.new( point.x, point.y )
	local dir = _Vector2.sub( p, srcpos )
	dir:normalize()
	if backdis then --考虑将扇形的中心点往攻击朝向反方向移动backdis
		local antidir = _Vector2.new(-dir.x, -dir.y)
		antidir = _Vector2.mul( antidir, backdis, tempV1 )
		startPos = _Vector2.add(startPos, antidir, tempV1 )
	end
	local list = src:getCanAttacks( true )
	local anglev = math.cos(math.rad(angle/2))
	anglev = math.pow(anglev, 2)
	local sels = {}
	maxNum = maxNum or 8
	for guid, e in pairs( list ) do
		if SkillManage.checkTarget(src, e) and num < maxNum and haveselect ~= e:gp'guid' then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= r then
				local epos = _Vector2.new( e:gp'currPos'.x, e:gp'currPos'.y )
				local evect = _Vector2.sub( epos, startPos )
				evect:normalize()
				local v1 = (dir.x*evect.x + dir.y*evect.y)
				local v2 = (dir.x^2 + dir.y^2)*(evect.x^2 + evect.y^2)
				if( v2 ~= 0 ) then
					local cosvalsqrt = v1 > 0 and ((v1*v1)/v2) or (-(v1*v1)/v2)--优化过的，不需要算开根号以及acos
					-- _js('guiid', cosvalsqrt, anglev)
					if( cosvalsqrt > anglev ) then	--cos(45°)^2 = 0.5
						num = num + 1
						sels[e] = true
						eList[ num ] = e
					end
				end
			end
		end
	end
	--[[
	-- 附加圆形范围内目标
	for guid, e in pairs( list ) do
		if SkillManage.checkTarget(src, e) and num < maxNum and haveselect ~= e:gp'guid' and not sels[e] then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= (rangefeedback or SectorAppendRange) then
				num = num + 1
				sels[e] = true
				eList[ num ] = e
			end
		end
	end
	]]

	return eList
end

function SkillManage.useRangeSelect( src, target, skill )
	local eList, fList = {}, {}
	--根据不同的技能作用范围得到技能作用玩家数组
	local round = skill.useRangeParm1
	if ROBOTTEST then round = round + 100 end --机器人测试把技能范围改大
	if( skill.useRange == CFG_USERANGES.SINGLE_ENEMY or	skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE
		) then
		eList = SkillManage.singleEnemy( src, target, skill )
	elseif( skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND ) then
		eList = SkillManage.singleTarget( src, target, skill )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL ) then
		if( src.ridewSkillData ) then
			round = round + src.ridewSkillData[2]
		end
		eList = SkillManage.roundTargetAllEnemy( src, target, round )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER ) then
		eList = SkillManage.roundTargetSomeEnemy( src, target, skill, round, skill.useRangeParm2 )
	elseif( skill.useRange == CFG_USERANGES.SELF ) then
		eList[1] = src
	elseif( skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND ) then
		eList = SkillManage.singleFriendOrSelf( src, target, skill )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND ) then
		if( src.ridewSkillData ) then
			round = round + src.ridewSkillData[2]
		end
		eList = SkillManage.roundSelfAllFriend( src, src, round )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY ) then
		if( src.ridewSkillData ) then
			round = round + src.ridewSkillData[2]
		end
		eList = SkillManage.roundSelfAllEnemy( src, target, round )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY ) then
		eList, fList = SkillManage.roundSelfAllEntity( src, target, round )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY ) then
		eList = SkillManage.roundSelfSomeEnemy( src, target, round, skill.useRangeParm2 )
	end
	return eList, fList
end
---------------------------------------------技能逻辑----------------------------
--战斗状态的处理
function SkillManage.proCombatState( srcEntity, tarEntity, skill )
	local onAttack = true
	if( CampManage.campRelation( srcEntity, tarEntity ) == 'friend' ) then--对友方不产生攻击行为
		onAttack = false
	elseif( srcEntity == tarEntity ) then--自己对自己不产生攻击行为
		onAttack = false
	end

	if( onAttack ) then
		if( srcEntity:gp'type' == 'role' ) then
			if( srcEntity:gp'combatState' == COMBATSTATE.COMBAT ) then
				srcEntity:updateCombat()
			elseif( srcEntity:gp'combatState' == COMBATSTATE.IMCOMBAT ) then
				srcEntity:changeCombatState( COMBATSTATE.COMBAT )
				srcEntity:updateCombat()
			end
		end

		if( tarEntity:gp'type' == 'role' ) then
			if( tarEntity:gp'combatState' == COMBATSTATE.COMBAT ) then
				tarEntity:updateCombat()
			elseif( tarEntity:gp'combatState' == COMBATSTATE.IMCOMBAT ) then
				tarEntity:changeCombatState( COMBATSTATE.COMBAT )
				tarEntity:updateCombat()
			end
		end
	end
end

-- 单次攻击单个目标的逻辑
function SkillManage.specialEffect(srcEntity, tarEntity, skill, effectInfo, value)
	if skill.speEffect.suck then --吸血
		local suckcfg = skill.speEffect.suck
		if suckcfg.type == 2 then --百分比伤害
			local val = toint(value*suckcfg.val/1000)
			srcEntity:modifyHp( srcEntity:gp'guid', val, nil, 'suckreturn')
		elseif suckcfg.type == 3 then
			srcEntity:modifyHp( srcEntity:gp'guid', suckcfg.val, nil, 'suckreturn')
		end
	elseif skill.speEffect.totem then --图腾驱散
		local totemcfg = skill.speEffect.totem
		local needtotem = {}
		for _, v in next, totemcfg do
			needtotem[v.buffid] = v.skillid
		end
		-- for k, buffdata in next, tarEntity:gp'buffGroupList' or EMPTY do
		local zone = tarEntity:getZone()
		if zone then
			for k, buffdata in next, zone.buffGroupList or EMPTY do
				if buffdata.srcguid and buffdata.srcguid == tarEntity:gp'guid' then
					for i, buff in inext, buffdata.runBuff or EMPTY do
						if needtotem[buff.id] then
							local cfgbuff = cfg_buff[ buff.id ]
							local logicID = cfgbuff.logicID
							local buffgroupdata = { buffdata, buff  }
							buffs[ logicID ].endBuff(buffgroupdata)
							if srcEntity:gp'type' == 'role' then --考虑竞技场对方
								srcEntity:clearCd( needtotem[buff.id] )
							end
						end
					end
				end
			end
		end
	elseif skill.speEffect.tardam then --以目标为中心对周围人造成伤害
		local tardamcfg = skill.speEffect.tardam
		local r, maxnum = tardamcfg.r, tardamcfg.maxn
		local eList = SkillManage.roundTargetAllEnemy( srcEntity, tarEntity, r, maxnum )
		local val = 0
		if tardamcfg.type == 1 then --百分比伤害
			val = toint(value*tardamcfg.val/1000)
		elseif tardamcfg.type == 2 then --固定数值伤害
			val = tardamcfg.val
		end
		for _, e in next, eList do
			e:modifyHp( srcEntity:gp'guid', -val, nil, 'tardamreturn')
		end
	elseif skill.speEffect.clearcd then --清除友军技能cd
		if srcEntity:gp'type' == 'role' and tarEntity:gp'type' == 'role' and Team.same( srcEntity:gp'guid', tarEntity:gp'guid' ) then
			if skill.speEffect.clearcd.cd then --有时间限制
				if tarEntity.clearcdtime and _now() - tarEntity.clearcdtime < skill.speEffect.clearcd.cd then return end
				skill.speEffect.clearcdtime = _now()
			end
			for cguid, v in next, tarEntity.cdManager.cds do
				tarEntity:cancelCD(cguid)
			end
		end
	elseif skill.speEffect.tardamratio then --几率百分比 1固定值，2千分比(最大血量)
		local ratioCfg = skill.speEffect.tardamratio
		local ratio,effect,stype = ratioCfg.ratio,ratioCfg.effect,ratioCfg.type
		local random = math.random(0,1000)
		if random <= ratio and SkillManage.checkTarget(srcEntity, tarEntity) then
			local val = stype == 1 and effect or toint(tarEntity:gp'maxHp'*effect/1000)
			local death, trueValue, islose, oldhp = tarEntity:modifyHp( srcEntity:gp'guid', -val, nil, 'tardamratio',true)
			if not islose then
				effectInfo[ #effectInfo + 1 ] = { 1, {}, -val, trueValue, oldhp, 'skill',}
			end
		end
	elseif skill.speEffect.cleandebuff then --清除友军debuff
		if srcEntity:gp'type' == 'role' and tarEntity:gp'type' == 'role' and Team.same( srcEntity:gp'guid', tarEntity:gp'guid' ) then
			local tbglist = tarEntity:gp'buffGroupList'
			for i, buffdata in next, tbglist do
				if cfg_buffgroup[ buffdata.groupID ].effectype == 'bad' then
					if not srcEntity.cleandebuffharms then srcEntity.cleandebuffharms = {} end
					srcEntity.cleandebuffharms[skill.id] = srcEntity.cleandebuffharms[skill.id] or 0
					if srcEntity.cleandebuffharms[skill.id] >= skill.speEffect.cleandebuff.maxadd then return end
					if next(buffdata.runBuff) then
						for i, buff in inext, buffdata.runBuff do
							local cfgbuff = cfg_buff[ buff.id ]
							local logicID = cfgbuff.logicID
							local buffgroupdata = { buffdata, buff  }
							buffs[ logicID ].endBuff(buffgroupdata)
						end
						local baseadd = skill.speEffect.cleandebuff.baseharm
						if skill.type == 'xp' and src:gp'type' == 'role' then --军师技,随等级提升概率
							-- skilllv = Advisor.getSkillLevel(srcEntity, skill)
							local _
							_, skilllv = Advisor.getXpSkill( src )
							baseadd = baseadd+skill.speEffect.cleandebuff.addharm*skilllv
						end
						srcEntity.cleandebuffharms[skill.id] = srcEntity.cleandebuffharms[skill.id] + baseadd
					end
				end
			end
		end
	end
	return value
end

-- 单个攻击总的逻辑
function SkillManage.specialEffectFinal(srcEntity, tarEntity, skill, effectInfo, value)
	if skill.speEffectFinal.suck then --吸血
		local suckcfg = skill.speEffectFinal.suck
		if suckcfg.type == 1 then
			local val = toint(value*suckcfg.val/1000)
			srcEntity:modifyHp( srcEntity:gp'guid', val, nil, 'suckreturn')
		elseif suckcfg.type == 3 then
			srcEntity:modifyHp( srcEntity:gp'guid', suckcfg.val, nil, 'suckreturn')
		end
	-- elseif skill.totem then --图腾驱散
	-- elseif skill.speEffect.tardam then --以目标为中心对周围人造成伤害

	end
end

-- 根据距离增加附加伤害
function SkillManage.rangeAddharm(srcEntity, tarEntity, skill, value)
	local rangeharm = skill.speEffect.rangeharm
	local rangerate = rangeharm.disrate
	local harmadd = rangeharm.harmadd
	local dis = getDistance(srcEntity:gp'currPos', tarEntity:gp'currPos')
	if dis <= rangerate*skill.useRangeParm1 then
		value = toint(value*harmadd/100)
	end
	return value
end

function SkillManage.returnDamage( srcEntity, tarEntity, effectInfo ,skill,srcskill)
	local basedam = SkillManage.attValue(tarEntity,skill,tarEntity,srcskill)
	local flag = { returnDamage=true }
	local buffcfg = cfg_buff[srcEntity.returnDamageId]
	local returnPro = (buffcfg.extAttrData or 0)/1000
	local damage = toint(basedam*returnPro)
	damage = damage + (buffcfg.effectData or 0)
	damage = mathmax(1, damage)
	local skillid
	for k, v in next, srcEntity:gp'buffGroupList' or EMPTY do
		for i, buff in inext, v.runBuff or EMPTY do
			if buff.id == srcEntity.returnDamageId and v.extdata and v.extdata.skill then
				skillid = v.extdata.skill
			end
		end
	end

	local death, trueValue, islose, oldhp = tarEntity:modifyHp( srcEntity:gp'guid', -damage, flag, 'buff', true)
	if( not islose ) then
		-- effectInfo[ #effectInfo + 1 ] = { attr = 'returnDamage', flag = flag, src = 'buff', value = -damage, truevalue = trueValue, skillid=skillid }
		effectInfo[ #effectInfo + 1 ] = { 3, flag, -damage, trueValue, oldhp, 'buff', skillid }
	end

	if( death ) then
		-- effectInfo[ #effectInfo + 1 ] = { attr = 'returnTodeath' }
		effectInfo[ #effectInfo + 1 ] = { 4 }
		--if( srcEntity:gp'type' == 'role' ) then
			--srcEntity:updateSerAttack()
		--end
	end
end

function SkillManage.addBuffStateHarm(srcEntity, tarEntity, damage, skill)
	if tarEntity.buffstates then
		for sname, v in next, tarEntity.buffstates do
			if sname == skill.stateharm.state then
				if skill.stateharm.valx then
					damage = damage*(1+skill.stateharm.valx/1000)
				end
				if skill.stateharm.val then
					damage = damage+skill.stateharm.val
				end
			end
		end
	end
	return damage
end

-- 护盾, 多个共存的情况下按获得时间顺序使用
function SkillManage.shieldDamage(srcEntity, tarEntity, damage)
	for i=1, #tarEntity.shieldbuffs do
		local value = tarEntity.shieldbuffs[i][2]
		if value > damage then
			tarEntity.shieldbuffs[i][2] = value - damage
			damage = 1
			break
		else
			damage = damage - value
			tarEntity.shieldbuffs[i][2] = 0
			BuffSys.closeByGUID( tarEntity, tarEntity.shieldbuffs[i][1] )
		end
	end
	return damage
end

function SkillManage.sleepEffect( srcEntity, tarEntity, damage)
	if damage>=0 then return end
	if tarEntity.buffstates and tarEntity.buffstates['sleep'] then
		local closeguid = {}
		for k,v in next,tarEntity:gp'buffGroupList' do
			-- for kk,vv in v do
			-- 	cfg_buffgroup
			-- end
			for kk,vv in pairs( v.runBuff )do
				local cfg = Cfg.cfg_buff[ vv.id ]
				if cfg.effect == 'sleep' then
					closeguid[#closeguid+1]=v.guid
					break
				end
			end
		end
		for _,v in inext,closeguid do
			BuffSys.closeByGUID( tarEntity, v )
		end
	end
	-- for i,v in ipairs(tarEntity.sleep or EMPTY) do
	-- 	BuffSys.closeByGUID( tarEntity, tarEntity.sleep[i][1] )
	-- end
end
-- 吸血buff, 多个共存的情况下叠加
function SkillManage.suckBuff( srcEntity, tarEntity, damage )
	if damage>0 then return end
	if not srcEntity or not srcEntity.suck then return end
	local val1, val2 = 0, 0
	for i, effect in ipairs(srcEntity.suck) do
		val1 = val1 + effect[2]
		val2 = val2 + effect[3]
	end
	local hp = val1 + val2 * (-damage) / 1000
	srcEntity:modifyHp( srcEntity:gp'guid', hp, nil, 'suckBuff')
end
-- aoe反伤
function SkillManage.aoeReverse(entity, srcEntity, buffid)
	local buffcfg = cfg_buff[ buffid ]
	local r, maxNum = buffcfg.dataArray[1], buffcfg.dataArray[2]
	local value = buffcfg.effectData or 0
	if buffcfg.extAttr then
		value = value + AttrSys.get( entity, buffcfg.extAttr ) * buffcfg.extAttrData * 0.001
	end
	local eList = SkillManage.roundSelfAllEnemy( entity, nil, r, maxNum )
	for _, e in next, eList do
		e:modifyHp( entity:gp'guid', -value, nil, 'aoeReverse')
	end
end

function SkillManage.skillExtAttr(skill, attr)
	if not skill.extattrs then return 0 end
	for i, attname in next, skill.extattrs do
		if attname == attr then
			return skill.extvals[i]/100
		end
	end
	return 0
end

function SkillManage.getOtherAttr( entity, skill, attr )
	return 0
end

-- 计算防御减免
-- 防御减免=min(目标防御/(目标防御+目标防御lv系数)*防御参数1+防御参数2，防御减免上限参数)
function SkillManage.defSubPro(srcEntity, tarEntity, skill)
	if tarEntity:gp"type" ~= 'role' then
		local mon = cfg_mon[tarEntity:gp'id']
		return mon.defrate
	else
		local job = tarEntity:gp"job"
		local level = tarEntity:gp"level"
		local cfg = Cfg.cfg_baseattr[job][level]
		local defval = AttrSys.get(tarEntity, 'def')
		--local defsubValue = (defval/(defval+cfg.defparam)*cfg_formula[1].value+cfg_formula[2].value)
		local defsubValue = (defval/(defval+1.86*125))
		return mathmin(defsubValue, cfg_formula[3].value)
	end
end

--计算受击着闪避率，如命中返回true，否则返因false
--公式1:min(max((（系数1+系数2*受击者等级修正）*受击者dodge/（受击者dodge+攻击者hit+系数3）+受击者dodgegerate-攻击者hitrate),0)，系数4）
function SkillManage.hitPro( srcEntity, tarEntity, skill )
	if srcEntity.neverHit then -- 必定miss的debuff
		return false
	end

	local srcHit = AttrSys.get(srcEntity, 'hit')
	local tarDodge = AttrSys.get( tarEntity, 'dodge' )
	local srcHitrate = AttrSys.get( srcEntity, 'hitrate')
	local tarDodgerate = AttrSys.get( tarEntity, 'dodgerate')
	local tarlv = tarEntity:gp'level'
	local lvparam = Cfg.cfg_levelup[tarlv] and Cfg.cfg_levelup[tarlv].formulapara1 or Cfg.cfg_levelup[1].formulapara1
	local val = (cfg_formula[1].value+cfg_formula[2].value*lvparam)*tarDodge/(tarDodge+srcHit+cfg_formula[3].value) + tarDodgerate - srcHitrate
	local valm = mathmax(val, 0)
	local value = mathmin(val, cfg_formula[4].value)
	local ret = randomResult( value*100 ) --闪避成功
	return not ret
end

--计算暴击，如暴击返回true，否则返因false
--公式2:min(（系数5+系数6*攻击者等级修正）*攻击者cri/（攻击者cri+受击者defCri+系数7）+攻击者crirate-受击者goodluck，系数8）
function SkillManage.criPro( srcEntity, tarEntity, skill )
	if tarEntity.benumb then return true end --麻痹后必暴击
	if tarEntity.absbecri then return true end --必被暴击
	if srcEntity.abscri and srcEntity.abscri[1] > 0 then --必然暴击
		srcEntity.abscri[1] = srcEntity.abscri[1] - 1
		if srcEntity.abscri[1] <= 0 then --暴击次数用完
			for k, buffdata  in next, srcEntity:gp'buffGroupList' or EMPTY do
				for i, buff in inext, buffdata.runBuff or EMPTY do
					if srcEntity.abscri and buff.id == srcEntity.abscri[2] and buffdata.totalTime > 0 then 		--TODO 临时不报错的判断， 需要处理中多次必暴击buff
						local cfgbuff = cfg_buff[ buff.id ]
						local logicID = cfgbuff.logicID
						local buffgroupdata = { buffdata, buff  }
						buffs[ logicID ].endBuff(buffgroupdata)
					end
				end
			end
		end
		return true
	end

	local srcCri = AttrSys.get(srcEntity, 'cri')
	local srcCrirate = AttrSys.get(srcEntity,'crirate')
	local tarDefCri = AttrSys.get(tarEntity, 'defCri')
	local tarGoodLuck = AttrSys.get(tarEntity, 'goodluck')
	local srclv = srcEntity:gp'level'
	local lvparam = Cfg.cfg_levelup[srclv] and Cfg.cfg_levelup[srclv].formulapara1 or Cfg.cfg_levelup[1].formulapara1
	local val = (cfg_formula[5].value+cfg_formula[6].value*lvparam)*srcCri/(srcCri+tarDefCri+cfg_formula[7].value) + srcCrirate - tarGoodLuck
	local value = mathmin(val, cfg_formula[8].value)
	local ret = randomResult( value*100 )
	return ret
end

-- 攻击者暴伤率
-- 公式3:max（系数9+攻击者criValue-受击者subCri，系数10）
function SkillManage.finalCriValue(srcEntity, tarEntity, skill)
	local crivalue = AttrSys.get(srcEntity, 'criValue')
	local subcri = AttrSys.get(tarEntity, 'subCri')
	return mathmax(cfg_formula[9].value+crivalue - subcri, cfg_formula[10].value)
end

-- 获取攻击者技能伤害值(包含技能系数和附加伤害)
-- 公式4:攻击者玩家att*技能基础伤害百分比+技能伤害附加固定值
function SkillManage.attValue(srcEntity, skill, tarEntity, srcskill, leadindex)
	if skill.type and skill.type == 'nohurt' then return 0 end
	local isadvr = false
	if srcEntity:gp'type' == 'advisor' then
		isadvr = true
		srcEntity = srcEntity:getHost()
		if not srcEntity then return 0 end
	end
	local srcAtt = AttrSys.get(srcEntity, 'att')
	local skillcoe = 1--玩家技能基础伤害百分比
	local skilldam = 0--技能伤害附加固定值
	local skilllv, skillid = SkillManage.getSkillLevel(srcEntity, skill, srcskill)
	if not skilllv then return 0 end
	local cfglvup = Cfg.cfg_skill_lvup[skill.id]
	if cfglvup then
		local cfgcoe = leadindex and skill.skillcoes and cfglvup[skill.skillcoes[leadindex]] or cfglvup.skillcoe
		local cfgdamage = leadindex and skill.skilldamages and cfglvup[skill.skilldamages[leadindex]] or cfglvup.skilldamage
		skillcoe = GetSkillArg('skillcoe', skilllv, cfgcoe) or skillcoe
		skilldam = cfgdamage and GetSkillArg('skilldamage', skilllv, cfgdamage) or 0
	end
	local basevalue = (srcAtt*skillcoe + skilldam)
	--技能增伤
	if srcEntity.addskilldamage and srcEntity.addskilldamage[skill.id] and srcEntity.addskilldamage[skill.id][3] > 0 then
		basevalue = basevalue * (1 + srcEntity.addskilldamage[skill.id][1] or 0) + (srcEntity.addskilldamage[skill.id][2] or 0)
		srcEntity.addskilldamage[skill.id][3] = srcEntity.addskilldamage[skill.id][3] - 1
		if srcEntity.addskilldamage[skill.id][3] <= 0 then
			local logicID = cfg_buff[ srcEntity.addskilldamage[skill.id][4][2].id ].logicID
			buffs[ logicID ].endBuff(srcEntity.addskilldamage[skill.id][4] )
		end
	end
	-- 军师xp技伤害加成
	if isadvr and skill.type == 'xp' then
		local xpskilldam = AttrSys.get( srcEntity, 'xpskilldamadd')
		basevalue = basevalue * (1 + xpskilldam)
	end
	return toint(basevalue)
end

-- 受击者最终护甲
-- 公式5:max(受击者def-受击者def*攻击者subdefrate,0)
function SkillManage.finalDef(srcEntity, tarEntity, skill)
	local tarDef = AttrSys.get(tarEntity, 'def')
	local srcSubDefRate = AttrSys.get(srcEntity, 'subdefrate')
	return mathmax(toint(tarDef - tarDef*srcSubDefRate), 0)
end

--受击者减伤
--公式6:min（受击者最终护甲*受击者护甲修正*系数15*2*（攻击者技能伤害/受击者最终护甲）/（系数16+攻击者技能伤害/受击者最终护甲），受击者最终护甲*受击者护甲修正*系数15）
function SkillManage.subDamage(srcEntity, tarEntity, skill, srcAtt)
	local att = srcAtt or SkillManage.attValue(srcEntity, skill)
	local tarlv = tarEntity:gp'level'
	local lvparam = Cfg.cfg_levelup[tarlv] and Cfg.cfg_levelup[tarlv].formulapara3 or Cfg.cfg_levelup[1].formulapara3
	local finaldef = SkillManage.finalDef(srcEntity, tarEntity, skill)
	--local val1 = (finaldef*lvparam*cfg_formula[15].value*2*(att/finaldef))/(cfg_formula[16].value+att/finaldef)
	--local val2 = finaldef*lvparam*cfg_formula[15].value
	--return mathmin(val1, val2)
	--*************************************************临时修改by褚智勇**********************************************************
	--新战斗公式改为 减伤率 = 防 / (攻击方攻击 + 2*防)
	att = AttrSys.get(srcEntity, 'att')
	--Log.sys("SkillManage.subDamage att = "..att.."  finaldef = "..finaldef)
	local val = finaldef / (att + 2*finaldef)
	return val
	--**************************************************************************************************************************
end

-- 受击者免伤率
-- 公式7:（（系数11+系数12*受击者等级修正）*受击者最终护甲/（受击者最终护甲+受击者投放修正*系数13+系数14））+受击者格挡减伤率
function SkillManage.avoidRate(srcEntity, tarEntity, skill)
	--local srclv = srcEntity:gp'level'
	local tarlv = tarEntity:gp'level'
	local lvparam = Cfg.cfg_levelup[tarlv] and Cfg.cfg_levelup[tarlv].formulapara1 or Cfg.cfg_levelup[1].formulapara1
	local finaldef = SkillManage.finalDef(srcEntity, tarEntity, skill)
	local tarlvparam = Cfg.cfg_levelup[tarlv] and Cfg.cfg_levelup[tarlv].formulapara2 or Cfg.cfg_levelup[1].formulapara2
	--local value = ((cfg_formula[11].value+cfg_formula[12].value*lvparam)*finaldef)/(finaldef+tarlvparam*cfg_formula[13].value+cfg_formula[14].value)
	--*************************************************临时修改by褚智勇**********************************************************
	--新战斗公式改为 免伤率 = 防御 / (该等级段标准防御+3*防御)，到时候标准防御要配表
	local value = finaldef / (500+3*finaldef)
	local isblock = SkillManage.blockPro(tarEntity)
	if isblock then value = value + AttrSys.get(tarEntity, 'subDamage') end
	return value, isblock
	--**************************************************************************************************************************
end

--受击者最终减伤
--公式8:min（受击者免伤率*攻击者技能伤害+受击者减伤值，系数17*攻击者技能伤害）
function SkillManage.finalSubDamage(srcEntity, tarEntity, skill, srcAtt)
	local att = srcAtt or SkillManage.attValue(srcEntity, skill, tarEntity)
	local avoidrate, isblock = SkillManage.avoidRate(srcEntity, tarEntity, skill)
	local subdamage = SkillManage.subDamage(srcEntity, tarEntity, skill, srcAtt)
	--return mathmin(avoidrate*att+subdamage, cfg_formula[17].value*att), isblock
	--*************************************************临时修改by褚智勇**********************************************************
	--最终免伤值 = 攻击 * (免伤率 + 减伤率)
	--Log.sys("SkillManage.finalSubDamage avoid percent = "..avoidrate + subdamage)
	return att * (avoidrate + subdamage),isblock
	--***************************************************************************************************************************
end

-- 受击者群攻减免比例
-- 公式9 if（攻击者群体技能、受击者非主要目标，max(（100%-受击者aoeSubRate）,0)，1）
function SkillManage.aoeSubRate(srcEntity, tarEntity)
	local aoesubrate = AttrSys.get(tarEntity, 'aoeSubRate')
	local value = 1-aoesubrate - cfg_formula[23].value
	return mathmax(value, 0)
end

--计算格挡，如果格挡返回true,否则返回false
function SkillManage.blockPro( tarEntity )
	local wardvalue = AttrSys.get(tarEntity, 'wardValue')
	local ret = randomResult( wardvalue*100 )
	return ret
end

-- 攻击者真实伤害对冲结果
-- 公式29 攻击者absAtt-受击者finalSubDamage
function SkillManage.absAttDamage(srcEntity, tarEntity, skill)
	local absatt = AttrSys.get(srcEntity, 'absAtt')
	local finalsubdam = AttrSys.get(srcEntity, 'finalSubDamage')
	return absatt - finalsubdam
end

-- 最终综合强度
-- 公式30 攻击者军师强度对冲结果+攻击者武将强度对冲结果
function SkillManage.finalAddRate(srcEntity, tarEntity, skill)
	local isadvr = srcEntity:gp'type' == 'advisor'
	if isadvr and skill.type == 'xp' then
		return SkillManage.advisorAddRate(srcEntity, tarEntity, skill)
	elseif skill.type == 'generals' then
		return SkillManage.generalAddRate(srcEntity, tarEntity, skill)
	end
	return 0
end

-- 攻击者军师强度对冲结果
-- 公式34 max（系数21*（攻击者军师强度advRes-受击者军师抗性subadvRes），0)
function SkillManage.advisorAddRate(srcEntity, tarEntity, skill)
	local advRes = AttrSys.get( srcEntity, 'advRes')
	local subadvRes = AttrSys.get( tarEntity, 'subadvRes')
	local value = cfg_formula[21].value*(advRes - subadvRes)
	return mathmax(value, 0)
end

-- 攻击者武将强度对冲结果
-- 公式35 max（系数22*（攻击者武将强度warriorRes-受击者武将抗性subwarriorRes），0）
function SkillManage.generalAddRate(srcEntity, tarEntity, skill)
	local warriorRes = AttrSys.get( srcEntity, 'warriorRes')
	local subwarriorRes = AttrSys.get( tarEntity, 'subwarriorRes')
	local value = cfg_formula[22].value*(warriorRes - warriorRes)
	return mathmax(value, 0)
end

-- 计算攻击者伤害增幅
-- 公式36 max（（1+攻击者addharm-受击者originSubDamage)，0）
function SkillManage.damageAddHarm(srcEntity, tarEntity, skill)
	local addharm = AttrSys.get(srcEntity, 'addharm')
	local subdam = AttrSys.get(tarEntity, 'subharm')
	return mathmax((1+addharm-subdam), 0)
end

-- 攻击者武将数值增伤
-- 公式37 max(攻击者武将伤害genaddharm—受击者武将伤害减免gensubharm，0)
function SkillManage.generalsAddDam(srcEntity, tarEntity, skill)
	local broadchangesysid = srcEntity.changesys and srcEntity:gp'broadchangesys'.id or -1
	if broadchangesysid > 0 then
		local genaddharm = AttrSys.get( srcEntity, 'genaddharm')
		local subgenharm = AttrSys.get( tarEntity, 'gensubharm')
		local value = genaddharm - subgenharm
		return mathmax(value, 0)
	else
		return 0
	end
end

-- 攻击者军师数值增伤
-- 公式38 max(攻击者武将伤害genaddharm—受击者武将伤害减免gensubharm，0)
function SkillManage.advisorAddDam(srcEntity, tarEntity, skill)
	if srcEntity:gp'type' == 'advisor' then
		local advaddharm = AttrSys.get( srcEntity, 'advaddharm')
		local advsubharm = AttrSys.get( tarEntity, 'advsubharm')
		local value = advaddharm - advsubharm
		return mathmax(value, 0)
	else
		return 0
	end
end

function SkillManage.attRealDamage(srcEntity, tarEntity)
	return AttrSys.get(srcEntity, 'absAtt') - AttrSys.get(tarEntity, 'finalSubDamage')
end

function SkillManage.effectTypePro(src,tar,skill,ret,effectInfo)
	local flag = {}
	for k,v in next,eHitType do 
		if ret.hitType == v and k ~= 'normal' then
			flag[k] = true
			break
		end
	end
	local dmglist = {ret.damage,ret.element_damage}
	local retvalue = ret.damage+ret.element_damage
	for i,v in ipairs(dmglist) do 
		local damage = dmglist[i]
		if damage > 0 then
			if tar.almostnoharm then damage = mathmin(damage,1) end
			damage = mathmax(toint(damage), 1)
			if ret.damage_type == eSkillHitType.heal then damage = -damage end
			local death, trueValue, islose, oldhp = tar:modifyHp( src:gp'guid', -damage, flag, 'skill', true, skill.id)
			if( not islose ) then
				-- effectInfo[ #effectInfo + 1 ] = { attr = 'hp', flag = flag, src = 'skill', value = -damage, truevalue = trueValue }
				if i == 2 then 
					effectInfo[ #effectInfo + 1 ] = { 1, {element = true}, -damage, trueValue, oldhp, 'skill', }
				else
					effectInfo[ #effectInfo + 1 ] = { 1, flag, -damage, trueValue, oldhp, 'skill', }
				end
				if( src:gp'type' == 'role' ) then
					src:updateSerAttack()
				end
			end
			if( death ) then
				-- effectInfo[ #effectInfo + 1 ] = { attr = 'death' }
				effectInfo[ #effectInfo + 1 ] = { 2 }
				--if( src:gp'type' == 'role' ) then
					--src:updateSerAttack()
				--end
			end
		end
	end
	if tar.returnDamageId then
		SkillManage.returnDamage( tar, src, effectInfo , skill, srcskill)
	end
	if skill.speEffect then
		SkillManage.specialEffect(src, tar, skill, effectInfo, retvalue)
	end

	SkillManage.proCombatState( src, tar, skill )
	src:onAttack( tar, skill )
	tar:onGetHit( src, skill )

	SkillManage.getHitGiftPro( src, tar, skill )
	SkillManage.attackGiftOtherPro( src, tar )
	SkillManage.useSkillTarGiftPro( src, tar, skill.category )
	SkillManage.useSkillDamageGiftPro( src, tar, skill.category, src.skilldamage )

	return retvalue, death
end

-- 战斗伤害计算
--[[公式:
	基础伤害: 公式15（攻击者技能伤害-受击者最终减伤）*（100%+攻击者addharm-受击者originSubDamage）
	攻击者最终伤害：公式16 max（（攻击者基础伤害+攻击者暴击伤害+攻击者攻击玩家加成+攻击者攻击Boss加成+攻击者攻击怪物加成+攻击者战神伤害加成-受击者格挡值-受击者群攻减免+（攻击者absAtt-
	受击者finalSubDamage+max（攻击者cavalryabsAtt-受击者cavalrfinalSubDamage，0）））*(1+受击者finalDamagerate)+受击者finalDamag，攻击者基础伤害*系数18）
--]]
-- function SkillManage.effectTypePro( srcEntity, tarEntity, skill, cri, effectInfo, srcskill, skillInfoExt )
-- 	-- local isadvr = false
-- 	-- if srcEntity:gp'type' == 'advisor' then
-- 	-- 	isadvr = true
-- 	-- 	srcEntity = srcEntity:getHost()
-- 	-- 	if not srcEntity then return end
-- 	-- end

-- 	local srcAtt = SkillManage.attValue(srcEntity, skill, tarEntity, srcskill, skillInfoExt.stepindex)--攻击者技能伤害值
-- 	if not srcAtt or srcAtt <= 0  then
-- 		SkillManage.attackGiftOtherPro( srcEntity, tarEntity )
-- 		SkillManage.useSkillTarGiftPro( srcEntity, tarEntity, skill.category )
-- 		return 0
-- 	end
-- 	local flag = {}

-- 	--攻击者基础伤害basedamage 公式15  （攻击者技能伤害-受击者最终减伤）*攻击者伤害增幅*（1+攻击者最终综合强度）
-- 	local finalsubdam, isblock = SkillManage.finalSubDamage(srcEntity, tarEntity, skill, srcAtt)--受击者最终减伤
-- 	local damage = srcAtt - finalsubdam
-- 	damage = damage*SkillManage.damageAddHarm(srcEntity, tarEntity, skill)*(1+SkillManage.finalAddRate(srcEntity, tarEntity, skill))
-- 	local basedamage = damage

-- 	--攻击者暴击伤害 公式12 if（攻击者暴击率，攻击者暴伤率*攻击者基础伤害，0）
-- 	if cri then --暴击
-- 		flag.cri = true
-- 		damage = basedamage + basedamage*SkillManage.finalCriValue(srcEntity, tarEntity, skill)
-- 	end

-- 	if tarEntity:gp'type' == 'role' then
-- 		--攻击者攻击玩家加成 公式10 if（受击者是玩家，攻击者playerAddharm*攻击者基础伤害，0）
-- 		damage = damage + basedamage * AttrSys.get(srcEntity, 'playerAddharm')
-- 	elseif tarEntity:gp'type' == 'monster' and Cfg.cfg_mon[tarEntity:gp'id'].boss > 0 then
-- 		--攻击者攻击Boss加成 公式11 if（受击者是Boss，攻击者bossAddharm*攻击者基础伤害，0）
-- 		damage = damage + basedamage * AttrSys.get(srcEntity, 'bossAddharm')
-- 	end
-- 	if isblock then flag.block = true end
-- 	--*******************************************修改by褚智勇*************************************************
-- 	--damage = damage * (skillInfoExt.caststep or 1) -- 计算蓄力阶段伤害
-- 	--修改为伤害根据阶段，为0.2,0.5,1的伤害
-- 	local stepHitTimes = {0.2,0.5,1}
-- 	damage = damage * stepHitTimes[toint(mathmin(skillInfoExt.caststep or 3,3))]
-- 	--********************************************************************************************************

-- 	--攻击者最终伤害：公式16
-- 	-- max（（攻击者基础伤害+攻击者暴击伤害+攻击者真实伤害对冲结果+攻击者武将数值增伤+攻击者军师伤害加成），攻击者基础伤害*系数18）*if（攻击者群体技能、受击者非主要目标，max(（100%-受击者aoeSubRate）,0)，1）
-- 	damage = toint(damage + SkillManage.attRealDamage(srcEntity, tarEntity) + SkillManage.generalsAddDam(srcEntity, tarEntity, skill) + SkillManage.advisorAddDam(srcEntity, tarEntity, skill))
-- 	damage = mathmax(damage, basedamage*cfg_formula[18].value)

-- 	if skill.aoeflag == 2 then --公式9, AOE伤害减免
-- 		if not skillInfoExt or not skillInfoExt.maintargetguid or tarEntity:gp'guid' ~= skillInfoExt.maintargetguid then
-- 			local subaoe = SkillManage.aoeSubRate(srcEntity, tarEntity)
-- 			if subaoe >= 0 then damage = damage*subaoe end
-- 		end
-- 	end
-- 	-- pvp系数(竞技场)
-- 	if SkillManage.isPvpEntity(srcEntity) and SkillManage.isPvpEntity(tarEntity) then
-- 		damage = damage*cfg_formula[24].value
-- 	end
-- 	-- 军师攻击pvp加成
-- 	if srcEntity:gp'type' == 'advisor' and SkillManage.isPvpEntity(tarEntity) then
-- 		damage = damage*cfg_formula[25].value
-- 	end
-- 	-- 武将攻击pvp加成
-- 	if SkillManage.isPvpEntity(srcEntity) and skill.type == 'generals' and SkillManage.isPvpEntity(tarEntity) then
-- 		damage = damage*cfg_formula[26].value
-- 	end

-- 	--护盾
-- 	if tarEntity.shieldbuffs then
-- 		damage = SkillManage.shieldDamage(srcEntity, tarEntity, damage)
-- 	end
-- 	--buff减伤(伤害来源收到减伤buff) subdamage>=1减少数值，，，<1是减少百分比
-- 	if srcEntity and srcEntity.subdamage then
-- 		if srcEntity.subdamage >= 1 then
-- 			damage = damage - srcEntity.subdamage
-- 		else
-- 			damage = damage*srcEntity.subdamage
-- 		end
-- 	end

-- 	--buff增伤，来源增伤
-- 	if srcEntity and srcEntity.adddamage then
-- 		local buffGroupData = BuffSys.getBuffGroupDataById(srcEntity, srcEntity.adddamage[1])
-- 		damage = damage + damage*srcEntity.adddamage[2]*(buffGroupData and buffGroupData.pileLayer or 1)
-- 	end
-- 	-- 目标buff自增伤
-- 	if tarEntity and tarEntity.selfadddamage then
-- 		local buffGroupData = BuffSys.getBuffGroupDataById(tarEntity, tarEntity.selfadddamage[1])
-- 		damage = damage + damage*tarEntity.selfadddamage[2]*(buffGroupData and buffGroupData.pileLayer or 1)
-- 	end

-- 	if tarEntity.almostnoharm then damage = mathmin(damage,1) end
-- 	damage = mathmax(toint(damage), 1)
-- 	local retvalue = damage
-- 	local death, trueValue, islose, oldhp = tarEntity:modifyHp( srcEntity:gp'guid', -damage, flag, 'skill', true, skill.id)
-- 	if( not islose ) then
-- 		-- effectInfo[ #effectInfo + 1 ] = { attr = 'hp', flag = flag, src = 'skill', value = -damage, truevalue = trueValue }
-- 		effectInfo[ #effectInfo + 1 ] = { 1, flag, -damage, trueValue, oldhp, 'skill', }
-- 		if( srcEntity:gp'type' == 'role' ) then
-- 			srcEntity:updateSerAttack()
-- 		end
-- 	end
-- 	if tarEntity.returnDamageId then
-- 		SkillManage.returnDamage( tarEntity, srcEntity, effectInfo , skill, srcskill)
-- 	end
-- 	if skill.speEffect then
-- 		SkillManage.specialEffect(srcEntity, tarEntity, skill, effectInfo, retvalue)
-- 	end
-- 	if( death ) then
-- 		-- effectInfo[ #effectInfo + 1 ] = { attr = 'death' }
-- 		effectInfo[ #effectInfo + 1 ] = { 2 }
-- 		--if( srcEntity:gp'type' == 'role' ) then
-- 			--srcEntity:updateSerAttack()
-- 		--end
-- 	end

-- 	SkillManage.proCombatState( srcEntity, tarEntity, skill )
-- 	srcEntity:onAttack( tarEntity, skill )
-- 	tarEntity:onGetHit( srcEntity, skill )

-- 	SkillManage.getHitGiftPro( srcEntity, tarEntity, skill )
-- 	SkillManage.attackGiftOtherPro( srcEntity, tarEntity )
-- 	SkillManage.useSkillTarGiftPro( srcEntity, tarEntity, skill.category )
-- 	SkillManage.useSkillDamageGiftPro( srcEntity, tarEntity, skill.category, srcEntity.skilldamage )

-- 	return retvalue, death
-- end

function SkillManage.mobaTypePro( srcEntity, tarEntity, skill, cri, effectInfo)
	local atk = srcEntity.mobaatk
	local tarhp = AttrSys.get(tarEntity, 'maxHp')
	local damage = math.ceil(tarhp*atk)
	local death, trueValue, islose, oldhp = tarEntity:modifyHp( srcEntity:gp'guid', -damage, nil, 'skill', true, skill.id)
	if( not islose ) then
		-- effectInfo[ #effectInfo + 1 ] = { attr = 'hp', flag = flag, src = 'skill', value = -damage, truevalue = trueValue }
		effectInfo[ #effectInfo + 1 ] = { 1, flag, -damage, trueValue, oldhp, 'skill', }
		if( srcEntity:gp'type' == 'role' ) then
			srcEntity:updateSerAttack()
		end
	end
	if( death ) then
		-- effectInfo[ #effectInfo + 1 ] = { attr = 'death' }
		effectInfo[ #effectInfo + 1 ] = { 2 }
		--if( srcEntity:gp'type' == 'role' ) then
			--srcEntity:updateSerAttack()
		--end
	end

	SkillManage.proCombatState( srcEntity, tarEntity, skill )
	srcEntity:onAttack( tarEntity, skill )
	tarEntity:onGetHit( srcEntity, skill )

	SkillManage.getHitGiftPro( srcEntity, tarEntity, skill )
	SkillManage.attackGiftOtherPro( srcEntity, tarEntity )
	SkillManage.useSkillTarGiftPro( srcEntity, tarEntity, skill.category )
	SkillManage.useSkillDamageGiftPro( srcEntity, tarEntity, skill.category, srcEntity.skilldamage )

	return damage, death
end

function SkillManage.isPvpEntity(entity)
	if entity:gp'type'=='role' or (entity:gp'type'=='monster' and entity:isSp'roleava' and entity:gp'roleava' ) or entity:gp'type' == 'advisor' then
		return true
	end
end

function SkillManage.checkTarget(src, target, friend)
	if src:gp'type'=='advisor' then
		src = src:getHost()
	end
	if( not target:isDeath() and CampManage.campRelation( src, target ) == 'enemy' ) and not target.noAttacked and target:isVisible(src) then
		return true
	else
		return false
	end
end

function SkillManage.checkFriend(src, target)
	local tartype = target:gp'type'
	if tartype ~= 'role' or tartype~='monster' then return false end
	return true
end

function SkillManage.checkSingleEnemy(src, target, skill, round)
	if( not target:isDeath() and CampManage.campRelation( src, target ) == 'enemy' ) and
		(not target.cambat or target.cambat ~='back') and not target.noAttacked then
			local srcPos = src:gp"currPos"
			local tarPos = target:gp"currPos"
			local dis = getDistance( srcPos, tarPos )
			dis = dis - src:gp'sizeR' - target:gp'sizeR'
		return dis <= round
	end
	return false
end

function SkillManage.checkSingleTarget(src, target, round)
	if ( (not target.cambat or target.cambat ~='back') and CampManage.campRelation( src, target ) == 'enemy' )
		or CampManage.campRelation( src, target ) == 'friend'  then
		local srcPos = src:gp"currPos"
			local tarPos = target:gp"currPos"
			local dis = getDistance( srcPos, tarPos )
			dis = dis - src:gp'sizeR' - target:gp'sizeR'
		return dis <= round
	end
	return false
end

function SkillManage.checkRoundRoleAllEnemy(pointtarget, role, target, roundtar, round)
	if not role then return end
	if not pointtarget then return end
	if target:isDeath() then return end
	if( CampManage.campRelation( role, target ) == 'enemy' )  and (not target.cambat or target.cambat ~='back') and not target.noAttacked then
		local srcPos = role:gp'currPos'
		local tarpos = pointtarget:gp"currPos"
		local otherPos = target:gp"currPos"
		local dis = getDistance( tarpos, otherPos )
		dis = dis - pointtarget:gp'sizeR' - target:gp'sizeR'
		if dis <= roundtar then
			if round then
				local dis2 = getDistance( tarpos, srcPos )
				dis2 = dis2 - role:gp'sizeR' - target:gp'sizeR'
				return dis2 <= round
			else
				-- return false
				return true --临时保留true
			end
		end
	end
end

function SkillManage.checkSingleFriend(src, target, round)
	if CampManage.campRelation( src, target ) == 'friend' then
		if src == target then
			return true
		else
			local srcPos = src:gp'currPos'
			local tarPos = target:gp'currPos'
			local dis = getDistance( srcPos, tarPos )
			dis = dis - src:gp'sizeR' - target:gp'sizeR'
			return dis <= round
		end
	end
end

function SkillManage.checkSelfAllFriend(src, target, round)
	local srcPos = src:gp"currPos"
	if not target:isDeath() and CampManage.campRelation( src, target ) == 'friend' then
		local otherPos = target:gp"currPos"
		local dis = getDistance( srcPos, otherPos )
		dis = dis - src:gp'sizeR' - target:gp'sizeR'
		return dis <= round
	end
end

function SkillManage.checkSelfAllEnemy(src, target, round)
	local srcPos = src:gp'currPos'
	if CampManage.campRelation( src, target ) == 'enemy' and (not target.cambat or target.cambat ~='back') and not target.noAttacked then
		local otherPos = target:gp'currPos'
		local dis = getDistance( srcPos, otherPos )
		dis = dis - src:gp'sizeR' - target:gp'sizeR'
		return dis <= round
	end
end

function SkillManage.checkSelfAllEntity(src, target, round)
	local otherPos = target:gp"currPos"
	local srcPos = src:gp"currPos"
	local dis = getDistance( srcPos, otherPos )
	dis = dis - src:gp'sizeR' - target:gp'sizeR'
	return dis <= round
end

function SkillManage.checkSelfTeam(src, eposes, round)
	local eList = {}
	local teamid = src:gp'teamid'
	if not teamid or teamid == 0 then return eList end
	local srcPos = src:gp"currPos"
	local teampids = Team.byID(teamid)
	for pid, v in next, teampids do
		local target = GsRole.byPID(pid)
		if target and target ~= src and not target:isDeath() and eposes[target:gp'guid'] then
			local otherPos = target:gp"currPos"
			local dis = getDistance( srcPos, otherPos )
			dis = dis - src:gp'sizeR' - target:gp'sizeR'
			if dis <= round then table.insert(eList, target) end
		end
	end
	return eList
end

function SkillManage.checkSelfTeamAll(src, eposes, round)
	local eList = { src } --默认包含自己
	local teamid = src:gp'teamid'
	if not teamid or teamid == 0 then return eList end
	local srcPos = src:gp"currPos"
	local teampids = Team.byID(teamid)
	for pid, v in next, teampids do
		local target = GsRole.byPID(pid)
		if target and target ~= src and not target:isDeath() and eposes[target:gp'guid'] then
			local otherPos = target:gp"currPos"
			local dis = getDistance( srcPos, otherPos )
			dis = dis - src:gp'sizeR' - target:gp'sizeR'
			if dis <= round then table.insert(eList, target) end
		end
	end
	return eList
end

-- 验证客户端获得的目标的合法性(包括敌人和好友)
function SkillManage.checkRangeSelect(src, skill, eposes, targetguid)
	local eList, fList = {}, {} --技能需要同时对敌方和好友
	local pointtarget = src:getZone():getEntity( targetguid )
	local userange = (skill.useRangeParm1 or 0)
	if( src.ridewSkillData ) then userange = userange + src.ridewSkillData[2] end
	if( skill.useRange == CFG_USERANGES.CIRCLE_TEAM ) then
		eList = SkillManage.checkSelfTeam(src, eposes, userange)
	elseif ( skill.useRange == CFG_USERANGES.CIRCLE_SELF_TEAM ) then
		eList = SkillManage.checkSelfTeamAll(src, eposes, userange)
	elseif ( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND ) then
		eList = SkillManage.roundSelfAllFriend( src, eposes, userange, skill.useRangeParm2 or 0 )
	elseif( skill.useRange == CFG_USERANGES.SELF ) then
		table.insert(eList, src)
	elseif ( skill.useRange == CFG_USERANGES.SINGLE_ENEMY or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
				or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE) then
		local target = src:getZone():getEntity( targetguid )
		if target and SkillManage.checkSingleEnemy(src, target, skill, userange) then
			table.insert(eList, target)
		end
	else
		for guid, pos in next, eposes do
			local target = src:getZone():getEntity( guid )
			if target and ( skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND ) and SkillManage.checkSingleTarget(src, target, userange) then
				table.insert(eList, target)
			elseif target and ( skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER ) and SkillManage.checkRoundRoleAllEnemy(pointtarget, src, target, userange, skill.useRangeParm3) then
				table.insert(eList, target)
			elseif target and  ( skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND ) and SkillManage.checkSingleFriend(src, target, userange) then
				table.insert(eList, target)
			elseif target and ( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND ) and SkillManage.checkSelfAllFriend(src, target, userange) then
				table.insert(eList, target)
			elseif target and ( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY or skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY ) and SkillManage.checkSelfAllEnemy(src, target, userange) then
				table.insert(eList, target)
			elseif target and ( skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY ) and SkillManage.checkSelfAllEntity(src, target, userange) then
				if SkillManage.checkTarget(src, target, skill) then
					table.insert(eList, target)
				else
					table.insert(fList, target)
				end
			end
		end
	end
	return eList, fList
end

function SkillManage.checkRangeSelectPoint(src, skill, eposes, point)
	local eList = {}
	local round = skill.useRangeParm1
	for guid, p in next, eposes do
		local target = src:getZone():getEntity( guid )
		if target and ( CampManage.campRelation( src, target ) == 'enemy' ) and (not target.cambat or target.cambat ~='back') and not target.noAttacked then
			local dis = getDistance( target:gp"currPos", point )
			dis = dis - target:gp'sizeR'
			if dis <= round then table.insert(eList, target) end
		end
	end
	return eList
end

function SkillManage.checkSectorSomeEnemy(src, skill, eposes, atkdir, rangefeedback)
	local eList = {}
	local srcpos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local startPos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local angle = skill.useRangeParm3
	if skill.useRangeParm4 then
		local antidir = _Vector2.new(-atkdir.x, -atkdir.y)
		antidir = _Vector2.mul( antidir, skill.useRangeParm4, tempV1 )
		startPos = _Vector2.add(startPos, antidir, tempV1 )
	end
	local r = skill.tinyrush and skill.tinyrush + skill.useRangeParm1 or skill.useRangeParm1
	local anglev = math.cos(math.rad(angle/2))
	anglev = math.pow(anglev, 2)
	local sels = {}
	-- dump(eposes)
	for guid, pos in next, eposes do
		local e = src:getZone():getEntity( guid )
		if e and ( not e:isDeath() and CampManage.campRelation( src, e ) == 'enemy' ) and (not e.cambat or e.cambat ~='back') and not e.noAttacked then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= r then
				local epos = _Vector2.new( e:gp'currPos'.x, e:gp'currPos'.y )
				local evect = _Vector2.sub( epos, startPos )
				local v1 = (atkdir.x*evect.x + atkdir.y*evect.y)
				local v2 = (atkdir.x^2 + atkdir.y^2)*(evect.x^2 + evect.y^2)
				if( v2 ~= 0 ) then
					local cosvalsqrt = v1 > 0 and ((v1*v1)/v2) or (-(v1*v1)/v2)--优化过的，不需要算开根号以及acos
					if( cosvalsqrt > anglev ) then	--cos(45°)^2 = 0.5
						table.insert(eList, e)
						sels[e] = true
					end
				end
			end
		end
	end
	for guid, pos in next, eposes do
		local e = src:getZone():getEntity( guid )
		if e and ( not e:isDeath() and CampManage.campRelation( src, e ) == 'enemy' )
			and (not e.cambat or e.cambat ~='back') and not e.noAttacked and not sels[e] then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= (rangefeedback or SectorAppendRange) then
				table.insert(eList, e)
				sels[e] = true
			end
		end
	end
	return eList
end

local tempv2 = _Vector2.new( )
----算法描述,先构造一个表示dir到_Vector2.new( 1, 0 )的旋转矩阵，然后把矩阵转到正X、Y坐标里去判断
-- additional表示是否将矩形前方的相当于矩形的宽的长度计算在内
function SkillManage.checkLineSomeEnemy(src, skill, atkdir, eposes, length, width, additional, rangefeedback)
	tempv2.x = atkdir.x
	tempv2.y = atkdir.y
	atkdir = tempv2
	length = length or skill.useRangeParm1
	length = skill.tinyrush and skill.tinyrush + length or length
	width = width or skill.useRangeParm2
	if additional then length = length + width end

	local srcpos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	local temp = _Vector2.new( 1, 0 )
	local dir = _Vector2.new(atkdir.x, atkdir.y)
	local cosdir = (atkdir.x*temp.x + atkdir.y*temp.y)/dir:magnitude()
	local r = math.acos( cosdir )
	local mat = _Matrix2D.new()
	if( atkdir.y >=0 ) then
		mat:setRotation( -r )
	else
		mat:setRotation( r )
	end
	local eList = {}
	local sels = {}
	for guid, pos in next, eposes do
		local e = src:getZone():getEntity( guid )
		if e and ( not e:isDeath() and CampManage.campRelation( src, e ) == 'enemy') and (not e.cambat or e.cambat ~='back') and not e.noAttacked then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= length then
				local epos = _Vector2.new( e:gp'currPos'.x, e:gp'currPos'.y )
				local difv = _Vector2.sub( epos, srcpos )
				difv = mat:apply( difv )
				if difv.x > 0 and difv.x < length and difv.y > - width / 2 and difv.y < width / 2 then
					table.insert(eList, e)
					sels[e] = true
				end
			end
		end
	end

	for guid, pos in next, eposes do
		local e = src:getZone():getEntity( guid )
		if e and ( not e:isDeath() and CampManage.campRelation( src, e ) == 'enemy' )
			and (not e.cambat or e.cambat ~='back') and not e.noAttacked and not sels[e] then
			local dis = getDistance( srcpos, e:gp'currPos' )
			dis = dis - src:gp'sizeR' - e:gp'sizeR'
			if dis <= (rangefeedback or SectorAppendRange) then
				table.insert(eList, e)
				sels[e] = true
			end
		end
	end
	return eList
end

-- 判断技能使用条件
function SkillManage.canUseSkill(src, skill, targetguid, targetpos )
	-- _js('----------fire star----', skill.iscrazy, src.crazy, skill.id)
	if src:isDeath() then return false end
	if skill.iscrazy and not src.crazy then return false end
	if skill.cost_type and src:gp(skill.cost_type) < skill.cost_num then
		return false
	end
	local targetguy
	--施法各种防错防外挂的判断
	local result = true
	if ( (src:gp'type' ~= 'role' and skill.useRange == CFG_USERANGES.SINGLE_ENEMY and targetguid) or        --why?
	 skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
		or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER or skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE
		) then
		targetguy = src:getZone():getEntity( targetguid )
		--_js('----', src:gp'guid', targetguid, targetguy, targetguy and targetguy:gp'guid')
		if( not targetguy  ) then
			result = false
		else
			if  targetguy:isDeath() then
				result = false
			elseif( not SkillManage.attackDistanceAble( skill, src, targetguy ) ) then
				result = false
			end
		end
	elseif (skill.useRange == CFG_USERANGES.SELF or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND
		or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY or skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY) then
		targetguy = src:getZone():getEntity( targetguid )
		if( not SkillManage.attackDistanceAble( skill, src, targetguy ) ) then
			result = false
		end
	elseif ( skill.useRange == CFG_USERANGES.LINE) then
		local pos = { x = targetpos[1], y = targetpos[2]}
		if( not SkillManage.attackPointDisAble( skill, src, pos ) ) then
			result = false
		end
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_POINT_ALLENEMY ) then
		if not targetpos then
			result = false
		else
			if( not SkillManage.attackPointDisAble( skill, src, targetpos ) ) then
				result = false
			end
		end
	elseif( skill.useRange == CFG_USERANGES.POINTLINE ) and src:gp'type' == 'role' then
		if( targetpos.x or targetpos.y) then
			local dis = getDistance( src:gp'currPos', { x=targetpos.x or 0, y=targetpos.y or 0 } )
			-- if targetguid then
			-- 	targetguy = src:getZone():getEntity( targetguid )
			-- end
			-- dis = dis - src:gp'sizeR' - (targetguy and targetguy:gp'sizeR' or 0)
			if dis > skill.useRangeParm1 then
				-- _lzl('xxxdis xxx dixs', dis, skill.useRangeParm1, src:gp'currPos'.x, src:gp'currPos'.y)
				result = false
			end
		end
	else
		-- assert( PUBLIC, 'useRange 没有检测 '..skill.useRange)
		--Log.warn('useRange 没有检测 '..skill.useRange)
	end
	return result, targetguy
end

-- 怪物攻击后的位置
function SkillManage.monPosAfterAttack(src, skill, tarpos, targetguy)
	local srcpos = _Vector2.new( src:gp'currPos'.x, src:gp'currPos'.y )
	tarpos = tarpos or targetguy:gp"currPos"
	tarpos = _Vector2.new(tarpos.x, tarpos.y)
	local atkdir, newPos
	if( skill.goto ) then--设置冲锋后的新的位置
		atkdir = _Vector2.new( tarpos.x - srcpos.x, tarpos.y - srcpos.y )
		if skill.useRange == CFG_USERANGES.SINGLE_ENEMY or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER
			-- or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ROLE
			or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL then --需要选目标的,计算与目标的位置差
			local m = dir:magnitude() - targetguy:gp'sizeR' - src:gp'sizeR'
			if( m > 0 ) then
				newPos = src:getZone():findDirPos(srcpos, dir, m)
			end
		else
			newPos = src:getZone():findDirPos(srcpos, atkdir, skill.useRangeParm1)
		end
	elseif( skill.backto ) then
		atkdir = _Vector2.sub( srcpos, tarpos )
		newPos = src:getZone():findDirPos(srcpos, atkdir, 40)
	elseif skill.push then
		atkdir = _Vector2.sub( tarpos, srcpos )
		local m = atkdir:magnitude() - (targetguy and targetguy:gp'sizeR' or 0) - src:gp'sizeR'
		if m <= 0 then return { x = src:gp"currPos".x, y=src:gp"currPos".y }, atkdir elseif m > skill.push then m = skill.push end
		newPos = src:getZone():findDirPos(srcpos, atkdir, m)
	else
		atkdir = _Vector2.new(tarpos.x - srcpos.x, tarpos.y-srcpos.y)
	end
	if newPos then newPos = { x = newPos.x, y = newPos.y } end
	return newPos, atkdir
end

-- 获取矩形范围内的受击单位受击后的移动方向和位置
local rotVec1 = _Vector2.new()
local rotVec2 = _Vector2.new()
local rotVec3 = _Vector2.new()
function SkillManage.posAfterLineAttack(atkdir, e, skill, src)
	atkdir:normalize()
	local range = skill.useRangeParm2/2 + e:gp'sizeR'
	local theta = math.acos(atkdir.x)
	local mat1 = _Matrix2D.new()
	local mat2 = _Matrix2D.new()
	if atkdir.y >= 0 then
		mat1:setRotation(-theta)
		mat2:setRotation(-theta)
	else
		mat1:setRotation(theta)
		mat2:setRotation(theta)
	end
	mat2:inverse()
	local srcpos = _Vector2.new(src:gp'currPos'.x, src:gp'currPos'.y)
	local epos = _Vector2.new(e:gp'currPos'.x, e:gp'currPos'.y)
	local myrotp = mat1:apply(srcpos, rotVec1)
	local newepos = mat1:apply(epos, rotVec2)
	local theta1 = math.asin((newepos.y - myrotp.y)/range)
	local dx = range * math.cos(theta1)
	local movedir = _Vector2.new(dx, newepos.y - myrotp.y)
	movedir = mat2:apply(movedir, rotVec3)
	movedir = movedir:normalize()
	movedir = _Vector2.new(movedir.x, movedir.y, 0)

	local S = math.random(skill.back[1], skill.back[2])
	local L, P = skill.useRangeParm1 + range, 0.5
	local cosv = math.cos(theta1)
	local m = S*(1-(newepos.x - myrotp.x)/L*P)*(4/5*cosv+1/5)
	local movet = 500
	local as = (2 * m) / (movet * movet)
	local newPos = src:getZone():findDirPos(e:gp'currPos', movedir, m)
	return newPos
end

-- 被怪物攻击后的目标位置
function SkillManage.posesAfterAttack(src, atkdir, eList, skill)
	local eposes = {}
	if skill.backdir then --会导致受击者后退
		for i, e in next, eList do
			local m = math.random(skill.back[1], skill.back[2])
			local dir, newPos
			local srcVec = _Vector2.new(src:gp"currPos".x, src:gp"currPos".y)
			local eVec = _Vector2.new(e:gp"currPos".x, e:gp"currPos".y)
			if skill.backdir == 0 then --方向为攻击者指向自身的方向
				dir = _Vector2.new(e:gp"currPos".x - src:gp"currPos".x,e:gp"currPos".y - src:gp"currPos".y, dir)
				newPos = src:getZone():findDirPos(e:gp"currPos", dir, m)
			elseif skill.backdir == 1 then --方向为攻击者的面向
				dir =  _Vector2.new(atkdir.x, atkdir.y)
				newPos = src:getZone():findDirPos(e:gp"currPos", dir, m)
			elseif skill.backdir == 2 then --方向为攻击者为圆心的自身所在圆上的点的切线顺时针
				dir = tanOfPoint(src:gp"currPos", e:gp"currPos", true)
				newPos = src:getZone():findDirPos(e:gp"currPos", dir, m)
			elseif skill.backdir == 3 then --方向为攻击者为圆心的自身所在圆上的点的切线逆时针
				dir = tanOfPoint(src:gp"currPos", e:gp"currPos", false)
				newPos = src:getZone():findDirPos(e:gp"currPos", dir, m)
			elseif skill.backdir == 4 then -- 垂直于攻击者方向的自身所在侧为正向
				local atkdirt = _Vector2.new(atkdir.x, atkdir.y)
				dir = verticalSideDir(atkdirt, _Vector2.new(src:gp"currPos".x, src:gp"currPos".y), _Vector2.new(e:gp'currPos'.x, e:gp'currPos'.y) )
				newPos = src:getZone():findDirPos(e:gp"currPos", dir, m)
			elseif skill.backdir == 5 then
				newPos = SkillManage.posAfterLineAttack(atkdir, e, skill, src)
			end
			eposes[e:gp'guid'] = {x = newPos.x, y = newPos.y}
		end
	else
		for i, e in next, eList do eposes[e:gp'guid'] = {x = e:gp'currPos'.x, y = e:gp'currPos'.y } end
	end
	return eposes
end

-- 使用技能前的处理,用于怪物
function SkillManage.monPreUseSkill(src, skill, targetguid, targetpos, targetguy)
	local eList, eposes, fList = {}, {}, {}
	local theatker
	if skill.type == 'xp' then theatker = src:getHost() end --军师xp技位置计算以玩家为中心
	theatker = theatker or src
	if( skill.useRange == CFG_USERANGES.SINGLE_ENEMY or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
		or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY)
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE
	then
		eList, fList = SkillManage.useRangeSelect( theatker, targetguy, skill )
	elseif skill.useRange == CFG_USERANGES.SELF	or skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND
		or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY or skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY then
		eList, fList = SkillManage.useRangeSelect( theatker, targetguy, skill )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_POINT_ALLENEMY ) then
		eList = SkillManage.useRangeSelectPoint( theatker, selfPos, skill )
	elseif( skill.useRange == CFG_USERANGES.SECTOR ) then
		eList = SkillManage.sectorSomeEnemy( theatker, targetguy, targetpos, skill.useRangeParm1, skill.useRangeParm2, skill.useRangeParm3, skill.useRangeParm4, skill.rangefeedback )
	elseif( skill.useRange == CFG_USERANGES.LINE ) then
		eList = SkillManage.lineSomeEnemy( theatker, targetguy, targetpos, skill.useRangeParm1, skill.useRangeParm2, skill.useRangeParm3, skill.goto, skill.rangefeedback )
	elseif( skill.useRange == CFG_USERANGES.POINTLINE ) then
		eList = SkillManage.lineSomeEnemy( theatker, targetguy, targetpos, skill.useRangeParm1, skill.useRangeParm2, skill.useRangeParm3, skill.goto, skill.rangefeedback )
	end
	local oldatkpos = {x = src:gp'currPos'.x, y = src:gp'currPos'.y }
	local newPos, atkdir = SkillManage.monPosAfterAttack(src, skill, targetpos, targetguy)
	eposes = SkillManage.posesAfterAttack(src, atkdir, eList, skill)
	if newPos and src:canMove() then --判断是否可以移动
		src:setCurrPos( newPos.x, newPos.y )
	else
		newPos = {x = src:gp'currPos'.x, y = src:gp'currPos'.y }
	end
	local atkdirnew = {x = atkdir.x, y=atkdir.y }
	return eList, fList, atkdirnew, newPos, eposes, oldatkpos
end

-- TODO检查玩家自己客户端位置和服务器位置的差距
function SkillManage.checkRolePos(src, skill, extdata)
	if extdata.buffskill then return true end
	return true
end

-- 使用技能前的处理,用于玩家
function SkillManage.rolePreUseSkill(src, skill, targetguid, targetpos, targetguy, extdata)
	local eList, fList = {}, {}
	local oldatkpos = {x = src:gp'currPos'.x, y = src:gp'currPos'.y }
	if not SkillManage.checkRolePos(src, skill, extdata) then --客户端位置和服务器位置相差太大, 有可能是作弊
		return eList
	end
	local theatker
	if skill.type == 'xp' then theatker = src:getHost() end --军师xp技以玩家为中心计算
	theatker = theatker or src
	if( skill.useRange == CFG_USERANGES.SINGLE_ENEMY or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
		or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER or skill.useRange == CFG_USERANGES.SELF
		or skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND
		or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY or skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY
		or skill.useRange == CFG_USERANGES.CIRCLE_TEAM or skill.useRange == CFG_USERANGES.CIRCLE_SELF_TEAM
		or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE
		) then
		eList, fList = SkillManage.checkRangeSelect( theatker, skill, extdata.eposes, targetguid )
	elseif( skill.useRange == CFG_USERANGES.CIRCLE_POINT_ALLENEMY ) then
		eList = SkillManage.checkRangeSelectPoint( theatker, skill, extdata.eposes, targetpos)
	elseif( skill.useRange == CFG_USERANGES.SECTOR ) then
		eList = SkillManage.checkSectorSomeEnemy( theatker, skill, extdata.eposes, extdata.atkdir, skill.rangefeedback )
	elseif( skill.useRange == CFG_USERANGES.LINE ) then
		eList = SkillManage.checkLineSomeEnemy( theatker, skill, extdata.atkdir, extdata.eposes, skill.useRangeParm1, skill.useRangeParm2, skill.goto, skill.rangefeedback )
	elseif( skill.useRange == CFG_USERANGES.POINTLINE ) then
		eList = SkillManage.checkLineSomeEnemy( theatker, skill, extdata.atkdir, extdata.eposes, getDistance( theatker:gp'currPos', { x=targetpos.x or 0, y=targetpos.y or 0 } )+5, skill.useRangeParm1, skill.goto, skill.rangefeedback)
	end
	if src:canMove() and not extdata.buffskill then --判断是否可位移
		if skill.ismoveuse then
			src:setCurrPos( oldatkpos.x, oldatkpos.y )
		else
			if (skill.goto or skill.push or skill.backto) and ((math.abs(extdata.atkpos.x - oldatkpos.x))^2 + (math.abs(extdata.atkpos.y - oldatkpos.y))^2)<CFG_MAXJUMPDIS then
				src:setCurrPos( extdata.atkpos.x, extdata.atkpos.y )
			elseif skill.tinyrush and ((math.abs(extdata.atkpos.x - oldatkpos.x))^2 + (math.abs(extdata.atkpos.y - oldatkpos.y))^2)<CFG_MAXJUMPDIS then
				src:setCurrPos( extdata.rushpos.x, extdata.rushpos.y )
			end
		end
	end
	return eList, fList, atkdir, oldatkpos
end

-- 被攻击处理打断
function SkillManage.stateInterupt(target, src, skill)
	local curstate = target.stateMachine.currentState
	if target:gp'type' == 'role' and curstate and curstate == 'cast' then --角色蓄力可以被打断
		CallRound( target ).CancelCast{ GUID = src:gp'guid' }
		target.stateMachine:changeState( State_idle.new( src ) )
	end
end

-- 给指定单位加buff
function SkillManage.addBuff(src, target, buffgroupid, extdata)
	if target:gp'type' == 'monster' and Cfg.cfg_mon[target:gp'id'].montype == 3 then return end --boss不加buff
	local tarstate = target.stateMachine.currentState
	if tarstate.name == 'lead' then --引导状态免控
		local cfg = cfg_buffgroup[ buffgroupid ]
		local have = false
		for i=1, 6 do
			if cfg[ 'buffID'..i ] and (cfg_buff[cfg[ 'buffID'..i ]].effect == 'stun' or cfg_buff[cfg[ 'buffID'..i ]].effect == 'sleep') then
				have = true break
			end
		end
		if have then return end
	end
	BuffSys.addBuffGroup( src, target, { groupID=buffgroupid, type='skill', extdata = extdata } )
end

-- 处理受击获得buff逻辑
function SkillManage.addHitBuff(src, tar, skill, skilllv)
	if not skill.hitBuffGroupRate then
		for _, buffgroupid in next, skill.hitBuffGroupID do
			SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
		end
	else --有概率获得
		for i=1, #skill.hitBuffGroupRate do
			local rand = math.random(1, 1000)
			local trate = skill.hitBuffGroupRate[i]
			if skill.type == 'xp' and skill.speEffect and skill.speEffect.benumb and src:gp'type' == 'role' then --军师技,随等级提升概率
				-- skilllv = Advisor.getSkillLevel(src, skill)
				local _
				_, skilllv = Advisor.getXpSkill( src )
				trate = trate + skill.speEffect.benumb.rateadd*skilllv
			end
			if rand <= trate then
				SkillManage.addBuff(src, tar, skill.hitBuffGroupID[i], {skill=skill.id, skilllv = skilllv})
			end
		end
	end
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
local result = {hitType = eHitType.normal,damage = 0,damage_type = eSkillHitType.real,is_ingor_def = false,suck = 0,damage_reflect = 0,element_damage_type=0,element_damage=0}
function SkillManage.skillEffect(src,tar,skill)
	local result = table.newclone(result)
	local skill_info = skill
	local level,skillid = SkillManage.getSkillLevel(src, skill, skill)
	local levelcfg = Cfg.cfg_skill_lvup[skillid]
	result.damage_type = skill_info.hitType
	--获取技能信息
	if not levelcfg then
		result.damage = 0
		return result
	end

	local skill_base_dmg = levelcfg.skilldamage[level]
	local skill_fac = levelcfg.skillcoe[level]
	local element_type = skill_info.element_type
	local element_damage_base = levelcfg.elementdamage and levelcfg.elementdamage[level]
	local element_fac = levelcfg.elementfac and levelcfg.elementfac[level]
	local element_prob = skill_info.element_prob/_G.PERCENT_R --概率
	
	--对于特殊对象进行判定
	if tar.behit_damage then--伤害=固定伤害值*技能系数
		result.damage = tar.behit_damage * skill_fac
		return result
	end

	--计算闪避，格挡，暴击
	local formula_fac = Cfg.cfg_formula()
	local crit_R = formula_fac[8].value--暴击基础R
	local dodge_R = formula_fac[9].value--基础闪避R
	local block_R = formula_fac[10].value--基础格挡R
	local decrit_R = formula_fac[17].value--抗暴R
	local hit_R = formula_fac[18].value--命中R
	local dash_R = formula_fac[19].value--冲击R
	local decrit_sub_fac = formula_fac[14].value--抗暴减法因子
	local hit_sub_fac = formula_fac[15].value--命中减法因子
	local dash_sub_fac = formula_fac[16].value--冲击减法因子
	local crit_hit_R = formula_fac[21].value--基础爆伤等级

	local srchit = AttrSys.get(src, 'hit')
	local srcdash = AttrSys.get(src, 'dash')
	local srccrit = AttrSys.get(src, 'crit')
	local srccritHit = AttrSys.get(src, 'critHit')
	local srcignorDef = AttrSys.get(src, 'ignorDef')
	local srcatk = AttrSys.get(src, 'atk')
	local srceleTrigger = AttrSys.get(src, 'eleTrigger')
	local srceleAtk = AttrSys.get(src, 'eleAtk')
	local srcmgfDmg = AttrSys.get(src, 'mgfDmg')
	local srcsuck = AttrSys.get(src, 'suck')

	local tarhit = AttrSys.get(tar, 'hit')
	local tardodge = AttrSys.get(tar, 'dodge')
	local tarblock = AttrSys.get(tar, 'block')
	local tardash = AttrSys.get(tar, 'dash')
	local tarcrit = AttrSys.get(tar, 'crit')
	local tardeCrit = AttrSys.get(tar, 'deCrit')
	local tarcritDeHit = AttrSys.get(tar, 'critDeHit')
	local tardefConcern = AttrSys.get(tar, 'defConcern')
	local tarpsDef = AttrSys.get(tar, 'psDef')
	local tarmgDef = AttrSys.get(tar, 'mgDef')
	local tareleAvoid = AttrSys.get(tar, 'eleAvoid')
	local tareleDef = {
		AttrSys.get(tar, 'eleDef1'),AttrSys.get(tar, 'eleDef2'),AttrSys.get(tar, 'eleDef3'),AttrSys.get(tar, 'eleDef4')
	}
	local tarredDmg = AttrSys.get(tar, 'redDmg')
	local tardmgReflact = AttrSys.get(tar, 'dmgReflact')

	local dodge_val = tardodge - hit_sub_fac * srchit
	local dodge_rate = math.min(formula_fac[4].value, formula_fac[6].value + math.max(-formula_fac[6].value,(dodge_val/(hit_R*tarhit+dodge_R))))
	--dodge_rate =0
	local block_val = tarblock - dash_sub_fac * srcdash
	local block_rate = math.min(formula_fac[5].value, 0 + math.max(0,block_val/(dash_R*srcdash+block_R)))
	local crit_val = srccrit - decrit_sub_fac * tardeCrit
	local crit_rate = math.min(formula_fac[3].value, 0 + math.max(0, crit_val/(decrit_R*tardeCrit + crit_R)))
	
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
	--计算忽略防御
	local random2 = math.random()
	if random2 < (srcignorDef - tardefConcern)/formula_fac[12].value then
		result.is_ingor_def = true
		result.damage_type = eSkillHitType.real
		if rst_hit_type == eHitType.block or rst_hit_type == eHitType.dodge then--发生卓越一击时，格挡、闪避变为普攻
			result.hitType = eHitType.normal
		end
	end
	if rst_hit_type == eHitType.dodge then--闪避
		fac = 0
		result.hitType = eHitType.dodge
	elseif rst_hit_type == eHitType.block then--格挡
		fac = fac * (1 - formula_fac[2].value)
		result.hitType = eHitType.block
	elseif rst_hit_type == eHitType.crit then--暴击
		fac = fac * (formula_fac[1].value + (srccritHit - tarcritDeHit)/crit_hit_R)
		result.hitType = eHitType.crit
	else--普通
		fac = fac
	end

	local hitType = skill_info.hitType
	local srcdamage = 0
	--计算防御免伤
	--属性伤害 = 攻1 - 防2*防御系数
	--防御免伤公式：免伤系数 = (攻1 - 防2*防御系数)/攻方攻击
	--最终技能伤害 = (属性伤害 * 技能系数 + 技能基础伤害) * 免伤系数 * 之前的修正系数
	local fn_def_fac = function(v_atk,v_def)
		return math.max(0,v_atk - v_def * formula_fac[7].value)/ v_atk
	end
	local fn_get_srcdamage = function(v_atk,v_def,v_defFac)
		local att_hit = math.max(0,v_atk - v_def * formula_fac[7].value) --属性伤害
		return  (att_hit * skill_fac + skill_base_dmg) * v_defFac * fac  --技能最终伤害	
	end

	local defFac = 1
	if result.damage_type == eSkillHitType.phisical then--物理伤害
		defFac = defFac * fn_def_fac(srcatk , tarpsDef)
		srcdamage = fn_get_srcdamage(srcatk , tarpsDef , defFac)
	elseif result.damage_type == eSkillHitType.magical then--魔法伤害
		defFac = defFac * fn_def_fac(srcatk , tarmgDef)
		srcdamage = fn_get_srcdamage(srcatk , tarmgDef , defFac)
	elseif result.damage_type == eSkillHitType.real then--真实伤害
		defFac = defFac
		srcdamage = (srcatk * skill_fac + skill_base_dmg) * fac
	elseif result.damage_type == eSkillHitType.heal then--受到治疗
		defFac = defFac * (1 + tartreatBonus)
		srcdamage = (srcatk * defFac * skill_fac + skill_base_dmg) * fac
	end

	--计算元素伤害
	local element_damage = 0
	if element_type and result.damage_type ~= eSkillHitType.heal then --如果该技能有元素类型，并且不是治疗
		local random3 = math.random()
		local element_trigerR = formula_fac[13].value
		local element_triger_prob = element_prob * (1 + (srceleTrigger - tareleAvoid)/element_trigerR)
		if random3 <= element_triger_prob then
			local element_def = tareleDef[element_type]
			result.element_damage_type = element_type
			element_damage = math.max(0,srceleAtk - element_def) * element_fac + element_damage_base
		end
	end

	--计算加减伤
	local jianshang_fac = math.max( (PERCENT_R - tarredDmg + srcmgfDmg) / PERCENT_R, 0)
	srcdamage = srcdamage * jianshang_fac
	element_damage = element_damage * jianshang_fac
	--伤害浮动
	local dmg_float_fac = formula_fac[20].value * 10000
	local float_fac = math.random(10000-dmg_float_fac/2,10000+dmg_float_fac/2)/10000
	srcdamage = srcdamage * float_fac
	element_damage = element_damage * float_fac
	--伤害赋值
	result.damage = math.floor(srcdamage)
	result.element_damage = math.floor(element_damage)
	
	if result.damage_type ~= eSkillHitType.heal then
		--处理吸血
		result.suck = srcdamage * (srcsuck / PERCENT_R)
		--处理反伤
		result.damage_reflect = srcdamage * (tardmgReflact / PERCENT_R)
	end

	return result
end

-- 技能攻击效果
function SkillManage.skillFire(src, skill, srcskill, targetguid, targetpos, skillguid, extdata)
	--施法各种防错防外挂的判断
	local result, targetguy
	if not extdata.buffskill then 			--buff触发的技能不走canuseskill,不改状态机
		result, targetguy = SkillManage.canUseSkill(src, skill, targetguid, targetpos)
		if not result then
			if ( skill.castTime ) then
				CallRound( src ).CancelCast{ GUID = src:gp'guid' }
			end
			return false
		end
		src.stateMachine:changeState( State_idle.new( src ) )
	else
		targetguy = src:getZone():getEntity( targetguid )
	end
	local cost = skill.cost_type
	if cost then
		if cost == 'hp' then
			src:modifyHp(src:gp'guid', -skill.cost_num, {}, 'skillcost')
		elseif cost == 'mp' then
			src:modifyMp(src:gp'guid', -skill.cost_num)
		elseif cost == 'energe' then
			src:modifyEnerge(src:gp'guid', -skill.cost_num)
		end
	end
	if skill.energe_gain then
		src:modifyEnerge(src:gp'guid', skill.energe_gain)
	end
	local skillInfo, eList, fList, skilllv = {}, {}, {}, SkillManage.getSkillLevel( src, skill, srcskill)
	local isadvr = src:gp"type" == 'summon'
	local host = isadvr and src:getHost()
	if (isadvr and not host) then return end
	if not ROBOTTEST then
		if src:gp"type" == 'role' or src:gp"type" == 'summon' then
			eList, fList, extdata.atkdir, extdata.oldatkpos = SkillManage.rolePreUseSkill(src, skill, targetguid, targetpos, targetguy, extdata)
		else
			eList, fList, extdata.atkdir, extdata.atkpos, extdata.eposes, extdata.oldatkpos = SkillManage.monPreUseSkill(src, skill, targetguid, targetpos, targetguy)
		end
	else
		eList, fList, extdata.atkdir, extdata.atkpos, extdata.eposes, extdata.oldatkpos = SkillManage.monPreUseSkill(src, skill, targetguid, targetpos, targetguy)
	end
	if( skill.fireBuffGroupID ) then
		local buffsrc = src
		if isadvr then --军师加攻击者buff改为给主角加buff
			buffsrc = host
		end
		for _, buffgroupid in next, skill.fireBuffGroupID do
			SkillManage.addBuff(buffsrc, buffsrc, buffgroupid, {num=#eList, skill=skill.id, skilllv = skilllv})
		end
	end
	skillInfo.srcguid = src:gp'guid'
	skillInfo.effect = {}
	local dodgeList = {}
	local hitList = {}
	local criList = {}
	local blockList = {}

	if skill.sceneBuffGroupID then
		BuffSys.addSceneBuffGroup( src, src:getZone().guid, skill.sceneBuffGroupID, src:gp'currPos', nil, {skilllv = skilllv} )
	end

	if not skill.onlybuff then --非纯粹加buff的技能
		local totaldam = 0
		local isDeath
		for _, tar in pairs( eList ) do
			local rettable = SkillManage.skillEffect(src,tar,skill)    --目前暂不考虑宠物类造成的伤害
			local hitret = rettable.hitType
			if hitret ~= eHitType.dodge then
				skillInfo.effect[ tar:gp'guid' ] = {}
				if hitret == eHitType.normal then				
					hitList[ #hitList + 1 ] = tar:gp'guid'
				end
				if hitret == eHitType.crit then
					hitList[ #hitList + 1 ] = tar:gp'guid'
					criList[ #criList + 1 ] = tar:gp'guid'
					tar:onCri(src, skill.id)
					if not extdata.buffskill then
						SkillManage.criToGiftPro( src, tar )
						SkillManage.getCriGiftPro( tar )
					end
				end
				if hitret == eHitType.block then
					hitList[ #hitList + 1 ] = tar:gp'guid'
					blockList[ #blockList + 1 ] = tar:gp'guid'
				end
				if tar:canHitMove(skill) then
					local newPos = extdata.eposes[tar:gp"guid"]
					if newPos then
						tar:setCurrPos( newPos.x, newPos.y )
					end
				end
			-- local hit = SkillManage.hitPro( isadvr and host or src, tar, skill )
			-- if( hit ) then
			-- 	skillInfo.effect[ tar:gp'guid' ] = {}
			-- 	hitList[ #hitList + 1 ] = tar:gp'guid'
			-- 	local cri = SkillManage.criPro( isadvr and host or src, tar, skill )
			-- 	if( cri ) then
					-- criList[ #criList + 1 ] = tar:gp'guid'
					-- tar:onCri(src, skill.id)
					-- if not extdata.buffskill then
					-- 	SkillManage.criToGiftPro( src, tar )
					-- 	SkillManage.getCriGiftPro( tar )
					-- end
			-- 	end
				-- if tar:canHitMove(skill) then
				-- 	local newPos = extdata.eposes[tar:gp"guid"]
				-- 	if newPos then
				-- 		tar:setCurrPos( newPos.x, newPos.y )
				-- 	end
				-- end
			-- 	local skillInfoExt = { maintargetguid=targetguid, caststep=extdata.caststep }
				local dam, death
			-- 	if not src.mobaatk then
			-- 		dam, death = SkillManage.effectTypePro( src, tar, skill, cri, skillInfo.effect[ tar:gp'guid' ], srcskill, skillInfoExt )
			-- 	else
			-- 		dam, death = SkillManage.mobaTypePro( src, tar, skill, cri, skillInfo.effect[ tar:gp'guid' ] )
			-- 	end
				dam,death = SkillManage.effectTypePro(src,tar,skill,rettable,skillInfo.effect[tar:gp'guid'])
				if death then isDeath = death end
				SkillManage.stateInterupt(tar, src, skill)
				if targetguy and tar == targetguy and skill.targetBuffGroupID then
					for _, buffgroupid in next, skill.targetBuffGroupID do
						SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
					end
				end

				if( skill.hitBuffGroupID ) then
					SkillManage.addHitBuff(src, tar, skill, skilllv)
				end

				if( skill.criBuffGroupID ) then --暴击后概率触发buff
					for i=1, #skill.criBuffGroupRate do
						local rand = math.random(1, 1000)
						if rand <= skill.criBuffGroupRate[i] then
							SkillManage.addBuff(src, tar, skill.criBuffGroupID[i], {skill=skill.id, skilllv = skilllv})
						end
					end
				end

				totaldam = totaldam + dam
				if not extdata.buffskill then
					SkillManage.attacksGiftSelfPro( src, tar )
				end

				if tar and tar:gp'type' ~= 'role' and tar.nomovongoto then
					tar:stop()
				end
			else
				dodgeList[ #dodgeList + 1 ] = tar:gp'guid'
				tar:onMiss(src, skill.id)
			end
		end

		-- 给友军加buff
		if skill.friendBuffGroupID and fList then
			for _, tar in next, fList do
				for _, buffgroupid in next, skill.friendBuffGroupID do
					SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
				end
			end
		end

		if #hitList >0 then
			if not extdata.buffskill then
				SkillManage.hitGiftPro( src )
			end
			if #criList >0 then
				if not extdata.buffskill then
					SkillManage.criGiftPro( src )
				end
			end
		end

		if( isDeath ) and not extdata.buffskill then
			SkillManage.killGiftPro( src, tarpos )
		end

		skillInfo.dodgeList = dodgeList
		skillInfo.blockList = blockList
		skillInfo.hitList = hitList
		skillInfo.criList = criList
		skillInfo.buffskill = extdata.buffskill

		if( skill.useRange == CFG_USERANGES.SINGLE_ENEMY or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_ALL or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_TRA
			or skill.useRange == CFG_USERANGES.CIRCLE_ENEMY_NUMBER or skill.useRange == CFG_USERANGES.SELF
			or skill.useRange == CFG_USERANGES.SELF_OR_SINGLE_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLFRIEND
			or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENEMY or skill.useRange == CFG_USERANGES.CIRCLE_SELF_SOMEENEMY
			or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_FRIEND or skill.useRange == CFG_USERANGES.CIRCLE_SELF_ALLENTITY
			or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_MONSTER or skill.useRange == CFG_USERANGES.SINGLE_ENEMY_ROLE
			) then
			CallRound( isadvr and host or src, true, true).AttackTo{ FGUID = src:gp'guid', TGUID = targetguid, SkillInfo = skillInfo, SkillID = skill.id,  ExtData = extdata }
			if( src:gp'type' == 'role' ) then
				CallEntity( src ).AttackInfo{ SkillID = skill.id, SkillGUID = skillguid, Info = skillInfo }
			elseif( src:gp'type' == 'summon' ) then
			 	CallEntity( src:getHost() ).AttackInfo{ SkillID = skill.id, SkillGUID = skillguid, Info = skillInfo }
			end
		elseif( skill.useRange == CFG_USERANGES.POINTLINE or skill.useRange == CFG_USERANGES.CIRCLE_POINT_ALLENEMY or skill.useRange == CFG_USERANGES.SECTOR or skill.useRange == CFG_USERANGES.LINE ) then
			CallRound(isadvr and host or src, true, true).AttackToPoint{ FGUID = src:gp'guid', TGUID = targetguid, SkillInfo = skillInfo, SkillID = skill.id,
					Point = {targetpos[1], targetpos[2]}, ExtData = extdata}
			if( src:gp'type' == 'role' ) then
				CallEntity( src ).AttackInfo{ SkillID = skill.id, SkillGUID = skillguid, Info = skillInfo }
			elseif( src:gp'type' == 'summon' ) then
			 	CallEntity( src:getHost() ).AttackInfo{ SkillID = skill.id, SkillGUID = skillguid, Info = skillInfo }
		    end
		end
		src.stateMachine:changeState( State_idle.new( src ) )

		-- 特殊效果
		if skill.speEffectFinal then
			SkillManage.specialEffectFinal(srcEntity, nil, skill, effectInfo, totaldam)
		end
	else --纯粹加buff的技能
		for _, tar in pairs( eList ) do
			if targetguy and tar == targetguy and skill.targetBuffGroupID then
				for _, buffgroupid in next, skill.targetBuffGroupID do
					SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
				end
			end

			if( skill.hitBuffGroupID ) then
				SkillManage.addHitBuff(src, tar, skill, skilllv)
			end
		end

		-- 给友军加buff
		if skill.friendBuffGroupID and fList then
			for _, tar in next, fList do
				for _, buffgroupid in next, skill.friendBuffGroupID do
					SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
				end
			end
		end
		if not extdata.buffskill then
			SkillManage.attackGiftOtherPro( src, targetguy )
			SkillManage.useSkillTarGiftPro( src, targetguy, skill.category )
		end
	end
	--连招处理
	if( src:gp'type' == 'role' ) then
		src:proSerSkill( srcskill )
		local zone = src:getZone()
		onUseSkill{ entity = src, srcid = srcskill.id, trueid = skill.id, zoneid = zone.id }
		if not extdata.buffskill then
			SkillManage.useSkillSelfGiftPro( src, skill.category, skill )
			SkillManage.useSkillLink( src, skill.category, targetguy )
			SkillManage.attackSchemeGift(src, targetguid, targetpos)
		end
	elseif src:gp'type' == 'monster' and src:getZone() then
		onMonSkill{zoneid = src:getZone().id, entity = src, skillid = skill.id}
	end
	src._autosrcskill = skill.id 				--用于验证autoserskill
	if not extdata.buffskill then
		SkillManage.attackGiftSelfPro( src, skill )
	end
end

-- 怪物使用引导技能
function SkillManage.monSkillLead(src, skill, srcskill, targetguid, targetpos, skillguid, isrobot)
	if( skill.leadTime ) then
		src.stateMachine:changeState( State_lead.new( src, skill, skillguid, srcskill, targetguid, targetpos, isrobot ) )
	else
		src.stateMachine:changeState( State_idle.new( src ) )
	end
end

function SkillManage.monLeadEffect(src, skill, srcskill, targetguid, targetpos, skillguid, step)
	local eList, extdata, fList = {}, {}, {}
	local zone = src:getZone()
	if not zone then return end
	local targetguy = zone:getEntity( targetguid )
	eList, fList, extdata.atkdir, extdata.atkpos, extdata.eposes, extdata.oldatkpos
		= SkillManage.monPreUseSkill(src, skill, targetguid, targetpos, targetguy)
	SkillManage.leadEffect(src, skill, eList, step, extdata, targetguid )
end

-- 引导技能生效
function SkillManage.leadEffect(src, skill, eList, step, extdata, targetguid )
	local skillInfo, dodgeList, hitList, criList,blockList = {}, {}, {}, {}, {}, {}
	skillInfo.effect = {}
	src._autosrcskill = skill.id
	local skilllv = SkillManage.getSkillLevel(src, skill, skill)
	-- if src:gp"type" == 'role' then
	-- 	skilllv = SkillGift.skillLvById(src, skill.id, srcskill and srcskill.id) or skill.level
	-- else
	-- 	skilllv = skill.level
	-- end
	local isadvr = src:gp'type'=='advisor'
	local host = isadvr and src:getHost()
	if isadvr and not host then return end
	if( skill.fireBuffGroupID ) then
		local buffsrc = isadvr and host or src
		for _, buffgroupid in next, skill.fireBuffGroupID do
			SkillManage.addBuff(buffsrc, buffsrc, buffgroupid, {num=#eList, skill=skill.id, skilllv = skilllv})
		end
	end
	local stepindex = extdata.stepindex -- 引导技能的伤害系数索引
	for _, tar in pairs( eList ) do
		-- local hit = SkillManage.hitPro( isadvr and host or src, tar, skill )
		local rettable = SkillManage.skillEffect(src,tar,skill)
		if rettable.hitType == eHitType.dodge then
			dodgeList[ #dodgeList + 1 ] = tar:gp'guid'
		else
			local hitret = rettable.hitType
			skillInfo.effect[ tar:gp'guid' ] = {}
			if hitret == eHitType.normal then				
				hitList[ #hitList + 1 ] = tar:gp'guid'
			end
			if hitret == eHitType.crit then
				hitList[ #hitList + 1 ] = tar:gp'guid'
				criList[ #criList + 1 ] = tar:gp'guid'
			end
			if hitret == eHitType.block then
				blockList[ #blockList + 1 ] = tar:gp'guid'
			end
			-- local skillInfoExt = { stepindex = stepindex, maintargetguid = targetguid }
			-- if not src.mobaatk then
				-- SkillManage.effectTypePro( src, tar, skill, cri, skillInfo.effect[ tar:gp'guid' ], skill, skillInfoExt )
			-- else
			-- 	SkillManage.mobaTypePro( src, tar, skill, cri, skillInfo.effect[ tar:gp'guid' ] )
			-- end
			SkillManage.effectTypePro(src,tar,skill,rettable,skillInfo.effect[tar:gp'guid'])
			if tar:canHitMove(skill) then
				local newPos = extdata.eposes[tar:gp"guid"]
				tar:setCurrPos( newPos.x, newPos.y )
			end
			if skill.targetBuffGroupID then
				for _, buffgroupid in next, skill.targetBuffGroupID do
					SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
				end
			end

			if( skill.hitBuffGroupID ) then
				for _, buffgroupid in next, skill.hitBuffGroupID do
					SkillManage.addBuff(src, tar, buffgroupid, {skill=skill.id, skilllv = skilllv})
				end
			end
		end
	end

	skillInfo.dodgeList = dodgeList
	skillInfo.hitList = hitList
	skillInfo.criList = criList
	skillInfo.blockList = blockList

	CallRound( src, false, true ).LeadInfo{ FGUID = src:gp'guid', SkillInfo = skillInfo, SkillID = skill.id, ExtData = extdata }

	if( stepindex==1 and step == math.floor( skill.leadTime/skill.leadEffectTime[1] ) ) then
		CallRound( src ).CancelLead{ GUID = src:gp'guid', Flag = 'finish' }
		src.stateMachine:changeState( State_idle.new( src ) )
	end
end

--玩家技能leadeffect
function SkillManage.skillLead(src, skill, targetguid, targetpos, skillguid, step, extdata)
	if step == 1 then
		if skill.cost_type and src:gp(skill.cost_type) < skill.cost_num then
			return
		end
		local cost = skill.cost_type
		if cost then
			if cost == 'hp' then
				src:modifyHp(src:gp'guid', -skill.cost_num, {}, 'skillcost')
			elseif cost == 'mp' then
				src:modifyMp(src:gp'guid', -skill.cost_num)
			elseif cost == 'energe' then
				src:modifyEnerge(src:gp'guid', -skill.cost_num)
			end
		end
		if skill.energe_gain then
			src:modifyEnerge(src:gp'guid', skill.energe_gain)
		end
	end
	local eList, fList, atkdir = SkillManage.rolePreUseSkill(src, skill, targetguid, targetpos, targetguy, extdata)
	-- _js("引导技能选中的目标", skill.id, skillguid, step, #eList)
	-- dump(eposes)
	SkillManage.leadEffect(src, skill, eList, step, extdata, targetguid )
end

--天赋抗性处理(只抗概率)
function SkillManage.giftProBuffHit( srcEntity, tarEntity, groupCFG )
	return 0
end

cdefine.c.SetLeadPoint{ GUID = 0, SkillID = -1, Point = EMPTY }
when{} function SetLeadPoint( GUID, SkillID, Point )
	local r = GsRole.byNet(_from)
	if not r then return end

	local state = r.skillStage
	if( state and state.flag == 'lead' and state.skill.id == SkillID ) then
		state.point = { Point[1], Point[2] }

		CallRound( r ).SetLeadPoint{ GUID = GUID, SkillID = SkillID, Point = Point }
	end
end


-----------------PVP----------
cdefine.cs.ChangePVPModel{ Token = '', Model = -1}
when{}function ChangePVPModel( Token, Model )
	local role = GsRole.byToken( Token )
	role:setPVP( 'model', Model )
	--_js('----gs change model--', Model)
end
cdefine.cs.ChangeCusModel{ Token = '', Index = -1, State = false }
when{}function ChangeCusModel( Token, Index, State )
	local role = GsRole.byToken( Token )

	if( Index == 1 ) then
		role:setPVP( 'custom1', State )
	elseif( Index == 2 ) then
		role:setPVP( 'custom2', State )
	elseif( Index == 3 ) then
		role:setPVP( 'custom3', State )
	elseif( Index == 4 ) then
		role:setPVP( 'custom4', State )
	end
	--_js('----gs change cusmodel--', Index, State)
end
------------------------------
