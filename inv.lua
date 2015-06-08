function readyItem()
	local slot, count
	repeat
		slot = turtle.getSelectedSlot()
		count = turtle.getItemCount(slot)
		if count == 0 then
			if slot == 16 then 
				return false 
			end
			turtle.select(slot+1)
		end
	until count > 0 or slot == 16
	return slot
end

