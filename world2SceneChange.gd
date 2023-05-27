extends Area2D




func _on_body_entered(body):
	var player = body.get_parent()
	await get_tree().current_scene.get_node('SceneChanger').change_scene('res://world3.tscn')
