extends PanelContainer
@onready var texture_rect = %TextureRect
@onready var label = %Label


func display(item):
	texture_rect.texture = item.texture
	label.text = item.name
	
func select(isSelected):
	var color = Color(1.0, 0.0, 0.0) if isSelected else Color(0.6, 0.6, 0.6)
	var styleBox: StyleBoxFlat = get_theme_stylebox("panel").duplicate()
	styleBox.set("bg_color", color)
	add_theme_stylebox_override("panel", styleBox)
	
