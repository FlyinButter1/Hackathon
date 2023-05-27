extends Area2D

@export var DialogueHandler : CanvasLayer

func _input(event):
	if event.is_action_pressed("ui_interact") and listen and player != null:
		player.animationTreePlayback.travel('Idle')
		DialogueHandler.start()
		player.is_blocked = true
		
func _ready():
	DialogueHandler.dialogue_ended.connect(dialogue_ended)

var listen = false
var player = null

func _on_area_entered(area):
	listen = true
	player = area.get_parent()

func _on_area_exited(area):
	listen = false
	
func dialogue_ended():
	player.is_blocked = false
