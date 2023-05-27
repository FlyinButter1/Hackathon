extends Camera2D

func _ready():
	limit_left = $Marker2D1.global_position.x
	limit_top = $Marker2D1.global_position.y
	
	limit_bottom = $Marker2D2.global_position.y
	limit_right = $Marker2D2.global_position.x
	
	
