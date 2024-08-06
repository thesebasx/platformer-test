extends Node

@onready var jump = $"../Jump"
@onready var double_jump = $"../DoubleJump"
@onready var dash = $"../Dash"
@onready var roll = $"../Roll"
@onready var wall_slide = $"../WallSlide"

func SetActive(node: Node):
	node.process_mode = Node.PROCESS_MODE_INHERIT

func SetInactive(node: Node):
	node.process_mode = Node.PROCESS_MODE_DISABLED
