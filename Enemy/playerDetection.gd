extends Area2D

var player

func _on_body_entered(body):
	player = body
	
func _on_body_exited(body):
	player = null
