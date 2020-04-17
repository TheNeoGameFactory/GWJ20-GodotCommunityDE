extends Node


var konami = ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"] 
var lastet_inputs =[]

	

func _input(event):

	
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


	if len(lastet_inputs) > len(konami):
		lastet_inputs.pop_front()
	if lastet_inputs == konami:
		print("yeah, yeah, yeah!!!")
		lastet_inputs.clear()
	

