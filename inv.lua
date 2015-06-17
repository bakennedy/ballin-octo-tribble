function mapInventory() {
    local map = {}
    for i=1, 16 do
        local item = turtle.getItemDetail(i)
        map[item.name] = turtle.getItemCount(i)
    end
    return map
}

function readyItem(item)
	local slot, count
	for i=1,16 do
		slot = turtle.getSelectedSlot()
		count = turtle.getItemCount(slot)
		detail = turtle.getItemDetail()
		if count > 0 and (not item or detail.name == item) then
		    return slot
	    end
		turtle.select((slot + 1) % 16 + 1)
	end
end

