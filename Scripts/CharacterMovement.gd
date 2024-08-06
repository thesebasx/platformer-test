extends CharacterBody2D

@export_category("Movement variables")
@export var SPEED:float = 130.0
@export var SLIDE_SPEED:float = 10.0
@export var ROLL_SPEED:float = 230.0
@export var DASH_SPEED:float = 230.0
@export var CLIMB_SPEED:float = 25.0

@export_category("Jump variables")
@export var JUMP_SPEED:float = -192.0
@export var D_JUMP_SPEED:float = -168.0
@export var maxJumps:int = 1

@export_category("Gravity variables")
@export var NORMAL_GRAVITY:float = 3200
@export var LONG_GRAVITY:float = 384
@export var FALLING_GRAVITY:float = 1536

#Float variables
var direction:float = 0
var direction_y:float = 0
var gravity

#Bolean variables
var is_dashing:bool = false
var facingRight:bool = true
var is_sliding:bool = false
var was_on_floor:bool = false
var is_rolling:bool = false
var is_holding_wall:bool = false

func _physics_process(delta):
	handle_gravity()
	handle_y_velocity(delta)
	direction = Input.get_axis("Left", "Right")
	direction_y = Input.get_axis("Up", 'Down')
	handle_movement()
	was_on_floor = is_on_floor()
	move_and_slide()

func handle_movement():
	if direction and !is_dashing and !is_holding_wall and !is_rolling:
		velocity.x = direction * SPEED
	else:
		if is_on_floor() and !is_dashing:
			velocity.x = move_toward(velocity.x, 0, SPEED)

func handle_gravity():
	if not is_on_floor_only() and velocity.y < 0:
		if Input.is_action_pressed("Jump"):
			gravity = LONG_GRAVITY
		else:
			gravity = NORMAL_GRAVITY
	
	if velocity.y >= 0:
		gravity = FALLING_GRAVITY

func handle_y_velocity(delta):
	if !is_dashing:
		if is_sliding:
			velocity.y = SLIDE_SPEED
		elif is_holding_wall:
			velocity.y = CLIMB_SPEED * direction_y
		else:
			velocity.y += gravity * delta
