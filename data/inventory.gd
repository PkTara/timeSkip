extends Node

class_name Inventory

var slots: Array

func _init(slot_count: int):
	slots = []
	for i in range(slot_count):
		slots.append(null)

func add_item(item: Item, count: int) -> bool:
	for i in range(slots.size()):
		var slot = slots[i]
		if slot == null:
			slots[i] = { "item": item, "count": count }
			return true
		elif slot.item == item and slot.count + count <= item.max_stack_size:
			slot.count += count
			return true
	return false

func remove_item(slot_index: int, count: int) -> bool:
	if slot_index < 0 or slot_index >= slots.size():
		return false
	var slot = slots[slot_index]
	if slot != null:
		slot.count -= count
		if slot.count <= 0:
			slots[slot_index] = null
		return true
	return false

var selected_item = null
var selected_slot = -1

func _on_slot_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		var slot_index = int(event.target.name.split("_")[1])
		if event.button_index == MOUSE_BUTTON_LEFT:
			handle_left_click(slot_index)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			handle_right_click(slot_index)

func handle_left_click(slot_index: int) -> void:
	if selected_item == null:
		selected_item = slots[slot_index]
		selected_slot = slot_index
		slots[slot_index] = null
	else:
		if slots[slot_index] == null:
			slots[slot_index] = selected_item
			selected_item = null
		elif slots[slot_index].item == selected_item.item:
			var available_space = slots[slot_index].item.max_stack_size - slots[slot_index].count
			if available_space > 0:
				var transfer_amount = min(selected_item.count, available_space)
				slots[slot_index].count += transfer_amount
				selected_item.count -= transfer_amount
				if selected_item.count <= 0:
					selected_item = null
	update_inventory_ui()


func handle_right_click(slot_index: int) -> void:
	if selected_item == null:
		if slots[slot_index] != null:
			selected_item = { "item": slots[slot_index].item, "count": 1 }
			slots[slot_index].count -= 1
			if slots[slot_index].count <= 0:
				slots[slot_index] = null
	else:
		if slots[slot_index] == null:
			slots[slot_index] = selected_item
			selected_item = null
		elif slots[slot_index].item == selected_item.item:
			if slots[slot_index].count < slots[slot_index].item.max_stack_size:
				slots[slot_index].count += 1
				selected_item.count -= 1
				if selected_item.count <= 0:
					selected_item = null
	update_inventory_ui()

					

func _ready():
	_init(32)
	add_item()
	# Existing code to create the grid
	update_inventory_ui()

func update_inventory_ui():
	for i in range(slots.size()):
		var slot = $GridContainer.get_child(i)
		if slots[i] != null:
			slot.texture = slots[i].item.icon
		else:
			slot.texture = null


