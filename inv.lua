function readyItem(item)
	local slot, count
	for i=1,16
		slot = turtle.getSelectedSlot()
		count = turtle.getItemCount(slot)
		detail = turtle.getItemDetail()
		if count > 0 and detail.name == item then
		    return slot
	    end
		turtle.select((slot + 1) % 16 + 1)
	end
end

