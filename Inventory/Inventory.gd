extends Resource
class_name Inventory

var drag_data = null

signal items_changed(indexes)

export(Array, Resource) var items = [null, null, null, null, null, null, null, null, null,]

func set_item(index, item):
	var o = items[index]
	items[index] = item
	emit_signal("items_changed", [index])
	return o
	
	
func swap_items(item_index, other_item_index):
	var o = items[item_index]
	items[item_index] = items[other_item_index]
	items[other_item_index] = o
	emit_signal("items_changed", [item_index, other_item_index])
	
	
func remove_item(index):
	var o = items[index]
	items[index] = null
	emit_signal("items_changed", [index])
	return o


func make_items_unique():
	var unique_items = []
	for item in items:
		if item is Item:
			unique_items.append(item.duplicate())
		else:
			unique_items.append(null)
	items = unique_items
