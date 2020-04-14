extends KinematicBody



var speed = 0.1


func _physics_process(delta):
	var move = Vector3(0,0,0)
	if Input.is_action_pressed("ui_up"):
		move += Vector3(1,0,0)
	elif Input.is_action_pressed("ui_down"):
		move += Vector3(-1,0,0)
	if Input.is_action_pressed("ui_right"):
		self.rotation.y -= 1 * delta
	elif Input.is_action_pressed("ui_left"):
		self.rotation.y += 1 * delta
	

	move = move.rotated(Vector3(0,1,0).normalized(),rotation.y)
	move = move_and_collide(move*speed)


func _ready():
	set_process_input(true)
