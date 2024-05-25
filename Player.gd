extends CharacterBody2D

signal place(tile)
signal destroy(tile)
var signals = {
	"place" : place,
	"destroy": destroy
}

@onready var toolbar = %Toolbar

var speed = 300.0
const WALKING = 300.0
const RUNNING = 500.0
	
func changeRunningValue():
	if Input.is_action_pressed("shift"): 
		speed = RUNNING
		$AnimatedSprite2D.speed_scale = 1.5
	else: 
		speed = WALKING
		$AnimatedSprite2D.speed_scale = 1
func playerMovement():
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.play("side")
		$AnimatedSprite2D.flip_h = true if direction == -1 else false
	
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	var upDown = Input.get_axis("up", "down")
	if upDown:
		velocity.y = upDown * speed
		$AnimatedSprite2D.play( "forward" if upDown == 1 else "backward")
	else:
		velocity.y = move_toward(velocity.x, 0, speed)

	if !direction and !upDown:
		$AnimatedSprite2D.stop()
		
	return(velocity)
	
func tileChange(tile):
	if (position - get_global_mouse_position()).length() < 300: # TODO: Place at limits of reach
		if tile == "till":
			place.emit("soil")
		elif tile == "destroy":
			destroy.emit("grass")

	# TODO: Add Till animation
	
func _physics_process(delta):
	changeRunningValue() # if shift is pressed
	velocity = playerMovement() 
	
	if Input.is_action_just_pressed("leftClick"): 
		toolbar.getCurrentTool().leftClick(signals)
		
	if Input.is_action_just_pressed("rightClick"): 
		toolbar.getCurrentTool().rightClick(signals)
	
		
		
		
	if Input.is_action_just_pressed("esc"): get_tree().quit()
	move_and_slide()
