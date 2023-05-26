extends CharacterBody2D

@export var MAX_SPEED = 165
@export var ACCELERATION = 80
@export var FRICTION = 150
@export var ROLL_SPEED = 175

@onready var animationTree = $AnimationTree
@onready var animationTreePlayback = animationTree.get('parameters/playback')

var input_vector: Vector2 = Vector2.ZERO

var can_attack: bool

enum {
	ATTACK,
	ROLL,
	MOVE
}

var state = MOVE

func _physics_process(delta):
	match state:
		MOVE:
			move_state()
			

func move_state():
			input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
			input_vector.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
			
			animationTree.set('parameters/Idle/blend_position', input_vector)
			animationTree.set('parameters/Attack/blend_position', input_vector)
			animationTree.set('parameters/Run/blend_position', input_vector)
			animationTree.set('parameters/Roll/blend_position', input_vector)
			
			if input_vector != Vector2.ZERO:
				animationTreePlayback.travel('Run')
				velocity = velocity.move_toward(input_vector.normalized() * MAX_SPEED, ACCELERATION)
			else:
				animationTreePlayback.travel('Idle')
				velocity = velocity.move_toward(Vector2.ZERO, FRICTION)
				
			print(velocity)

			move_and_slide()


	
