extends Node

@onready var character = $".."

func _physics_process(_delta):
	if character.is_on_wall_only() and Input.is_action_just_pressed("Jump"):
		WallJump()

func WallJump():
	character.is_sliding = false
	character.is_holding_wall = false
	Input.action_release("Left")
	Input.action_release("Right")
	Input.action_release("HoldWall")
	if !character.is_sliding:
		if character.facingRight:
			character.velocity = Vector2(-character.SPEED, character.JUMP_SPEED)
			character.facingRight = !character.facingRight
		else:
			character.velocity = Vector2(character.SPEED, character.JUMP_SPEED)
			character.facingRight = !character.facingRight
