module("battle",package.seeall)


Scene = class()
function Scene:Ctor()
	self.m_obj_mgr = Object_manager:new()--关卡管理器
	self.m_stars = {}--3个元素，true or false，关卡星星
	self.m_trigger_mgr = TriggerManager:new()--触发器管理器
	self.m_events = {}
	self.m_marks = {}--mark点
	self.m_road_info = nil--通路信息
	self.m_time = 0--关卡时间
	self.m_area_manager = AreaMgr:new()
end


--加载场景配置
--场景配置包括地图通路信息，地图中的触发区域，地图中的mark点，地图中的机关
function Scene:load_scene(v_scene_cfg)
	--加载通路信息
	self.m_road_info = v_scene_cfg.road_info
	--加载区域
	self.m_area_manager:load(v_scene_cfg.areas)
	--加载mark点区域
	for mark_tag,mark_point in ipairs(v_scene_cfg.mark) do
		self.m_marks[mark_tag] = mark_point
	end
	--加载手动机关
	for _i,trigger_info in ipairs(v_scene_cfg.trigger) do
		local new_trigger_object = TriggerObject:new()
		new_trigger_object:ini(trigger_info)
		self.m_obj_mgr:add_instence(new_trigger_object)
	end
	--加载宝箱
	--XXXXXXX
	--加载战斗机关
	--XXXXXXXX
	--加载空气墙
	--XXXXXXX
end




function Scene:load_level_cfg(v_level_id)--加载关卡配置
	local cfgs = require("level_spawn")
	local cfg = cfgs[v_level_id]
	self.monster_groups = cfg.monsterGroup
	self.triggers = cfg.triggers
	self.events = cfg.events
	self.birth_mark = cfg.birth
	self.star_info = {cfg.star[1],cfg.star[2],cfg.star[3]}
	self.enter = cfg.enter
	self.m_trigger_mgr:load_cfg(cfg.triggers)
	local event_cfgs = cfg.events
	for _i,event_cfg in ipairs(event_cfgs) do
		table.insert(self.m_events,Event.create_from_cfg(event_cfg))
	end

	--向客户端发送场景相关数据
	--XXXXXXX
	
end


function Scene:enter()--进入场景
	for _i,trigger_id in ipairs(self.enter.triggers) do
		self.m_trigger_mgr:add_trigger(trigger_id)
	end
	for _i,event_id in ipairs(self.enter.execute_events) do
		self.self.m_events[event_id]:execute()
	end
end
function Scene:begin()--战斗开始
	self.time = 0
end
function Scene:handle_skill(v_src,v_skillid,v_skill_tarinfo)--释放技能
	--根据技能范围，选取目标，根据mask决定是否受到影响
end
function Scene:on_instence_die(v_instence)--实例死亡
	self.m_obj_mgr:remove_instence(v_instence)
	local msg = {}
	msg.tag = v_instence.tag
	self.m_trigger_mgr:on_msg("monsters_die",msg)
end
function Scene:open_trigger_request(v_oPlayer,v_trigger_guid)
	--玩家开启机关的请求
end



function Scene:create_monster(v_strmark,v_group_id)
	
end

function Scene:gain_star(v_loc)
	
end

function Scene:lose_star(v_loc)
	
end

function Scene:win_game()
	-- body
end

function Scene:lose_game()
	-- body
end

function Scene:set_valid(v_tag,v_val)

end

function Scene:set_trigger(v_trigger_id)
	self.m_trigger_mgr:add_trigger(v_trigger_id)
end

function Scene:unload_trigger(v_trigger_id)
	self.m_trigger_mgr:unload_trigger(v_trigger_id)
end

function Scene:on_logic(v_dt)--逻辑帧
	
	
end