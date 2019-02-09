module("battle",package.seeall)

local fn_event_creates = {}
fn_event_creates["create_monster"] = function()
	return create_monster_event:new()
end

fn_event_creates["change_star"] = function()
	return change_star_event:new()
end

fn_event_creates["gameover"] = function()
	return gameover_event:new()
end

fn_event_creates["set_valid"] = function()
	return setvalid_event:new()
end

fn_event_creates["add_trigger"] = function()
	return add_trigger_event:new()
end

fn_event_creates["unload_trigger"] = function()
	return unload_trigger_event:new()
end


function Event.create_from_cfg(v_battle_scene,v_cfg)
	local fn_create = fn_event_creates[v_cfg.type]
	if not fn_create then
		Debug.Error("don't find"..v_cfg.type.." in fn_event_creates")
		return
	end
	local rtn = fn_create()
	rtn:init(v_battle_scene,v_cfg)
	return rtn
end



Event = class()
function Event:Ctor()
	self.m_scene = nil
end

create_monster_event = class(Event)
function create_monster_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	self.spawn = v_cfg.spawn
end

function create_monster_event:excute()
	for _i,spawn in ipairs(self.spawn) do
		self.m_scene:create_monster(spawn.loc,spawn.monster_group)
	end
end

change_star_event = class(Event)
function change_star_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	self.op = v_cfg.op
	self.loc = v_cfg.loc
end

function change_star_event:excute()
	if self.op == "gain" then
		self.m_scene:gain_star(self.loc)
	elseif self.op == "lose" then
		self.m_scene:lose_star(self.loc)
	end
end

gameover_event = class(Event)
function gameover_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	self.result = v_cfg.result
end

function gameover_event:excute()
	if self.result == "win" then
		self.m_scene:win_game()
	elseif self.result == "lose" then
		self.m_scene:lose_game()
	end
end


setvalid_event = class(Event)
function setvalid_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	self.m_key = v_cfg.key
	self.m_val = v_cfg.val
end

function setvalid_event:excute()
	self.m_scene:set_valid(self.m_key,self.m_val)
end


add_trigger_event = class()
function add_trigger_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	if v_cfg.id then
		self.ids = {v_cfg.id}
	end
	if v_cfg.ids then
		self.ids = v_cfg.ids
	end
end

function add_trigger_event:excute()
	for _i,id in ipairs(self.ids) do
		self.m_scene:add_trigger(id)
	end
end

unload_trigger_event = class()
function unload_trigger_event:init(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	if v_cfg.id then
		self.ids = {v_cfg.id}
	end
	if v_cfg.ids then
		self.ids = v_cfg.ids
	end
end

function add_trigger_event:excute()
	for _i,id in ipairs(self.ids) do
		self.m_scene:unload_trigger(id)
	end
end


send_message_event = class()
function send_message_event:Ctor(v_battle_scene,v_cfg)
	self.m_scene = v_battle_scene
	if v_cfg.tag then
		self.tags = {v_cfg.tag}
	end
	if v_cfg.tags then
		self.tags = v_cfg.tags
	end
	self.msg = v_cfg.msg
end

function send_message_event:excute()
	for _i,tag in ipairs(v_cfg.tags) do
		self.m_scene:send_message(tag,self.msg)
	end	
end
