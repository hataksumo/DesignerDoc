function Array.remove(v_arr,v_delobj)
	local is_find = false
	for _i=1,#v_arr-1 do
		if v_arr[_i] == v_delobj then
			is_find = true
		end
		if is_find then
			v_arr[_i] = v_arr[_i+1]
		end
	end
	if is_find then
		v_arr[#v_arr] = nil
	end
end

function Array.remove_if(v_arr,v_fn)
	local idx = 1
	for _i,data in ipairs(v_arr) do
		if not fn(data) then
			v_arr[idx] = data
			idx = idx + 1
		end
	end
	for _i=idx,#v_arr do
		v_arr[_i] = nil
	end
end