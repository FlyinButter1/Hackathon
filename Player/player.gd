extends CharacterBody2D

@export var MAX_SPEED = 100
@export var ACCELERATION = 50
@export var FRICTION = 100

@onready var animationTree = $AnimationTree
@onready var animationTreePlayback = animationTree.get('parameters/playback')
@onready var hitbox = $HitboxAnchor/Hitbox
@onready var remoteTransform2D = $RemoteTransform2D
var input_vector: Vector2 = Vector2.ZERO

func _input(event):
	if event.is_action_pressed("attack"):
		state = ATTACK

var can_attack: bool

var is_blocked = false

enum {
	ATTACK,
	MOVE
}

var state = MOVE

func _ready():
	randomize()

func _physics_process(delta):
	if is_blocked:
		return
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()

func move_state():
	print('move')
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	if input_vector != Vector2.ZERO:
		animationTree.set('parameters/Idle/blend_position', input_vector)
		animationTree.set('parameters/Attack/blend_position', input_vector)
		animationTree.set('parameters/Run/blend_position', input_vector)
		animationTree.set('parameters/Roll/blend_position', input_vector)
		hitbox.knockback_vector = input_vector.normalized()
		animationTreePlayback.travel('Run')
		velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION)
	else:
		animationTreePlayback.travel('Idle')
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
		

	move_and_slide()


func attack_state():
	animationTreePlayback.travel('Attack')
	
func attack_end():
	state = MOVE


func _on_hurtbox_death():
	#umieranie effekty / animacje
	queue_free()


func _on_hurtbox_knockback(knockback_value, knockback_vector):
	velocity += knockback_vector * knockback_value

