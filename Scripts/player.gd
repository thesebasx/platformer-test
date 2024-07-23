extends CharacterBody2D

@onready var jumpBufferTimer = $JumpBuffer
@onready var coyoteTimer = $CoyoteTimer
@onready var dashTimer = $DashTimer
@onready var dashingTime = $dashingTime
@onready var wallJumpTimer = $WallJumpTimer

const SPEED = 130.0
const JUMP_VELOCITY = -256.0
const DASH_SPEED = 300.0
const SLIDE_SPEED = 25

#Dash variables
var is_dashing:bool = false
var can_dash:bool = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#Jump variables
var jumpbuffered:bool = false
var coyoteJump:bool = false
var jumpCount:int = 2
var max_jumps:int = 2

#wall variables
var isWallSliding:bool = false
var isWallJumping:bool = false

func _physics_process(delta):
	# Add the gravity.
	if (Input.is_action_pressed("Right") or Input.is_action_pressed("Left")) and is_on_wall_only() and velocity.y >= 0:
		velocity.y = SLIDE_SPEED
		isWallSliding = true
	else:
		isWallSliding = false
	
	if not is_on_floor() and !isWallSliding:
		if !is_dashing:
			if velocity.y < 0 and Input.is_action_pressed("Jump"):
				velocity.y += 0.5 * gravity * delta
			elif velocity.y < 0 and not Input.is_action_pressed("Jump"):
				velocity.y += gravity * delta
		else:
			velocity.y = 0
		
		if velocity.y >= 0 and dashingTime.time_left == 0:
			velocity.y += 1.5 * gravity * delta
	
	#Handle Dash.
	if Input.is_action_just_pressed("Dash") and can_dash:
		Dash()
	
	# Get the input direction and handle the movement/deceleration.
	var direction = Input.get_axis("Left", "Right")
	if direction and !isWallSliding and !isWallJumping:
		if is_dashing:
			velocity.x = direction * DASH_SPEED
		else:
			velocity.x = direction * SPEED
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, SPEED*0.5)
	
		# Handle Jump.
	if Input.is_action_just_pressed("Jump"):
		Jump()
	
	var was_on_floor = is_on_floor()
	var was_on_wall_only = is_on_wall_only()
	move_and_slide()
	
	#Get double jump and dash back
	if is_on_floor():
		jumpCount = 2
		
		if dashTimer.time_left <= 0:
			can_dash = true
	
	if !was_on_floor and is_on_floor() and jumpbuffered:
		Jump()
	
	if was_on_floor and !is_on_floor() and velocity.y >= 0:
		coyoteTimer.start()
		coyoteJump = true
	
	if is_on_wall_only() and jumpCount == 0:
		jumpCount = 1
	
	if was_on_wall_only and !is_on_wall_only():
		pass


func Jump():
	if !can_dash:
		can_dash = true
	
	if is_on_floor() or coyoteJump:
		velocity.y = JUMP_VELOCITY
		jumpCount -= 1
	
	if velocity.y >= 0 and !jumpbuffered:
		jumpbuffered = true
		jumpBufferTimer.start()
	
	if !is_on_floor() and jumpCount > 0:
		velocity.y = JUMP_VELOCITY
		if is_on_wall_only():
			if Input.is_action_pressed("Right"):
				velocity.x = -SPEED
			
			if Input.is_action_pressed("Left"):
				velocity.x = SPEED
			
			isWallJumping = true
			wallJumpTimer.start()
		jumpCount -= 1

func Dash():
	is_dashing = true
	dashTimer.start()
	can_dash = false
	dashingTime.start()

func _on_jump_buffer_timeout():
	jumpbuffered = false

func _on_coyote_timer_timeout():
	coyoteJump = false

func _on_dash_timer_timeout():
	if is_on_floor():
		can_dash = true

func _on_dashing_time_timeout():
	is_dashing = false


func _on_wall_jump_timer_timeout():
	isWallJumping = false
