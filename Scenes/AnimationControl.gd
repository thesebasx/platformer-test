extends AnimatedSprite2D

@onready var character = $".."

func _process(_delta):
	if character.velocity.x > 0 and !character.facingRight:
		character.facingRight = true
	
	if character.velocity.x < 0 and character.facingRight:
		character.facingRight = false
	
	flip_h = !character.facingRight
	handle_animation()

func handle_animation():
	if character.is_rolling:
		play('Roll')
	elif character.is_dashing:
		play('Dash')
	elif character.is_holding_wall:
		play("HoldWall")
	elif character.direction == 0:
		play("Idle")
	else:
		play("Run")
	
	if character.velocity.y > 0:
		play("JumpUp")
	
	if character.velocity.y < 0 and !character.is_rolling:
		play("JumpDown")

