extends KinematicBody

<<<<<<< HEAD
var speed = 0.1

func _physics_process(delta):
	var move = Vector3(0,-1,0)
=======
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
var roty = 0

func _physics_process(delta):
	var move = Vector3(0,-1,0)
	var speed = 0.1
>>>>>>> 771de09... Rechtschreibfehler, neue Rattenszene, johns ratte, canomi und grundgerüst
	if Input.is_action_pressed("ui_up"):
		move.x += 1
	elif Input.is_action_pressed("ui_down"):
<<<<<<< HEAD
		move.x += -1
=======
		move += Vector3(-10,0,0)

>>>>>>> 771de09... Rechtschreibfehler, neue Rattenszene, johns ratte, canomi und grundgerüst
	if Input.is_action_pressed("ui_right"):
		self.rotation.y -= 1 * delta
	elif Input.is_action_pressed("ui_left"):
<<<<<<< HEAD
		self.rotation.y += 1 * delta
=======
		roty += 1.5 * delta
	
	self.rotation.y += 1 * delta
>>>>>>> 771de09... Rechtschreibfehler, neue Rattenszene, johns ratte, canomi und grundgerüst

	move = move.rotated(Vector3(0,1,0).normalized(),rotation.y)
	move = move_and_collide(move*speed)

<<<<<<< HEAD

=======
>>>>>>> 771de09... Rechtschreibfehler, neue Rattenszene, johns ratte, canomi und grundgerüst
func _ready():
	set_process_input(true)
