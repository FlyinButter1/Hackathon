extends Area2D

@export var knockback_value:float
@export var damage:int = 1:
	set(value):
		damage = abs(value)

var knockback_vector: Vector2

func _on_area_entered(area):
	area.damage(damage)	
	area.invincible()
	area.knockback_apply(knockback_value, knockback_vector)
