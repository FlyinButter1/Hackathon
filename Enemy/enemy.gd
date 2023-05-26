extends CharacterBody2D
class_name Enemy

@export_category("move")
@export var MAX_SPEED = 50
@export var ACCELERATION = 10
@export var FRICTION = 150

@export_category("components")
@export var Hitbox : Area2D
@export var Hurtbox: Area2D
@export var PlayerDetectionZone: Area2D
@export var navigationAgent: NavigationAgent2D


enum {
	CHASE,
	WANDER,
	IDLE
}

var state = IDLE

var target_position:Vector2


func _physics_process(delta):
	check_for_player()
	match state:
		CHASE:
			if PlayerDetectionZone.player != null:
				target_position = PlayerDetectionZone.player.global_position
			accelerate_to_point()
		WANDER:
			if global_position.distance_to(target_position) < 10:
				state = IDLE
			accelerate_to_point()
		IDLE:
			idle_state()
	move_and_slide()

func idle_state():
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
	
func accelerate_to_point():
	navigationAgent.target_position = target_position
	velocity = velocity.move_toward(global_position.direction_to(navigationAgent.get_next_path_position()) * MAX_SPEED, ACCELERATION)

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
