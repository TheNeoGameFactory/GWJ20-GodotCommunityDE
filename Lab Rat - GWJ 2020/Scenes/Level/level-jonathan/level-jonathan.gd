extends Spatial


var laser_count = 0

var mission_archieved = [] #hier wird gespeichert, welche laser schon "geöfnet" wurden

var mission1 = []

var rng = RandomNumberGenerator.new()


func _ready():
	rng.randomize()
	mission1.append(rng.randi_range(1, 6))
	$ansagen/Popup_start.popup()
	$ansagen/Tween.interpolate_property($ansagen/Popup_start/ansage_start, "percent_visible", 0, 1, 7, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$ansagen/Tween.start()
	get_node("laser_sounds/"+str(mission1[0])).playing = true
	$rat.set_physics_process(false)



func _process(delta):
	pass


func mouse_in_laser(laser_art):
	laser_count += 1
	if mission1[mission_archieved.size()] == laser_art:
		$rat/AnimationPlayer.play("linght_blink_green")
		mission_archieved.append(laser_art)
	else:
		$rat/AnimationPlayer.play("linght_blink_red")
		mission1 = []
		mission1.append(rng.randi_range(1, 6))
		mission_archieved = []


func _on_Tween_tween_completed(object, key):
	if object.get_parent().get_class() == "Popup":
		object.get_parent().popup_exclusive = false
		object.get_parent().popup()
		$rat.set_physics_process(true)
		get_node("laser_sounds/"+str(mission1[0])).playing = false
		$AudioStreamPlayer.playing = true


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "linght_blink_green":
		$ansagen/Popup_start.hide()
		$ansagen/Popup_mission2.popup()
		$ansagen/Tween.interpolate_property($ansagen/Popup_mission2/ansage_start, "percent_visible", 0, 1, 7, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$ansagen/Tween.start()


func not_managed_to_do(mission):
	
