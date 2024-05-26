class_name InventorySlots
extends CanvasLayer

@onready var panel = %Panel
@onready var player = %Player

@export var slot_scene:PackedScene
@export var slots:Array[Item] = []

class Tool extends Node:
	func leftClick(singals:Object):
		pass
	func rightClick(signals:Object):
		pass
		

class ToolHoe extends Tool:
	func leftClick(signals):
		signals["destroy"].emit("grass")
	func rightClick(signals):
		signals["place"].emit("soil")

		
class ToolWood extends Tool:
	func leftClick(signals):
		print("Wood left")
	func rightClick(signals):
		signals["place"].emit("wood")
		print("woodRight")
		
var tools = {
	"Hoe": ToolHoe.new(),
	"Wood": ToolWood.new()
}
		

var currentTool: String
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
		currentTool = slots[number].name

func getCurrentTool():
	return(tools[currentTool])
	
func _unhandled_input(event):
	for i in range(1, 5): 
		if Input.is_action_just_pressed(str(i)): selectSlot(i - 1)
		
		
