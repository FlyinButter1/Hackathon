extends CanvasLayer

@onready var animationPlayer = $AnimationPlayer

var next_scene

func change_scene(next_scene_path):
	animationPlayer.play("FadeOut")
	next_scene = next_scene_path

func fadeOutFinished():
	get_tree().change.change_scene_to_file(next_scene)
