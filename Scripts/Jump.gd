extends Node

@onready var jumpBufferTimer = $"../JumpBuffer"
@onready var coyoteTimer = $"../CoyoteTimer"
@onready var character = $".."

var jumpbuffered:bool = false
var coyoteJump:bool = false
var isJumping:bool = false

func _ready():
	jumpBufferTimer.timeout.connect(_on_jump_buffer_timeout)
	coyoteTimer.timeout.connect(_on_coyote_timer_timeout)

func _physics_process(_delta):
	if character.was_on_floor and !character.is_on_floor() and character.velocity.y >= 0:
		coyoteTimer.start()
		coyoteJump = true
	
	if Input.is_action_just_pressed("Jump"):
		Jump()
	
	if !character.was_on_floor and character.is_on_floor() and jumpbuffered:
		Jump()

func Jump():
	if character.is_on_floor() or coyoteJump:
		character.velocity.y = character.JUMP_SPEED
	
	if character.velocity.y >= 0 and !jumpbuffered:
		jumpbuffered = true
		jumpBufferTimer.start()

func _on_jump_buffer_timeout():
	jumpbuffered = false

func _on_coyote_timer_timeout():
	coyoteJump = false
