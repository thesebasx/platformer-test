extends AnimatedSprite2D

@onready var character = $".."

func _physics_process(_delta):
	if character.direction > 0 and !character.facingRight:
		character.facingRight = true
	
	if character.direction < 0 and character.facingRight:
		character.facingRight = false
	
	flip_h = !character.facingRight
	handle_animation()

func handle_animation():
	if character.velocity.y == 0:
		if character.direction != 0:
			play("Run")
		else:
			play("Idle")
	
	if character.velocity.y > 0:
		play("JumpUp")
	
	if character.velocity.y < 0:
		play("JumpDown")
