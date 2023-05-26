extends Area2D

signal max_health_changed
signal health_changed
signal death
signal knockback

@onready var collisionShape = $CollisionShape2D
@onready var timer = $Timer

func invincible():
	collisionShape.set_deferred('disabled', true)
	# odpal shader
	timer.start(invincibility_timer)
	await timer.timeout
	#wylacz shader 
	collisionShape.set_deferred('disabled', false)

@export var max_health: int :
	set(value):
		max_health = clamp(value,1,value)
		emit_signal('max_health_changed', value)
		
@export var invincibility_timer : float


var health :
	set(value):
		health = clamp(value, 0, max_health)
		emit_signal('health_changed', value)

func damage(damage):
	self.health -= damage
	if health == 0:
		emit_signal('death')
		
		
func knockback_apply(knockback_value, knockback_vector):
	emit_signal('knockback', knockback_value, knockback_vector)


func _ready():
	self.health = max_health
