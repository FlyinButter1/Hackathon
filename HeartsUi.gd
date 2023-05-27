extends CanvasLayer

@export var player : CharacterBody2D

var maxHearts: int: 
	set(value):
		maxHearts = clamp(value,1, 10)
		$MaxHearts.transform.size = Vector2(16*maxHearts, 16)
		
var Hearts : int:
	set(value):
		Hearts = clamp(value, 0, maxHearts)
		if Hearts == 0:
			$Hearts.transform.scale = Vector2.ZERO
		else:
			$Hearts.transform = Vector2(16*maxHearts, 16)
func _ready():
	player.get_node('Hurtbox').max_health_changed.connect(_on_max_health_changed)
	player.get_node('Hurtbox').max_health_changed.connect(_on_health_changed)
		
func _on_max_health_changed(value):
	self.maxHearts = value
func _on_health_changed(value):
	self.maxHearts = value
