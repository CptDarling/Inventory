extends CenterContainer
class_name InventorySlotDisplay

var inventory = preload("res://Inventory/Inventory.tres")

onready var item_texture_rect = $ItemTextureRect
onready var item_amount_label = $ItemTextureRect/ItemAmountLabel

func display_item(item):
	if item is Item:
		item_texture_rect.texture = item.texture
		if item.amount > 1:
			item_amount_label.text = str(item.amount)
		else:
			item_amount_label.text = ""
	else:
		item_texture_rect.texture = load("res://Items/EmptyInventorySlot.png")
		item_amount_label.text = ""


func get_drag_data(_position):
	var index = get_index()
	var item = inventory.remove_item(index)
	if item is Item:
		var data = {}
		data.item = item
		data.item_index = index
		var drag_preview = TextureRect.new()
		drag_preview.texture = item.texture
		set_drag_preview(drag_preview)
		inventory.drag_data = data
		return data


func can_drop_data(_position, data):
	return data is Dictionary and data.has("item")


func drop_data(_position, data):
	var my_item_index = get_index()
	var my_item = inventory.items[my_item_index] as Item
	
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		inventory.emit_signal("items_changed", [my_item_index])
	else:
		inventory.swap_items(my_item_index, data.item_index)
		inventory.set_item(my_item_index, data.item)
	
	inventory.drag_data = null
