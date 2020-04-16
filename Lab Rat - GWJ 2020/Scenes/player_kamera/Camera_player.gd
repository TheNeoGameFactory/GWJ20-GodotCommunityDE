extends Spatial

#statt der Camera alleine dreht sich dieses Spatial, das die Position "verkörpert" an der die Ratte stehen würde. So ist es einfacher die Rotation zu smoothen



export var rotation_speed = 130
export var smooth_winkel = 50 #winkel zwischen Ratte und Camera, ab der die Dreh-Geschwindigkeit abnimmt, damit die Drehung natürlicher ist


export var player_path = "../rat"





func _process(delta):
	self.translation = get_node(player_path).translation #die position der Camera mit der position des spielers gleichsetzten
	
	rotation.y = rotation.y*0.94 + get_node(player_path).roty*0.06
