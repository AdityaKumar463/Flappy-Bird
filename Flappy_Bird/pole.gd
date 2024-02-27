extends StaticBody2D

func _physics_process(delta):
	global_position.x = global_position.x - (120 * delta)
	



func _on_area_2d_area_exited(area):
	if area.is_in_group("bird"):
		Global.point.emit()
