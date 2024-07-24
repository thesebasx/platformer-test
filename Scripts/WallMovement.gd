extends Node

@onready var character = $".."

func _physics_process(_delta):
	if (Input.is_action_pressed("Right") or Input.is_action_pressed("Left")) and  character.is_on_wall_only() and character.velocity.y >= 0:
		character.is_sliding = true
	else:
		character.is_sliding = false
	
	if character.is_on_wall_only() and Input.is_action_just_pressed("Jump"):
		character.is_sliding = false
		WallJump()

func WallJump():
	if character.is_on_wall_only():
		if character.facingRight:
			character.velocity = Vector2(-character.SPEED, character.JUMP_SPEED)
			character.facingRight = !character.facingRight
		else:
			character.velocity = Vector2(character.SPEED, character.JUMP_SPEED)
			character.facingRight = !character.facingRight
