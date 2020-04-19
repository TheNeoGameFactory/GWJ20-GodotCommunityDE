extends Spatial



export (Color) var farbe = Color(1,1,1,0.4)
export (int) var laser_art = 1

var used = false
var mission_doing

signal wants_musik(laser_type)
signal stops_musik(laser_type)

func _ready():
	self.connect("wants_musik", get_node("../.."),"laser_wants_to_play_musik")
	self.connect("stops_musik", get_node("../.."),"laser_wants_to_stop_musik")
	var laser_mat = SpatialMaterial.new()
	laser_mat.flags_transparent = true
	laser_mat.albedo_color = farbe
	$MeshInstance.set_surface_material(0,laser_mat)
	get_node("../..").possible_laser.append(laser_art)

func _process(delta):
	if mission_doing != get_node("../..").current_mission:
		used = false
		self.visible = true
	mission_doing = get_node("../..").current_mission

func _on_Area_body_entered(body):
	
	if body.name == "rat" and not used:
		get_node("../..").mission_archieved.append(laser_art)
		print(get_node("../..").mission_to_do[len(get_node("../..").mission_archieved)-1])
		if get_node("../..").mission_to_do[len(get_node("../..").mission_archieved)-1] == laser_art:
			self.visible = false
			used = true
			emit_signal("stops_musik", laser_art)
			get_node("../../rat/AnimationPlayer").play("linght_blink_green")
		
		else: 
			get_node("../../rat/AnimationPlayer").play("linght_blink_red")
			var lasers =  get_node("../..").possible_laser.duplicate()
			get_node("../..").get_new_laser_config(get_node("../..").current_mission, lasers)
			get_node("../..").mission_archieved = []
			get_node("../..").play_laser_sounds(get_node("../..").mission_to_do)
			get_node("../../").show_text_popup("ansagen/Popup_failed")
			for laser in get_node("..").get_children():
				laser.show()
				laser.used = false


func _on_sound_area_body_entered(body):
	if body.name == "rat" and not used:
		emit_signal("wants_musik", laser_art)


func _on_sound_area_body_exited(body):
	if body.name == "rat" and not used:
		emit_signal("stops_musik", laser_art)
