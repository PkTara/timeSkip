extends PanelContainer
@onready var texture_rect = %item
@onready var label = %Label
@onready var quantity = %Quantity
@export var slot:Texture2D

func display(item:Item):
	if item:
		texture_rect.texture = item.texture
		label.text = item.name

func addQuantity(number:int):
	quantity.text = str(number + int(quantity.text))
		
func select(isSelected):
	var color = Color(1.0, 0.0, 0.0) if isSelected else Color(0.6, 0.6, 0.6)
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	styleBox.set("bg_color", color)
	add_theme_stylebox_override("panel", styleBox)
	
