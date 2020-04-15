extends KinematicBody

var speed = 5
var rotation_speed = 2.5
var roty: float

func _physics_process(delta):
	var move = Vector3(0,-1,0)
	if Input.is_action_pressed("ui_up"):
		move.x += 1
	elif Input.is_action_pressed("ui_down"):
		move.x -= 1
	if Input.is_action_pressed("ui_right"):
		roty -= rotation_speed * delta
	elif Input.is_action_pressed("ui_left"):
		roty += rotation_speed * delta
	self.rotation.y = roty
	move = move.rotated(Vector3(0,1,0).normalized(),roty)
	move = move_and_slide(move*speed, Vector3(0,1,0))

func _ready():
	set_process_input(true)
