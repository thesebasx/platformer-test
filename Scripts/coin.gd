extends Area2D

@onready var game_manager = %GameManager

func _on_body_entered(_body):
	game_manager.AddPoint()
	queue_free()
