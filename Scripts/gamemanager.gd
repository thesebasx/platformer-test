extends Node

@onready var score_label = $"../Camera2D/Label3"

var score = 0

func AddPoint():
	score += 1
	score_label.text = "Score: " + str(score)
