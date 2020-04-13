extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var roty = 0
func _physics_process(delta):
	var move = Vector3(0,0,0)
	if Input.is_action_pressed("ui_up"):
		move += Vector3(10,0,0)
	elif Input.is_action_pressed("ui_down"):
		move += Vector3(-10,0,0)
	if Input.is_action_pressed("ui_right"):
		roty -= 1.5 * delta
	elif Input.is_action_pressed("ui_left"):
		roty += 1.5 * delta
	
	self.translate(move*delta)
	self.rotation.y = roty
	
func _ready():
	set_process_input(true)
