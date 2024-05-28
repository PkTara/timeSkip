extends CanvasLayer


@onready var container = %Container
@onready var grid_container = $PanelContainer/HBoxContainer/GridContainer
@onready var animated_sprite_2d = %AnimatedSprite2D
@export var slot_scene:PackedScene
@export var items:Array[Item] = []
var slots:Array = []

@onready var toolbar = %Toolbar

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	for i in range(32):
		var slot_scene_instance = slot_scene.instantiate()
		grid_container.add_child(slot_scene_instance)
		slot_scene_instance.custom_minimum_size = Vector2(100, 100)
		
		slots.append(slot_scene_instance)

	for i in range(len(toolbar.slots)):
		slots[i].display(toolbar.slots[i])
		
	for i in range(len(items)):
		slots[i + 8].display(items[i])
		
func add_item(item):
	var index = 0
	for slot in slots:
		var added = false
		if slot.label.text == item.name:
			slot.addQuantity(1)
			added = true
		elif !(slot.texture_rect.texture):
			slot.display(item)
			added = true
		if added:
			toolbar.add_item(item)
			return(1)
	return(0)		


func _on_map_removed_tile(tile):
	add_item(tile)
