extends Spatial



var startGame = "res://Scenes/Level/level-jonathan/level-jonathan.tscn"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_physics_process(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	get_node("labyrinth").rotate_y(0.1*delta)

func _on_NewGame_button_down():
	get_tree().change_scene(startGame)
