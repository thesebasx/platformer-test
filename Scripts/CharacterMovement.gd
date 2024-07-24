extends CharacterBody2D

@export var SPEED = 130.0
@export var SLIDE_SPEED = 25
@export var JUMP_SPEED = -256.0
@export var maxJumps = 1

@onready var wallJumpTimer = $WallJumpTimer

var direction:float = 0
var gravity
var is_dashing:bool = false
var facingRight:bool = true
var is_sliding:bool = false
var was_on_floor:bool = false

func _physics_process(delta):
	handle_gravity()
	if is_dashing:
		velocity.y = 0
	elif is_sliding:
		velocity.y = SLIDE_SPEED
	else:
		velocity.y += gravity * delta
	direction = Input.get_axis("Left", "Right")
	handle_movement()
	was_on_floor = is_on_floor()
	move_and_slide()

func handle_movement():
	if direction:
		velocity.x = direction * SPEED
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_gravity():
	if not is_on_floor_only() and velocity.y < 0:
		if Input.is_action_pressed("Jump"):
			gravity = 0.5 * ProjectSettings.get_setting("physics/2d/default_gravity")
		else:
			gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	
	if velocity.y >= 0:
		gravity = 1.5 * ProjectSettings.get_setting("physics/2d/default_gravity")
