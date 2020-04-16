extends Node


var konami = ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"] 
var lastet_inputs =[]
var easterEggStarted = false
var timer = Timer.new()
var easterEggScene = "res://Scenes/Easter Egg/easter egg.tscn"


func _ready():
	timer.name = "timer"
	add_child(timer)
	timer.connect("timeout", self, "_timer_finish")

func _timer_finish():
	easterEggStarted = true
	timer.stop()
	get_tree().change_scene(easterEggScene)
	

func _input(event):
	timer = get_node("timer")
	var action = true
	
	if event.is_action_pressed("ui_up"):
		lastet_inputs.append("up")
	elif event.is_action_pressed("ui_down"):
		lastet_inputs.append("down")
	elif event.is_action_pressed("ui_left"):
		lastet_inputs.append("left")
	elif event.is_action_pressed("ui_right"):
		lastet_inputs.append("right")
	elif event is InputEventKey and event.pressed:
		if event.scancode == KEY_A:
			lastet_inputs.append("A")
		elif event.scancode == KEY_B:
			lastet_inputs.append("B")
	else:
		action = false
		if timer.time_left == 0 and get_tree().get_current_scene().get_name() != "HauptMenu" and easterEggStarted == false:
			timer.start(4)
	if action:
		timer.stop()

	if len(lastet_inputs) > len(konami):
		lastet_inputs.pop_front()
	if lastet_inputs == konami:
		print("yeah, yeah, yeah!!!")
		lastet_inputs.clear()
	

