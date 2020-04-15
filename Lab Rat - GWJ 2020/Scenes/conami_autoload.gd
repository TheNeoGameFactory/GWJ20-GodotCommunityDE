extends Node


var conami = ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"] 
var lastet_inputs =[]


func _ready():
	var timer = Timer.new()
	timer.name = "timer"
	add_child(timer)

func _timer_finish():
	print("welcome to easter egg")

func _input(event):
	var timer = get_node("timer")
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
		if timer.time_left == 0:
			timer.start(140)
			timer.connect("timeout", self, "_timer_finish")
	if action:
		timer.stop()

	if len(lastet_inputs) > len(conami):
		lastet_inputs.pop_front()
	if lastet_inputs == conami:
		print("yeah, yeah, yeah!!!")

