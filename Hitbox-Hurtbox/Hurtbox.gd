extends Area2D

signal max_health_changed
signal health_changed
signal death
signal knockback

@onready var collisionShape = $CollisionShape2D
@onready var timer = $Timer
@export var blinkAnimationPlayer :AnimationPlayer

var invincible_state = false

func invincible():
	invincible_state = true
	collisionShape.set_deferred('disabled', true)
	timer.start(invincibility_timer)
	blinkAnimationPlayer.play('start')
	await timer.timeout
	blinkAnimationPlayer.play('stop')
	invincible_state = false
	collisionShape.set_deferred('disabled', false)
	

@export var max_health: int :
	set(value):
		max_health = clamp(value,1, 10)
		emit_signal('max_health_changed', max_health)
		
@export var invincibility_timer : float



var health:int :
	set(value):
		health = clamp(value, 0, max_health)
		emit_signal('health_changed', health)

func damage(damage):
	self.health -= damage
	if health <= 0:
		emit_signal('death')
		
		
func knockback_apply(knockback_value, knockback_vector):
	emit_signal('knockback', knockback_value, knockback_vector)


func _ready():
	self.health = max_health
