extends Node

@onready var character = $".."

func _physics_process(_delta):
	WallSlide()

func WallSlide():
		if (Input.is_action_pressed("Right") or Input.is_action_pressed("Left")) and  character.is_on_wall_only():
			character.is_sliding = true
		else:
			character.is_sliding = false
