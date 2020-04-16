extends Node2D


var count_trought_splashes #variable um zu zählen,bei welchem Teil des splashes man gerade ist ("teile" auf github zu finden, hat sich Neo da überlegt)

var scale_at_1000px = 0.4

export (Resource) var main_menu

func _ready():
	count_trought_splashes = 0
	$parts/logo_com.show()
	$AnimationPlayer.play("goComDE_logo")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$parts.position = get_viewport().size * Vector2(0.5,0.5)
	$parts.scale = Vector2(scale_at_1000px * (get_viewport().size.x/1000), scale_at_1000px * (get_viewport().size.x/1000))


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "goComDE_logo":
		$parts/logo_gwj.show()
		$AnimationPlayer.play("GWJ_logo")
	elif anim_name == "GWJ_logo":
		$parts/kartenhand.show()
		$AnimationPlayer.play("kartenhand")
	elif anim_name == "kartenhand":
		$parts/gamename.show()
		$AnimationPlayer.play("game_name")
	elif anim_name == "game_name":
		get_tree().change_scene(main_menu.resource_path)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$AnimationPlayer.seek($AnimationPlayer.get_current_animation_length()-0.01,true) #-0.01 damit das animation_finished signal noch emittet wird
