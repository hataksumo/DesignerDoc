module("battle_scene",package.sellall)

--战斗场景的基类
Scene = class()
function Scene:Ctor()
	self._guidCreator = GUID_Creator:new()--guid生成器
	self._oPlayerMgr = PlayerMgr:new()--玩家
	self._oMonsterMgr = MonsterMgr:new()--怪物（可移动，可攻击的对象）
	self._oRBQMgr = MonsterMgr:new()--肉便器（只能被杀等死的对象）
	self._oIntrigueMgr = Intrigue:new()--机关
	self._oMapRoadInfo = MapRoadInfo:new()--地图通路信息
	self._oSkillBulletMgr = SkillBulletMgr:new()--子弹管理器
	self._oTriggerMgr = TriggerMgr:new()--触发器管理器
	self._arrEvents = {}--存放各设定的事件
	self._arroClock = {}--存放各时钟
	self._name = "deffault"
end

--***************************************玩家移动操作*****************************
--使玩家的移动朝向设置为选定方向，在逻辑帧中才进行移动
--[[param:
	v_iPlayerId		:		玩家ID
	v_vecDir		:		移动方向,该值为空时
]]
function Scene:player_move(v_iPlayerId,v_vecDir)
	local oBattlePlayer = self._oPlayerMgr:get_player(v_iPlayerId)
	if not oBattlePlayer then
		Debug.Error("can't find the player in "..self._name..". player id is "..v_iPlayerId)
		return
	end
	oBattlePlayer:set_move_dir(v_vecDir)
end

--***************************************玩家停止移动操作*****************************
--[[param:
	v_iPlayerId		:		玩家ID
]]
function Scene:player_stop_move(v_iPlayerId)
	local oBattlePlayer = self._oPlayerMgr:get_player(v_iPlayerId)
	if not oBattlePlayer then
		Debug.Error("can't find the player in "..self._name..". player id is "..v_iPlayerId)
		return
	end
	oBattlePlayer:set_move_dir(nil)
end



--***************************************玩家释放技能*******************************
--用于接收玩家的释放技能操作
--[[param:
	v_iPlayerId		:		玩家ID
	v_iSkillId		:		技能ID
	v_tCastInfo		:		技能释放的数据，是一个表
		{
			iTarGuid		:		目标在场景的guid
			vec2Anchor		:		目标中心
			vec2Orient		:		技能朝向
		}
]]
function Scene:player_cast_skill(v_iPlayerId,v_iBulletId,v_tCastInfo)
	local oBattlePlayer = self._oPlayerMgr:get_player(v_iPlayerId)
	if not oBattlePlayer then
		Debug.Error("can't find the player in "..self._name..". player id is "..v_iPlayerId)
		return
	end

	local oSkillBullet = SkillBulletMgr.Create(v_iBulletId)
	oSkillBullet:init(oBattlePlayer,v_tCastInfo)
	self._oSkillBulletMgr:add_bullet(oSkillBullet)


end

--************************************场景怪物的释放技能********************************
--[[param:
	v_iObjGuid		:		场景对象的guid
	v_iSkillId		:		技能ID
	v_tCastInfo		:		技能释放的数据，是一个表
]]
function Scene:monster_cast_skill(v_iObjGuid,v_iSkillId,v_tCastInfo)
	local oBattlePlayer = self._oPlayerMgr:get_player(v_iPlayerId)
	if not oBattlePlayer then
		Debug.Error("can't find the player in "..self._name..". player id is "..v_iPlayerId)
		return
	end
	local oAutomSkillInstence = Skill_Mgr:create_skill_instence(oBattlePlayer,v_tCastInfo)
	local oSkill_bullet = oAutomSkillInstence:create_instence()
	self._oSkillBulletMgr:add_bullet(skill_bullet)

end


--**********************************场景单位释放技能子弹**********************************



--**********************************子弹生效****************************************
--保护函数，处理一个子弹的生效
--[[param:
	v_oSkillBullet		:		子弹实例
]]
function Scene:_bullet_effect(v_oSkillBullet)
	local bullet_tar_type = v_oSkillBullet:get_type()
	local tArea = v_oSkillBullet:get_area()
	local tar_players = self._oPlayerMgr:get_hit_objs(v_oSkillBullet.hitMask)
	local tar_monsters = self._oMonsterMgr:get_hit_objs(v_oSkillBullet.hitMask)
	local tar_rbqs = self._oRBQMgr:get_hit_objs(v_oSkillBullet.hitMask)
	local arr_tars = {tar_players,tar_monsters,tar_rbqs}

	if v_oSkillBullet._target then
		if v_oSkillBullet:is_prepared() then
			self:_fire(v_oSkillBullet._oCaster,v_oSkillBullet._oTarget,v_oSkillBullet.cfg)
		end
	else
		for _i,tars in ipairs(arr_tars) do
			for _j,tar in ipairs(tars) do
				if tArea:is_in(tars:get_area()) then
					self:_fire(v_oSkillBullet._oCaster,tar,v_oSkillBullet.cfg)
				end
			end
		end
	end



end


function Scene:_fire(v_oCaster,v_oSuffer,v_tBulletCfg)
	--处理伤害和BUFF



end




--**************************************玩家打开机关*********************************
--[[param:
	v_iPlayerId			:		玩家ID
	v_iIntrigueGuid		：		场景内机关的guid	
]]
function Scene:player_open_trigger(v_iPlayerId,v_iIntrigueGuid)
	local oIntrigue = self._oIntrigueMgr:get_intrigue(v_iIntrigueGuid)
	oIntrigue:open(v_iPlayerId)
end



--***********************************场景中对象的移动操作*****************************
--使场景对象的移动朝向设置为选定方向，在逻辑帧中才进行移动，如果v_vecDir为空，则停止移动
--[[param:
	v_iObjGuid		:		场景对象的guid
	v_vecDir		:		移动方向,该值为空时
]]
function Scene:obj_move(v_iObjGuid,v_vecDir)
	local oBattleMonster = self._oMonsterMgr:get_object(v_iObjGuid)
	if not oBattleMonster then
		Debug.Error("can't find the player in "..self._name..". player id is "..v_iPlayerId)
		return
	end
	oBattleMonster:set_move_dir(v_vecDir)
end



--***********************************逻辑帧事件****************************************
--[[param:
	v_dt		:		和上一次执行逻辑帧间隔多少秒
]]
function Scene:on_tick(v_dt)
--[[逻辑帧中，做以下事情:
]]
	--#1更新个场景对象的位置
	local arrPlayers = self._oPlayerMgr:get_objs()
	local arrMonsters = self._oMonsterMgr:get_objs()
	local moveObjs = {arrPlayers,arrMonsters}
	for _i,arr in ipairs(moveObjs) do
		for _j,oMoveObj in ipairs(arr) do
			local org_pos = oMoveObj:get_pos()
			local tar_pos = org_pos + oMoveObj:get_speed() * v_dt
			if self._oMapRoadInfo:can_through(org_pos,tar_pos) then
				oMoveObj:trans(tar_pos)
			end
		end
	end
	--#2调用各时钟的on_tick
	--#3向trigger_manager发送"on_tick"消息
	--#4调用各AI对象的on_tick
	local ai_objs = {}
	ai_objs[1] = self._oMonsterMgr:get_objs()
	for _i,arr in ipairs(ai_objs) do
		for _j,oAiObj in ipairs(arr) do
			oAiObj:on_tick(v_dt)
		end
	end
	--#5处理子弹伤害
	local oArrBullets = self._oSkillBulletMgr:get_objs()
	for _i,oBullet in ipairs(oArrBullets) do
		self:_bullet_effect(oBullet)
	end
	--#6处理子弹移动
	for _i,oBullet in ipairs(oArrBullets) do
		oBullet:on_tick(v_dt)
	end
	--#7把各死亡的对象回收
	self._oPlayerMgr:clear_died()
	self._oMonsterMgr:clear_died()
	self._oIntrigueMgr:clear_died()
	self._oSkillBulletMgr:clear_died()
end

--***********************************物体死亡回调**************************************
--[[param:
	v_iObjGuid		:		死亡对象的guid
	v_tReason		:		死亡原因
		{
			iObjSrcGuid		:		杀掉这个对象的对象的guid
			oSkillInstence 	:		杀掉这个对象的技能实例
			tSkillEffect	:		杀掉这个对象的技能效果
		}
]]
function Scene:on_die(v_oObj,v_tReason)--一般用于死亡通告，或者
	if class.is(v_oObj,"player") then
		v_tReason.oSkillInstence:on_kill_player(v_oObj)
	elseif class.is(v_oObj,"monster") then
		v_tReason.oSkillInstence:on_kill_monster(v_oObj)
	end
	local trigger_msg = {}
	trigger_msg.tag = v_oObj.tag
	self._oTriggerMgr:on_msg("on_die",trigger_msg)
end

--********************************玩家进入场景*****************************************
--[[param:
	v_iPlayerId		:		玩家的ID
]]
function Scene:player_enter(v_iPlayerId)
	local oPlayer = self._oPlayerMgr:create_player(v_iPlayerId)
	self._oPlayerMgr:add_obj(oPlayer)
end


--********************************玩家离开场景*****************************************
--[[param:
	v_iPlayerId		:		玩家的ID
]]
function Scene:player_exit(v_iPlayerId)
	self._oPlayerMgr:remove_obj(oPlayer)
end

--********************************创建一个怪物*****************************************
--[[param:
	v_iMonId		:		怪物ID
	v_vec2Pos		:		出生位置
]]
function Scene:create_monster(v_iMonId,v_vec2Pos)
	local oBattleMonster = self._oMonsterMgr:get_monster(v_iMonId)
	if not oBattlePlayer then
		Debug.Error("can't find the monster in "..self._name..". monster id is "..v_iMonId)
		return
	end
	local oAutomSkillInstence = Skill_Mgr:create_skill_instence(oBattlePlayer,v_tCastInfo)
	local skill_bullet = oAutomSkillInstence:create_instence()
	self._oSkillBulletMgr:add_bullet(skill_bullet)
end
--********************************使一个路障打开或关闭*********************************
--[[param:
	v_sRoadTag		:		路障的tag
	v_bOpen			:		打开为true，关闭为false	
]]
function Scene:set_roadblock(v_sRoadTag,v_bOpen)
	
end