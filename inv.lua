function readyItem(item)
	local slot, count
	repeat
		slot = turtle.getSelectedSlot()
		count = turtle.getItemCount(slot)
		detail = turtle.getItemDetail()
		if count == 0 or not detail.name == item then
			if slot == 16 then 
				return false 
			end
			turtle.select(slot+1)
		end
	until (count > 0  detail.name == item) and  or slot == 16
	return slot
end

