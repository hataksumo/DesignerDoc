local level_spawn = {
	[101] = {
		--刷2波怪，而后出BOSS，通关时间3分钟，90秒通关3星，120秒通关2星
		--进关卡3秒后刷第一波怪
		--每杀完1波怪，撤销1道空气墙
		--boss有2个状态，血量低于30%进入状态2
		birth = "d1",--出生点
		star = {0,1,1},
		monsterGroup = {--怪物组
			--该数据到时候做编辑器导出，粘贴过来
            [1] = {
                {monsterid = 2, x = 0, y = 0, rotate = 0, tag="bc1"},--怪物ID，数量，坐标偏移，标签，如果不需要控制，则不需加标签
                {monsterid = 1, x = 0, y = 3, rotate = 0, tag="bc1"},
                {monsterid = 1, x = 2.6, y = -1.5 rotate = 0, tag="bc1"},
                {monsterid = 1, x = -2.6, y = 1.5, rotate = 0, tag="bc1"},
            },
            [2] = {
            	{monsterid = 3, x = 3, y = 0, rotate = 0, tag = "bc1"},
            	{monsterid = 3, x = 4, y = 0, rotate = 0, tag = "bc1"},
            	{monsterid = 3, x = 5, y = 0, rotate = 0, tag = "bc1"},
            	{monsterid = 3, x = 6, y = 0, rotate = 0, tag = "bc1"},
            	{monsterid = 3, x = 7, y = 0, rotate = 0, tag = "bc1"},
                {monsterid = 4, x = -3, y = 0, rotate = 0, tag = "bc1"},
                {monsterid = 4, x = -5, y = 0, rotate = 0, tag = "bc1"},
                {monsterid = 4, x = -7, y = 0, rotate = 0, tag = "bc1"},
        	},
        	[3] = {
            	{monsterid = 5, x = 3, y = 0, rotate = 0, tag = "bc2"},
                {monsterid = 6, x = 3, y = 0, rotate = 0, tag = "bc2"},
        	},
        	[4] = {
            	{monsterid = 7, x = 3, y = 0, rotate = 0, tag = "bc2"},
                {monsterid = 8, x = 3, y = 0, rotate = 0, tag = "bc2"},
        	},
        	[5] = {
        		{monsterid = 101, num = 1, tag = "boss", hppct_change_emitter = true},--BOSS,hppct_change_emitter，表示血量变化发送事件
        	},
        },
        triggers = {
        --注意，listener是type的成员属性，实际上应该再配张trigger_type的表，这里懒省事，先写这儿了
        	[1] = {type="time_down",time = 300, listener = "on_tick",events={1}},--3秒后刷怪
        	[2] = {type="monsters_die", tag = "bc1",listener = "on_instence_die", num = 8, events={2,8}},--击杀波次1
        	[3] = {type="monsters_die", tag = "bc2",listener = "on_instence_die",  num = 14, events={3,2,12}},--击杀波次2
        	[4] = {type="monsters_die", tag = "boss",listener = "on_instence_die", num = 1, event={7,8,13}},--击杀BOSS
        	[5] = {type="hp_detect", hppct = 0.3,listener = "on_hppct_change", event={11}},--boss血量低于30%，进入状态2
        	[6] = {type="time_down", time = 9000, listener = "on_tick", event={4}},--90秒后丢失第一颗星
        	[7] = {type="time_down", time = 12000, listener = "on_tick", event={5}},--120秒后丢失第二颗星
        	[8] = {type="time_down", time = 18000, listener = "on_tick", event={6}},--180秒后失败
    	},
    	event = {
    		[1] = {type = "create_monster", --刷第一波怪
    			spawn = {
    				[1] = {loc = "d1",monster_group=1,delay = 0},
    				[2] = {loc = "d2",monster_group=2,delay = 0}
    			}
    		},
    		[2] = {type = "create_monster", --刷第二波怪
    			spawn = {
    				[1] = {loc = "d3",monster_group=3,delay = 0},
    				[2] = {loc = "d4",monster_group=4,delay = 0}
    			}
    		},
    		[3] = {type = "create_monster", --刷第三波怪
    			spawn = {
    				[1] = {loc = "d5",monster_group=5,delay = 0},
    			}
    		},
    		[4] = {type = "change_star",loc=3,op="lose"},--失去第3颗星
    		[5] = {type = "change_star",loc=2,op="lose"},--失去第2颗星
    		[6] = {type = "gameover",result="lose"},--游戏失败
    		[7] = {type = "gameover",result="win"},--游戏胜利
    		[8] = {type = "change_star",loc=1,op="gain"},--获得第1颗星
    		[9] = {type = "set_valid",key="zdq_1",value=false},--去掉空气墙1
    		[10] = {type = "set_valid",key="zdq_2",value=false},--去掉空气墙2
    		[11] = {type = "change_state",tag="boss",state=2},--boss进入状态2
    		[12] = {type = "add_trigger", id = 5},
    		[13] = {type = "unload_trigger", id = 5}
    	},

    	enter = {
    		triggers = {1,2,3,4,6,7,8},
    		execute_events = {}
    	}
	},

	[103] = {
	--罗马竞技场玩法
	--圆形场景，场上最多8只怪，每隔5秒检测，场上怪物数少于6只，就会在圆形边界区域随机刷出2只怪，
	--每杀12只怪，场上小怪全部退散，进入BOSS阶段
	--5分钟后，游戏结束
		birth = "o",--出生点
		score = 0,--初始分数
		monsterGroup = {--怪物组
			[1] = {
				{monsterid = 1, num = 1, tag = "xiaoguai", score = 1}
			},
			[2] = {
				{monsterid = 2, num = 1, tag = "xiaoguai", score = 2}
			},
			[3] = {
				{monsterid = 3, num = 1, tag = "boss", score = 10}
			}
		},

		triggers = {
			[1] = {type = "monsters_die",tag = "xiaoguai",listener = "on_instence_die",num = 12, events={3,5}},
			[2] = {type = "timedown", time = 300,listener = "on_tick",events = {4,8}},
			[3] = {type = "monster_exist", tag="xiaoguai",listener = "on_tick", num = 6, op = "<", cd = 500,events = {2}},
			[4] = {type = "timedown", time = 30000,listener = "on_tick", events = {6}},
			[5] = {type = "monsters_die", tag = "boss",listener = "on_instence_die", num = 1, events={6,7}},
			[6] = {type = "timedown", time = 300,listener = "on_tick",events = {1}},
		},

		events = {
			[1] = {
				type = "create_monster",--进场刷新
				spawn = {
					[1] = {loc = "d1",monster_group=1},
					[2] = {loc = "d2",monster_group=2},
					[3] = {loc = "d3",monster_group=1},
					[4] = {loc = "d4",monster_group=2},
					[5] = {loc = "d5",monster_group=1},
					[6] = {loc = "d6",monster_group=2},
					[7] = {loc = "d7",monster_group=1},
					[8] = {loc = "d8",monster_group=2},
				}
			},
			[2] = {
				type = "create_monster_randomly",
				spawn = {
					[1] = {loc = "d1",monster_group=1,weight =2},
					[2] = {loc = "d2",monster_group=1,weight =2},
					[3] = {loc = "d3",monster_group=1,weight =2},
					[4] = {loc = "d4",monster_group=1,weight =2},
					[5] = {loc = "d5",monster_group=1,weight =2},
					[6] = {loc = "d6",monster_group=1,weight =2},
					[7] = {loc = "d7",monster_group=1,weight =2},
					[8] = {loc = "d8",monster_group=1,weight =2}, 
					[9] = {loc = "d1",monster_group=2,weight =1},
					[10] = {loc = "d2",monster_group=2,weight =1},
					[11] = {loc = "d3",monster_group=2,weight =1},
					[12] = {loc = "d4",monster_group=2,weight =1},
					[13] = {loc = "d5",monster_group=2,weight =1},
					[14] = {loc = "d6",monster_group=2,weight =1},
					[15] = {loc = "d7",monster_group=2,weight =1},
					[16] = {loc = "d8",monster_group=2,weight =1},
				}
			},
			[3] = {type = "send_message", tag="xiaoguai",message = "withdraw"},
			[4] = {
				type = "create_monster",
				spawn = {
					[1] = {loc = "o",monster_group=3}
				}
			},
			[5] = {type = "add_trigger",triggers={2}},
			[6] = {type = "gameover", result = "over"},
			[7] = {type = "add_trigger", triggers={3}},
			[8] = {type = "unload_trigger", triggers={3}},

		},

		enter = {
			triggers = {1,3,4},
    		execute_events = {1}
		}
	},

    [104] = {
        --逃生模式
    },

    [105] = {
        --推车模式
    },
    [106] = {
        --BOSS战模式
    }



}