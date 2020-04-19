extends Spatial


var laser_count = 0

var mission_archieved = [] #hier wird gespeichert, welche laser schon "geöfnet" wurden
var last_laser_went_into = 0
var current_mission = 1
var highest_mission = 3

var mission_to_do = []

var possible_laser = []


var gerade_vorspiel = false
var takt_im_vorspiel = 1
var laenge_des_vorspiels = 1

func _ready():
	$rat.transform = $rat_start_pos.transform
	show_text_popup("ansagen/Popup_mission1")
	var lasers =  possible_laser.duplicate()
	get_new_laser_config(current_mission,lasers)
	play_laser_sounds(mission_to_do)
	

func _process(delta):
	$ansagen.rect_size = get_viewport().size
	if gerade_vorspiel:
		$rat.set_physics_process(false)
	else: $rat.set_physics_process(true)
	if mission_archieved == mission_to_do:
		current_mission+=1
		if not current_mission > highest_mission:
			var lasers =  possible_laser.duplicate()
			get_new_laser_config(current_mission,lasers)
			mission_archieved = []
			show_text_popup("ansagen/Popup_mission"+str(current_mission))
			play_laser_sounds(mission_to_do)


func laser_wants_to_play_musik(laser_type):
	if not gerade_vorspiel:
		get_node("laser_sounds/"+str(laser_type)).playing = true
		$AudioStreamPlayer.stream_paused = true

func laser_wants_to_stop_musik(laser_type):
	get_node("laser_sounds/"+str(laser_type)).playing = false
	if not gerade_vorspiel:
		$AudioStreamPlayer.stream_paused = false


func get_new_laser_config(anzahl, laser_to_use):
	laser_to_use.shuffle()
	laser_to_use.resize(anzahl)
	mission_to_do = laser_to_use


func play_laser_sounds(sounds):
	$AudioStreamPlayer.stream_paused = true
	gerade_vorspiel = true
	for sound_to_stop in get_node("laser_sounds").get_children():
		sound_to_stop.playing = false
	print("vorspiel gestartet")
	laenge_des_vorspiels = len(sounds)
	takt_im_vorspiel = 0
	#get_node("laser_sounds_without_loop/"+str(sounds[0])).playing = true
	get_node("laser_sounds_without_loop/Time_laser_needs").start()





func _on_Time_laser_needs_timeout():
	get_node("laser_sounds_without_loop/"+str(mission_to_do[takt_im_vorspiel-1])).playing = false
	if gerade_vorspiel:
		print("nexter laser")
		if takt_im_vorspiel == laenge_des_vorspiels:
			$AudioStreamPlayer.stream_paused = false
			print("vorspiel zu ende")
			gerade_vorspiel = false
		else:
			takt_im_vorspiel += 1
			get_node("laser_sounds_without_loop/"+str(mission_to_do[takt_im_vorspiel-1])).playing = true
			get_node("laser_sounds_without_loop/Time_laser_needs").start()


func show_text_popup(popup_path):
	get_node(popup_path).popup()
	get_node("ansagen/Tween").interpolate_property(get_node(popup_path+"/RichTextLabel"), "percent_visible", 0.0, 1.0, 7)
	get_node("ansagen/Tween").start()
	print("text wird animiert")


func _on_AnimationPlayer_animation_finished(anim_name):
	if current_mission > highest_mission:
		get_tree().change_scene("res://Scenes/Menus/HauptMenu/HauptMenu.tscn")
	if anim_name == "linght_blink_red" or (anim_name == "linght_blink_green" and mission_archieved == []):
		$rat.transform = $rat_start_pos.transform
