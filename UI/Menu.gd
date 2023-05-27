extends Control

@onready var animationPlayer = $AnimationPlayer

var next_scene
func change_scene(next_scene_path):
	next_scene = next_scene_path
	animationPlayer.play("FadeOut")
	
	
func fadeoutfinished():
	get_tree().change_scene_to_file(next_scene)

func _on_start_button_pressed():
	change_scene("res://worldProps/world1.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
