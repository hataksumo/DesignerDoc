--[[
lua class
特性：
支持继承及多重继承
支持类型检测
支持构造函数
符合面向对象的的编程思维模式
继承关系复杂不再影响性能，但是失去了reload
]]


local ClassDefineMt = {}
function ClassDefineMt.__index( tbl, key )
		local tBaseClass = tbl.__tbl_Baseclass__
		for i = 1, #tBaseClass do
			local xValue = rawget(tBaseClass[i],key)
			if xValue then
				rawset( tbl, key, xValue )
				return xValue
			end
		end
end

        
function class( ... )
	local arg = {...}
    local ClassDefine = {}
    
    -- 这里是把所有的基类放到 ClassDefine.__tbl_Bseclass__ 里面
    ClassDefine.__tbl_Baseclass__ =  {}
    for index = 1, #arg do
    		local tBaseClass = arg[index]
        table.insert(ClassDefine.__tbl_Baseclass__, tBaseClass)
        
        for i = 1, #tBaseClass.__tbl_Baseclass__ do
        	table.insert(ClassDefine.__tbl_Baseclass__, tBaseClass.__tbl_Baseclass__[i])
        end
    end
    
    -- 所有对实例对象的访问都会访问转到ClassDefine上
    local InstanceMt =  { __index = ClassDefine }
    
       --  IsClass 函数提供对象是否某种类型的检测, 支持多重继承
    ClassDefine.IsClass = function(self, classtype)
        local bIsType = (self == classtype)
        if bIsType then
            return bIsType
        end
        
        for index=1, #self.__tbl_Baseclass__ do
            local baseclass = self.__tbl_Baseclass__[index]
            bIsType =  (baseclass == classtype)
            if bIsType then
                return bIsType
            end
        end
        return bIsType
    end
    
    --构造函数参数的传递，只支持一层, 出于动态语言的特性以及性能的考虑
    ClassDefine.new = function( self, ... )
    	local NewInstance = {}
    	NewInstance.__ClassDefine__ = self    -- IsType 函数的支持由此来
    
        NewInstance.IsClass = function( self, classtype )
            return self.__ClassDefine__:IsClass(classtype)
        end
        
        -- 这里要放到调用构造函数之前，因为构造函数里面，可能调用基类的成员函数或者成员变量
        setmetatable( NewInstance, InstanceMt )
        
      local funcCtor = rawget(self, "Ctor")
    	if funcCtor then
    	    funcCtor(NewInstance, ...)
    	end
    	
    	return NewInstance
    end

    setmetatable( ClassDefine, ClassDefineMt )
    return ClassDefine
end


local bTestClass = false

if bTestClass then

	-- test case
	baseclass = class()
	
	function baseclass:Ctor(a,b,c)
	    print( "in baseclass Ctor : ", a, b, c)
	    
	    self.m_test = "baseclass member m_test"
	end
	function baseclass:print()
	    print "baseclass function print"
	end
	
	function baseclass:basseprint()
			print "basseprint"
	end
	
	--aaa = baseclass:new()
	
	dclass = class(baseclass)
	function dclass:Ctor(a,b,c)
			baseclass.Ctor(self, a,b,c)
	    print( "in dclass Ctor : ", a, b, c,d)
	    
	    
	    self:print()
	end
	
	function dclass:print()
	    print "dclass function print"
	end
	
	
	---obj = dclass:new(1,2,3)
	
	bclass2 = class()
	
	function bclass2:Ctor()
	    print "bclass2:Ctor()"
	end
	
	function bclass2:print()
	    print "bclass2 function print"
	end
	
	dclass2 = class(bclass2,dclass)
	
	function dclass2:Ctor()
		bclass2.Ctor(self)
	  dclass.Ctor(self)
	end
	
	--[[function dclass2:Ctor()
	    print "dclass2:Ctor"
	    
	    self:print()
	end]]
	
	ooo = dclass2:new()
	--ccc = class()
	ddd = bclass2:new()
	eee = dclass:new()
	
	--print("ooo is  dclass2", ooo:IsClass(dclass2))
	--print("ooo is bclass2", ooo:IsClass(bclass2))
	--print("ooo is dclass", ooo:IsClass(dclass))
	--print("ooo is baseclass", ooo:IsClass(baseclass))
	--print("ooo is ccc", ooo:IsClass(ccc))
	--print("ddd is baseclass", ddd:IsClass(baseclass))
	--print("eee is dclass2", eee:IsClass(dclass2))
	
	print("cp test begine1")
	ooo:basseprint()
	print("cp test end1")
	
	print("cp test begine2")
	ooo:basseprint()
	print("cp test end2")

end
