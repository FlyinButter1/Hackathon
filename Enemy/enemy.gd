extends CharacterBody2D
class_name Enemy

@export_category("move")
@export var MAX_SPEED = 50
@export var ACCELERATION = 10
@export var FRICTION = 100

@export_category("components")
@export var Hitbox : Area2D
@export var Hurtbox: Area2D
@export var PlayerDetectionZone: Area2D
@export var navigationAgent: NavigationAgent2D

@onready var animationTree = $AnimationTree
@onready var animationTreePlayback = animationTree.get('parameters/playback')
@onready var hitbox = $Hitbox

enum {
	CHASE,
	WANDER,
	IDLE
}

var state = IDLE

var target_position:Vector2


func _physics_process(delta):
	check_for_player()
	print(state)
	match state:
		CHASE:
			if PlayerDetectionZone.player != null:
				target_position = PlayerDetectionZone.player.global_position
			accelerate_to_point(delta)
		WANDER:
			if global_position.distance_to(target_position) < 10:
				state = IDLE
			accelerate_to_point(delta)
		IDLE:
			idle_state(delta)
	move_and_slide()

var direction_vector

func idle_state(delta):
	animationTreePlayback.travel('Idle')
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
	
func accelerate_to_point(delta):
	navigationAgent.target_position = target_position
	direction_vector = global_position.direction_to(navigationAgent.get_next_path_position()).normalized()
	animationTree.set('parameters/Idle/blend_position', direction_vector)
	animationTree.set('parameters/Run/blend_position', direction_vector)
	animationTreePlayback.travel('Run')
	hitbox.knockback_vector = direction_vector
	velocity = velocity.move_toward(global_position.direction_to(navigationAgent.get_next_path_position()).normalized() * MAX_SPEED, ACCELERATION * delta)

func check_for_player():
	if PlayerDetectionZone.player != null:
		state = CHASE
	else:
		pick_state()

var state_cooldown = false

func pick_state():
	if state_cooldown == false:
		var states = [IDLE, WANDER]
		state = states.pick_random()
		if state == WANDER:
			target_position = global_position + Vector2(randi_range(-32, 32), randi_range(-32, 32))
		state_cooldown = true
		get_tree().create_timer(2.0).timeout.connect(state_coolodown_end)
	
func state_coolodown_end():
	state_cooldown = false


func _on_hurtbox_knockback(knckback_value, knockback_vector):
	velocity += knockback_vector * knckback_value
