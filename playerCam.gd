extends Camera2D

var zoomspeed = 100
var zoommargin = 0.3

var zoomMin = 0.2
var zoomMax=1

var zoompos = Vector2()
var zoomfactor = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if abs(zoompos.x - get_global_mouse_position().x) > zoommargin:
		zoomfactor = 1.0
	if abs(zoompos.x - get_global_mouse_position().x) > zoommargin:
		zoomfactor = 1.
		
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == MOUSE_BUTTON_WHEEL_UP:
					zoomfactor -= 0.01
					zoompos = get_global_mouse_position()
				if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
					zoomfactor += 0.01
					zoompos = get_global_mouse_position()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zoom.x = lerp(zoom.x , zoom.x * zoomfactor, zoomspeed * delta)
	zoom.y = lerp(zoom.y , zoom.y * zoomfactor, zoomspeed * delta)
	
	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)
