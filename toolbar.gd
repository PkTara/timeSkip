class_name InventorySlots
extends CanvasLayer

@onready var panel = %Panel
@onready var player = %Player

@export var slot_scene:PackedScene
@export var slots:Array[Item] = []

var currentTool: String
var slotDisplays = []
var tools = {}
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(8):
		var instance = slot_scene.instantiate()
		$Panel/HBoxContainer.add_child(instance)
		
			
		slotDisplays.append(instance)
		if len(slots) > i and slots[i]:
			instance.display(slots[i])
			tools[slots[i].name] = load(slots[i].scriptString).new()
			
	selectSlot(0)
		
func add_item(item):
	for slot in slotDisplays:
		print(item.name, slot.label.text)
		if slot.label.text == item.name:
			slot.addQuantity(1)
			slots.append(item)
			tools[item.name] = load(item.scriptString).new()
			return(1)
		elif !(slot.texture_rect.texture):
			slot.addQuantity(1)
			slot.display(item)
			slots.append(item)
			tools[item.name] = load(item.scriptString).new()
			return(1)
	return(0)
	
func selectSlot(number):
	for slot in slotDisplays:
		slot.select(false)
	
	if number < len(slotDisplays):
		slotDisplays[number].select(true)
		currentTool = slots[number].name

func getCurrentTool():
	return(tools[currentTool])
	
func _unhandled_input(event):
	for i in range(1, 5): 
		if Input.is_action_just_pressed(str(i)): selectSlot(i - 1)
		
		
