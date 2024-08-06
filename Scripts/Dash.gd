extends Node

@onready var character = $".."
@onready var dashTimer = $"../DashTimer"
@onready var dashingTime = $"../dashingTime"

var can_dash:bool = true
var direction

func _ready():
	dashingTime.timeout.connect(_on_dashing_timer_timeout)

func _physics_process(_delta):
	if dashTimer.time_left <= 0 and character.is_on_floor():
		can_dash = true
	
	if Input.is_action_just_pressed("Dash") and can_dash:
		direction = Vector2(character.direction, character.direction_y)
		Input.action_release("Jump")
		Dash()
	
	if character.is_dashing:
		if direction:
			character.velocity = direction * character.DASH_SPEED
		else:
			if character.facingRight:
				character.velocity = Vector2(character.DASH_SPEED, 0)
			else:
				character.velocity = Vector2(-character.DASH_SPEED, 0)


func Dash():
	character.is_dashing = true
	dashTimer.start()
	can_dash = false
	dashingTime.start()

func _on_dashing_timer_timeout():
	character.is_dashing = false
	direction = Vector2(0,0)
