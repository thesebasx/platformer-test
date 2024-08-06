extends Node

@onready var roll_timer = $"../RollTimer"
@onready var roll_buffer = $"../RollBuffer"
@onready var roll_cool_down = $"../RollCoolDown"
@onready var character = $".."

var can_roll:bool = true
var roll_buffered:bool = false

func _ready():
	roll_timer.timeout.connect(_on_roll_timer_timeout)
	roll_buffer.timeout.connect(_on_roll_buffer_timeout)
	roll_cool_down.timeout.connect(_on_roll_cool_down)

func _physics_process(_delta):
	if Input.is_action_just_pressed('Roll') and can_roll:
		Roll()
	
	if !character.was_on_floor and character.is_on_floor() and roll_buffered:
		Roll()
	
	if character.is_rolling:
		if character.facingRight:
			character.velocity.x = character.ROLL_SPEED
		else:
			character.velocity.x = -character.ROLL_SPEED


func Roll():
	if character.is_on_floor():
		character.is_rolling = true
		roll_cool_down.start()
		roll_timer.start()
		can_roll = false
	else:
		roll_buffered = true
		roll_buffer.start()

func _on_roll_timer_timeout():
	character.is_rolling = false

func _on_roll_buffer_timeout():
	roll_buffered = false

func _on_roll_cool_down():
	can_roll = true


