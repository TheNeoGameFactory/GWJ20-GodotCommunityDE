extends Node


var konami = ["up", "up", "down", "down", "left", "right", "left", "right", "B", "A"] 
var lastet_inputs =[]
var konami_video
	

func _input(event):

	
	if event.is_action_pressed("konami_up"):
		lastet_inputs.append("up")
	elif event.is_action_pressed("konami_down"):
		lastet_inputs.append("down")
	elif event.is_action_pressed("konami_left"):
		lastet_inputs.append("left")
	elif event.is_action_pressed("konami_right"):
		lastet_inputs.append("right")
	elif event is InputEventKey and event.pressed:
		if event.scancode == KEY_A:
			lastet_inputs.append("A")
		elif event.scancode == KEY_B:
			lastet_inputs.append("B")


	if len(lastet_inputs) > len(konami):
		lastet_inputs.pop_front()
	if lastet_inputs == konami:
		konami_video = get_node("VideoPlayer")
		konami_video.connect("finished",self,"konami_video_finished")
		konami_video.visible=true
		konami_video.play()
		lastet_inputs.clear()
		
func konami_video_finished():
	konami_video.visible=false
	konami_video.stop()
		
	
	

