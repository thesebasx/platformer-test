extends Node

@onready var character = $".."

func _physics_process(_delta):
	if Input.is_action_pressed("HoldWall"):
		if character.is_on_wall():
			character.is_sliding = false
			character.is_holding_wall = true
		else:
			Input.action_release("HoldWall")
	
	if Input.is_action_just_released("HoldWall"):
		character.is_holding_wall = false
