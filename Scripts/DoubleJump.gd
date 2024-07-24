extends Node

@onready var character = $".."
@onready var jump = $"../Jump"

@export var D_JUMP_VELOCIITY = -300

var jumpCount = 0

var canJump:bool = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("Jump") and !character.is_on_floor() and !character.is_sliding:
		DoubleJump()

	if jump.coyoteJump:
		jumpCount = 0
	
	if !character.was_on_floor and character.is_on_floor():
		jumpCount = 0

func DoubleJump():
	if jumpCount < character.maxJumps:
		character.velocity.y = character.JUMP_SPEED * 1.17
		jumpCount += 1
