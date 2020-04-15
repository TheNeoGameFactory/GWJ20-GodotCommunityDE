extends KinematicBody

var speed = 5

func _physics_process(delta):
	var move = Vector3(0,-1,0)
	if Input.is_action_pressed("ui_up"):
		move.x += 1
	elif Input.is_action_pressed("ui_down"):
		move.x += -1
	if Input.is_action_pressed("ui_right"):
		self.rotation.y -= 1 * delta
	elif Input.is_action_pressed("ui_left"):
		self.rotation.y += 1 * delta

	move = move.rotated(Vector3(0,1,0).normalized(),rotation.y)
	move = move_and_slide(move*speed, Vector3(0,1,0))


func _ready():
	set_process_input(true)
