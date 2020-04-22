extends Node2D


var count_trought_splashes #variable um zu zählen,bei welchem Teil des splashes man gerade ist ("teile" auf github zu finden, hat sich Neo da überlegt)

var scale_at_1000px = 0.4

export (Resource) var main_menu
var sfx

func _ready():
	count_trought_splashes = 0
	$parts/logo_com.show()
	$AnimationPlayer.play("goComDE_logo")
	sfx = get_node("AudioStreamPlayer")
	_waitig("res://Sounds/SFX/Splashscreen/Splashscreen-GodotDE.wav",0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$parts.position = get_viewport().size * Vector2(0.5,0.5)
	$parts.scale = Vector2(scale_at_1000px * (get_viewport().size.x/1000), scale_at_1000px * (get_viewport().size.x/1000))


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "goComDE_logo":
		$parts/logo_gwj.show()
		$AnimationPlayer.play("GWJ_logo")
		_waitig("res://Sounds/SFX/Splashscreen/Splashscreen-Lion.wav",2)
	elif anim_name == "GWJ_logo":
		$parts/kartenhand.show()
		$AnimationPlayer.play("kartenhand")
		_waitig("res://Sounds/SFX/Splashscreen/Splashscreen-Cards.wav",2)
	elif anim_name == "kartenhand":
		$parts/gamename.show()
		$AnimationPlayer.play("game_name")
		_waitig("res://Sounds/SFX/Splashscreen/Splashscreen-Title.wav",1.5)
	elif anim_name == "game_name":
		get_tree().change_scene(main_menu.resource_path)


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$AnimationPlayer.seek($AnimationPlayer.get_current_animation_length()-0.01,true) #-0.01 damit das animation_finished signal noch emittet wird

func _waitig(loadThis, seconds):
	var t = Timer.new()
	t.set_wait_time(seconds)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	sfx.stream = load(loadThis)
	sfx.play()
	t.queue_free()
