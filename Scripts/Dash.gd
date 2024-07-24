extends Node

@onready var character = $".."
@onready var dashTimer = $"../DashTimer"
@onready var dashingTime = $"../dashingTime"

@export var DASH_MULT = 2.5
var can_dash:bool = true

func _ready():
	dashingTime.timeout.connect(_on_dashing_timer_timeout)

func _physics_process(_delta):
	if Input.is_action_just_pressed("Dash") and can_dash and character.direction != 0:
		Dash()
	
	if dashTimer.time_left <= 0 and character.is_on_floor():
		can_dash = true

func Dash():
	character.is_dashing = true
	dashTimer.start()
	can_dash = false
	dashingTime.start()
	character.SPEED = character.SPEED * DASH_MULT

func _on_dashing_timer_timeout():
	character.is_dashing = false
	character.SPEED = character.SPEED/DASH_MULT