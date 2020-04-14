extends Node


var conami = ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"] 
var lastet_inputs =[]



func _input(event):
	if event.is_action_pressed("ui_up"):
		lastet_inputs.append("up")
	if event.is_action_pressed("ui_down"):
		lastet_inputs.append("down")
	if event.is_action_pressed("ui_left"):
		lastet_inputs.append("left")
	if event.is_action_pressed("ui_right"):
		lastet_inputs.append("right")
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_A:
			lastet_inputs.append("A")
		if event.scancode == KEY_B:
			lastet_inputs.append("B")
	
	if len(lastet_inputs) > len(conami):
		lastet_inputs.pop_front()
	if lastet_inputs == conami:
		print("yeah, yeah, yeah!!!")

