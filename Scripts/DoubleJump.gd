extends Node

@onready var character = $".."
@onready var jump = $"../Jump"

var jumpCount = 0

var canJump:bool = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("Jump") and !character.is_on_floor() and !character.is_sliding and !character.is_on_wall():
		DoubleJump()

	if jump.coyoteJump:
		jumpCount = 0
	
	if !character.was_on_floor and character.is_on_floor():
		jumpCount = 0

func DoubleJump():
	if jumpCount < character.maxJumps:
		character.velocity.y = character.D_JUMP_SPEED
		jumpCount += 1
