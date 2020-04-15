extends Spatial

#statt der Camera alleine dreht sich dieses Spatial, das die Position "verkörpert" an der die Ratte stehen würde. So ist es einfacher die Rotation zu smoothen


export var rotation_speed = 130
export var smooth_winkel = 50 #winkel zwischen Ratte und Camera, ab der die Dreh-Geschwindigkeit abnimmt, damit die Drehung natürlicher ist

export var player_path = "../rat"





func _process(delta):
	self.translation = get_node(player_path).translation #die position der Camera mit der position des spielers gleichsetzten

	var linksherum_drehen = 1
	if (get_node(player_path).rotation_degrees.y - rotation_degrees.y) <0:
		linksherum_drehen = -1

	if abs(get_node(player_path).rotation_degrees.y - rotation_degrees.y)<smooth_winkel: #wenn die rotytion.y des spielers mit der der Camera fast übereinstimmen, wird die geschwindigkeit der Camera verringert
		linksherum_drehen*=abs(get_node(player_path).rotation_degrees.y - rotation_degrees.y)/smooth_winkel

	if (360-get_node(player_path).rotation_degrees.y + rotation_degrees.y)<smooth_winkel: #damit das smoothen auch geht, wenn sich die Ratte von kleiner -180° auf größer 180° dreht
		linksherum_drehen*=(360-get_node(player_path).rotation_degrees.y + rotation_degrees.y)/smooth_winkel

	elif (360 + get_node(player_path).rotation_degrees.y - rotation_degrees.y)<smooth_winkel: #damit das smoothen auch geht, wenn sich die Ratte von größer 180° auf kleiner -180° dreht
		linksherum_drehen*=(360 + get_node(player_path).rotation_degrees.y - rotation_degrees.y)/smooth_winkel

	if abs(get_node(player_path).rotation_degrees.y - rotation_degrees.y) > 180: #damit sich die ratte bei einem Übergang von -180° auf 180° oder 180° auf -180° nicht einmal um sich selbst dreht
		linksherum_drehen*= -1

	self.rotation_degrees.y += linksherum_drehen*delta*rotation_speed #updaten von rotation_degrees.y der Camera


	if rotation_degrees.y < -180: rotation_degrees.y += 360 #damit die rotation_degrees.y nicht kleiner als -180° wird: dann würde der obige Skript nicht mehr funktionieren
	elif rotation_degrees.y > 180: rotation_degrees.y -= 360 #damit die rotation_degrees.y nicht größer als 180° wird: dann würde der obige Skript nicht mehr funktionieren
