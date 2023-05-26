extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

func change_scene(next_scene_path):
	animationPlayer.play("FadeOut")
	get_tree().change.change_scene_to_file(next_scene_path)
