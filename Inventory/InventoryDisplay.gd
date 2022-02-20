extends GridContainer
class_name InventoryDisplay

var inventory = preload("res://Inventory/Inventory.tres")

func _ready():
	inventory.connect("items_changed", self, "_on_items_changed")
	inventory.make_items_unique()
	update_inventory_display()


func update_inventory_display():
	for index in inventory.items.size():
		update_inventory_slot_display(index)


func update_inventory_slot_display(index):
	var inventory_slot_display = get_child(index) as InventorySlotDisplay
	var item = inventory.items[index]
	inventory_slot_display.display_item(item)


func _on_items_changed(indexes):
	assert(indexes is Array)
	for index in indexes:
		update_inventory_slot_display(index)


func _unhandled_input(event):
	if event.is_action_released("ui_left_mouse"):
		if inventory.drag_data is Dictionary:
			inventory.set_item(inventory.drag_data.item_index, inventory.drag_data.item)
