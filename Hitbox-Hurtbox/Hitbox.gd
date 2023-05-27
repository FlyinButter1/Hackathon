extends Area2D

@export var knockback_value:float
@export var damage:int = 1:
	set(value):
		damage = abs(value)

var knockback_vector: Vector2
var hitEffectNode = preload("res://Efekty/HitEffect.tscn")
func _on_area_entered(area):
	area.damage(damage)	
	var hitEffect = hitEffectNode.instantiate()
	area.add_child(hitEffect)
	hitEffect.z_index = 1
	hitEffect.global_position = area.global_position + area.global_position.direction_to(global_position) * 5
	area.invincible()
	area.knockback_apply(knockback_value, knockback_vector)
