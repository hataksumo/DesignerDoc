module("battle",package.seeall)

TriggerManager = class()
function TriggerManager:Ctor()
	self.m_arr_trigger = {}
	self.m_trigger_pool = {}
end

function TriggerManager:load_cfg(v_cfgs)
	for _i,trigger_cfg in ipairs(v_cfgs) do
		local new_trigger = nil
		new_trigger.events = trigger_cfg.events
		if trigger_cfg.type == "time_down" then
			new_trigger = time_down_trigger:new()
			new_trigger:init(trigger_cfg)
		elseif trigger_cfg.type == "monsters_die" then
			new_trigger = kill_num_trigger:new()
			new_trigger:init(trigger_cfg)
		end
		if new_trigger then
			table.insert(self.m_arr_trigger,v_trigger)
		end
	end
end

function TriggerManager:add_trigger(v_idx)
	local the_trigger = self.m_arr_trigger[v_idx]
	if not the_trigger then
		Debug.Error("self.m_arr_trigger["..v_idx.."] doesn't exist")
		return
	end
	if the_trigger.is_active then
		Debug.Error("self.m_arr_trigger["..v_idx.."] is active, it's not nessesary to add again")
	end
	the_trigger.is_active = true
	if not self.m_trigger_pool[v_trigger.listener] then
	 	self.m_trigger_pool[v_trigger.listener] = {}
	end
	table.insert(self.m_trigger_pool,v_idx)
end


function TriggerManager:unload_trigger(v_trigger)
	local pool = self.m_trigger_pool[v_trigger.listener]
	if pool then
		array.remove(pool,v_trigger)
	end
end


function TriggerManager:on_msg(v_pool_name,v_msg)
	v_pool_name = v_pool_name or "nil"
	local pool = self.m_trigger_pool[v_pool_name]
	if not pool then
		Debug.Error("can't find the trigger pool named "..v_pool_name) 
		return 
	end
	for _i,idx in ipairs(pool) do
		local the_trigger = self.m_arr_trigger[idx]
		the_trigger:on_msg(v_msg)
	end

	local tail = 1
	for _i=1,#pool do
		local the_trigger = self.m_arr_trigger[pool[_i]]
		if not the_trigger.del then
			pool[tail] = pool[_i]
			tail = tail + 1
		else
			the_trigger.del = false
			the_trigger.active = false
			pool[_i] = nil
		end
	end
end


trigger = class()
function trigger:Ctor()
	self.events = {}
	self.del = false
	self.active = false
	self.type = "base"
end

function trigger:on_msg(v_msg)
	Debug.Error("the trigger  "..self.type." haven't been implemented") 
end

function trigger:excute_events()
	for _i,the_event in ipairs(self.events) do
		the_event:execute()
	end
end

kill_num_trigger = class(trigger)
function kill_num_trigger:Ctor()
	self.type = "monsters_die"
end

function kill_num_trigger:init(v_cfg)
	self.kill_num = 0
	self.complete_num = v_cfg.num
	self.tag = v_cfg.tag
end

function kill_num_trigger:on_msg(v_msg)
	local tag = v_msg.tag
	if tag == self.tag then
		self.kill_num = self.kill_num + 1
		if self.kill_num >= self.complete_num then
			self:excute_events(v_msg)
			self.del = true
		end
	end
	return false
end


time_down_trigger = class(trigger)
function time_down_trigger:Ctor()
	self.type = "time_down"
	self.t = 0
end

function time_down_trigger:init(v_cfg)
	self.time = v_cfg.time
end

function time_down_trigger:on_msg(v_msg)
	self.t = self.t + v_msg.dt
	if self.t >= self.time then
		self:excute_events(v_battle_scene,v_msg)
		self.del = true
	end
end

