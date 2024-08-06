extends Area2D

@onready var winCanvas = %CanvasLayer

func _on_body_entered(_body):
	winCanvas.show()
