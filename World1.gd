extends Node2D

@onready var camera = $Camera2D
@onready var player = $CharacterBody2D

func _ready():
	player.connect_camera(camera)

