local AttrMT = {}
AttrMT.__index= function(v_table,v_key)
	local key_hash = CFG.ATTRIBUTE_INFO.uindex__ename
	local key_data = CFG.ATTRIBUTE_INFO.data
	if type(v_key) == "string" then
		if key_hash[v_key] ~= nil then
			return v_table[ key_hash[v_key] ]
		else
			return -1
		end
	elseif type(v_key) == "number" and v_key <= #v_table then
		return v_table[v_key]
	end
end

AttrMT.__newindex= function(v_table,v_key,v_val)
	local key_hash = CFG.ATTRIBUTE_INFO.uindex__ename
	local key_data = CFG.ATTRIBUTE_INFO.data
	if type(v_key) == "string" then
		if key_hash[v_key] ~= nil then
			local attr_id = key_hash[v_key]
			v_table[attr_id] = v_val
		end
	elseif type(v_key) == "number" and v_key <= #v_table then
		v_table[v_key] = v_val
	end
end



function createAttrTable()
	local rtn = {}
	for i,1,#CFG.ATTRIBUTE_INFO.data do
		table.insert(rtn,0) --初始属性为0
	end
	rtn.mt = AttrMT
end

monotone_buff_que = class()

function monotone_buff_que:Ctor()
	self.sortType = 1 --1是数组从小到大，-1是数组从大到小
	self.attr_buffs = {}--属性buff
end

function monotone_buff_que:add_buff(v_buff)
	--实现略，大致思路是，把新的buffid放到队尾，如果buff值比上一个大，则与之前的交换...
	--如果加入的buff是队头，则return true
end

function monotone_buff_que:erase_buff(v_buff)
	--把一个buff移除单调队列
	--如果删除的buff是队头，则return true
end

function monotone_buff_que:val()
	if self.attr_buffs == 0 then
		return 0
	end
	return self.attr_buffs[1].val
end


function createAttrBuffTable()
	local rtn = {}
	for i,1,#CFG.ATTRIBUTE_INFO.data do
		table.insert(rtn,monotone_buff_que:new()}) --初始属性为0
	end
	rtn.mt = AttrMT
end


EntityAttr = class()

function EntityAttr:Ctor()
	self.level--角色等级
	self.hp--角色生命
	self.mp--角色魔法
	self.behit_demage = nil--这个值不为nil时，每次受到技能攻击，只受到固定值的伤害。
	--战斗属性是经过改变的，养成属性是自带的
	self.board_attr = createAttrTable()--养成属性
	self.battle_attr = createAttrTable()--战斗属性
	--buff中全取数值最大的
	self.buff_attrs = createAttrTable()--buff属性
	self.buff_attr[1] = createAttrBuffTable()--值加成
	self.buff_attr[2] = createAttrBuffTable()--值减少
	self.buff_attr[3] = createAttrBuffTable()--值百分比加成
	self.buff_attr[4] = createAttrBuffTable()--值百分比减少
	self.state_buffs = {}--状态类BUFF
	self.trigger_buffs = {}--触发类buff


end

function EntityAttr:gen_battle_attr(v_bRefresh)
	for _i,val in ipairs(self.board_attr) do
		rawset(self.battle_attr,self.board_attr[i] * (self.buff_attr[3]:val() - self.buff_attr[4]:val()) + self.buff_attr[1]:val() - self.buff_attr[2]:val())
	end
	local formula_fac = CFG.FORMULA_FAC_INFO.data
	battle_attr.max_hp = battle_attr.max_hp * (1 + battle_attr.magnify_hp / 10000.0)
	battle_attr.max_mp = battle_attr.max_mp * (1 + battle_attr.magnify_mp / 10000.0)
	battle_attr.hp_recover = battle_attr.hp_recover * (1 + battle_attr.magnify_hp_recover / 10000.0)
	battle_attr.mp_recover = battle_attr.mp_recover * (1 + battle_attr.magnify_mp_recover / 10000.0)
	battle_attr.atk = battle_attr.atk * (1 + battle_attr.magnify_atk / 10000.0)
	battle_attr.mgatk = battle_attr.mgatk * (1 + battle_attr.magnify_mgatk / 10000.0)
	battle_attr.psdef = battle_attr.psdef * (1 + battle_attr.magnify_psdef / 10000.0)
	battle_attr.move_speed = battle_attr.move_speed * (1 + battle_attr.magnify_move_speed / 10000.0)
	battle_attr.element_atk = battle_attr.element_atk * (1 + battle_attr.magnify_element_atk / 10000.0)
	for _i=1,4 do
		local keyName = "element_def".._i
		battle_attr[keyName] = battle_attr[keyName] * battle_attr.magnify_element_def
	end
	if v_bRefresh then
		self.hp = battle_attr.max_hp
		self.mp = battle_attr.max_mp
	end
end

function EntityAttr:get_battle_score()
	local rtn = 0
	local attr_cfg = CFG.ATTRIBUTE_INFO.data 
	for _i,val in ipairs(self.battle_attr) do
		rtn = rtn + val * attr_cfg[i].battle_score_fac
	end
end

function EntityAttr:add_buff(v_buff)
	--根据buff的类型，放入对应的结构中
	--如果该操作使属性变化，则调用gen_battle_attr()，下同
end

function EntityAttr:erase_buff(v_buff,v_buffType,v_buffSubType)
	--根据buff类型和buff子类型移除buff
end

function EntityAttr:erase_buffGroup(v_buffGroup)
	--把buff组中的所有buff移除
end





-- EBoardAttrType = {
-- 	--1级属性
-- 	tongshuai = 1,--统帅
-- 	wuli = 2,--武力
-- 	zhili = 3,--智力
-- 	meili = 4,--魅力

-- 	--2级属性
-- 	max_hp = 5,--最大生命
-- 	atk = 6,--攻击力
-- 	psdef = 7,--物理防御
-- 	mgdef = 8,--魔法防御
-- 	crit = 9,--暴击等级
-- 	crit_def = 10,--抗暴等级
-- 	hit = 11,--命中等级
-- 	dodge = 12,--闪避等级
-- 	block = 13,--格挡等级
-- 	dash = 14,--冲击等级

-- 	--RMB属性
-- 	shatter = 15,--破击等级
-- 	restoration = 16,--韧性
-- 	add_atk = 17,--追伤
-- 	add_def = 18,--减伤
-- 	magnify_demage = 19,--增伤
-- 	reduce_demage = 20,--减伤
-- 	ignor_def =21,--无视防御
-- 	crit_hit = 22,--爆伤提升

-- 	magnify_hp = 23,--最大生命值提升
-- 	magnify_atk = 24,--最大攻击值提升
-- 	magnify_def = 25,--最大防御提升

-- }