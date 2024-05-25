class_name InventorySlots
extends CanvasLayer


@onready var panel = %Panel

@export var slot_scene:PackedScene
@export var slots:Array[Item] = []

var currentTool = 0
var slotDisplays = []

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for slot in slots:
		if slot:
			var instance = slot_scene.instantiate()
			$Panel/HBoxContainer.add_child(instance)
			instance.display(slot)
			
			slotDisplays.append(instance)
			
	selectSlot(0)
		
func selectSlot(number):
	for slot in slotDisplays:
		slot.select(false)
	
	if number < len(slotDisplays):
		slotDisplays[number].select(true)
		currentTool = slots[number]

	
func _unhandled_input(event):
	for i in range(1, 5): 
		if Input.is_action_just_pressed(str(i)): selectSlot(i - 1)
		
		
