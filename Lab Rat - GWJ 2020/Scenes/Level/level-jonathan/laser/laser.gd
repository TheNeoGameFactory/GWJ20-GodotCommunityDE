extends Spatial


export (int) var laenge = 1 
export (Color) var farbe = Color(1,1,1,0.4)
export (bool) var hide_when_used = false
export (int) var laser_art = 1

signal mouse_entered(art)

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("mouse_entered", get_node("../.."), "mouse_in_laser")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$MeshInstance.mesh.mid_height = laenge
	$Area/CollisionShape.scale.z = laenge
	$sound_area/CollisionShape.shape.height = laenge
	var laser_mat = SpatialMaterial.new()
	laser_mat.flags_transparent = true
	laser_mat.albedo_color = farbe
	$MeshInstance.set_surface_material(0,laser_mat)	


func _on_Area_body_entered(body):
		emit_signal("mouse_entered", laser_art)
		$Area/CollisionShape.disabled = true
		$sound_area/CollisionShape.disabled = true
		if hide_when_used:
			self.hide()


func _on_sound_area_body_entered(body):
	if body.name == "rat":
		get_node("../../laser_sounds/"+str(laser_art)).playing = true
		get_node("../../AudioStreamPlayer").playing = false


func _on_sound_area_body_exited(body):
	if body.name == "rat":
		get_node("../../laser_sounds/"+str(laser_art)).playing = false
		get_node("../../AudioStreamPlayer").playing = true
