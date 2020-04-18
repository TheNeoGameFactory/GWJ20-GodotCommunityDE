extends KinematicBody

var speed = 5

var rotation_speed = 2.5
var roty: float

var easterEggCanStart=false
var easterEggTimerStarted=false
var timer = Timer.new()
var easterEggScene ="res://Scenes/Easter egg/easter egg.tscn"



func _timer_finish():
	get_tree().change_scene(easterEggScene)
	
	
func _physics_process(delta):
	if get_tree().get_current_scene().get_name() == "easter egg":
		return
	var move = Vector3(0,-1,0)
	easterEggCanStart=true
	if Input.is_action_pressed("ui_up"):
		move.x += 1
		easterEggCanStart=false
	elif Input.is_action_pressed("ui_down"):
		move.x -= 1
		easterEggCanStart=false
	if Input.is_action_pressed("ui_right"):
		roty -= rotation_speed * delta
		easterEggCanStart=false
	elif Input.is_action_pressed("ui_left"):
		roty += rotation_speed * delta
		easterEggCanStart=false
	self.rotation.y = roty
	move = move.rotated(Vector3(0,1,0).normalized(),roty)
	move = move_and_slide(move*speed)
	
	if easterEggCanStart and not easterEggTimerStarted:
		timer.start(200)
		easterEggTimerStarted=true
		
	if easterEggTimerStarted and not easterEggCanStart:
		timer.stop()
		easterEggTimerStarted=false

func _ready():
	set_process_input(true)
	timer.name = "timer"
	add_child(timer)
	timer.connect("timeout", self, "_timer_finish")
