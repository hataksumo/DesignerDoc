module("battle_scene",package.seeall)

Object_manager = class()
function Object_manager:Ctor()
	self.m_instence = {}--guid为键，放Object对象
	self.m_aiguids = {}--数组，存放guid
	self.m_tags = {}--tag名为键，值为guid的数组
	self.players = {}
	self.players[1] = {}--玩家阵营1
	self.players[2] = {}--玩家阵营2
end

function Object_manager:add_instence(vobj_instence)
	local guid = vobj_instence.guid
	if not guid then
		Debug.Error("vobj_instence don't has guid")
		return
	end
	self.m_instence[vobj_instence.guid] = vobj_instence
	if vobj_instence.tag then
		local tag_pool = self.m_tags[vobj_instence.tag]
		if not tag_pool then
			self.m_tags[vobj_instence.tag] = {}
			tag_pool = self.m_tags[vobj_instence.tag]
		end
		table.insert(tag_pool,guid)
	end

	if class:Is(vobj_instence,"player") then
		table.insert(self.players[vobj_instence.part],guid)
	end

	if class:Is(vobj_instence,"AI_object") then
		table.insert(self.m_aiguids)
	end

end


function Object_manager:remove_instence(vobj_instence)
	local guid = vobj_instence.guid
	if not guid then
		Debug.Error("vobj_instence don't has guid")
		return
	end
	self.m_instence[vobj_instence.guid] = nil
	if vobj_instence.tag then
		local tag_pool = self.m_tags[vobj_instence.tag]
		Array.remove(tag_pool,guid)
		-- if #tag_pool == 0 then
		-- 	self.m_tags[vobj_instence.tag] = nil
		-- end
	end

	if class:Is(vobj_instence,"player") then
		Array.remove(self.players[vobj_instence.part],guid)
	end

	if class:Is(vobj_instence,"AI_object") then
		Array.remove(self.m_aiguids)
	end
	vobj_instence:finalize()
end

function Object_manager:get_instence(v_guid)
	return self.m_instence[v_guid]
end

function Object_manager:select(v_area)
	local rtn = {}
	for guid,obj in pairs(self.m_instence) do
		if v_area:is_in(obj.transform.position) then
			table.insert(rtn,obj)
		end
	end
	return rtn
end

function Object_manager:update(v_dt)
	for _i,guid in ipairs(self.m_aiguids) do
		self.m_instence[guid]:on_tick(v_dt)
	end
end


e_battle_obj_type = {
	default = 0,
	player = 1,
	monster = 2,
	area	= 3,
	can_break = 4,
}

e_battle_obj_shape = {
	round = 1,
	rectangle = 2,
}


Object = class()
function Object:Ctor()
	self.type = e_battle_obj_type.default
	--0x01玩家，0x02怪物，0x04NPC，0x08可破坏物，0x10中立
	self.hitmask = 0x05--攻击玩家和可破坏物和NPC
	self.heal_mask = 0x02--治疗怪物
	self.mask = 0x02 --自身受击掩码
	self.obj = nil--实际的对象
	self.guid = Guid:get_instence():create_id()
	self.trans = nil
end

function Object:finalize()
	Guid:get_instence():recycl_guid(self.guid)
end

function Object:on_receive_msg(v_strmsg)
	if self.ai then
		self.ai:on_msg(v_strmsg)
	end
end

function Object:init(v_cfg)
	local cfg_trans = v_cfg.transform
	if cfg_trans then
		self.trans = Transform:New()
		if cfg_trans.pos then
			self.trans.position = Vector3:New(cfg_trans.pos.x,cfg_trans.pos.y,cfg_trans.pos.z)
		end
		if cfg_trans.rotation then
			self.trans.rotation = Quaternion:New(cfg_trans.rot.x,cfg_trans.rot.y,cfg_trans.rot.z)
		end
		if cfg_trans.scale then
			self.trans.scale = Vector3:New(cfg_trans.scale.x,cfg_trans.scale.y,cfg_trans.scale.z)
		end
	end
end


AreaMgr = class()
function AreaMgr:Ctor()
	self.m_areas = {}
	self.m_tags = {}
end

function AreaMgr:load_cfg(v_cfg)
	for _i,cfg in ipairs(v_cfg) do
		local area = Area:new()
		area:ini(cfg)
		table.insert(self.m_areas,area)
		local arr = self.m_tags[area.guid]
		if not arr then
			arr = {}
			self.m_tags[area.guid] = arr
		end
		table.insert(arr,area.guid)
	end
end

function AreaMgr:test(v_x,v_y)
	local rtn = {}
	for _i,area in ipairs(self.m_areas) do
		if area:is_in(v_x,v_y) then
			table.insert(rtn,area)
		end
	end
	return rtn
end



Area = class(Object)
function Area:Ctor()
	
end
function Area:ini(v_cfg)
	Object.init(self,v_cfg)
	self.active = false
	self.shape = v_cfg.shape
	if area_info.shape == e_battle_obj_shape.round then
		self.r = v_cfg.r
	elseif area_info.shape == e_battle_obj_shape.rectangle then
		self.rotation = Quaternion:new(v_cfg.rotate)
		self.a = v_cfg.a
		self.b = v_cfg.b
	end
end

function Area:is_in(v_x,v_y)
	if self.shape = e_battle_obj_shape.round then
		local pos = self.transorm.position
		return math3d.distense(pos,vector3:New(v_x,0,v_y)) < self.r
	else if self.shape = e_battle_obj_shape.rectangle then
		local test_pos = vector3:New(v_x,0,v_y)
		local dir_dif = vector3:New(v_x - self.x,0,v_y - self.y)
		dir_dif = dir_dif * (-self.rotation)
		return dir_dif.x >= -self.a/2 and dir_dif.x <= -self.a/2 and dir_dif.y >= -self.b/2 and dir_dif.y <= self.b/2
	end
end


TriggerManager = class()
function TriggerManager:Ctor(v_battle_scene)
	self.m_trigers = {}--键为guid,值为触发器对象
	self.m_scene = v_battle_scene
end

--加载机关
function TriggerManager:load_triggers()
	
end

--加载宝箱
function TriggerManager:load_box()
	-- body
end

function TriggerManager:on_time(v_dt)
	for guid,oTrigger in pairs(self.m_trigers) do
		local  finished_players,useout = oTrigger:on_time(v_dt)
		--self:battle_scene:on_open_trigger(finished_players)
		for _i,finished_player in ipairs(finished_players) do
			self:battle_scene:on_open_trigger(finished_player,self)
		end
		if useout then
			self:remove_trigger(oTrigger.guid)
		end
	end
end

function TriggerManager:remove_trigger(v_guid)
	-- body
end

function TriggerManager:add_trigger(v_guid)
	-- body
end



--机关,开启后触发事件
TriggerObject = class(Object)
function TriggerObject:Ctor()
	
end
function TriggerObject:init(v_cfg)
	Object.init(self,v_cfg)
	self.reachr = v_cfg.r
	self.times = v_cfg.times or 1--术士拉糖
	self.mutual = v_cfg.mutual
	if not self.mutual then self.mutual = true end
	if self.mutual then
		self.mutex = 0
	end
	self.finish_process = v_cfg.process or 0
	self.process = {}--存玩家的对象，时间
end

function TriggerObject:can_reach(v_x,v_y)
	local dis = math3d.distense(Vector3:New(v_x,0,v_y),self.transform.position)
	return dis <= self.reachr
end

function TriggerObject:begin_open_trigger(v_obj_player)
	if self.mutex and self.mutex > 0 then
		local msg = Msg_pb.Err()
		msg.reason = xxx
		msg.guid = self.guid
		msg.playerid = v_obj_player.guid
		Connector:get_instence():send_msg(msg)
		return
	end
	self.mutex = self.mutex + 1
	local process_data = {}
	process_data.player = v_obj_player
	process_data.time = 0
	table.insert(self.process,process_data)


end

function TriggerObject:on_time(v_dt)
	local finished_players = {}
	for _i,process_data in ipairs(self.process) do
		process_data.time = process_data.time + v_dt
		if process_data.time >= self.finish_process then
			table.insert(finished_players,process_data.oPlayer)
			self:on_finish_open(v_obj_player)
			if self.times == 0 then
				self:on_useout()
				break
			end
		end
	end

	Array.remove_if(self.process,function(v_data)
		return v_data.time >= self.finish_process
	end)

	return finished_players,self.times == 0
end

function TriggerObject:cancle(v_obj_player)
	self.mutex = self.mutex - 1
	self.process[v_obj_player.guid] = nil
end


function TriggerObject:on_finish_ope(v_obj_player)
	self.mutex = self.mutex - 1
	self.times = self.times - 1
	--其他掉落，加BUFF相关逻辑
	--XXXXXXXX
end

function TriggerObject:on_useout()
	-- 通知其他开启该宝箱的玩家，这个宝箱已经被开了
end




AI_object = class(Object)
function AI_object:Ctor()
	
end

function AI_object:on_tick(v_dt)
	Debug.Error("AI_object:on_tick has not been implemented")
end



--怪物
MonsterObject = class(AI_object)
function MonsterObject:Ctor()
end
function MonsterObject:load_cfg(v_cfg)
	self.tag = v_cfg.tag
	self.monster_id = v_cfg.monster_id
	self.attr = 
end
function MonsterObject:on_tick(v_dt)
	if self.ai_ext and elf.ai_ext.on_tick then--如果策划配置AI，则使用AI中的on_tick
		self.ai_ext:on_tick(v_dt)
		return
	end

	--通用的移动或者攻击，AI写在这里
	--寻敌，警戒范围，脱战范围，仇恨机制，技能释放等
end

--机关兽，不会移动，但会周期释放技能
TowerObject = class(Object)
function TowerObject:Ctor()
	-- body
end

function TowerObject:load_cfg(v_cfg)
	-- body
end


