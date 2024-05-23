class_name InventorySlots
extends CanvasLayer

@export var slot1:Item
@export var slot2:Item


# Called when the node enters the scene tree for the first time.
func _ready():
	var slots = [slot1, slot2]

	for slot in slots:

		var itemDispay = load("res://data/tools/item_display.tscn")
		var instance = itemDispay.instantiate()
		
		instance.texture = slot.texture
		$Panel/HBoxContainer.add_child(instance)
		
		
		
