extends Area2D

@onready var timer = $Timer

func _on_body_entered(_body):
	timer.start()


func _on_timer_timeout():
	print("you die")
	get_tree().reload_current_scene()
