extends KinematicBody

var speed = 5

var rotation_speed = 2.5
var roty: float

var easterEggCanStart=false
var easterEggTimerStarted=false
var timer = Timer.new()
var easterEggScene ="res://Scenes/Easter egg/easter egg.tscn"
var dukeFired=false


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
		timer.start(140)
		easterEggTimerStarted=true
		dukeFired=false

	if easterEggTimerStarted and not easterEggCanStart:
		timer.stop()
		easterEggTimerStarted=false
		dukeFired=false

	if timer.time_left<60 and easterEggTimerStarted and not dukeFired:
		var duke_voice = get_node("../DukeVoice")
		duke_voice.stream = load("res://Sounds/SFX/Speech/Easter Egg/Duke Nukem What are you waiting for.ogg")
		duke_voice.volume_db = 3
		duke_voice.play()
		dukeFired=true


func _ready():
	set_process_input(false)
	set_physics_process(true)
	timer.name = "timer"
	add_child(timer)
	timer.connect("timeout", self, "_timer_finish")

func _on_Button_pressed():
	set_physics_process(conami.pause)
	conami.pause = !conami.pause
	get_parent().get_node("Pausenmenü").visible = conami.pause
